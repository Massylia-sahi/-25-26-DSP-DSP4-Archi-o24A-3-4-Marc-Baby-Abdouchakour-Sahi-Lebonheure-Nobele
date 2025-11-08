
CREATE TABLE IF NOT EXISTS `categorie` (
  `id_categorie` INT AUTO_INCREMENT,
  `libelle_categorie` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255),
  PRIMARY KEY (`id_categorie`)
);
ALTER TABLE `categorie`
  ADD COLUMN IF NOT EXISTS `libelle_categorie` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `description` VARCHAR(255);


CREATE TABLE IF NOT EXISTS `site` (
  `id_site` INT AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `adresse` VARCHAR(255) NOT NULL,
  `ville` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_site`)
);
ALTER TABLE `site`
  ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `adresse` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `ville` VARCHAR(255) NOT NULL;


CREATE TABLE IF NOT EXISTS `client` (
  `id_client` INT AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `num_siret` VARCHAR(255) NOT NULL,
  `adresse` VARCHAR(255),
  `email` VARCHAR(255),
  `telephone` VARCHAR(255),
  `id_mission` INT NOT NULL,
  PRIMARY KEY (`id_client`)
);
ALTER TABLE `client`
  ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `num_siret` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `adresse` VARCHAR(255),
  ADD COLUMN IF NOT EXISTS `email` VARCHAR(255),
  ADD COLUMN IF NOT EXISTS `telephone` VARCHAR(255),
  ADD COLUMN IF NOT EXISTS `id_mission` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `conducteur` (
  `id_conducteur` INT AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `matricule_conducteur` VARCHAR(255) NOT NULL,
  `id_client` INT NOT NULL,
  `email` VARCHAR(255),
  `telephone` VARCHAR(155) NOT NULL,
  PRIMARY KEY (`id_conducteur`)
);
ALTER TABLE `conducteur`
  ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `matricule_conducteur` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `id_client` INT NOT NULL,
  ADD COLUMN IF NOT EXISTS `email` VARCHAR(255),
  ADD COLUMN IF NOT EXISTS `telephone` VARCHAR(155) NOT NULL;


CREATE TABLE IF NOT EXISTS `planning` (
  `id_planning` INT AUTO_INCREMENT,
  `date_debut` DATETIME NOT NULL,
  `date_fin` DATETIME NOT NULL,
  `statut` ENUM('prevu','valide','annule','termine') DEFAULT 'prevu',
  `notes` TEXT,
  PRIMARY KEY (`id_planning`)
);
ALTER TABLE `planning`
  ADD COLUMN IF NOT EXISTS `date_debut` DATETIME NOT NULL,
  ADD COLUMN IF NOT EXISTS `date_fin` DATETIME NOT NULL,
  ADD COLUMN IF NOT EXISTS `statut` ENUM('prevu','valide','annule','termine') DEFAULT 'prevu',
  ADD COLUMN IF NOT EXISTS `notes` TEXT;


CREATE TABLE IF NOT EXISTS `mission` (
  `id_mission` INT AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `cout_mission` DECIMAL(15,2) DEFAULT 0.00,
  `description` VARCHAR(255),
  `date_debut` DATETIME NOT NULL,
  `date_fin` DATETIME NOT NULL,
  `id_planning` INT,
  PRIMARY KEY (`id_mission`)
);
ALTER TABLE `mission`
  ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `cout_mission` DECIMAL(15,2) DEFAULT 0.00,
  ADD COLUMN IF NOT EXISTS `description` VARCHAR(255),
  ADD COLUMN IF NOT EXISTS `date_debut` DATETIME NOT NULL,
  ADD COLUMN IF NOT EXISTS `date_fin` DATETIME NOT NULL,
  ADD COLUMN IF NOT EXISTS `id_planning` INT;


CREATE TABLE IF NOT EXISTS `categorie_piece` (
  `id_categorie_piece` INT AUTO_INCREMENT,
  `libelle_categorie` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_categorie_piece`)
);
ALTER TABLE `categorie_piece`
  ADD COLUMN IF NOT EXISTS `libelle_categorie` VARCHAR(255) NOT NULL;


