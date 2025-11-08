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