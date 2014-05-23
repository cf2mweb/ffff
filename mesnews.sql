-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mer 29 Janvier 2014 à 14:28
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.16

SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `mesnews`
--
CREATE DATABASE IF NOT EXISTS `mesnews` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE mesnews;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

CREATE TABLE IF NOT EXISTS "article" (
  "id" int(10) unsigned NOT NULL AUTO_INCREMENT,
  "letitre" varchar(100) NOT NULL,
  "letexte" text,
  "ladate" datetime DEFAULT CURRENT_TIMESTAMP,
  "auteur_id" int(10) unsigned NOT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_article_auteur_idx" ("auteur_id")
) AUTO_INCREMENT=3 ;

--
-- Contenu de la table `article`
--

INSERT INTO `article` (`id`, `letitre`, `letexte`, `ladate`, `auteur_id`) VALUES
(1, '1 milliard de fumeurs sur Terre', 'Une personne sur sept dans le monde; femmes, nourrissons et grabataires compris. Le chiffre donne presque la nausée tant il est impressionnant et vient à contre-courant de l’évolution générale du nombre de fumeurs qui, globalement, diminue depuis plusieurs décennies dans les pays occidentaux.', '2013-11-21 21:17:21', 2),
(2, 'Elle tombe en dessous d''un train et survit miraculeusement', 'Une femme et un ami se trouvent sur le quai lorsqu''un train de marchandises entre en gare. Désireuse d''impressionner le jeune homme, l''inconsciente, cigarette à la main et verre dans le nez, tente alors un saut périlleux. Le train circulant à vitesse réduite (environ 20 km/h), la demoiselle bondit sur un des wagons, tel un kangourou. Sauf que voilà, la réception est moins réussie que le saut et la jeune femme tombe du wagon et se retrouve sur les voies, en dessous du train.', '2013-11-22 21:17:21', 1);

-- --------------------------------------------------------

--
-- Structure de la table `auteur`
--

CREATE TABLE IF NOT EXISTS "auteur" (
  "id" int(10) unsigned NOT NULL AUTO_INCREMENT,
  "lelogin" varchar(45) NOT NULL,
  "lepass" varchar(45) DEFAULT NULL,
  "lenom" varchar(85) DEFAULT NULL,
  "lemail" varchar(128) DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "lelogin_UNIQUE" ("lelogin")
) AUTO_INCREMENT=4 ;

--
-- Contenu de la table `auteur`
--

INSERT INTO `auteur` (`id`, `lelogin`, `lepass`, `lenom`, `lemail`) VALUES
(1, 'aaa', 'aaa', 'aaa le bbb', 'aaa@bbb.com'),
(2, 'ccc', 'ccc', 'ccc le ddd', 'ccc@ddd.com'),
(3, 'eee', 'eee', 'eee le fff', 'eee@fff.com');

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE IF NOT EXISTS "categorie" (
  "id" int(10) unsigned NOT NULL AUTO_INCREMENT,
  "lintitule" varchar(45) DEFAULT NULL,
  PRIMARY KEY ("id")
) AUTO_INCREMENT=8 ;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`id`, `lintitule`) VALUES
(1, 'Sexe'),
(2, 'Sport'),
(3, 'Belgique'),
(4, 'International'),
(5, 'Economie'),
(6, 'Politique'),
(7, 'Potins');

-- --------------------------------------------------------

--
-- Structure de la table `jointure`
--

CREATE TABLE IF NOT EXISTS "jointure" (
  "categorie_id" int(10) unsigned NOT NULL,
  "article_id" int(10) unsigned NOT NULL,
  PRIMARY KEY ("categorie_id","article_id"),
  KEY "fk_categorie_has_article_article1_idx" ("article_id"),
  KEY "fk_categorie_has_article_categorie1_idx" ("categorie_id")
);

--
-- Contenu de la table `jointure`
--

INSERT INTO `jointure` (`categorie_id`, `article_id`) VALUES
(4, 1),
(5, 1),
(4, 2),
(7, 2);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT "fk_article_auteur" FOREIGN KEY ("auteur_id") REFERENCES "auteur" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `jointure`
--
ALTER TABLE `jointure`
  ADD CONSTRAINT "fk_categorie_has_article_article1" FOREIGN KEY ("article_id") REFERENCES "article" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT "fk_categorie_has_article_categorie1" FOREIGN KEY ("categorie_id") REFERENCES "categorie" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