CREATE TABLE IF NOT EXISTS `piece` (
  `id_piece` INT AUTO_INCREMENT,
  `nom_piece` VARCHAR(255) NOT NULL,
  `quantite` INT DEFAULT 0,
  `id_categorie_piece` INT NOT NULL,
  `type_piece` VARCHAR(255),
  PRIMARY KEY (`id_piece`)
);
ALTER TABLE `piece`
  ADD COLUMN IF NOT EXISTS `nom_piece` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `quantite` INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `id_categorie_piece` INT NOT NULL,
  ADD COLUMN IF NOT EXISTS `type_piece` VARCHAR(255);


CREATE TABLE IF NOT EXISTS `technicien` (
  `id_technicien` INT AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255),
  `telephone` VARCHAR(155) NOT NULL,
  `statut` ENUM('actif','inactif') DEFAULT 'actif',
  PRIMARY KEY (`id_technicien`)
);
ALTER TABLE `technicien`
  ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `email` VARCHAR(255),
  ADD COLUMN IF NOT EXISTS `telephone` VARCHAR(155) NOT NULL,
  ADD COLUMN IF NOT EXISTS `statut` ENUM('actif','inactif') DEFAULT 'actif';


CREATE TABLE IF NOT EXISTS `specialite_technicien` (
  `id_specialite` INT AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`id_specialite`)
);
ALTER TABLE `specialite_technicien`
  ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `description` TEXT;


CREATE TABLE IF NOT EXISTS `controle_technique` (
  `id_controle` INT AUTO_INCREMENT,
  `libelle` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `lieu` TEXT,
  PRIMARY KEY (`id_controle`)
);
ALTER TABLE `controle_technique`
  ADD COLUMN IF NOT EXISTS `libelle` VARCHAR(255) NOT NULL,
  ADD COLUMN IF NOT EXISTS `description` TEXT,
  ADD COLUMN IF NOT EXISTS `lieu` TEXT;
CREATE TABLE IF NOT EXISTS `contrat` (
                                         `id_contrat` INT AUTO_INCREMENT,
                                         `reference_contrat` VARCHAR(255) NOT NULL,
    `type_contrat` ENUM(
                           'location_longue_duree','location_courte_duree','leasing','maintenance','assurance',
                           'fourniture_pieces','partenariat','service_externe','autre'
                       ) NOT NULL DEFAULT 'autre',
    `montant` DECIMAL(15,2) NOT NULL,
    `date_debut` DATE,
    `date_fin` DATE,
    `statut` ENUM('actif','suspendu','resilie','expire') NOT NULL DEFAULT 'actif',
    `periode_facturation` ENUM('mensuelle','trimestrielle','annuelle','ponctuelle') NOT NULL DEFAULT 'mensuelle',
    `notes` VARCHAR(255),
    `created_at` DATETIME NOT NULL,
    `tva_taux` DECIMAL(15,2) NOT NULL,
    `renouvellement_auto` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`id_contrat`),
    UNIQUE (`reference_contrat`)
    );
ALTER TABLE `contrat`
    ADD COLUMN IF NOT EXISTS `reference_contrat` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `type_contrat` ENUM(
    'location_longue_duree','location_courte_duree','leasing','maintenance','assurance',
    'fourniture_pieces','partenariat','service_externe','autre'
    ) NOT NULL DEFAULT 'autre',
    ADD COLUMN IF NOT EXISTS `montant` DECIMAL(15,2) NOT NULL,
    ADD COLUMN IF NOT EXISTS `date_debut` DATE,
    ADD COLUMN IF NOT EXISTS `date_fin` DATE,
    ADD COLUMN IF NOT EXISTS `statut` ENUM('actif','suspendu','resilie','expire') NOT NULL DEFAULT 'actif',
    ADD COLUMN IF NOT EXISTS `periode_facturation` ENUM('mensuelle','trimestrielle','annuelle','ponctuelle') NOT NULL DEFAULT 'mensuelle',
    ADD COLUMN IF NOT EXISTS `notes` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `created_at` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `tva_taux` DECIMAL(15,2) NOT NULL,
    ADD COLUMN IF NOT EXISTS `renouvellement_auto` BOOLEAN DEFAULT FALSE;


