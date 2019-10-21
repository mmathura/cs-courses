# ************************************************************
# Sequel Pro SQL dump
# Version 4004
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.17)
# Database: project3
# Generation Time: 2013-02-09 20:06:26 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `line` int(11) NOT NULL,
  `station` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `line` (`line`),
  KEY `station` (`station`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;

INSERT INTO `routes` (`id`, `line`, `station`)
VALUES
	(1,1,16),
	(2,1,17),
	(3,1,28),
	(4,1,14),
	(5,1,5),
	(6,1,25),
	(7,1,3),
	(8,1,1),
	(9,1,43),
	(10,1,18);

/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table stations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stations`;

CREATE TABLE `stations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `abbr` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `latitude` varchar(255) NOT NULL DEFAULT '',
  `longitude` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;

INSERT INTO `stations` (`id`, `abbr`, `name`, `latitude`, `longitude`)
VALUES
	(1,'12th','12th St. Oakland City Center','37.80307','-122.27157'),
	(2,'16th','16th St. Mission (SF)','37.76506','-122.41969'),
	(3,'19th','19th St. Oakland','37.80987','-122.27480'),
	(4,'24th','24th St. Mission (SF)','37.75225','-122.41847'),
	(5,'ashb','Ashby (Berkeley)','37.85302','-122.26978'),
	(6,'balb','Balboa Park (SF)','37.72500','-122.44503'),
	(7,'bayf','Bay Fair (San Leandro)','37.69718','-122.12687'),
	(8,'cast','Castro Valley','37.69410','-122.08635'),
	(9,'civc','Civic Center (SF)','37.77930','-122.41939'),
	(10,'cols','Coliseum/Oakland Airport','37.75401','-122.19727'),
	(11,'colm','Colma','37.67766','-122.45522'),
	(12,'conc','Concord','37.97798','-122.03107'),
	(13,'daly','Daly City','37.68792','-122.47021'),
	(14,'dbrk','Downtown Berkeley','37.87159','-122.27275'),
	(15,'dubl','Dublin/Pleasanton','37.70170','-121.90037'),
	(16,'deln','El Cerrito del Norte','37.92565','-122.31727'),
	(17,'plza','El Cerrito Plaza','37.90306','-122.29927'),
	(18,'embr','Embarcadero (SF)','37.79768','-122.39434'),
	(19,'frmt','Fremont','37.54827','-121.98857'),
	(20,'ftvl','Fruitvale (Oakland)','37.77911','-122.22142'),
	(21,'glen','Glen Park (SF)','37.73708','-122.43257'),
	(22,'hayvv','Hayward','37.66882','-122.08080'),
	(23,'lafy','Lafayette','30.22409','-92.01984'),
	(24,'lake','Lake Merritt (Oakland)','37.80124','-122.25830'),
	(25,'mcar','MacArthur (Oakland)','37.82841','-122.26723'),
	(26,'mlbr','Millbrae','37.59855','-122.38719'),
	(27,'mont','Montgomery St. (SF)','37.78998','-122.40077'),
	(28,'nbrk','North Berkeley','37.87159','-122.27275'),
	(29,'ncon','North Concord/Martinez','38.00328','-122.02460'),
	(30,'orin','Orinda','37.87715','-122.17969'),
	(31,'pitt','Pittsburg/Bay Point','38.01891','-121.94515'),
	(32,'phil','Pleasant Hill','37.94798','-122.06080'),
	(33,'powl','Powell St. (SF)','37.78499','-122.40686'),
	(34,'rich','Richmond','37.54072','-77.43605'),
	(35,'rock','Rockridge (Oakland)','37.84436','-122.24979'),
	(36,'sbrn','San Bruno','37.63049','-122.41108'),
	(37,'sfia','San Francisco |nt\'l Airport','37.61522','-122.38998'),
	(38,'sanl','San Leandro','37.72493','-122.15608'),
	(39,'shay','South Hayward','37.66882','-122.08080'),
	(40,'ssan','South San Francisco','37.65466','-122.40775'),
	(41,'ucty','Union City','37.59193','-122.04562'),
	(42,'wcrk','Walnut Creek','37.90631','-122.06496'),
	(43,'woak','West Oakland','37.81391','-122.29091');

/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table trains
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trains`;

CREATE TABLE `trains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line` varchar(255) NOT NULL DEFAULT '',
  `colour` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `trains` WRITE;
/*!40000 ALTER TABLE `trains` DISABLE KEYS */;

INSERT INTO `trains` (`id`, `line`, `colour`)
VALUES
	(1,'Richmond  Daly City - Millbrae','#ff0000'),
	(2,'Fremont - Richmond','#ffa500'),
	(3,'Fremont - Daly City','#00ff00'),
	(4,'Pittsburg / Bay Point  SFO - Millbrae','#ffff00'),
	(5,'Dublin / Pleasanton - Daly City','#0000ff');

/*!40000 ALTER TABLE `trains` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
