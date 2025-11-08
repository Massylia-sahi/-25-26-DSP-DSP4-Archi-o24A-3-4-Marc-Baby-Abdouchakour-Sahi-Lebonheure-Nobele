-- =====================================================
-- Création des tables principales FleetControl
-- =====================================================

CREATE TABLE IF NOT EXISTS categorie (
    id_categorie INT AUTO_INCREMENT,
    libelle_categorie VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id_categorie)
);

CREATE TABLE IF NOT EXISTS site (
    id_site INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_site)
);

CREATE TABLE IF NOT EXISTS client (
    id_client INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    num_siret VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    email VARCHAR(255),
    telephone VARCHAR(255),
    id_mission INT NOT NULL,
    PRIMARY KEY (id_client),
    FOREIGN KEY (id_mission) REFERENCES mission(id_mission) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS conducteur (
    id_conducteur INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    matricule_conducteur VARCHAR(255) NOT NULL,
    id_client INT NOT NULL,
    email VARCHAR(255),
    telephone VARCHAR(155) NOT NULL,
    PRIMARY KEY (id_conducteur),
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS planning (
    id_planning INT AUTO_INCREMENT,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    statut ENUM('prevu','valide','annule','termine') DEFAULT 'prevu',
    notes TEXT,
    PRIMARY KEY (id_planning)
);

CREATE TABLE IF NOT EXISTS mission (
    id_mission INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    cout_mission DECIMAL(15,2) DEFAULT 0.00,
    description VARCHAR(255),
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    id_planning INT,
    PRIMARY KEY (id_mission),
    FOREIGN KEY (id_planning) REFERENCES planning(id_planning) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS categorie_piece (
    id_categorie_piece INT AUTO_INCREMENT,
    libelle_categorie VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_categorie_piece)
);

CREATE TABLE IF NOT EXISTS piece (
    id_piece INT AUTO_INCREMENT,
    nom_piece VARCHAR(255) NOT NULL,
    quantite INT DEFAULT 0,
    id_categorie_piece INT NOT NULL,
    type_piece VARCHAR(255),
    PRIMARY KEY (id_piece),
    FOREIGN KEY (id_categorie_piece) REFERENCES categorie_piece(id_categorie_piece) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS technicien (
    id_technicien INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telephone VARCHAR(155) NOT NULL,
    statut ENUM('actif','inactif') DEFAULT 'actif',
    PRIMARY KEY (id_technicien)
);

CREATE TABLE IF NOT EXISTS specialite_technicien (
    id_specialite INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    PRIMARY KEY (id_specialite)
);

CREATE TABLE IF NOT EXISTS controle_technique (
    id_controle INT AUTO_INCREMENT,
    libelle VARCHAR(255) NOT NULL,
    description TEXT,
    lieu TEXT,
    PRIMARY KEY (id_controle)
);

CREATE TABLE IF NOT EXISTS contrat (
    id_contrat INT AUTO_INCREMENT,
    reference_contrat VARCHAR(191) NOT NULL,
    type_contrat ENUM(
        'location_longue_duree','location_courte_duree','leasing','maintenance','assurance',
        'fourniture_pieces','partenariat','service_externe','autre'
    ) NOT NULL DEFAULT 'autre',
    montant DECIMAL(15,2) NOT NULL,
    date_debut DATE,
    date_fin DATE,
    statut ENUM('actif','suspendu','resilie','expire') NOT NULL DEFAULT 'actif',
    periode_facturation ENUM('mensuelle','trimestrielle','annuelle','ponctuelle') NOT NULL DEFAULT 'mensuelle',
    notes VARCHAR(255),
    created_at DATETIME NOT NULL,
    tva_taux DECIMAL(15,2) NOT NULL,
    renouvellement_auto BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_contrat),
    UNIQUE (reference_contrat)
);

CREATE TABLE IF NOT EXISTS vehicule (
    id_vehicule INT AUTO_INCREMENT,
    matricule VARCHAR(255) NOT NULL,
    date_achat DATE NOT NULL,
    description VARCHAR(255),
    date_mise_en_service DATE NOT NULL,
    modele VARCHAR(255),
    id_contrat INT NOT NULL,
    id_categorie INT NOT NULL,
    PRIMARY KEY (id_vehicule),
    FOREIGN KEY (id_contrat) REFERENCES contrat(id_contrat) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS trajet (
    id_trajet INT AUTO_INCREMENT,
    depart VARCHAR(255) NOT NULL,
    arrive VARCHAR(255) NOT NULL,
    date_depart DATETIME NOT NULL,
    distance_km DECIMAL(15,2) NOT NULL,
    carburant DECIMAL(15,2) DEFAULT 0.00,
    statut ENUM('prevu','en_cours','termine','interrompu') DEFAULT 'prevu',
    commentaire VARCHAR(255),
    date_arrive DATETIME NOT NULL,
    id_vehicule INT NOT NULL,
    PRIMARY KEY (id_trajet),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS fournisseur (
    id_fournisseur INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telephone VARCHAR(155) NOT NULL,
    adresse VARCHAR(255),
    num_siret VARCHAR(255) NOT NULL,
    id_contrat INT NOT NULL,
    PRIMARY KEY (id_fournisseur),
    FOREIGN KEY (id_contrat) REFERENCES contrat(id_contrat) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS assurance (
    id_assurance INT AUTO_INCREMENT,
    assureur VARCHAR(255) NOT NULL,
    num_contrat VARCHAR(255) NOT NULL,
    type_couverture VARCHAR(255),
    statut ENUM('active','expiree','resiliee') NOT NULL DEFAULT 'active',
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    notes VARCHAR(255),
    id_vehicule INT NOT NULL,
    PRIMARY KEY (id_assurance),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS type_maintenance (
    id_type_maintenance INT AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_type_maintenance)
);

CREATE TABLE IF NOT EXISTS maintenance (
    id_maintenance INT AUTO_INCREMENT,
    date_maintenance DATETIME NOT NULL,
    frequence ENUM('mensuelle','trimestrielle','semestrielle','annuelle','ponctuelle') NOT NULL DEFAULT 'ponctuelle',
    type_maintenance_lib VARCHAR(100),
    description TEXT,
    statut ENUM('prevue','en_cours','terminee','annulee') NOT NULL DEFAULT 'prevue',
    id_type_maintenance INT NOT NULL,
    PRIMARY KEY (id_maintenance),
    FOREIGN KEY (id_type_maintenance) REFERENCES type_maintenance(id_type_maintenance) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS incident (
    id_incident INT AUTO_INCREMENT,
    libelle VARCHAR(255) NOT NULL,
    description TEXT,
    date_incident DATETIME NOT NULL,
    type_incident ENUM('accident','panne','vol','autre') NOT NULL DEFAULT 'autre',
    id_categorie_vehicule INT NOT NULL,
    id_type_incident INT,
    PRIMARY KEY (id_incident)
);

CREATE TABLE IF NOT EXISTS intervention (
    id_intervention INT AUTO_INCREMENT,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    type_intervention ENUM('reparation','entretien','remorquage','autre') DEFAULT 'autre',
    lieu VARCHAR(255) NOT NULL,
    mode_intervention ENUM('interne','externe') NOT NULL,
    commentaire TEXT,
    id_incident INT NOT NULL,
    PRIMARY KEY (id_intervention),
    FOREIGN KEY (id_incident) REFERENCES incident(id_incident) ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================================================
-- Tables de liaison et historiques
-- =====================================================

CREATE TABLE IF NOT EXISTS conducteur_vehicule (
    id_vehicule INT NOT NULL,
    id_conducteur INT NOT NULL,
    date_affectation DATETIME NOT NULL,
    PRIMARY KEY (id_vehicule, id_conducteur),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_conducteur) REFERENCES conducteur(id_conducteur) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS site_vehicule (
    id_vehicule INT NOT NULL,
    id_site INT NOT NULL,
    date_affectation DATETIME NOT NULL,
    PRIMARY KEY (id_vehicule, id_site),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_site) REFERENCES site(id_site) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS controle_technique_vehicule (
    id_vehicule INT NOT NULL,
    id_controle INT NOT NULL,
    date_controle DATETIME,
    statut ENUM('valide','contre_visite','expire') DEFAULT 'valide',
    PRIMARY KEY (id_vehicule, id_controle),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_controle) REFERENCES controle_technique(id_controle) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS planning_vehicule (
    id_vehicule INT NOT NULL,
    id_planning INT NOT NULL,
    date_planning DATETIME NOT NULL,
    PRIMARY KEY (id_vehicule, id_planning),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_planning) REFERENCES planning(id_planning) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS planning_conducteur (
    id_conducteur INT NOT NULL,
    id_planning INT NOT NULL,
    date_planning DATETIME NOT NULL,
    PRIMARY KEY (id_conducteur, id_planning),
    FOREIGN KEY (id_conducteur) REFERENCES conducteur(id_conducteur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_planning) REFERENCES planning(id_planning) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS louer (
    id_vehicule INT NOT NULL,
    id_client INT NOT NULL,
    date_location DATETIME NOT NULL,
    PRIMARY KEY (id_vehicule, id_client),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS intervention_technicien (
    id_technicien INT NOT NULL,
    id_intervention INT NOT NULL,
    PRIMARY KEY (id_technicien, id_intervention),
    FOREIGN KEY (id_technicien) REFERENCES technicien(id_technicien) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_intervention) REFERENCES intervention(id_intervention) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS maintenance_vehicule (
    id_vehicule INT NOT NULL,
    id_maintenance INT NOT NULL,
    date_maintenance DATETIME NOT NULL,
    PRIMARY KEY (id_vehicule, id_maintenance),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_maintenance) REFERENCES maintenance(id_maintenance) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS maitrise (
    id_technicien INT NOT NULL,
    id_specialite INT NOT NULL,
    PRIMARY KEY (id_technicien, id_specialite),
    FOREIGN KEY (id_technicien) REFERENCES technicien(id_technicien) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_specialite) REFERENCES specialite_technicien(id_specialite) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS fournir (
    id_fournisseur INT NOT NULL,
    id_piece INT NOT NULL,
    date_fourniture DATETIME NOT NULL,
    PRIMARY KEY (id_fournisseur, id_piece),
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseur(id_fournisseur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_piece) REFERENCES piece(id_piece) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS incident_trajet (
    id_trajet INT NOT NULL,
    id_incident INT NOT NULL,
    date_incident DATETIME NOT NULL,
    PRIMARY KEY (id_trajet, id_incident),
    FOREIGN KEY (id_trajet) REFERENCES trajet(id_trajet) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_incident) REFERENCES incident(id_incident) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS planning_maintenance (
    id_planning INT NOT NULL,
    id_maintenance INT NOT NULL,
    date_planning DATETIME NOT NULL,
    PRIMARY KEY (id_planning, id_maintenance),
    FOREIGN KEY (id_planning) REFERENCES planning(id_planning) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_maintenance) REFERENCES maintenance(id_maintenance) ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================================================
-- Tables pour anomalie et cause_anomalie
-- =====================================================

CREATE TABLE IF NOT EXISTS cause_anomalie (
    id_cause_anomalie INT AUTO_INCREMENT,
    code_anomalie VARCHAR(50) NOT NULL,
    libelle VARCHAR(255) NOT NULL,
    description TEXT,
    PRIMARY KEY(id_cause_anomalie),
    UNIQUE(code_anomalie),
    CHECK (CHAR_LENGTH(code_anomalie) > 0),
    CHECK (CHAR_LENGTH(libelle) > 0)
);

CREATE TABLE IF NOT EXISTS anomalie (
    id_anomalie INT AUTO_INCREMENT,
    description TEXT,
    libelle VARCHAR(50) NOT NULL,
    date_detection DATETIME NOT NULL,
    statut ENUM('ouvert','en cours','résolu','annulé') NOT NULL DEFAULT 'ouvert',
    cout_reparation DECIMAL(15,2) DEFAULT 0,
    gravite ENUM('faible','moyenne','élevée','critique'),
    id_vehicule INT,
    id_cause_anomalie INT NOT NULL,
    id_incident INT,
    PRIMARY KEY(id_anomalie),
    FOREIGN KEY(id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(id_cause_anomalie) REFERENCES cause_anomalie(id_cause_anomalie) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(id_incident) REFERENCES incident(id_incident) ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (CHAR_LENGTH(libelle) > 0),
    CHECK (cout_reparation >= 0)
);

COMMIT;
