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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,'locker room','2015-05-18 19:26:14','2015-05-18 19:26:14'),(3,'pool','2015-05-18 20:09:36','2015-05-18 20:09:36'),(4,'towel service','2015-05-21 21:16:02','2015-05-21 21:16:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athletic_directors`
--

LOCK TABLES `athletic_directors` WRITE;
/*!40000 ALTER TABLE `athletic_directors` DISABLE KEYS */;
INSERT INTO `athletic_directors` VALUES (6,2,9,NULL,NULL,NULL,'2015-06-22 22:07:45','2015-06-22 22:07:45');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendees`
--

LOCK TABLES `attendees` WRITE;
/*!40000 ALTER TABLE `attendees` DISABLE KEYS */;
INSERT INTO `attendees` VALUES (4,87,2,NULL,NULL,1,'2015-07-08 17:31:24','2015-07-08 19:00:34'),(5,85,2,NULL,NULL,1,'2015-07-08 18:36:22','2015-07-08 19:00:27'),(6,91,2,1,NULL,NULL,'2015-07-08 18:52:54','2015-07-08 18:53:00'),(7,86,2,NULL,NULL,1,'2015-07-08 19:00:29','2015-07-08 19:00:31');
/*!40000 ALTER TABLE `attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attending_teams`
--

DROP TABLE IF EXISTS `attending_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attending_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `tournament_id` int(11) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `paid` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attending_teams`
--

LOCK TABLES `attending_teams` WRITE;
/*!40000 ALTER TABLE `attending_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `attending_teams` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
INSERT INTO `certificates` VALUES (1,2,7,'2015-06-17',1,'2015-06-04 14:43:50','2015-06-04 14:43:50'),(4,63,7,'2015-07-11',1,'2015-06-18 22:29:01','2015-07-06 21:25:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certification_badges`
--

LOCK TABLES `certification_badges` WRITE;
/*!40000 ALTER TABLE `certification_badges` DISABLE KEYS */;
INSERT INTO `certification_badges` VALUES (1,6,'Screen_Shot_2015-05-14_at_1.15.21_PM.png','2015-05-18 15:05:26','2015-05-18 15:05:26'),(2,7,'soccer-i.png','2015-05-21 21:08:43','2015-05-21 21:08:43');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certifications`
--

LOCK TABLES `certifications` WRITE;
/*!40000 ALTER TABLE `certifications` DISABLE KEYS */;
INSERT INTO `certifications` VALUES (6,'new with','new new','2015-05-18 15:05:26','2015-05-18 15:05:26'),(7,'CPR certification','some org','2015-05-21 21:08:43','2015-05-21 21:08:43');
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
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classifications`
--

LOCK TABLES `classifications` WRITE;
/*!40000 ALTER TABLE `classifications` DISABLE KEYS */;
INSERT INTO `classifications` VALUES (10,9,'Parent','2015-05-07 00:11:00','2015-05-07 00:11:00'),(24,26,'Athletic Director','2015-05-20 15:38:59','2015-05-20 15:38:59'),(25,27,'Athlete','2015-05-20 15:40:06','2015-05-20 15:40:06'),(26,27,'Coach','2015-05-20 15:40:07','2015-05-20 15:40:07'),(27,28,'Coach','2015-05-20 15:41:03','2015-05-20 15:41:03'),(28,29,'Athlete','2015-05-21 21:02:13','2015-05-21 21:02:13'),(29,29,'Coach','2015-05-21 21:02:15','2015-05-21 21:02:15'),(30,29,'Athletic Director','2015-05-21 21:02:17','2015-05-21 21:02:17'),(31,33,'Student Athlete','2015-05-22 18:05:26','2015-05-22 18:05:26'),(51,34,'Student Athlete','2015-06-05 18:37:10','2015-06-05 18:37:10'),(52,35,'Student Athlete','2015-06-05 18:38:44','2015-06-05 18:38:44'),(59,36,'Student Athlete','2015-06-05 19:20:48','2015-06-05 19:20:48'),(60,37,'Student Athlete','2015-06-12 15:23:51','2015-06-12 15:23:51'),(61,37,'Coach','2015-06-12 15:23:51','2015-06-12 15:23:51'),(62,38,'Student Athlete','2015-06-12 15:31:18','2015-06-12 15:31:18'),(63,38,'Coach','2015-06-12 15:31:18','2015-06-12 15:31:18'),(64,39,'Student Athlete','2015-06-12 15:31:57','2015-06-12 15:31:57'),(65,39,'Coach','2015-06-12 15:31:57','2015-06-12 15:31:57'),(66,40,'Student Athlete','2015-06-12 15:34:25','2015-06-12 15:34:25'),(67,40,'Coach','2015-06-12 15:34:25','2015-06-12 15:34:25'),(68,41,'Student Athlete','2015-06-12 15:35:54','2015-06-12 15:35:54'),(69,41,'Coach','2015-06-12 15:35:54','2015-06-12 15:35:54'),(70,42,'Student Athlete','2015-06-12 15:40:26','2015-06-12 15:40:26'),(71,42,'Coach','2015-06-12 15:40:26','2015-06-12 15:40:26'),(72,43,'Student Athlete','2015-06-12 15:42:49','2015-06-12 15:42:49'),(73,43,'Coach','2015-06-12 15:42:49','2015-06-12 15:42:49'),(74,44,'Student Athlete','2015-06-12 15:43:14','2015-06-12 15:43:14'),(75,44,'Coach','2015-06-12 15:43:14','2015-06-12 15:43:14'),(76,45,'Student Athlete','2015-06-12 15:44:34','2015-06-12 15:44:34'),(77,45,'Coach','2015-06-12 15:44:34','2015-06-12 15:44:34'),(78,46,'Student Athlete','2015-06-12 15:45:17','2015-06-12 15:45:17'),(79,46,'Coach','2015-06-12 15:45:17','2015-06-12 15:45:17'),(80,47,'Student Athlete','2015-06-12 15:45:54','2015-06-12 15:45:54'),(94,54,'Student Athlete','2015-06-13 19:06:02','2015-06-13 19:06:02'),(95,54,'Coach','2015-06-13 19:06:02','2015-06-13 19:06:02'),(96,55,'Student Athlete','2015-06-13 19:18:35','2015-06-13 19:18:35'),(97,55,'Coach','2015-06-13 19:18:35','2015-06-13 19:18:35'),(98,59,'Student Athlete','2015-06-16 16:02:14','2015-06-16 16:02:14'),(99,59,'Coach','2015-06-16 16:02:14','2015-06-16 16:02:14'),(100,60,'Student Athlete','2015-06-16 17:58:14','2015-06-16 17:58:14'),(101,60,'Coach','2015-06-16 17:58:14','2015-06-16 17:58:14'),(102,61,'Student Athlete','2015-06-16 18:02:08','2015-06-16 18:02:08'),(103,63,'Student Athlete','2015-06-18 22:11:44','2015-06-18 22:11:44'),(104,63,'Athlete','2015-06-18 22:12:13','2015-06-18 22:12:13'),(105,63,'Coach','2015-06-18 22:12:14','2015-06-18 22:12:14'),(106,63,'Parent','2015-06-18 22:12:14','2015-06-18 22:12:14'),(109,64,'Athlete','2015-06-18 22:41:43','2015-06-18 22:41:43'),(110,65,'Athlete','2015-06-18 22:47:57','2015-06-18 22:47:57'),(111,63,'Athlete','2015-06-19 01:52:32','2015-06-19 01:52:32'),(112,63,'Athlete','2015-06-19 01:57:47','2015-06-19 01:57:47'),(113,63,'Athlete','2015-06-19 02:04:28','2015-06-19 02:04:28'),(114,66,'Athlete','2015-06-19 03:36:04','2015-06-19 03:36:04'),(116,75,'Student Athlete','2015-06-22 12:48:19','2015-06-22 12:48:19'),(123,76,'Student Athlete','2015-06-22 14:37:45','2015-06-22 14:37:45'),(128,2,'Student Athlete','2015-06-23 15:26:35','2015-06-23 15:26:35'),(129,2,'Athlete','2015-06-23 15:26:36','2015-06-23 15:26:36'),(130,2,'Coach','2015-06-23 15:26:37','2015-06-23 15:26:37'),(131,2,'Parent','2015-06-23 15:30:16','2015-06-23 15:30:16'),(132,77,'Student Athlete','2015-06-23 15:47:30','2015-06-23 15:47:30'),(133,2,'Athletic Director','2015-06-30 00:01:45','2015-06-30 00:01:45'),(134,79,'Student Athlete','2015-07-01 21:44:05','2015-07-01 21:44:05'),(139,84,'Student Athlete','2015-07-07 00:37:50','2015-07-07 00:37:50');
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_facilities`
--

LOCK TABLES `event_facilities` WRITE;
/*!40000 ALTER TABLE `event_facilities` DISABLE KEYS */;
INSERT INTO `event_facilities` VALUES (1,20,NULL,NULL,'2015-04-21 19:02:39','2015-04-21 19:02:39'),(2,21,NULL,NULL,'2015-04-21 19:02:43','2015-04-21 19:02:43'),(3,22,3,NULL,'2015-04-21 19:03:41','2015-04-21 19:03:41'),(4,23,3,NULL,'2015-04-24 16:21:58','2015-04-24 16:21:58'),(5,24,3,NULL,'2015-04-27 22:39:51','2015-04-27 22:39:51'),(6,25,3,NULL,'2015-04-27 22:40:16','2015-04-27 22:40:16'),(7,26,3,NULL,'2015-05-05 17:44:58','2015-05-05 17:44:58'),(8,27,3,NULL,'2015-05-05 23:50:54','2015-05-05 23:50:54'),(9,28,3,NULL,'2015-05-06 22:39:55','2015-05-06 22:39:55'),(10,28,9,NULL,'2015-05-21 21:17:45','2015-05-21 21:17:45'),(11,41,10,NULL,'2015-05-22 16:31:02','2015-05-22 16:31:02'),(12,42,9,NULL,'2015-05-27 06:13:02','2015-05-27 06:13:02'),(13,43,3,NULL,'2015-05-27 06:14:00','2015-05-27 06:14:00'),(14,44,12,NULL,'2015-06-05 16:12:22','2015-06-05 16:12:22'),(15,45,3,NULL,'2015-06-05 16:18:07','2015-06-05 16:18:07'),(16,46,3,NULL,'2015-06-05 16:18:27','2015-06-05 16:18:27'),(17,47,3,NULL,'2015-06-05 16:20:00','2015-06-05 16:20:00'),(18,48,3,NULL,'2015-06-05 16:20:49','2015-06-05 16:20:49'),(19,49,3,NULL,'2015-06-05 16:23:19','2015-06-05 16:23:19'),(20,50,9,NULL,'2015-06-05 16:46:23','2015-06-05 16:46:23'),(21,51,3,NULL,'2015-06-05 17:05:02','2015-06-05 17:05:02'),(22,52,3,NULL,'2015-06-05 17:13:20','2015-06-05 17:13:20'),(23,53,3,NULL,'2015-06-05 18:10:28','2015-06-05 18:10:28'),(24,54,3,NULL,'2015-06-05 18:13:48','2015-06-05 18:13:48'),(25,55,3,NULL,'2015-06-05 18:13:58','2015-06-05 18:13:58'),(26,56,3,NULL,'2015-06-05 18:14:20','2015-06-05 18:14:20'),(27,57,3,NULL,'2015-06-05 18:15:40','2015-06-05 18:15:40'),(28,58,3,NULL,'2015-06-05 18:15:41','2015-06-05 18:15:41'),(29,59,3,NULL,'2015-06-05 18:16:54','2015-06-05 18:16:54'),(30,60,3,NULL,'2015-06-05 18:16:56','2015-06-05 18:16:56'),(31,61,3,NULL,'2015-06-05 18:16:58','2015-06-05 18:16:58'),(32,62,3,NULL,'2015-06-05 18:19:07','2015-06-05 18:19:07'),(33,63,3,NULL,'2015-06-05 18:19:09','2015-06-05 18:19:09'),(34,64,3,NULL,'2015-06-05 18:19:09','2015-06-05 18:19:09'),(35,65,3,NULL,'2015-06-05 18:19:10','2015-06-05 18:19:10'),(36,66,3,NULL,'2015-06-05 18:19:12','2015-06-05 18:19:12'),(37,67,3,NULL,'2015-06-05 18:20:38','2015-06-05 18:20:38'),(38,68,3,NULL,'2015-06-05 18:22:02','2015-06-05 18:22:02'),(39,69,9,NULL,'2015-06-05 18:26:26','2015-06-05 18:26:26'),(40,70,3,NULL,'2015-06-05 18:28:24','2015-06-05 18:28:24'),(41,71,3,NULL,'2015-06-05 18:28:42','2015-06-05 18:28:42'),(42,72,3,NULL,'2015-06-05 18:28:56','2015-06-05 18:28:56'),(43,73,9,NULL,'2015-06-05 18:33:33','2015-06-05 18:33:33'),(44,74,9,NULL,'2015-06-05 18:33:50','2015-06-05 18:33:50'),(45,75,9,NULL,'2015-06-05 18:34:05','2015-06-05 18:34:05'),(46,76,9,NULL,'2015-06-05 18:34:20','2015-06-05 18:34:20'),(47,77,9,NULL,'2015-06-05 18:40:34','2015-06-05 18:40:34'),(48,78,9,NULL,'2015-06-05 18:40:49','2015-06-05 18:40:49'),(49,79,9,NULL,'2015-06-05 18:46:03','2015-06-05 18:46:03'),(51,80,9,NULL,'2015-06-16 18:08:55','2015-06-16 18:08:55'),(52,81,9,NULL,'2015-06-16 18:13:19','2015-06-16 18:13:19'),(54,83,13,NULL,'2015-06-18 23:01:42','2015-06-18 23:01:42'),(55,84,13,NULL,'2015-06-18 23:02:11','2015-06-18 23:02:11'),(56,85,9,NULL,'2015-07-01 20:03:33','2015-07-01 20:03:33'),(57,86,3,NULL,'2015-07-02 22:42:41','2015-07-02 22:42:41'),(58,87,3,NULL,'2015-07-08 16:47:39','2015-07-08 16:47:39'),(59,88,3,NULL,'2015-07-08 18:27:59','2015-07-08 18:27:59'),(60,89,3,NULL,'2015-07-08 18:28:11','2015-07-08 18:28:11'),(61,90,3,NULL,'2015-07-08 18:28:20','2015-07-08 18:28:20'),(62,91,3,NULL,'2015-07-08 18:28:27','2015-07-08 18:28:27');
/*!40000 ALTER TABLE `event_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_types`
--

DROP TABLE IF EXISTS `event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sport_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_types`
--

LOCK TABLES `event_types` WRITE;
/*!40000 ALTER TABLE `event_types` DISABLE KEYS */;
INSERT INTO `event_types` VALUES (1,'event','2015-07-01 17:05:39','2015-07-01 17:05:39',NULL),(4,'Free Throw Practice','2015-07-08 01:21:19','2015-07-08 01:21:19',24);
/*!40000 ALTER TABLE `event_types` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (81,2,5,'Team','Practice','test time','2015-07-09 04:34:27','2015-06-05 19:30:00',0,'test time',0,NULL,'1434478399-test-time','2015-06-16 18:13:19','2015-07-08 18:34:27'),(83,63,16,'Team','Practice','Ghost Note Personal Training','2015-07-09 05:34:27','2015-06-18 22:30:00',0,'PRACTICE',0,NULL,'1434668502-ghost-note-personal-training','2015-06-18 23:01:42','2015-07-08 18:34:27'),(84,63,16,'Team','Game','Ghost Note Personal Training','2015-07-09 06:34:27','2015-06-25 22:30:00',0,'game',0,NULL,'1434668531-ghost-note-personal-training','2015-06-18 23:02:11','2015-07-08 18:34:27'),(85,8,2,'User','efsd','Test Event','2015-07-09 07:34:27','2015-07-04 19:30:00',0,'sf',0,NULL,'1435781012-test-event','2015-07-01 20:03:32','2015-07-08 18:34:27'),(86,2,2,'User','Practice','Shade','2015-07-09 08:34:27','2015-07-04 19:30:00',0,'ff',0,NULL,'1435876960-shade','2015-07-02 22:42:41','2015-07-08 18:34:27'),(87,2,5,'Team','event','','2015-07-09 09:34:27','2015-07-08 17:40:00',0,'',0,NULL,'1436374058','2015-07-08 16:47:38','2015-07-08 18:34:27'),(88,2,2,'User','event','','2015-07-09 10:34:27','2015-07-08 19:27:00',0,'',0,NULL,'1436380078','2015-07-08 18:27:58','2015-07-08 18:34:27'),(89,2,2,'User','event','','2015-07-09 11:34:27','2015-07-08 19:27:00',0,'',0,NULL,'1436380091','2015-07-08 18:28:11','2015-07-08 18:34:27'),(90,2,2,'User','event','','2015-07-09 12:34:27','2015-07-08 19:27:00',0,'',0,NULL,'1436380099','2015-07-08 18:28:19','2015-07-08 18:34:27'),(91,2,2,'User','event','','2015-07-09 13:34:27','2015-07-08 19:27:00',0,'',0,NULL,'1436380107','2015-07-08 18:28:27','2015-07-08 18:34:27');
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
  `facility_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
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
-- Table structure for table `facility_types`
--

DROP TABLE IF EXISTS `facility_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facility_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility_types`
--

LOCK TABLES `facility_types` WRITE;
/*!40000 ALTER TABLE `facility_types` DISABLE KEYS */;
INSERT INTO `facility_types` VALUES (1,'gym','2015-07-01 19:56:21','2015-07-01 19:56:21'),(3,'bapp','2015-07-08 02:01:10','2015-07-08 02:04:42');
/*!40000 ALTER TABLE `facility_types` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fans`
--

LOCK TABLES `fans` WRITE;
/*!40000 ALTER TABLE `fans` DISABLE KEYS */;
INSERT INTO `fans` VALUES (1,9,9,'User','2015-05-07 00:17:02','2015-05-07 00:17:02'),(6,2,6,'School','2015-06-05 02:19:16','2015-06-05 02:19:16'),(7,2,2,'User','2015-06-22 14:33:54','2015-06-22 14:33:54'),(8,2,3,'Facility','2015-06-23 15:55:18','2015-06-23 15:55:18'),(9,2,6,'School','2015-07-02 16:10:33','2015-07-02 16:10:33'),(10,8,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(11,9,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(12,24,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(13,27,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(14,28,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(15,29,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(16,32,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(17,33,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(18,34,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(19,35,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(20,59,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(21,61,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(22,63,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(23,64,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(24,65,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(25,75,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(26,76,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(27,77,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(28,78,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35'),(29,79,2,'User','2015-07-02 16:33:35','2015-07-02 16:33:35');
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
-- Table structure for table `league_managers`
--

DROP TABLE IF EXISTS `league_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_managers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `league_id` int(11) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `rejected` tinyint(1) DEFAULT NULL,
  `mobile_phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_managers`
--

LOCK TABLES `league_managers` WRITE;
/*!40000 ALTER TABLE `league_managers` DISABLE KEYS */;
INSERT INTO `league_managers` VALUES (1,2,8,NULL,NULL,NULL,'2015-07-06 01:34:08','2015-07-06 01:34:08');
/*!40000 ALTER TABLE `league_managers` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurables`
--

LOCK TABLES `measurables` WRITE;
/*!40000 ALTER TABLE `measurables` DISABLE KEYS */;
INSERT INTO `measurables` VALUES (2,9,NULL,'40y Dash','4.23','Football','2015-05-07 00:13:38','2015-05-07 00:13:38'),(3,9,NULL,'40y Dash','4.19','Football','2015-05-07 00:14:56','2015-05-07 00:14:56'),(4,2,NULL,'40y','4.45','Football','2015-06-05 19:09:31','2015-06-05 19:09:31'),(5,2,NULL,'40y','4.39','Football','2015-06-05 19:09:57','2015-06-05 19:09:57');
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
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_media_on_mediable_id_and_mediable_type` (`mediable_id`,`mediable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,63,63,'User','2015-06-18 22:24:57','2015-06-18 22:26:09','Harden','https://www.youtube.com/watch?v=GRhHM-257mE','2015-06-18','Video'),(2,NULL,17,'Team','2015-06-19 01:40:09','2015-06-19 01:40:09','Steph','https://www.youtube.com/watch?v=EgENwP5zSbo','2015-06-19','Video'),(12,NULL,2,'User','2015-07-08 14:25:44','2015-07-08 14:25:44','LEBRON','https://www.youtube.com/watch?v=Ya2VNqgR_2I','2015-07-09','Video');
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
  `sender_id` int(11) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_children`
--

LOCK TABLES `parent_children` WRITE;
/*!40000 ALTER TABLE `parent_children` DISABLE KEYS */;
INSERT INTO `parent_children` VALUES (13,63,8,'2015-06-18 22:16:51','2015-06-18 22:16:51',NULL,NULL),(14,63,8,'2015-06-18 22:16:51','2015-06-18 22:16:51',NULL,NULL),(29,2,8,'2015-06-23 15:31:58','2015-06-23 15:31:58',NULL,NULL);
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
  `settings` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_photos_on_photo_owner_id` (`photo_owner_id`),
  KEY `index_photos_on_photo_owner_type` (`photo_owner_type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,6,'School','basketball-icon.png',1,'--- !ruby/hash:Hashie::Mash\noffset_x: \'0\'\noffset_y: \"-317\"\nzoom: \'6.984375\'\n'),(2,16,'Team','footballfield.png',1,'--- !ruby/hash:Hashie::Mash\noffset_x: \'0\'\noffset_y: \'0\'\nzoom: \'1.5263157894736843\'\n'),(3,5,'Team','Screen_Shot_2015-07-01_at_8.03.38_PM.png',1,'--- !ruby/hash:Hashie::Mash\noffset_x: \'0\'\noffset_y: \'0\'\nzoom: \'1.4688679245283018\'\n'),(5,2,'User','amerx.jpg',0,'--- !ruby/hash:Hashie::Mash {}\n'),(6,2,'User','alterG.jpg',0,'--- !ruby/hash:Hashie::Mash {}\n');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positionings`
--

DROP TABLE IF EXISTS `positionings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positionings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position_id` int(11) DEFAULT NULL,
  `positionable_id` int(11) DEFAULT NULL,
  `positionable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_positionings_on_positionable_id_and_positionable_type` (`positionable_id`,`positionable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positionings`
--

LOCK TABLES `positionings` WRITE;
/*!40000 ALTER TABLE `positionings` DISABLE KEYS */;
INSERT INTO `positionings` VALUES (1,1,21,'UserlessRelationship','2015-07-06 20:35:46','2015-07-06 20:35:46'),(2,2,21,'UserlessRelationship','2015-07-06 20:35:47','2015-07-06 20:35:47'),(7,1,165,'Relationship','2015-07-07 00:37:50','2015-07-07 00:37:50');
/*!40000 ALTER TABLE `positionings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sport_id` int(11) DEFAULT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `abbreviation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (1,NULL,'cornerback','2015-07-01 17:52:10','2015-07-01 17:52:10',NULL),(2,12,'1500m','2015-07-03 20:19:29','2015-07-07 21:41:21',''),(4,12,'Wide Receiver','2015-07-07 20:32:20','2015-07-07 20:32:20',NULL),(5,12,'Quarterback','2015-07-07 20:39:10','2015-07-07 20:39:10','QB'),(6,24,'Point Guard','2015-07-07 20:59:51','2015-07-07 20:59:51','PG');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,2,5,10,170,'1985-05-12',NULL,NULL,NULL,'http://www.linkedin.com/myname','http://www.facebook/cordis.stanfield','http://www.instagram.com/cordis','http://www.twitter.com/cordis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cary',NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-07 22:27:35','2015-06-29 23:24:17','Male','','','http://www.pinterest.com/cordis','http://www.foursqaure.com/cordis','','','',NULL,NULL,NULL),(5,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-04-18 14:53:16','2015-04-18 14:53:16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,9,6,2,195,NULL,NULL,NULL,NULL,'http://www.twitter.com/dfrank42','http://www.facebook.com/dwight.franklin32','','http://www.twitter.com/dfrank42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Akron',NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-07 00:10:23','2015-06-01 16:19:16','','','','','','','','',NULL,NULL,NULL),(18,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:36:48','2015-05-20 15:36:48',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:39:57','2015-05-20 15:39:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-20 15:40:57','2015-05-20 15:40:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,29,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-21 21:01:43','2015-05-21 21:06:56','','','','','','','','',NULL,NULL,NULL),(24,32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-21 21:30:58','2015-05-21 21:30:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,33,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-05-22 18:05:26','2015-05-22 18:05:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,34,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-05 18:37:10','2015-06-05 18:37:10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-05 18:38:44','2015-06-05 18:38:44',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,59,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-16 16:02:14','2015-06-16 16:02:14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,61,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-16 18:02:08','2015-06-16 18:02:08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,63,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-18 22:10:37','2015-06-18 22:10:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,64,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-18 22:41:42','2015-06-18 22:41:42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,65,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-18 22:47:57','2015-06-18 22:47:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,75,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-22 12:48:19','2015-06-22 12:48:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,76,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-22 14:37:45','2015-06-22 14:37:45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,77,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-23 15:47:30','2015-06-23 15:47:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,78,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-06-29 23:01:45','2015-06-29 23:01:45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,79,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-07-01 21:44:05','2015-07-01 21:44:05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,84,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'--- []\n','--- []\n','--- []\n','--- []\n','--- []\n',NULL,NULL,NULL,NULL,'2015-07-07 00:37:50','2015-07-07 00:37:50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
  `age` int(11) DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager` tinyint(1) DEFAULT NULL,
  `trainer` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationships`
--

LOCK TABLES `relationships` WRITE;
/*!40000 ALTER TABLE `relationships` DISABLE KEYS */;
INSERT INTO `relationships` VALUES (142,63,17,1,'Head Coach',1,'','',NULL,1,NULL,NULL,'2015-06-19 04:45:14','2015-06-19 14:29:33','',0,NULL,NULL,NULL,NULL),(156,2,9,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-23 15:31:30','2015-06-23 15:31:30','5047998526',0,NULL,NULL,NULL,NULL),(157,2,8,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-23 15:31:48','2015-06-23 15:31:48','5047998526',0,NULL,NULL,NULL,NULL),(158,77,5,0,NULL,1,'Junior','SF',NULL,1,NULL,NULL,'2015-06-23 15:47:30','2015-06-23 15:47:30','2023160669',0,NULL,NULL,0,0),(159,2,5,1,NULL,1,'Junior','--- []\n',NULL,1,NULL,NULL,'2015-06-30 00:01:07','2015-07-05 18:25:59','5047998526',1,NULL,NULL,NULL,NULL),(165,84,5,0,NULL,1,'g',NULL,NULL,1,NULL,NULL,'2015-07-07 00:37:50','2015-07-07 00:37:50','7776665555',0,NULL,NULL,0,0),(166,2,14,NULL,NULL,1,NULL,'--- []\n',NULL,NULL,NULL,NULL,'2015-07-07 20:05:31','2015-07-07 20:05:31',NULL,0,NULL,NULL,NULL,NULL);
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
INSERT INTO `schema_migrations` VALUES ('20150407212944'),('20150407213356'),('20150407214116'),('20150413123509'),('20150417165447'),('20150417170653'),('20150417171634'),('20150417224325'),('20150418040539'),('20150420173328'),('20150420174705'),('20150421173143'),('20150421211314'),('20150429174842'),('20150429183304'),('20150429205543'),('20150505175615'),('20150506012234'),('20150506103211'),('20150506104802'),('20150506105125'),('20150506105647'),('20150506134431'),('20150506134705'),('20150506144835'),('20150506160142'),('20150516163109'),('20150517182242'),('20150518122740'),('20150518160953'),('20150518163112'),('20150518175657'),('20150518183232'),('20150519115308'),('20150519123124'),('20150519144056'),('20150520035951'),('20150520040053'),('20150522113651'),('20150523174939'),('20150523182359'),('20150528233721'),('20150601190915'),('20150605024949'),('20150611141329'),('20150612130432'),('20150616172233'),('20150617195002'),('20150619143430'),('20150619193913'),('20150630124138'),('20150701160756'),('20150701173926'),('20150701194754'),('20150706042300'),('20150706192941'),('20150707195226'),('20150707203533'),('20150708010213'),('20150708021007');
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
  `last_payment` date DEFAULT NULL,
  `stripe_subscription_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `premium` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_schools_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (6,'Randallstown High School','High School','RHS','4000 Offutt Road','','Randallstown','Maryland','21133','',39.3829,-76.7985,1,'','','','randallstown-high-school-randallstown-maryland',NULL,'2015-04-18 01:36:17','2015-07-02 23:16:59',NULL,NULL,NULL),(7,'Kearny High School','High School','KHS','	7651 Wellington Way','','San Diego','California','92111','',32.8011,-117.16,1,'','','','kearny-high-school-san-diego-california',NULL,'2015-04-18 14:54:59','2015-04-18 14:54:59',NULL,NULL,NULL),(9,'Teddy Ruxpin','College','TRC','1600 Pennsylvania Avenue','','Washington','DC','','',38.8787,-76.9817,1,'','','','teddy-ruxpin-washington-dc',NULL,'2015-05-06 16:45:08','2015-05-06 16:45:08',NULL,NULL,NULL),(10,'DeMatha High School','High School','DHS','4313 Madison Street','','Hyattsville','Maryland','20781','',38.9585,-76.9425,1,'','','http://www.dematha.org/','dematha-high-school-hyattsville-maryland',NULL,'2015-05-20 15:24:20','2015-05-20 15:24:20',NULL,NULL,NULL),(11,'Forest Park High','High School','FPHS','3701 Eldorado Ave','','Baltimore','Maryland','21207','',39.3326,-76.6898,1,'','','http://www.baltimorecityschools.org/406','forest-park-high-baltimore-maryland',NULL,'2015-05-20 15:26:01','2015-05-20 15:26:01',NULL,NULL,NULL),(12,'Kingwood High School','High School','KHS','2701 Kingwood Drive','','Kingwood','Texas','77339','',30.0452,-95.1953,1,'','','http://www.humbleisd.net/KHS','kingwood-high-school-kingwood-texas',NULL,'2015-05-20 15:33:22','2015-05-20 15:33:22',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport_icons`
--

LOCK TABLES `sport_icons` WRITE;
/*!40000 ALTER TABLE `sport_icons` DISABLE KEYS */;
INSERT INTO `sport_icons` VALUES (3,12,'fb1.png','2015-05-06 23:09:13','2015-05-06 23:09:13'),(7,24,'basketball-icon.png','2015-06-30 16:51:25','2015-06-30 16:51:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport_photos`
--

LOCK TABLES `sport_photos` WRITE;
/*!40000 ALTER TABLE `sport_photos` DISABLE KEYS */;
INSERT INTO `sport_photos` VALUES (9,12,'fb1.png','2015-05-06 23:09:11','2015-05-06 23:09:11'),(12,24,'basketball-icon.png','2015-06-30 16:51:23','2015-06-30 16:51:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sports`
--

LOCK TABLES `sports` WRITE;
/*!40000 ALTER TABLE `sports` DISABLE KEYS */;
INSERT INTO `sports` VALUES (12,'Football','2015-05-06 23:09:11','2015-05-06 23:09:11'),(24,'Basketball','2015-06-30 16:51:23','2015-06-30 16:51:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_facilities`
--

LOCK TABLES `team_facilities` WRITE;
/*!40000 ALTER TABLE `team_facilities` DISABLE KEYS */;
INSERT INTO `team_facilities` VALUES (14,5,9,'2015-05-21 21:13:11','2015-05-21 21:13:11'),(19,5,11,'2015-06-15 16:05:37','2015-06-15 16:05:37');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_leagues`
--

LOCK TABLES `team_leagues` WRITE;
/*!40000 ALTER TABLE `team_leagues` DISABLE KEYS */;
INSERT INTO `team_leagues` VALUES (33,5,1,'2015-05-21 21:13:47','2015-05-21 21:13:47'),(34,5,2,'2015-05-21 21:13:48','2015-05-21 21:13:48');
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
  `stripe_customer_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (5,6,NULL,'Men\'s Varsity Basketball','Basketball','men-s-varsity-basketball-randallstown-high-school-basketball','2015-04-18 03:23:21','2015-04-18 03:23:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,NULL,'Men\'s Soccer','Soccer','men-s-soccer-randallstown-high-school-soccer','2015-04-18 03:28:00','2015-04-18 03:28:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,7,NULL,'Women\'s Basketball','Basketball','women-s-basketball-kearny-high-school-basketball','2015-04-18 14:55:47','2015-04-18 14:55:47',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,NULL,NULL,'Boys & Girls Club','Running','boys-girls-club-running','2015-04-18 15:00:50','2015-04-18 15:00:50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,NULL,NULL,'black run organization','Running','black-run-organization-running','2015-04-27 22:10:26','2015-04-27 22:10:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,6,NULL,'Junior Varsity Fencing','Fencing','junior-varsity-fencing-randallstown-high-school-fencing','2015-04-27 22:24:36','2015-04-27 22:24:36',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,NULL,NULL,'Florida A&M Rattlers','Football','florida-a-m-rattlers-football','2015-04-27 23:14:19','2015-04-27 23:14:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,6,NULL,'Volleyball','Volleyball','volleyball-randallstown-high-school-volleyball','2015-05-05 19:00:30','2015-05-05 19:00:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,9,NULL,'Varsity Football','Football','varsity-football-teddy-ruxpin-football','2015-05-06 17:07:12','2015-05-06 17:07:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,NULL,NULL,'Keswick Warriors','','keswick-warriors','2015-06-01 20:10:29','2015-06-01 20:10:29',NULL,NULL,'1575 Keswick Winery Drive','','Keswick','VA','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,NULL,NULL,'Ellis All Star Football','Football','ellis-all-star-football-football','2015-06-18 22:31:59','2015-06-18 22:31:59',NULL,NULL,'1600 Pennsylvania Avenue','','Washington','DC','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,NULL,NULL,'Test Now','Soccer','test-now-soccer','2015-06-19 01:31:32','2015-06-19 01:31:32',NULL,NULL,'1600 Pennsylvania Avenue','','Washington','DC','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournaments`
--

DROP TABLE IF EXISTS `tournaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournaments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `active` tinyint(1) DEFAULT NULL,
  `director_paid` tinyint(1) DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tournaments_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournaments`
--

LOCK TABLES `tournaments` WRITE;
/*!40000 ALTER TABLE `tournaments` DISABLE KEYS */;
INSERT INTO `tournaments` VALUES (13,2,'wth facility','Basketball','AAU','dfskl',1,NULL,'wth-facility','2015-05-22 16:31:02','2015-05-22 16:31:02');
/*!40000 ALTER TABLE `tournaments` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile_pictures`
--

LOCK TABLES `user_profile_pictures` WRITE;
/*!40000 ALTER TABLE `user_profile_pictures` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile_pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userless_relationships`
--

DROP TABLE IF EXISTS `userless_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userless_relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `head` tinyint(1) DEFAULT NULL,
  `head_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `participant` tinyint(1) DEFAULT NULL,
  `participant_classification` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `manager` tinyint(1) DEFAULT NULL,
  `trainer` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userless_relationships`
--

LOCK TABLES `userless_relationships` WRITE;
/*!40000 ALTER TABLE `userless_relationships` DISABLE KEYS */;
INSERT INTO `userless_relationships` VALUES (7,5,'Jason','Smith',1,NULL,1,'Senior','PG',NULL,'2015-06-16 15:54:52','2015-06-16 15:54:52',NULL,NULL,NULL,NULL,NULL),(12,5,'Michael','Zendol',1,'',0,'Coach','COACH','','2015-06-17 20:03:18','2015-06-22 13:45:22',NULL,NULL,0,0,0),(15,17,'Robert','Anderson',1,'Trainers',0,'','','','2015-06-19 14:46:50','2015-06-19 14:55:08',NULL,'',0,1,0),(17,5,'BOB','stewart',0,NULL,0,'Freshman','C',NULL,'2015-06-29 23:43:45','2015-06-29 23:43:45',NULL,NULL,0,1,1),(19,5,'Michael','Reid',0,NULL,1,'Junior','---\n- cornerback\n- \'1500\'\n',NULL,'2015-07-03 22:57:24','2015-07-03 22:57:24',NULL,NULL,0,0,0),(21,5,'Marcus','Garvey',0,NULL,1,'Junior',NULL,NULL,'2015-07-06 20:35:46','2015-07-06 20:35:46',NULL,NULL,0,0,0);
/*!40000 ALTER TABLE `userless_relationships` ENABLE KEYS */;
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
  `signin_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_authentication_token` (`authentication_token`),
  UNIQUE KEY `index_users_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'$2a$10$Kc8ui5/gVsQgVa5lkpwxj.kZr11kIA/9Emw1k27BI1l14YCrNDNKC','cordis.stanfield@gmail.com','miler350',NULL,'cordis','maurice','stanfield',NULL,NULL,NULL,'8lDT0f3ZrcQpa3daNnrV-Q','cordis-stanfield',1,NULL,NULL,NULL,NULL,NULL,NULL,'2015-04-07 22:27:35','2015-07-08 01:12:05',NULL,NULL,'5047998526',NULL,2),(8,'$2a$10$N1nk7cQK4eN2DVyvYnqWZuq8zRypSbGpfrTIfb/n1laBr01gjsMdW','kc@kc.com',NULL,NULL,'Khadijah',NULL,'Coakley',NULL,NULL,NULL,'dgKhQYbxtR6ZkHXzBEr38g','khadijah-coakley',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-04-18 14:53:16','2015-04-18 14:53:16',NULL,NULL,NULL,NULL,0),(9,'$2a$10$g7Zkk.HuHgUC9pZjxRF9IOYLf9/4kssbiqLEeQH64XjVbgsgMk5PC','df@df.com','dfrank42',NULL,'Dwight','','Franklin',NULL,NULL,NULL,'uiFLyy0L9GmPGURS3CnE-g','dwight-franklin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-07 00:10:23','2015-05-07 00:12:44',NULL,NULL,NULL,NULL,0),(24,'$2a$10$1hwhHjhB6/PXpSb8jGk/ROfUyI7u6GxnLS10BrrynnWPjQetrvoUe','mcollins@mc.com',NULL,NULL,'Marty ',NULL,'Collins',NULL,NULL,NULL,'QzZ66QGktL-CHqkDmT3n6Q','marty-collins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:36:48','2015-05-20 15:36:48',NULL,NULL,NULL,NULL,0),(27,'$2a$10$U4OIacMlw/UxR.UNEvNiBucX9XuQcyY.ZJdEue3hLf.aTGpG9MuFi','tdiego@td.com',NULL,NULL,'Tony',NULL,'Diego',NULL,NULL,NULL,'C4OGn_6WnIaXVjFgzfpxLA','tony-diego',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:39:57','2015-05-20 15:39:57',NULL,NULL,NULL,NULL,0),(28,'$2a$10$FI/4LMa5j/Wz87rWG6nT8.s7ek4OFB.7rzXlOzGWwmfsoLuod6OdS','kshiawa@ks.com',NULL,NULL,'Kanuko',NULL,'Shiawa',NULL,NULL,NULL,'OVBdb0rznzGLPUCW1drMEg','kanuko-shiawa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-20 15:40:57','2015-05-20 15:40:57',NULL,NULL,NULL,NULL,0),(29,'$2a$10$sYWlm8Huy253HrEYn8hgaO.zWpBe5L7ryPa3OjAYpcBc6B7BWscZC','ejenkins@google.com','ejenkins13',NULL,'Eric','Mark','Jenkins',NULL,NULL,NULL,'LqwnOtqwlHN6buN9xyasvw','eric-jenkins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-21 21:01:43','2015-05-21 21:06:56',NULL,NULL,NULL,NULL,0),(32,'$2a$10$jdoQ3.O.n3VRwZ/hPKkY.eefwvN2LuEEu/dOTr.DkY0QV6K1KcWNe','r@fdkjslkj.com',NULL,NULL,'Sorority',NULL,'Sister',NULL,NULL,NULL,'yqlMklVBxOeHH9viNwYM_w','sorority-sister',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-21 21:30:58','2015-06-16 16:01:07',NULL,NULL,'6667778888',NULL,0),(33,'$2a$10$HgYr5HuVHiAkEwnBvSTmb.LCpVZ/z.v0DjsCjkWPX7DF5QTl.QKlC','d@brady.com',NULL,NULL,'Donovan',NULL,'Brady',NULL,NULL,NULL,'WXqBhqCn0rpU9GE441UpCA','donovan-brady',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-22 18:05:25','2015-06-12 15:14:23',NULL,NULL,'4447998526',NULL,0),(34,'$2a$10$NmYuPtIW6xy6fFd8TFNRXepz2b8RTCA/XwD8rUjKXtulW9HnQla2K','thad@thad.com',NULL,NULL,'Thaddeus',NULL,'Payton',NULL,NULL,NULL,'QyflUVevA13FbREif7zGYA','thaddeus-payton',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-05 18:37:10','2015-06-05 18:38:21',NULL,NULL,'2405933717',NULL,0),(35,'$2a$10$BoCHK9j960ldzeq9.7rWCusTii/cXZhtfDvKisU7qbpICpzu11bNi','thad@max.com',NULL,NULL,'David',NULL,'Paul',NULL,NULL,NULL,'uOJ12CjdeXJFIlvg2GPABg','david-paul',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-05 18:38:44','2015-06-16 16:01:21',NULL,NULL,'7777778888',NULL,0),(59,'$2a$10$NzaJRrGF7W23/Xc4m0NAmeEH5LxUiw5jFgf6.3Zph5dj7rOMnJpqK','',NULL,NULL,'David ',NULL,'Gibson',NULL,NULL,NULL,'LeqEYCPaVIpTbCq5Ir_RpA','david-gibson',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-16 16:02:14','2015-06-16 16:02:14',NULL,NULL,'5613864491',NULL,0),(61,'$2a$10$oAq3CfhNqPqkS2BIXBez2.abFuRRhLztcxbJY5zmnTzx2nLZEMwHe','cordis.stanfield@yahoo.com',NULL,NULL,'Maurice',NULL,'Jones',NULL,NULL,NULL,'38EfezS4fY0pMdY6NifCSA','maurice-jones',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-16 18:02:08','2015-06-19 03:38:21',NULL,NULL,'6667778888',NULL,0),(63,'$2a$10$V5D5lR9sInla2GzyAgbwjOlsDqvzac1VZf1AbmxBxtmXwXKTAQ.vm','jellis@bellis.com',NULL,NULL,'James',NULL,'Ellis',NULL,NULL,NULL,'xU6X_dEGmEEzFzSpEmPbxw','james-ellis',1,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-18 22:10:37','2015-06-18 22:45:46',NULL,NULL,'4105558956',NULL,0),(64,'$2a$10$yKmJCQy/aOz5EHkNlSlpJeKK/8XnrNQBC.mjokT5JpAUQ5v/Y8Mj6','',NULL,NULL,'Brandon ',NULL,'Ellis',NULL,NULL,NULL,'tehaebz0rRKf9LlOQNZ93A','brandon-ellis',1,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-18 22:41:42','2015-06-18 22:45:03',NULL,NULL,'2024233572',NULL,0),(65,'$2a$10$m.7WA.tTa0ifIBX1yynkC.97iG.fHTRgJl.DubJwYbPVs.OW7hoXW','',NULL,NULL,'Dmitri',NULL,'Davis',NULL,NULL,NULL,'WgHPf67KzlV7HtPsNYrcZw','dmitri-davis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-18 22:47:57','2015-06-18 22:47:57',NULL,NULL,'2405055299',NULL,0),(75,'$2a$10$x6K1sVc4V22ylkEw8puSeOGNzSeIxZ0j9C0YKbsNV0Ahxo7WlhKve','',NULL,NULL,'Johnny ',NULL,'Flt',NULL,NULL,NULL,'qCGrPn971SS1OCpggcmG8w','johnny-flt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-22 12:48:19','2015-06-22 12:48:19',NULL,NULL,'4437998526',NULL,0),(76,'$2a$10$MW/.9GcknHzG7BINaij4texsmWdE3U2NiWI55q7n5wObahbIyKkxq','',NULL,NULL,'LeBron',NULL,'James',NULL,NULL,NULL,'B4YJZCyS-jaUuo9N8tdp1g','lebron-james',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-22 14:37:45','2015-06-22 14:37:45',NULL,NULL,'2024603467',NULL,0),(77,'$2a$10$XXxm3UccJP/qmIH/CQz13etY01lYfwXyPoBTB3I0kMf/bnqq7c.k2','',NULL,NULL,'Henry',NULL,'Hunter',NULL,NULL,NULL,'D8oWpGMC_eVdS1ytsUXDLw','henry-hunter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-23 15:47:30','2015-06-23 15:47:30',NULL,NULL,'2023160669',NULL,0),(78,'$2a$10$9K.S00d9Dni4JX65.z.5WOFwOUDireE.Tiq7nU5oFi3CT7t3RNj3y','@facebook.com',NULL,NULL,'Cordis',NULL,'Stanfield',NULL,NULL,NULL,'I4njH0DhTK5ebwPm8fRAdA','cordis-stanfield-1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-29 23:01:45','2015-06-29 23:01:45','facebook','8901673',NULL,NULL,0),(79,'$2a$10$GSq/pYco92joexiKcBIq3OTb6JiUeIql/R8RTDgOhbOh70ONe5X2K','',NULL,NULL,'Andwele',NULL,'Lewis',NULL,NULL,NULL,'mk_BCkiVUzmcRbuol2VaNA','andwele-lewis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-07-01 21:44:05','2015-07-01 21:44:05',NULL,NULL,'4108870660',NULL,0),(84,'$2a$10$m2r7LzozUsxm.L2sgnic5OLAaseMbrSoA.mG5VBn7VrPwjCZp7su2','',NULL,NULL,'Mary',NULL,'Ang',NULL,NULL,NULL,'pINmDXz3xPGdu6IIwUbQXQ','mary-ang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-07-07 00:37:50','2015-07-07 00:37:50',NULL,NULL,'7776665555',NULL,0);
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

-- Dump completed on 2015-07-08 18:44:33
