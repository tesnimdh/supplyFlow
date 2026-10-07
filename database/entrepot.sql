-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.4.3 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour entrepot
CREATE DATABASE IF NOT EXISTS `entrepot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `entrepot`;

-- Listage de la structure de table entrepot. anomalie
CREATE TABLE IF NOT EXISTS `anomalie` (
  `id_anomalie` varchar(20) NOT NULL,
  `id_commande` varchar(20) NOT NULL,
  `id_ligne` varchar(20) DEFAULT NULL,
  `type_anomalie` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `date_detection` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anomalie`),
  KEY `fk_anomalie_commande` (`id_commande`),
  KEY `fk_anomalie_ligne` (`id_ligne`),
  CONSTRAINT `fk_anomalie_commande` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_anomalie_ligne` FOREIGN KEY (`id_ligne`) REFERENCES `ligne_commande` (`id_ligne`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table entrepot. commande
CREATE TABLE IF NOT EXISTS `commande` (
  `id_commande` varchar(20) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `id_fournisseur` varchar(20) NOT NULL,
  `date_commande` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `statut` varchar(30) NOT NULL DEFAULT 'EN_ATTENTE',
  PRIMARY KEY (`id_commande`),
  UNIQUE KEY `reference` (`reference`),
  KEY `fk_commande_fournisseur` (`id_fournisseur`),
  CONSTRAINT `fk_commande_fournisseur` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseur` (`id_fournisseur`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table entrepot. fournisseur
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id_fournisseur` varchar(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telephone` varchar(30) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table entrepot. ligne_commande
CREATE TABLE IF NOT EXISTS `ligne_commande` (
  `id_ligne` varchar(20) NOT NULL,
  `id_commande` varchar(20) NOT NULL,
  `id_produit` varchar(20) NOT NULL,
  `quantite_commandee` int NOT NULL,
  `quantite_recue` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_ligne`),
  KEY `fk_ligne_commande` (`id_commande`),
  KEY `fk_ligne_produit` (`id_produit`),
  CONSTRAINT `fk_ligne_commande` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ligne_produit` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table entrepot. notification
CREATE TABLE IF NOT EXISTS `notification` (
  `id_notification` varchar(20) NOT NULL,
  `id_commande` varchar(20) NOT NULL,
  `id_fournisseur` varchar(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `date_envoi` datetime DEFAULT CURRENT_TIMESTAMP,
  `statut` varchar(30) NOT NULL DEFAULT 'ENVOYEE',
  PRIMARY KEY (`id_notification`),
  KEY `fk_notification_commande` (`id_commande`),
  KEY `fk_notification_fournisseur` (`id_fournisseur`),
  CONSTRAINT `fk_notification_commande` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_notification_fournisseur` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseur` (`id_fournisseur`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table entrepot. produit
CREATE TABLE IF NOT EXISTS `produit` (
  `id_produit` varchar(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `prix` decimal(10,2) DEFAULT NULL,
  `seuil_stock` int NOT NULL DEFAULT '10',
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de table entrepot. stock
CREATE TABLE IF NOT EXISTS `stock` (
  `id_stock` varchar(20) NOT NULL,
  `id_produit` varchar(20) NOT NULL,
  `quantite` int NOT NULL DEFAULT '0',
  `date_mise_a_jour` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_stock`),
  KEY `fk_stock_produit` (`id_produit`),
  CONSTRAINT `fk_stock_produit` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Les données exportées n'étaient pas sélectionnées.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
