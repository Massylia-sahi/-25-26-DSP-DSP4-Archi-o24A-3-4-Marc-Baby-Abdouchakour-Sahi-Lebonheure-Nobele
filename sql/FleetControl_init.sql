
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