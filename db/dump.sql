-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: perl_rev_unit4
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `article_main`
--

DROP TABLE IF EXISTS `article_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_main` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `social_type` tinyint(4) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `article_text` text,
  `profile_img_url` varchar(500) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `favorite_cnt` int(11) DEFAULT NULL,
  `entry_date` datetime NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `main_social_type` (`social_type`),
  KEY `main_favorite_cnt` (`favorite_cnt`),
  KEY `main_entry_date` (`entry_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_main`
--

LOCK TABLES `article_main` WRITE;
/*!40000 ALTER TABLE `article_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_table`
--

DROP TABLE IF EXISTS `comment_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_table` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `article_main_seq` int(11) NOT NULL,
  `contributor` varchar(60) DEFAULT NULL,
  `coment_content` text,
  `like_cnt` int(7) DEFAULT NULL,
  `post_time` datetime NOT NULL,
  `favorite_cnt` int(11) DEFAULT NULL,
  `entry_date` datetime NOT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_table`
--

LOCK TABLES `comment_table` WRITE;
/*!40000 ALTER TABLE `comment_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-07 17:03:03