CREATE TABLE IF NOT EXISTS `vehicule` (
                                          `id_vehicule` INT AUTO_INCREMENT,
                                          `matricule` VARCHAR(255) NOT NULL,
    `date_achat` DATE NOT NULL,
    `description` VARCHAR(255),
    `date_mise_en_service` DATE NOT NULL,
    `modele` VARCHAR(255),
    `id_contrat` INT NOT NULL,
    `id_categorie` INT NOT NULL,
    PRIMARY KEY (`id_vehicule`)
    );
ALTER TABLE `vehicule`
    ADD COLUMN IF NOT EXISTS `matricule` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `date_achat` DATE NOT NULL,
    ADD COLUMN IF NOT EXISTS `description` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `date_mise_en_service` DATE NOT NULL,
    ADD COLUMN IF NOT EXISTS `modele` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `id_contrat` INT NOT NULL,
    ADD COLUMN IF NOT EXISTS `id_categorie` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `trajet` (
                                        `id_trajet` INT AUTO_INCREMENT,
                                        `depart` VARCHAR(255) NOT NULL,
    `arrive` VARCHAR(255) NOT NULL,
    `date_depart` DATETIME NOT NULL,
    `distance_km` DECIMAL(15,2) NOT NULL,
    `carburant` DECIMAL(15,2) DEFAULT 0.00,
    `statut` ENUM('prevu','en_cours','termine','interrompu') DEFAULT 'prevu',
    `commentaire` VARCHAR(255),
    `date_arrive` DATETIME NOT NULL,
    `id_vehicule` INT NOT NULL,
    PRIMARY KEY (`id_trajet`)
    );
ALTER TABLE `trajet`
    ADD COLUMN IF NOT EXISTS `depart` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `arrive` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `date_depart` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `distance_km` DECIMAL(15,2) NOT NULL,
    ADD COLUMN IF NOT EXISTS `carburant` DECIMAL(15,2) DEFAULT 0.00,
    ADD COLUMN IF NOT EXISTS `statut` ENUM('prevu','en_cours','termine','interrompu') DEFAULT 'prevu',
    ADD COLUMN IF NOT EXISTS `commentaire` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `date_arrive` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `id_vehicule` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `fournisseur` (
                                             `id_fournisseur` INT AUTO_INCREMENT,
                                             `nom` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255),
    `telephone` VARCHAR(155) NOT NULL,
    `adresse` VARCHAR(255),
    `num_siret` VARCHAR(255) NOT NULL,
    `id_contrat` INT NOT NULL,
    PRIMARY KEY (`id_fournisseur`)
    );
ALTER TABLE `fournisseur`
    ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `email` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `telephone` VARCHAR(155) NOT NULL,
    ADD COLUMN IF NOT EXISTS `adresse` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `num_siret` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `id_contrat` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `assurance` (
                                           `id_assurance` INT AUTO_INCREMENT,
                                           `assureur` VARCHAR(255) NOT NULL,
    `num_contrat` VARCHAR(255) NOT NULL,
    `type_couverture` VARCHAR(255),
    `statut` ENUM('active','expiree','resiliee') NOT NULL DEFAULT 'active',
    `date_debut` DATE NOT NULL,
    `date_fin` DATE NOT NULL,
    `notes` VARCHAR(255),
    `id_vehicule` INT NOT NULL,
    PRIMARY KEY (`id_assurance`)
    );
