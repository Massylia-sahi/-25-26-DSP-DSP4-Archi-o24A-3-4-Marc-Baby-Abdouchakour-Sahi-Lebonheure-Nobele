# 🚗 FleetControl — Gestion de flotte automobile
**TP IEF2I — Projet de modélisation et conception de base de données**

---

## 🏢 Contexte général

FleetControl est une entreprise spécialisée dans la **gestion de flottes de véhicules** pour des sociétés de transport, de maintenance et de livraison.  
Son activité repose sur la **supervision d’un parc de plusieurs centaines de véhicules** répartis sur différents sites en France, avec des besoins de **suivi administratif, technique et opérationnel**.

L’entreprise a constaté une forte croissance et souhaite mettre en place un **système d’information centralisé**, permettant de :
- suivre la vie complète de chaque véhicule,
- organiser les trajets et planifications,
- tracer les maintenances et interventions,
- gérer les contrats et assurances,
- et depuis la phase 2, **assurer la traçabilité complète des anomalies et incidents**.

Ce projet s’inscrit dans une démarche d’industrialisation des données internes de FleetControl, en respectant les **principes de normalisation, d’intégrité référentielle et d’évolutivité**.

---

## 🎯 Objectifs du projet

1. Concevoir un **modèle de données robuste et évolutif** pour centraliser toutes les informations liées à la flotte.
2. Permettre le **suivi complet du cycle de vie** des véhicules :
    - Acquisition → Utilisation → Maintenance → Réforme/Vente
3. Intégrer les notions de **planning, trajets et missions**.
4. Relier les **interventions techniques** aux trajets et incidents.
5. Suivre les **coûts, assurances et contrats**.
6. Étendre la base avec un **module de traçabilité des anomalies** (Phase 2).

---

## 🧩 Structure du modèle

### 🔹 Domaine "Véhicule & Opérations"
- **Vehicule** : informations de base (immatriculation, date d’achat, statut, catégorie, site, contrat, assurance)
- **Categorie** : classification (utilitaire, poids lourd, véhicule de service…)
- **Site** : localisation des véhicules et des équipes
- **Conducteur** : informations sur les conducteurs
- **Trajet** : suivi des déplacements (départ, arrivée, distance, coûts, carburant)
- **Mission** : rattachement des trajets à des missions spécifiques
- **Planning** : disponibilité et affectation des ressources

### 🔹 Domaine "Maintenance & Technique"
- **Maintenance** : entretiens réguliers et préventifs
- **Intervention** : réparations ponctuelles (internes ou externes)
- **Techniciens / Spécialités / Maîtrises** : gestion des compétences techniques
- **Pièces / Fournisseurs / Catégories de pièces** : gestion des stocks et achats
- **Contrôle_technique** : suivi des contrôles réglementaires

### 🔹 Domaine "Contrats, Assurance et Gestion financière"
- **Contrat** : gestion des contrats (leasing, maintenance, assurance)
- **Assurance** : suivi des polices d’assurance
- **Fournisseur** : prestataires externes
- **Client / Louer** : location de véhicules à des tiers

---

## 🔍 Phase 2 — Traçabilité des anomalies

### 🧠 Contexte
L’entreprise souhaite désormais suivre toutes les **anomalies** rencontrées sur ses véhicules (pannes, incidents mineurs, erreurs humaines, défaillances techniques) afin d’en **analyser les causes** et d’évaluer leur **impact financier**.

### ⚙️ Nouvelles tables introduites

#### `cause_anomalie`
Référentiel des causes possibles d’anomalie.

| Colonne | Type | Description |
|----------|------|-------------|
| id_cause | INT | Identifiant unique |
| libelle_cause | VARCHAR(255) | Nom de la cause |
| description | TEXT | Détails et classification |

#### `anomalie`
Enregistre chaque incident ou panne rencontrée sur un véhicule.

| Colonne | Type | Description |
|----------|------|-------------|
| id_anomalie | INT | Identifiant unique |
| description | TEXT | Détails de l’anomalie |
| date_detection | DATETIME | Date de détection |
| gravite | ENUM('mineure','majeure','critique') | Niveau de gravité |
| cout_reparation | DECIMAL(10,2) | Coût financier de l’incident |
| id_vehicule | INT (FK) | Véhicule concerné |
| id_cause_anomalie | INT (FK) | Cause associée |
| id_incident | INT (FK, NULL) | Incident ou intervention liée |

### 🔗 Relations ajoutées
- 1 véhicule → N anomalies
- 1 anomalie → 1 cause_anomalie
- 1 anomalie → 0..1 intervention

### 🧾 Exemple d’usage
1. Une panne moteur est signalée sur le véhicule **VHC-104**.
2. L’anomalie est classée comme **défaut d’entretien préventif**.
3. Une intervention est planifiée et liée à cette anomalie.
4. Le coût total de réparation est consigné.
5. L’anomalie est clôturée et reste dans l’historique du véhicule.

---

## 💬 Justification des évolutions

| Aspect | Justification |
|--------|----------------|
| **Traçabilité** | Enregistre tous les incidents, même sans intervention |
| **Analyse qualité** | Suivi des causes récurrentes et statistiques par modèle |
| **Impact financier** | Calcul des coûts directs et indirects liés aux anomalies |
| **Extensibilité** | Compatible avec le modèle existant sans modification majeure |
| **Phase 2 validée** | Conforme aux exigences du cahier des charges |

---

## 🧠 Choix de conception

- **3e forme normale (3NF)** : aucune redondance inutile.
- **Intégrité référentielle** : contraintes FK explicites.
- **Vocabulaire cohérent** : noms unifiés, cohérence entre MCD/MLD/SQL.
- **Évolutivité** : ajout possible d’autres modules (suivi énergétique, alertes IoT…).
- **Compatibilité MySQL** : respect des types et contraintes natives.

---

## 📂 Arborescence du dépôt GitHub

```
/docs/
   ├── mcd.png
   ├── mld.png
/sql/
   ├── fleetcontrol_init.sql
   └── fleetcontrol_final.sql
README.md
```

---

## 🤝 Collaboration GitHub

- **Issues** liées aux commits (`Fixes #12`, `Closes #8`).
- **Pull Requests** systématiques avec revue de code croisée.
- Historique Git nettoyé avant rendu.

---

## 🏁 Conclusion

Le modèle final de **FleetControl** répond à tous les objectifs du TP :

✅ Suivi complet du cycle de vie des véhicules  
✅ Gestion des trajets, entretiens, contrats et fournisseurs  
✅ Intégration du module **Anomalies & Causes**  
✅ Normalisation, intégrité et extensibilité respectées

> Ce travail reflète une démarche professionnelle, collaborative et évolutive de conception de base de données adaptée à la gestion d’une flotte automobile moderne.

---

👥 **Équipe GitHub :**
- Massylia
- Abraham
- Florian
- Patrice
- Cheickne

📅 **Rendu final : 10 novembre 2025 – 20h**  
📧 **Encadrant :** ehouri@formateur.ief2i.fr
