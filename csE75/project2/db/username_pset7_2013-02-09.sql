# ************************************************************
# Sequel Pro SQL dump
# Version 4004
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.17)
# Database: username_pset7
# Generation Time: 2013-02-09 20:07:40 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `symbol` varchar(255) NOT NULL,
  `shares` int(11) unsigned NOT NULL DEFAULT '0',
  `status` varchar(255) NOT NULL,
  `price` decimal(65,4) unsigned NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;

INSERT INTO `history` (`id`, `uid`, `timestamp`, `symbol`, `shares`, `status`, `price`)
VALUES
	(3,1,'2011-12-04 19:39:17','ATH.TO',1,'SOLD',12.3000),
	(4,1,'2011-12-04 19:38:55','LUN.TO',1,'SOLD',4.0300),
	(5,1,'2011-12-04 21:50:10','GTE.TO',3,'SOLD',5.8300),
	(6,1,'2011-12-04 21:51:57','GTE.TO',1,'SOLD',5.8300),
	(7,1,'2011-12-04 21:55:43','GTE.TO',2,'SOLD',5.8300),
	(8,1,'2011-12-04 21:57:14','GTE.TO',1,'SOLD',5.8300),
	(9,1,'2011-12-05 23:54:58','GOOG',1,'BOUGHT',625.6500),
	(10,1,'2011-12-08 01:26:46','GOOG',2,'SOLD',623.3900),
	(11,1,'2011-12-08 01:30:59','GOOG',1,'SOLD',623.3900),
	(12,1,'2011-12-08 01:36:41','GOOG',3,'SOLD',623.3900),
	(13,1,'2011-12-08 01:51:11','AFLB.OB',1,'BOUGHT',0.0120),
	(14,1,'2011-12-08 01:51:38','SLF.TO',1,'BOUGHT',19.1600),
	(15,1,'2011-12-10 11:14:38','BAC',1,'SOLD',5.7200),
	(16,1,'2011-12-10 11:15:09','BAC',3,'SOLD',5.7200),
	(17,2,'2011-12-27 12:03:27','MSFT',1,'SOLD',26.0501),
	(18,2,'2011-12-27 12:04:01','MSFT',1,'SOLD',26.0512),
	(19,2,'2011-12-27 12:04:36','MSFT',1,'BOUGHT',26.0500),
	(20,1,'2011-12-27 14:05:13','AFLB.OB',1,'SOLD',0.0100),
	(21,1,'2011-12-27 14:06:39','AAPL',1,'BOUGHT',408.1200),
	(22,1,'2011-12-27 14:06:57','AAPL',1,'SOLD',408.0124),
	(23,1,'2011-12-27 14:09:45','AFLB.OB',1,'SOLD',0.0100),
	(24,1,'2011-12-27 14:18:41','AAPL',3,'BOUGHT',408.1500),
	(25,1,'2011-12-27 14:19:06','AAPL',4,'SOLD',408.1600),
	(26,1,'2011-12-27 14:26:08','AFLB.OB',2,'SOLD',0.0100),
	(27,1,'2011-12-27 14:26:31','AFLB.OB',2,'BOUGHT',0.0100);

/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table portfolios
# ------------------------------------------------------------

DROP TABLE IF EXISTS `portfolios`;

CREATE TABLE `portfolios` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `symbol` varchar(11) NOT NULL,
  `shares` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `portfolios` WRITE;
/*!40000 ALTER TABLE `portfolios` DISABLE KEYS */;

INSERT INTO `portfolios` (`id`, `uid`, `symbol`, `shares`)
VALUES
	(3,2,'MSFT',3),
	(4,7,'ORCL',1),
	(5,1,'AAPL',5),
	(6,2,'ABB',1),
	(7,2,'BNS.TO',1),
	(8,2,'RIM.TO',1),
	(9,1,'SLF.TO',4),
	(10,1,'GOOG',2),
	(11,1,'AFLB.OB',2);

/*!40000 ALTER TABLE `portfolios` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `cash` decimal(65,4) unsigned NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`uid`, `username`, `password`, `cash`)
VALUES
	(1,'mitch','1111',2018.8280),
	(2,'mary','2222',974.9500),
	(7,'bob','3333',1000.0000),
	(16,'john','4444',1000.0000),
	(29,'john','5555',1000.0000),
	(30,'john','6666',1000.0000),
	(31,'mike','7777',1000.0000),
	(32,'jason ','8888',1000.0000);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
