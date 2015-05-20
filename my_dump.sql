-- MySQL dump 10.13  Distrib 5.6.16, for osx10.9 (x86_64)
--
-- Host: localhost    Database: fyesports_development
-- ------------------------------------------------------
-- Server version	5.6.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amenities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amenity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,'locker room','2015-05-18 19:26:14','2015-05-18 19:26:14'),(3,'pool','2015-05-18 20:09:36','2015-05-18 20:09:36');
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `athletic_directors`
--

DROP TABLE IF EXISTS `athletic_directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `athletic_directors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `school_id` int(11) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `rejected` tinyint(1) DEFAULT NULL,
  `mobile_phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athletic_directors`
--

LOCK TABLES `athletic_directors` WRITE;
/*!40000 ALTER TABLE `athletic_directors` DISABLE KEYS */;
INSERT INTO `athletic_directors` VALUES (1,2,7,NULL,NULL,NULL,'2015-05-20 04:27:32','2015-05-20 13:13:47'),(2,26,12,NULL,NULL,NULL,'2015-05-20 15:39:12','2015-05-20 15:39:12');
/*!40000 ALTER TABLE `athletic_directors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendees`
--

DROP TABLE IF EXISTS `attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `yes` tinyint(1) DEFAULT NULL,
  `maybe` tinyint(1) DEFAULT NULL,
  `no` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendees`
--

LOCK TABLES `attendees` WRITE;
/*!40000 ALTER TABLE `attendees` DISABLE KEYS */;
INSERT INTO `attendees` VALUES (20,8,2,0,0,1,'2015-04-21 16:50:03','2015-04-21 16:50:07'),(21,25,2,1,0,0,'2015-04-27 22:41:38','2015-04-27 22:42:00'),(47,26,2,1,0,0,'2015-05-06 06:29:31','2015-05-17 17:23:20'),(48,4,2,0,0,1,'2015-05-06 15:42:26','2015-05-06 22:46:30'),(49,5,2,0,1,0,'2015-05-06 15:42:30','2015-05-06 15:42:33');
/*!40000 ALTER TABLE `attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `certification_id` int(11) DEFAULT NULL,
  `expiration` date DEFAULT NULL,
  `expires` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
INSERT INTO `certificates` VALUES (1,2,6,'2015-06-12',0,'2015-05-20 14:42:33','2015-05-20 14:42:33');
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certification_badges`
--

DROP TABLE IF EXISTS `certification_badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certification_badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certification_id` int(11) DEFAULT NULL,
  `badge` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certification_badges`
--

LOCK TABLES `certification_badges` WRITE;
/*!40000 ALTER TABLE `certification_badges` DISABLE KEYS */;
INSERT INTO `certification_badges` VALUES (1,6,'Screen_Shot_2015-05-14_at_1.15.21_PM.png','2015-05-18 15:05:26','2015-05-18 15:05:26');
/*!40000 ALTER TABLE `certification_badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certifications`
--

DROP TABLE IF EXISTS `certifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `issuer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certifications`
--

LOCK TABLES `certifications` WRITE;
/*!40000 ALTER TABLE `certifications` DISABLE KEYS */;
INSERT INTO `certifications` VALUES (6,'new with','new new','2015-05-18 15:05:26','2015-05-18 15:05:26');
/*!40000 ALTER TABLE `certifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classifications`
--

DROP TABLE IF EXISTS `classifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `classification` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classifications`
--

LOCK TABLES `classifications` WRITE;
/*!40000 ALTER TABLE `classifications` DISABLE KEYS */;
INSERT INTO `classifications` VALUES (10,9,'Parent','2015-05-07 00:11:00','2015-05-07 00:11:00'),(21,2,'Athlete','2015-05-19 15:57:52','2015-05-19 15:57:52'),(22,2,'Coach','2015-05-19 15:57:53','2015-05-19 15:57:53'),(23,2,'Athletic Director','2015-05-20 04:17:57','2015-05-20 04:17:57'),(24,26,'Athletic Director','2015-05-20 15:38:59','2015-05-20 15:38:59'),(25,27,'Athlete','2015-05-20 15:40:06','2015-05-20 15:40:06'),(26,27,'Coach','2015-05-20 15:40:07','2015-05-20 15:40:07'),(27,28,'Coach','2015-05-20 15:41:03','2015-05-20 15:41:03');
/*!40000 ALTER TABLE `classifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_facilities`
--

DROP TABLE IF EXISTS `event_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `facility_id` int(11) DEFAULT NULL,
  `facility_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_facilities`
--

LOCK TABLES `event_facilities` WRITE;
/*!40000 ALTER TABLE `event_facilities` DISABLE KEYS */;
INSERT INTO `event_facilities` VALUES (1,20,NULL,NULL,'2015-04-21 19:02:39','2015-04-21 19:02:39'),(2,21,NULL,NULL,'2015-04-21 19:02:43','2015-04-21 19:02:43'),(3,22,3,NULL,'2015-04-21 19:03:41','2015-04-21 19:03:41'),(4,23,3,NULL,'2015-04-24 16:21:58','2015-04-24 16:21:58'),(5,24,3,NULL,'2015-04-27 22:39:51','2015-04-27 22:39:51'),(6,25,3,NULL,'2015-04-27 22:40:16','2015-04-27 22:40:16'),(7,26,3,NULL,'2015-05-05 17:44:58','2015-05-05 17:44:58'),(8,27,3,NULL,'2015-05-05 23:50:54','2015-05-05 23:50:54'),(9,28,3,NULL,'2015-05-06 22:39:55','2015-05-06 22:39:55');
/*!40000 ALTER TABLE `event_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `eventable_id` int(11) DEFAULT NULL,
  `eventable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `all_day` tinyint(1) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `private` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_events_on_slug` (`slug`),
  KEY `index_events_on_eventable_id_and_eventable_type` (`eventable_id`,`eventable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (4,2,2,'User','Practice','Test Event','2015-04-20 20:14:00','2015-04-20 21:14:00',0,'hey',0,NULL,'1429561957-test-event','2015-04-20 20:32:37','2015-04-20 20:32:37'),(5,2,2,'User','Game','another event','2015-04-21 20:14:00','2015-04-21 21:14:00',0,'hey',0,NULL,'1429562100-another-event','2015-04-20 20:35:00','2015-04-20 20:35:00'),(8,2,2,'User','Practice','me me me','2015-04-23 20:14:00','2015-04-23 22:14:00',0,'hey',0,NULL,'1429631976-me-me-me','2015-04-21 15:59:37','2015-04-21 15:59:37'),(17,2,2,'User','','test','2015-04-21 18:32:00','2015-04-21 18:32:00',0,'',0,NULL,'1429641175-test','2015-04-21 18:32:55','2015-04-21 18:32:55'),(18,2,2,'User','','test','2015-04-21 18:32:00','2015-04-21 18:32:00',0,'',0,NULL,'1429641223-test','2015-04-21 18:33:43','2015-04-21 18:33:43'),(20,2,2,'User','','','2015-04-21 19:01:00','2015-04-21 19:01:00',0,'',0,NULL,'1429642958','2015-04-21 19:02:38','2015-04-21 19:02:38'),(21,2,2,'User','','','2015-04-21 19:01:00','2015-04-21 19:01:00',0,'',0,NULL,'1429642963','2015-04-21 19:02:43','2015-04-21 19:02:43'),(22,2,2,'User','','','2015-04-21 19:01:00','2015-04-21 19:01:00',0,'',0,NULL,'1429643021','2015-04-21 19:03:41','2015-04-21 19:03:41'),(23,2,2,'User','Practice','event for me',NULL,NULL,0,'HYH',0,NULL,'1429892517-event-for-me','2015-04-24 16:21:58','2015-04-24 16:21:58'),(24,2,2,'User','Practice','grits and biscuits party',NULL,NULL,0,'this is a party a club',0,NULL,'1430174390-grits-and-biscuits-party','2015-04-27 22:39:51','2015-04-27 22:39:51'),(25,2,2,'User','Practice','grits and biscuits party',NULL,NULL,0,'this is a party a club',0,NULL,'1430174416-grits-and-biscuits-party','2015-04-27 22:40:16','2015-04-27 22:40:16'),(26,2,5,'Team','Game','Game vs. WESTERN',NULL,NULL,0,'',0,NULL,'1430847898-game-vs-western','2015-05-05 17:44:58','2015-05-05 17:44:58'),(27,2,2,'User','Practice','practice','2015-05-05 23:52:23','2015-05-06 01:32:23',0,'',0,NULL,'1430869853-practice','2015-05-05 23:50:53','2015-05-05 23:52:24');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `private` tinyint(1) DEFAULT NULL,
  `publicly_visible` tinyint(1) DEFAULT NULL,
  `address_1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `gmaps` tinyint(1) DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `school_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_facilities_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` VALUES (3,'Milford Mill Track','',1,1,'3800 Washington Blvd','','Baltimore','Maryland','212144','',39.2448,-76.6742,1,'','','','milford-mill-track-baltimore-maryland','2015-04-17 20:24:44','2015-04-17 20:24:44',NULL),(9,'Basketball Court',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,39.3829,-76.7985,1,NULL,NULL,NULL,'randallstown-high-school-basketball-court','2015-05-06 03:39:07','2015-05-06 03:39:07',6),(10,'Patapsco State Park',NULL,0,1,'	8020 Baltimore National Pike','','Ellicott City','Maryland','21043','',39.2953,-76.7834,1,'','','','patapsco-state-park-ellicott-city-maryland','2015-05-20 15:07:07','2015-05-20 15:07:07',NULL),(11,'Track',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,39.3829,-76.7985,1,NULL,NULL,NULL,'randallstown-high-school-track','2015-05-20 15:08:01','2015-05-20 15:08:01',6),(12,'Tennis Court',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,39.3829,-76.7985,1,NULL,NULL,NULL,'randallstown-high-school-tennis-court','2015-05-20 15:08:20','2015-05-20 15:08:20',6),(13,'Football Field',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,39.3829,-76.7985,1,NULL,NULL,NULL,'randallstown-high-school-football-field','2015-05-20 15:08:27','2015-05-20 15:08:27',6),(14,'Soccer Field',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,39.3829,-76.7985,1,NULL,NULL,NULL,'randallstown-high-school-soccer-field','2015-05-20 15:08:36','2015-05-20 15:08:36',6),(15,'Bull Run Regional Park',NULL,0,0,'7700 Bull Run Drive','','Centreville','Virginia','20121','',38.8062,-77.474,1,'','','','bull-run-regional-park-centreville-virginia','2015-05-20 15:18:25','2015-05-20 15:18:25',NULL),(16,'Bull Run Regional Park',NULL,0,0,'7700 Bull Run Drive','','Centreville','Virginia','21021','',38.8062,-77.474,1,'','','','bull-run-regional-park-centreville-virginia-8a71618e-b80b-456d-b4fa-c838918cfeba','2015-05-20 15:19:04','2015-05-20 15:19:04',NULL),(17,'Harlem YMCA',NULL,0,0,'180 W 135th St','','New York','New York','10030','',40.8147,-73.943,1,'','','','harlem-ymca-new-york-new-york','2015-05-20 15:19:55','2015-05-20 15:19:55',NULL);
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fans`
--

DROP TABLE IF EXISTS `fans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `fannable_id` int(11) DEFAULT NULL,
  `fannable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fans_on_fannable_id_and_fannable_type` (`fannable_id`,`fannable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fans`
--

LOCK TABLES `fans` WRITE;
/*!40000 ALTER TABLE `fans` DISABLE KEYS */;
INSERT INTO `fans` VALUES (1,9,9,'User','2015-05-07 00:17:02','2015-05-07 00:17:02');
/*!40000 ALTER TABLE `fans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identity_checks`
--

DROP TABLE IF EXISTS `identity_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identity_checks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_checks`
--

LOCK TABLES `identity_checks` WRITE;
/*!40000 ALTER TABLE `identity_checks` DISABLE KEYS */;
/*!40000 ALTER TABLE `identity_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leagues`
--

DROP TABLE IF EXISTS `leagues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leagues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `sport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_leagues_on_slug` (`slug`),
  KEY `index_leagues_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leagues`
--

LOCK TABLES `leagues` WRITE;
/*!40000 ALTER TABLE `leagues` DISABLE KEYS */;
INSERT INTO `leagues` VALUES (1,'Baltimore County Public Schools','df','','Maryland','baltimore-county-public-schools-maryland','2015-04-18 02:42:43','2015-04-18 02:42:43'),(2,'MEAC','LKNLSKDNFL','','Mid-Atlantic','meac-mid-atlantic','2015-04-27 22:33:31','2015-04-27 22:33:31'),(3,'California Sports Conference','League','','California','california-sports-conference-california','2015-05-20 14:53:37','2015-05-20 14:53:37'),(4,'Bayou Women\'s Semi-Professional','BBall','Basketball','Lousiana','bayou-women-s-semi-professional-lousiana','2015-05-20 14:54:19','2015-05-20 14:54:19'),(5,'Khadijah Interstate Triathlon Association','Triathletes only','Triathlon','Interstate','khadijah-interstate-triathlon-association-interstate','2015-05-20 14:55:12','2015-05-20 14:55:12'),(6,'Miami Athletic Conference','High School League','','Florida','miami-athletic-conference-florida','2015-05-20 14:56:16','2015-05-20 14:56:16'),(7,'Florida Adult League','Flag ','Flag Football','Florida','florida-adult-league-florida','2015-05-20 14:56:46','2015-05-20 14:56:46'),(8,'Kentucky Derby','Equestrian','Horse Racing','Kentucky','kentucky-derby-kentucky','2015-05-20 14:59:30','2015-05-20 14:59:30');
/*!40000 ALTER TABLE `leagues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurables`
--

DROP TABLE IF EXISTS `measurables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `measurable` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurables`
--

LOCK TABLES `measurables` WRITE;
/*!40000 ALTER TABLE `measurables` DISABLE KEYS */;
INSERT INTO `measurables` VALUES (2,9,NULL,'40y Dash','4.23','Football','2015-05-07 00:13:38','2015-05-07 00:13:38'),(3,9,NULL,'40y Dash','4.19','Football','2015-05-07 00:14:56','2015-05-07 00:14:56');
/*!40000 ALTER TABLE `measurables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `mediable_id` int(11) DEFAULT NULL,
  `mediable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_media_on_mediable_id_and_mediable_type` (`mediable_id`,`mediable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupations`
--

DROP TABLE IF EXISTS `occupations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occupations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `current_job` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupations`
--

LOCK TABLES `occupations` WRITE;
/*!40000 ALTER TABLE `occupations` DISABLE KEYS */;
/*!40000 ALTER TABLE `occupations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent_children`
--

DROP TABLE IF EXISTS `parent_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parent_children` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `child_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_children`
--

LOCK TABLES `parent_children` WRITE;
/*!40000 ALTER TABLE `parent_children` DISABLE KEYS */;
INSERT INTO `parent_children` VALUES (2,2,1,'2015-05-06 16:25:54','2015-05-06 16:25:54');
/*!40000 ALTER TABLE `parent_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_owner_id` int(11) DEFAULT NULL,
  `photo_owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `main` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_photos_on_photo_owner_id` (`photo_owner_id`),
  KEY `index_photos_on_photo_owner_type` (`photo_owner_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,6,'School','soccer-i.png',1);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `height_ft` int(11) DEFAULT NULL,
  `height_in` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `guardian` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `guardian_phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `elementary_school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `highschool` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `undergraduate_school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `graduate_school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doctorate_school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `undergraduate_degree` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `graduate_degree` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doctorate_degree` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `undergraduate_major` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `graduate_major` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doctorate_major` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `undergraduate_year` int(11) DEFAULT NULL,
  `graduate_year` int(11) DEFAULT NULL,
  `doctorate_year` int(11) DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offseason_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `focus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `specialties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `skills` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `injuries` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `current_ailments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hudl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pinterest` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foursquare` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `favorite_pro_team` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `favorite_college_team` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `favorite_pro_athlete` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hobbies` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gyms` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `song` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_profiles_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,2,5,10,170,'1985-05-12',NULL,NULL,NULL,'http://www.linkedin.com/myname','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-07 22:27:35','2015-05-19 19:00:44','','','','','','','','',NULL,NULL,NULL),(2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-07 23:11:09','2015-04-07 23:11:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-09 15:00:39','2015-04-09 15:00:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-18 05:50:31','2015-04-18 05:50:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-18 14:53:16','2015-04-18 14:53:16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,9,6,2,195,NULL,NULL,NULL,NULL,'http://www.twitter.com/dfrank42','facebook.com','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-07 00:10:23','2015-05-07 00:15:58','','','','','','','','',NULL,NULL,NULL),(17,23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-17 17:00:41','2015-05-17 17:00:41',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:36:48','2015-05-20 15:36:48',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:38:31','2015-05-20 15:38:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:39:57','2015-05-20 15:39:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:40:57','2015-05-20 15:40:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationships`
--

DROP TABLE IF EXISTS `relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `head` tinyint(1) DEFAULT NULL,
  `head_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `participant` tinyint(1) DEFAULT NULL,
  `participant_classification` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quote` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `rejected` tinyint(1) DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `mobile_phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationships`
--

LOCK TABLES `relationships` WRITE;
/*!40000 ALTER TABLE `relationships` DISABLE KEYS */;
INSERT INTO `relationships` VALUES (1,2,5,1,NULL,1,'Sophomore','PG,SG','\"Work hard, ball weaker.\"',NULL,NULL,'men-s-varsity-basketball-c-stanfield','2015-04-18 05:31:57','2015-05-20 13:18:56',NULL,0),(4,8,7,NULL,NULL,1,'Senior','Center','\"Make it Nasty\"',1,NULL,'women-s-basketball-k-coakley','2015-04-18 14:55:58','2015-04-18 14:56:37',NULL,0),(5,8,6,1,'Assistant Coach',1,'Senior','Midfielder','\"Pele in this joint\"',1,NULL,'men-s-soccer-k-coakley','2015-04-18 14:57:10','2015-04-18 15:14:29',NULL,0),(6,6,6,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'men-s-soccer-payton','2015-04-18 18:02:52','2015-04-18 19:32:05',NULL,0),(7,2,6,0,NULL,1,NULL,NULL,NULL,NULL,NULL,'men-s-soccer-c-stanfield','2015-04-27 22:18:53','2015-05-19 18:35:27',NULL,0),(8,2,10,NULL,NULL,1,NULL,NULL,NULL,1,NULL,'junior-varsity-fencing-c-stanfield','2015-04-27 22:25:15','2015-05-19 16:59:05',NULL,0),(9,2,11,NULL,NULL,1,'Junior','DB, RB, K','\"All world athlete, chea!\"',1,NULL,'florida-a-m-rattlers-c-stanfield','2015-04-27 23:14:33','2015-05-19 16:59:21',NULL,0),(26,28,5,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'men-s-varsity-basketball-k-shiawa','2015-05-20 15:42:11','2015-05-20 15:42:11',NULL,0);
/*!40000 ALTER TABLE `relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20150407212944'),('20150407213356'),('20150407214116'),('20150413123509'),('20150417165447'),('20150417170653'),('20150417171634'),('20150417224325'),('20150418040539'),('20150420173328'),('20150420174705'),('20150421173143'),('20150421211314'),('20150429174842'),('20150429183304'),('20150429205543'),('20150505175615'),('20150506012234'),('20150506103211'),('20150506104802'),('20150506105125'),('20150506105647'),('20150506134431'),('20150506134705'),('20150506144835'),('20150506160142'),('20150516163109'),('20150517182242'),('20150518122740'),('20150518160953'),('20150518163112'),('20150518175657'),('20150518183232'),('20150519115308'),('20150519123124'),('20150519144056'),('20150520035951'),('20150520040053');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `classification` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abbreviation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `gmaps` tinyint(1) DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_schools_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (6,'Randallstown High School','High School','RHS','4000 Offutt Road','','Randallstown','Maryland','21133','',39.3829,-76.7985,1,'','','','randallstown-high-school-randallstown-maryland',NULL,'2015-04-18 01:36:17','2015-04-18 01:36:17'),(7,'Kearny High School','High School','KHS','	7651 Wellington Way','','San Diego','California','92111','',32.8011,-117.16,1,'','','','kearny-high-school-san-diego-california',NULL,'2015-04-18 14:54:59','2015-04-18 14:54:59'),(9,'Teddy Ruxpin','College','TRC','1600 Pennsylvania Avenue','','Washington','DC','','',38.8787,-76.9817,1,'','','','teddy-ruxpin-washington-dc',NULL,'2015-05-06 16:45:08','2015-05-06 16:45:08'),(10,'DeMatha High School','High School','DHS','4313 Madison Street','','Hyattsville','Maryland','20781','',38.9585,-76.9425,1,'','','http://www.dematha.org/','dematha-high-school-hyattsville-maryland',NULL,'2015-05-20 15:24:20','2015-05-20 15:24:20'),(11,'Forest Park High','High School','FPHS','3701 Eldorado Ave','','Baltimore','Maryland','21207','',39.3326,-76.6898,1,'','','http://www.baltimorecityschools.org/406','forest-park-high-baltimore-maryland',NULL,'2015-05-20 15:26:01','2015-05-20 15:26:01'),(12,'Kingwood High School','High School','KHS','2701 Kingwood Drive','','Kingwood','Texas','77339','',30.0452,-95.1953,1,'','','http://www.humbleisd.net/KHS','kingwood-high-school-kingwood-texas',NULL,'2015-05-20 15:33:22','2015-05-20 15:33:22');
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sport_icons`
--

DROP TABLE IF EXISTS `sport_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sport_icons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sport_id` int(11) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport_icons`
--

LOCK TABLES `sport_icons` WRITE;
/*!40000 ALTER TABLE `sport_icons` DISABLE KEYS */;
INSERT INTO `sport_icons` VALUES (3,12,'fb1.png','2015-05-06 23:09:13','2015-05-06 23:09:13'),(4,13,'basketball-icon.png','2015-05-06 23:10:06','2015-05-06 23:10:06'),(5,14,'soccer-i.png','2015-05-06 23:11:47','2015-05-06 23:11:47');
/*!40000 ALTER TABLE `sport_icons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sport_photos`
--

DROP TABLE IF EXISTS `sport_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sport_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sport_id` int(11) NOT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sport_photos_on_sport_id` (`sport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport_photos`
--

LOCK TABLES `sport_photos` WRITE;
/*!40000 ALTER TABLE `sport_photos` DISABLE KEYS */;
INSERT INTO `sport_photos` VALUES (9,12,'fb1.png','2015-05-06 23:09:11','2015-05-06 23:09:11'),(10,13,'basketball-icon.png','2015-05-06 23:10:04','2015-05-06 23:10:04'),(11,14,'soccer-i.png','2015-05-06 23:11:46','2015-05-06 23:11:46');
/*!40000 ALTER TABLE `sport_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sports`
--

DROP TABLE IF EXISTS `sports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sports`
--

LOCK TABLES `sports` WRITE;
/*!40000 ALTER TABLE `sports` DISABLE KEYS */;
INSERT INTO `sports` VALUES (12,'Football','2015-05-06 23:09:11','2015-05-06 23:09:11'),(13,'Basketball','2015-05-06 23:10:04','2015-05-06 23:10:04'),(14,'Soccer','2015-05-06 23:11:46','2015-05-06 23:11:46');
/*!40000 ALTER TABLE `sports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_facilities`
--

DROP TABLE IF EXISTS `team_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `facility_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_facilities`
--

LOCK TABLES `team_facilities` WRITE;
/*!40000 ALTER TABLE `team_facilities` DISABLE KEYS */;
INSERT INTO `team_facilities` VALUES (2,5,9,'2015-05-17 17:02:32','2015-05-17 17:02:32');
/*!40000 ALTER TABLE `team_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_leagues`
--

DROP TABLE IF EXISTS `team_leagues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_leagues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `league_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_leagues`
--

LOCK TABLES `team_leagues` WRITE;
/*!40000 ALTER TABLE `team_leagues` DISABLE KEYS */;
INSERT INTO `team_leagues` VALUES (25,5,1,'2015-05-18 20:11:46','2015-05-18 20:11:46'),(26,5,2,'2015-05-18 20:11:47','2015-05-18 20:11:47');
/*!40000 ALTER TABLE `team_leagues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) DEFAULT NULL,
  `league_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (5,6,NULL,'Men\'s Varsity Basketball','Basketball','men-s-varsity-basketball-randallstown-high-school-basketball','2015-04-18 03:23:21','2015-04-18 03:23:21'),(6,6,NULL,'Men\'s Soccer','Soccer','men-s-soccer-randallstown-high-school-soccer','2015-04-18 03:28:00','2015-04-18 03:28:00'),(7,7,NULL,'Women\'s Basketball','Basketball','women-s-basketball-kearny-high-school-basketball','2015-04-18 14:55:47','2015-04-18 14:55:47'),(8,NULL,NULL,'Boys & Girls Club','Running','boys-girls-club-running','2015-04-18 15:00:50','2015-04-18 15:00:50'),(9,NULL,NULL,'black run organization','Running','black-run-organization-running','2015-04-27 22:10:26','2015-04-27 22:10:26'),(10,6,NULL,'Junior Varsity Fencing','Fencing','junior-varsity-fencing-randallstown-high-school-fencing','2015-04-27 22:24:36','2015-04-27 22:24:36'),(11,NULL,NULL,'Florida A&M Rattlers','Football','florida-a-m-rattlers-football','2015-04-27 23:14:19','2015-04-27 23:14:19'),(12,6,NULL,'Volleyball','Volleyball','volleyball-randallstown-high-school-volleyball','2015-05-05 19:00:30','2015-05-05 19:00:30'),(14,9,NULL,'Varsity Football','Football','varsity-football-teddy-ruxpin-football','2015-05-06 17:07:12','2015-05-06 17:07:12');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile_pictures`
--

DROP TABLE IF EXISTS `user_profile_pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile_pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_profile_pictures_on_user_id` (`user_id`),
  KEY `index_user_profile_pictures_on_photo` (`photo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile_pictures`
--

LOCK TABLES `user_profile_pictures` WRITE;
/*!40000 ALTER TABLE `user_profile_pictures` DISABLE KEYS */;
INSERT INTO `user_profile_pictures` VALUES (1,2,'Screen_Shot_2015-05-14_at_1.15.28_PM.png','2015-05-19 19:18:42','2015-05-19 19:18:42');
/*!40000 ALTER TABLE `user_profile_pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password_digest` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `suffix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `authentication_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `categories` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invited_by_id` int(11) DEFAULT NULL,
  `invitation_count` int(11) DEFAULT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_recipient_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_subscription_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `temporary_school_ids` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_authentication_token` (`authentication_token`),
  UNIQUE KEY `index_users_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'$2a$10$Kc8ui5/gVsQgVa5lkpwxj.kZr11kIA/9Emw1k27BI1l14YCrNDNKC','cordis.stanfield@gmail.com','miler350',NULL,'cordis','smoods','stanfield',NULL,NULL,NULL,'8lDT0f3ZrcQpa3daNnrV-Q','cordis-stanfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-04-07 22:27:35','2015-05-19 13:09:22',NULL,NULL,NULL,NULL),(5,'$2a$10$AWOoTUXIwh.Dea4y/ICADufA080y0WndCHO0IKASuYwOzzVMly2Qm','dg@dg.com',NULL,NULL,'David',NULL,'Gibson',NULL,NULL,NULL,'KNwGOWWLPkaaqU1jPGfTag','david-gibson',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-04-18 05:42:16','2015-04-18 05:42:16',NULL,NULL,NULL,NULL),(6,'$2a$10$EuIPuGBHE6OZJ8XSm8mS7ODl/3NF.fDQQqwlxJeMEJBqgXjseVIL6','tp@tp.com',NULL,NULL,'Thad',NULL,'Payton',NULL,NULL,NULL,'OoA07hHXYAOara7E9BT0BA','thad-payton',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-04-18 05:42:37','2015-04-18 05:42:37',NULL,NULL,NULL,NULL),(8,'$2a$10$N1nk7cQK4eN2DVyvYnqWZuq8zRypSbGpfrTIfb/n1laBr01gjsMdW','kc@kc.com',NULL,NULL,'Khadijah',NULL,'Coakley',NULL,NULL,NULL,'dgKhQYbxtR6ZkHXzBEr38g','khadijah-coakley',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-04-18 14:53:16','2015-04-18 14:53:16',NULL,NULL,NULL,NULL),(9,'$2a$10$g7Zkk.HuHgUC9pZjxRF9IOYLf9/4kssbiqLEeQH64XjVbgsgMk5PC','df@df.com','dfrank42',NULL,'Dwight','','Franklin',NULL,NULL,NULL,'uiFLyy0L9GmPGURS3CnE-g','dwight-franklin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-07 00:10:23','2015-05-07 00:12:44',NULL,NULL,NULL,NULL),(23,'$2a$10$wOE4rC4DmalD7DsdcWDQxOnjzIt.lspW9CVsemos1UBgZoRhA/pk2','',NULL,NULL,'Raymond',NULL,'Gayle',NULL,NULL,NULL,'n_tZLWFTaOAy46sXrpqrEQ','raymond-gayle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-17 17:00:41','2015-05-17 17:00:41',NULL,NULL,'4437998526',NULL),(24,'$2a$10$1hwhHjhB6/PXpSb8jGk/ROfUyI7u6GxnLS10BrrynnWPjQetrvoUe','mcollins@mc.com',NULL,NULL,'Marty ',NULL,'Collins',NULL,NULL,NULL,'QzZ66QGktL-CHqkDmT3n6Q','marty-collins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:36:48','2015-05-20 15:36:48',NULL,NULL,NULL,NULL),(26,'$2a$10$4gOkTFmKJJ.ggKjOnqLhNORlXAeoudPd146UjpsMo1af..od.uhiG','grichards@gr.com',NULL,NULL,'George',NULL,'Richards',NULL,NULL,NULL,'OkflHJ7SVYqcB_w56U62Xw','george-richards',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:38:31','2015-05-20 15:38:31',NULL,NULL,NULL,NULL),(27,'$2a$10$U4OIacMlw/UxR.UNEvNiBucX9XuQcyY.ZJdEue3hLf.aTGpG9MuFi','tdiego@td.com',NULL,NULL,'Tony',NULL,'Diego',NULL,NULL,NULL,'C4OGn_6WnIaXVjFgzfpxLA','tony-diego',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:39:57','2015-05-20 15:39:57',NULL,NULL,NULL,NULL),(28,'$2a$10$FI/4LMa5j/Wz87rWG6nT8.s7ek4OFB.7rzXlOzGWwmfsoLuod6OdS','kshiawa@ks.com',NULL,NULL,'Kanuko',NULL,'Shiawa',NULL,NULL,NULL,'OVBdb0rznzGLPUCW1drMEg','kanuko-shiawa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:40:57','2015-05-20 15:40:57',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-20 12:06:44