ALTER TABLE `assurance`
    ADD COLUMN IF NOT EXISTS `assureur` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `num_contrat` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `type_couverture` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `statut` ENUM('active','expiree','resiliee') NOT NULL DEFAULT 'active',
    ADD COLUMN IF NOT EXISTS `date_debut` DATE NOT NULL,
    ADD COLUMN IF NOT EXISTS `date_fin` DATE NOT NULL,
    ADD COLUMN IF NOT EXISTS `notes` VARCHAR(255),
    ADD COLUMN IF NOT EXISTS `id_vehicule` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `type_maintenance` (
                                                  `id_type_maintenance` INT AUTO_INCREMENT,
                                                  `nom` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_type_maintenance`)
    );
ALTER TABLE `type_maintenance`
    ADD COLUMN IF NOT EXISTS `nom` VARCHAR(255) NOT NULL;


CREATE TABLE IF NOT EXISTS `maintenance` (
                                             `id_maintenance` INT AUTO_INCREMENT,
                                             `date_maintenance` DATETIME NOT NULL,
                                             `frequence` ENUM('mensuelle','trimestrielle','semestrielle','annuelle','ponctuelle') NOT NULL DEFAULT 'ponctuelle',
    `type_maintenance_lib` VARCHAR(100),
    `description` TEXT,
    `statut` ENUM('prevue','en_cours','terminee','annulee') NOT NULL DEFAULT 'prevue',
    `id_type_maintenance` INT NOT NULL,
    PRIMARY KEY (`id_maintenance`)
    );
ALTER TABLE `maintenance`
    ADD COLUMN IF NOT EXISTS `date_maintenance` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `frequence` ENUM('mensuelle','trimestrielle','semestrielle','annuelle','ponctuelle') NOT NULL DEFAULT 'ponctuelle',
    ADD COLUMN IF NOT EXISTS `type_maintenance_lib` VARCHAR(100),
    ADD COLUMN IF NOT EXISTS `description` TEXT,
    ADD COLUMN IF NOT EXISTS `statut` ENUM('prevue','en_cours','terminee','annulee') NOT NULL DEFAULT 'prevue',
    ADD COLUMN IF NOT EXISTS `id_type_maintenance` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `incident` (
                                          `id_incident` INT AUTO_INCREMENT,
                                          `libelle` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `date_incident` DATETIME NOT NULL,
    `type_incident` ENUM('accident','panne','vol','autre') NOT NULL DEFAULT 'autre',
    `id_categorie_vehicule` INT NOT NULL,
    `id_type_incident` INT,
    PRIMARY KEY (`id_incident`)
    );
ALTER TABLE `incident`
    ADD COLUMN IF NOT EXISTS `libelle` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `description` TEXT,
    ADD COLUMN IF NOT EXISTS `date_incident` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `type_incident` ENUM('accident','panne','vol','autre') NOT NULL DEFAULT 'autre',
    ADD COLUMN IF NOT EXISTS `id_categorie_vehicule` INT NOT NULL,
    ADD COLUMN IF NOT EXISTS `id_type_incident` INT;


CREATE TABLE IF NOT EXISTS `intervention` (
                                              `id_intervention` INT AUTO_INCREMENT,
                                              `date_debut` DATETIME NOT NULL,
                                              `date_fin` DATETIME NOT NULL,
                                              `type_intervention` ENUM('reparation','entretien','remorquage','autre') DEFAULT 'autre',
    `lieu` VARCHAR(255) NOT NULL,
    `mode_intervention` ENUM('interne','externe') NOT NULL,
    `commentaire` TEXT,
    `id_incident` INT NOT NULL,
    PRIMARY KEY (`id_intervention`)
    );
ALTER TABLE `intervention`
    ADD COLUMN IF NOT EXISTS `date_debut` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `date_fin` DATETIME NOT NULL,
    ADD COLUMN IF NOT EXISTS `type_intervention` ENUM('reparation','entretien','remorquage','autre') DEFAULT 'autre',
    ADD COLUMN IF NOT EXISTS `lieu` VARCHAR(255) NOT NULL,
    ADD COLUMN IF NOT EXISTS `mode_intervention` ENUM('interne','externe') NOT NULL,
    ADD COLUMN IF NOT EXISTS `commentaire` TEXT,
    ADD COLUMN IF NOT EXISTS `id_incident` INT NOT NULL;


CREATE TABLE IF NOT EXISTS `conducteur_vehicule` (
                                                     `id_vehicule` INT NOT NULL,
                                                     `id_conducteur` INT NOT NULL,
                                                     `date_affectation` DATETIME NOT NULL,
                                                     PRIMARY KEY (`id_vehicule`,`id_conducteur`)
    );
ALTER TABLE `conducteur_vehicule`
    ADD COLUMN IF NOT EXISTS `date_affectation` DATETIME NOT NULL;
