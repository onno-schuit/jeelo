-- MySQL dump 10.13  Distrib 5.1.61, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: jeelo19
-- ------------------------------------------------------
-- Server version	5.1.61-0ubuntu0.10.10.1

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
-- Table structure for table `adodb_logsql`
--

DROP TABLE IF EXISTS `adodb_logsql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adodb_logsql` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `sql0` varchar(250) NOT NULL DEFAULT '',
  `sql1` text,
  `params` text,
  `tracer` text,
  `timer` decimal(16,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to save some logs from ADOdb';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adodb_logsql`
--

LOCK TABLES `adodb_logsql` WRITE;
/*!40000 ALTER TABLE `adodb_logsql` DISABLE KEYS */;
/*!40000 ALTER TABLE `adodb_logsql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_assignment`
--

DROP TABLE IF EXISTS `mdl_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_assignment` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `format` smallint(4) unsigned NOT NULL DEFAULT '0',
  `assignmenttype` varchar(50) NOT NULL DEFAULT '',
  `resubmit` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `preventlate` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `emailteachers` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `var1` bigint(10) DEFAULT '0',
  `var2` bigint(10) DEFAULT '0',
  `var3` bigint(10) DEFAULT '0',
  `var4` bigint(10) DEFAULT '0',
  `var5` bigint(10) DEFAULT '0',
  `maxbytes` bigint(10) unsigned NOT NULL DEFAULT '100000',
  `timedue` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeavailable` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` bigint(10) NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_assi_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Defines assignments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_assignment`
--

LOCK TABLES `mdl_assignment` WRITE;
/*!40000 ALTER TABLE `mdl_assignment` DISABLE KEYS */;
INSERT INTO `mdl_assignment` VALUES (1,6,'Test activity',' Test description ',0,'offline',0,1,0,0,0,0,0,0,100000,0,0,100,1331205183);
/*!40000 ALTER TABLE `mdl_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_assignment_submissions`
--

DROP TABLE IF EXISTS `mdl_assignment_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_assignment_submissions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `assignment` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `numfiles` bigint(10) unsigned NOT NULL DEFAULT '0',
  `data1` text,
  `data2` text,
  `grade` bigint(11) NOT NULL DEFAULT '0',
  `submissioncomment` text NOT NULL,
  `format` smallint(4) unsigned NOT NULL DEFAULT '0',
  `teacher` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemarked` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_assisubm_use_ix` (`userid`),
  KEY `mdl_assisubm_mai_ix` (`mailed`),
  KEY `mdl_assisubm_tim_ix` (`timemarked`),
  KEY `mdl_assisubm_ass_ix` (`assignment`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about submitted assignments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_assignment_submissions`
--

LOCK TABLES `mdl_assignment_submissions` WRITE;
/*!40000 ALTER TABLE `mdl_assignment_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_assignment_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_backup_config`
--

DROP TABLE IF EXISTS `mdl_backup_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_backup_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backconf_nam_uix` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='To store backup configuration variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_backup_config`
--

LOCK TABLES `mdl_backup_config` WRITE;
/*!40000 ALTER TABLE `mdl_backup_config` DISABLE KEYS */;
INSERT INTO `mdl_backup_config` VALUES (1,'backup_sche_modules','1'),(2,'backup_sche_withuserdata','0'),(3,'backup_sche_metacourse','0'),(4,'backup_sche_users','0'),(5,'backup_sche_logs','0'),(6,'backup_sche_userfiles','0'),(7,'backup_sche_coursefiles','1'),(8,'backup_sche_sitefiles','1'),(9,'backup_sche_gradebook_history','0'),(10,'backup_sche_messages','0'),(11,'backup_sche_blogs','0'),(12,'backup_sche_keep','1'),(13,'backup_sche_active','0'),(14,'backup_sche_weekdays','0000000'),(15,'backup_sche_hour','0'),(16,'backup_sche_minute','0'),(17,'backup_sche_destination','');
/*!40000 ALTER TABLE `mdl_backup_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_backup_courses`
--

DROP TABLE IF EXISTS `mdl_backup_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_backup_courses` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `laststarttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastendtime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `laststatus` varchar(1) NOT NULL DEFAULT '0',
  `nextstarttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backcour_cou_uix` (`courseid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To store every course backup status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_backup_courses`
--

LOCK TABLES `mdl_backup_courses` WRITE;
/*!40000 ALTER TABLE `mdl_backup_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_backup_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_backup_files`
--

DROP TABLE IF EXISTS `mdl_backup_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_backup_files` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backup_code` bigint(10) unsigned NOT NULL DEFAULT '0',
  `file_type` varchar(10) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `old_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `new_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backfile_bacfilpat_uix` (`backup_code`,`file_type`,`path`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='To store and recode ids to user and course files';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_backup_files`
--

LOCK TABLES `mdl_backup_files` WRITE;
/*!40000 ALTER TABLE `mdl_backup_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_backup_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_backup_ids`
--

DROP TABLE IF EXISTS `mdl_backup_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_backup_ids` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backup_code` bigint(12) unsigned NOT NULL DEFAULT '0',
  `table_name` varchar(30) NOT NULL DEFAULT '',
  `old_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `new_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `info` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backids_bactabold_uix` (`backup_code`,`table_name`,`old_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3756 DEFAULT CHARSET=utf8 COMMENT='To store and convert ids in backup/restore';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_backup_ids`
--

LOCK TABLES `mdl_backup_ids` WRITE;
/*!40000 ALTER TABLE `mdl_backup_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_backup_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_backup_log`
--

DROP TABLE IF EXISTS `mdl_backup_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_backup_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `laststarttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_backlog_cou_ix` (`courseid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To store every course backup log info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_backup_log`
--

LOCK TABLES `mdl_backup_log` WRITE;
/*!40000 ALTER TABLE `mdl_backup_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_backup_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_block`
--

DROP TABLE IF EXISTS `mdl_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_block` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT '',
  `version` bigint(10) unsigned NOT NULL DEFAULT '0',
  `cron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastcron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `multiple` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='to store installed blocks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_block`
--

LOCK TABLES `mdl_block` WRITE;
/*!40000 ALTER TABLE `mdl_block` DISABLE KEYS */;
INSERT INTO `mdl_block` VALUES (1,'activity_modules',2007101509,0,0,1,0),(2,'admin',2007101509,0,0,1,0),(3,'admin_bookmarks',2007101509,0,0,1,0),(4,'admin_tree',2007101509,0,0,1,0),(5,'blog_menu',2007101509,0,0,1,0),(6,'blog_tags',2007101509,0,0,1,1),(7,'calendar_month',2007101509,0,0,1,0),(8,'calendar_upcoming',2007101509,0,0,1,0),(9,'course_list',2007101509,0,0,1,0),(10,'course_summary',2007101509,0,0,1,0),(11,'glossary_random',2007101509,0,0,1,1),(12,'html',2007101509,0,0,1,1),(13,'loancalc',2007101509,0,0,1,0),(14,'login',2007101509,0,0,1,0),(15,'mentees',2007101509,0,0,1,1),(16,'messages',2007101509,0,0,1,0),(17,'mnet_hosts',2007101509,0,0,1,0),(18,'news_items',2007101509,0,0,1,0),(19,'online_users',2007101510,0,0,1,0),(20,'participants',2007101509,0,0,1,0),(21,'quiz_results',2007101509,0,0,1,1),(22,'recent_activity',2007101509,0,0,1,0),(23,'rss_client',2007101511,300,0,1,1),(24,'search',2008031500,1,0,1,0),(25,'search_forums',2007101509,0,0,1,0),(26,'section_links',2007101511,0,0,1,0),(27,'site_main_menu',2007101509,0,0,1,0),(28,'social_activities',2007101509,0,0,1,0),(29,'tag_flickr',2007101509,0,0,1,1),(30,'tag_youtube',2007101509,0,0,1,1),(31,'tags',2007101509,0,0,1,1);
/*!40000 ALTER TABLE `mdl_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_block_instance`
--

DROP TABLE IF EXISTS `mdl_block_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_block_instance` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `blockid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pagetype` varchar(20) NOT NULL DEFAULT '',
  `position` varchar(10) NOT NULL DEFAULT '',
  `weight` smallint(3) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `configdata` text,
  PRIMARY KEY (`id`),
  KEY `mdl_blocinst_pag_ix` (`pageid`),
  KEY `mdl_blocinst_pag2_ix` (`pagetype`),
  KEY `mdl_blocinst_blo_ix` (`blockid`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='to store block instances in pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_block_instance`
--

LOCK TABLES `mdl_block_instance` WRITE;
/*!40000 ALTER TABLE `mdl_block_instance` DISABLE KEYS */;
INSERT INTO `mdl_block_instance` VALUES (1,27,1,'course-view','l',0,1,''),(2,4,1,'course-view','l',1,1,''),(3,10,1,'course-view','r',0,1,''),(4,7,1,'course-view','r',1,1,''),(5,4,0,'admin','l',0,1,''),(6,3,0,'admin','l',1,1,''),(7,20,2,'course-view','l',0,1,''),(8,1,2,'course-view','l',1,1,''),(9,25,2,'course-view','l',2,1,''),(10,2,2,'course-view','l',3,1,''),(11,9,2,'course-view','l',4,1,''),(12,18,2,'course-view','r',0,1,''),(13,8,2,'course-view','r',1,1,''),(14,22,2,'course-view','r',2,1,''),(15,20,3,'course-view','l',0,1,''),(16,1,3,'course-view','l',1,1,''),(17,25,3,'course-view','l',2,1,''),(18,2,3,'course-view','l',3,1,''),(19,9,3,'course-view','l',4,1,''),(20,18,3,'course-view','r',0,1,''),(21,8,3,'course-view','r',1,1,''),(22,22,3,'course-view','r',2,1,''),(23,20,4,'course-view','l',0,1,''),(24,1,4,'course-view','l',1,1,''),(25,25,4,'course-view','l',2,1,''),(26,2,4,'course-view','l',3,1,''),(27,9,4,'course-view','l',4,1,''),(28,18,4,'course-view','r',0,1,''),(29,8,4,'course-view','r',1,1,''),(30,22,4,'course-view','r',2,1,''),(31,20,5,'course-view','l',0,1,''),(32,1,5,'course-view','l',1,1,''),(33,25,5,'course-view','l',2,1,''),(34,2,5,'course-view','l',3,1,''),(35,9,5,'course-view','l',4,1,''),(36,18,5,'course-view','r',0,1,''),(37,8,5,'course-view','r',1,1,''),(38,22,5,'course-view','r',2,1,''),(39,20,6,'course-view','l',0,1,''),(40,1,6,'course-view','l',1,1,''),(41,25,6,'course-view','l',2,1,''),(42,2,6,'course-view','l',3,1,''),(43,9,6,'course-view','l',4,1,''),(44,18,6,'course-view','r',0,1,''),(45,8,6,'course-view','r',1,1,''),(46,22,6,'course-view','r',2,1,''),(47,20,7,'course-view','l',0,1,''),(48,1,7,'course-view','l',1,1,''),(49,25,7,'course-view','l',2,1,''),(50,2,7,'course-view','l',3,1,''),(51,9,7,'course-view','l',4,1,''),(52,18,7,'course-view','r',0,1,''),(53,8,7,'course-view','r',1,1,''),(54,22,7,'course-view','r',2,1,''),(55,20,8,'course-view','l',0,1,''),(56,1,8,'course-view','l',1,1,''),(57,25,8,'course-view','l',2,1,''),(58,2,8,'course-view','l',3,1,''),(59,9,8,'course-view','l',4,1,''),(60,18,8,'course-view','r',0,1,''),(61,8,8,'course-view','r',1,1,''),(62,22,8,'course-view','r',2,1,''),(63,20,9,'course-view','l',0,1,''),(64,1,9,'course-view','l',1,1,''),(65,25,9,'course-view','l',2,1,''),(66,2,9,'course-view','l',3,1,''),(67,9,9,'course-view','l',4,1,''),(68,18,9,'course-view','r',0,1,''),(69,8,9,'course-view','r',1,1,''),(70,22,9,'course-view','r',2,1,''),(71,20,10,'course-view','l',0,1,''),(72,1,10,'course-view','l',1,1,''),(73,25,10,'course-view','l',2,1,''),(74,2,10,'course-view','l',3,1,''),(75,9,10,'course-view','l',4,1,''),(76,18,10,'course-view','r',0,1,''),(77,8,10,'course-view','r',1,1,''),(78,22,10,'course-view','r',2,1,''),(79,20,11,'course-view','l',0,1,'Tjs='),(80,1,11,'course-view','l',1,1,'Tjs='),(81,25,11,'course-view','l',2,1,'Tjs='),(82,2,11,'course-view','l',3,1,'Tjs='),(83,9,11,'course-view','l',4,1,'Tjs='),(84,18,11,'course-view','r',0,1,'Tjs='),(85,8,11,'course-view','r',1,1,'Tjs='),(86,22,11,'course-view','r',2,1,'Tjs='),(87,20,12,'course-view','l',0,1,'Tjs='),(88,1,12,'course-view','l',1,1,'Tjs='),(89,25,12,'course-view','l',2,1,'Tjs='),(90,2,12,'course-view','l',3,1,'Tjs='),(91,9,12,'course-view','l',4,1,'Tjs='),(92,18,12,'course-view','r',0,1,'Tjs='),(93,8,12,'course-view','r',1,1,'Tjs='),(94,22,12,'course-view','r',2,1,'Tjs='),(95,2,13,'course-view','l',0,1,'Tjs='),(96,2,14,'course-view','l',0,1,'Tjs='),(97,2,15,'course-view','l',0,1,'Tjs='),(98,2,16,'course-view','l',0,1,'Tjs='),(99,2,17,'course-view','l',0,1,'Tjs=');
/*!40000 ALTER TABLE `mdl_block_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_block_pinned`
--

DROP TABLE IF EXISTS `mdl_block_pinned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_block_pinned` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `blockid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pagetype` varchar(20) NOT NULL DEFAULT '',
  `position` varchar(10) NOT NULL DEFAULT '',
  `weight` smallint(3) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `configdata` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_blocpinn_pag_ix` (`pagetype`),
  KEY `mdl_blocpinn_blo_ix` (`blockid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to pin blocks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_block_pinned`
--

LOCK TABLES `mdl_block_pinned` WRITE;
/*!40000 ALTER TABLE `mdl_block_pinned` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_block_pinned` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_block_rss_client`
--

DROP TABLE IF EXISTS `mdl_block_rss_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_block_rss_client` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `title` text NOT NULL,
  `preferredtitle` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `shared` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Remote news feed information. Contains the news feed id, the';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_block_rss_client`
--

LOCK TABLES `mdl_block_rss_client` WRITE;
/*!40000 ALTER TABLE `mdl_block_rss_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_block_rss_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_block_search_documents`
--

DROP TABLE IF EXISTS `mdl_block_search_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_block_search_documents` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `docid` varchar(32) NOT NULL DEFAULT '',
  `doctype` varchar(32) NOT NULL DEFAULT 'none',
  `itemtype` varchar(32) NOT NULL DEFAULT 'standard',
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `docdate` bigint(10) unsigned NOT NULL DEFAULT '0',
  `updated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_blocseardocu_doc_ix` (`docid`),
  KEY `mdl_blocseardocu_doc2_ix` (`doctype`),
  KEY `mdl_blocseardocu_ite_ix` (`itemtype`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='table to store search index backups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_block_search_documents`
--

LOCK TABLES `mdl_block_search_documents` WRITE;
/*!40000 ALTER TABLE `mdl_block_search_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_block_search_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_cache_filters`
--

DROP TABLE IF EXISTS `mdl_cache_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_cache_filters` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `version` bigint(10) unsigned NOT NULL DEFAULT '0',
  `md5key` varchar(32) NOT NULL DEFAULT '',
  `rawtext` text NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_cachfilt_filmd5_ix` (`filter`,`md5key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For keeping information about cached data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_cache_filters`
--

LOCK TABLES `mdl_cache_filters` WRITE;
/*!40000 ALTER TABLE `mdl_cache_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_cache_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_cache_flags`
--

DROP TABLE IF EXISTS `mdl_cache_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_cache_flags` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `flagtype` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `value` mediumtext NOT NULL,
  `expiry` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_cachflag_fla_ix` (`flagtype`),
  KEY `mdl_cachflag_nam_ix` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Cache of time-sensitive flags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_cache_flags`
--

LOCK TABLES `mdl_cache_flags` WRITE;
/*!40000 ALTER TABLE `mdl_cache_flags` DISABLE KEYS */;
INSERT INTO `mdl_cache_flags` VALUES (1,'accesslib/dirtycontexts','/1',1329389244,'1',1329396444),(2,'accesslib/dirtycontexts','/1/3/8',1325602774,'1',1325609974),(3,'accesslib/dirtycontexts','/1/3/20',1324980934,'1',1324988134),(4,'accesslib/dirtycontexts','/1/31',1325602756,'1',1325609956),(5,'accesslib/dirtycontexts','/1/31/8',1325602774,'1',1325609974),(6,'accesslib/dirtycontexts','/1/31/32',1325605060,'1',1325612260),(7,'accesslib/dirtycontexts','/1/31/42',1325605111,'1',1325612311),(8,'accesslib/dirtycontexts','/1/31/43',1325605140,'1',1325612340),(9,'accesslib/dirtycontexts','/1/44',1325605165,'1',1325612365),(10,'accesslib/dirtycontexts','/1/44/45',1325605204,'1',1325612404),(11,'accesslib/dirtycontexts','/1/44/55',1325605237,'1',1325612437),(12,'accesslib/dirtycontexts','/1/44/56',1325605257,'1',1325612457),(13,'accesslib/dirtycontexts','/1/44/57',1325605275,'1',1325612475),(14,'accesslib/dirtycontexts','/1/111',1332832938,'1',1332840138);
/*!40000 ALTER TABLE `mdl_cache_flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_cache_text`
--

DROP TABLE IF EXISTS `mdl_cache_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_cache_text` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `md5key` varchar(32) NOT NULL DEFAULT '',
  `formattedtext` longtext NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_cachtext_md5_ix` (`md5key`),
  KEY `mdl_cachtext_tim_ix` (`timemodified`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='For storing temporary copies of processed texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_cache_text`
--

LOCK TABLES `mdl_cache_text` WRITE;
/*!40000 ALTER TABLE `mdl_cache_text` DISABLE KEYS */;
INSERT INTO `mdl_cache_text` VALUES (1,'235f991e403028b4364b1b9e509426ca','Test Course 1 ',1325602347),(2,'1921056d595c71da7195194a13d69002','Test Course 2 ',1332847421),(3,'cb6e6938baac75d73d0778df5088372d',' Test Course 1 ',1325604800),(4,'ef09b90af81148ceb6f3f77d703ed474','Jaar 1/2 - Samen spelen',1325682137),(5,'c468ac7a422a1a7b7edabb8fd82f3fbf',' Jaar 1/2 - Samen spelen',1332847421),(6,'3f7fd3d401c9e47b79e4d3ad9f3be149','Administrators can usually do anything on the site, in all courses.',1329398882),(7,'cc9b927920dce1c867c881f40cb51598','Course creators can create new courses.',1329398882),(8,'7862c21bfb2325c5c0b3d490248b86f3','Teachers can do anything within a course, including changing the activities and grading students.',1329398882),(9,'dbc92f4d77130e3a05fee9d7f37cd128','Non-editing teachers can teach in courses and grade students, but may not alter activities.',1329398882),(10,'53ad46511f5b1356ab8eb29d3c1c4cbf','Students generally have fewer privileges within a course.',1329398882),(11,'ac13edf81e3c31bb72118fb0931c03d0','Guests have minimal privileges and usually can not enter text anywhere.',1329398882),(12,'91c495815f6be4e394b5bfa412f003c5','All logged in users.',1329398882),(13,'ede09bf4613bad2f6c11679e2b72d45d',' Blabla ',1326975810),(14,'db326b0753cd89ab85be0e4ae3d75d6c','<p>blabla</p>',1326975810),(15,'69157a9106e1d4920ae6bcc909a82bd2','blabla ',1326976869),(16,'34971dab2144a67cd27d8bf1bf6d6c58',' Test choice ',1331205201),(17,'605c02d1783db0137a703f4618f4a75e','<p>Choice 1</p>',1331205201),(18,'85cefb63ddf6e639743766e9eb06cbba','<p>Choice 2</p>',1331205201),(19,'2fc00aa7a4f29b47922c7ee74dd4ba75','A substitute is a copy of teacher and gets enrolled into all courses. ',1329386928),(20,'9be515476019fcb496af97a9d4987446','duplicate of Non-editing teacher',1329389210),(21,'9a1172e499b2be49591da0fc8c30ce10',' Substitute is a duplicate of Non-editing teacher. Substitutes get enrolled in all courses.<br /> ',1329398882),(22,'1a4e110740bdfd1486ed492aa4a6c01b','duplicate of Administrator',1329388011),(23,'1afd0f592029be06464f8124e262cd4d',' Manager is a duplicate of Administrator. This role gets all rights accept for the right to edit the admin user. This way we\'ll always have 1 backup user. ',1329388052),(24,'f14911f766a033fe0320af4ec9f8a33f',' Manager is a duplicate of Administrator.<br />This role gets all rights accept for the right to edit the admin user.<br />This way we\'ll always have 1 backup user. ',1329388080),(25,'293b6a97d6b6df68da37dd2b96338453','School leader is a duplicate of Non-editing teacher.<br />A school leader gets enrolled in all courses.<br /> ',1329398882),(26,'b95f34b6bcbf171f4b4ba979c2146c5c','<p> Test description </p>',1331205186),(27,'a6e85e07bb3a8e545f94d8d04f5a80cf','General news and announcements',1331205152),(28,'dd395f8d53048c16544c4e7ab76843a9','<p>General news and announcements</p>',1331205153),(29,'f2c6308dc633b2edc4c01b0d2b4344be','General news and announcements',1332832858),(30,'ec75bcc2923aa05f935a70d8c3744941','<img hspace=\"0\" height=\"533\" border=\"0\" width=\"800\" vspace=\"0\" src=\"http://localhost/jeelo19/file.php/13/Inrichten_van_je_eigen_omgeving_12.gif\" alt=\"Wonen in je straat\" title=\"Wonen in je straat\" useMap=\"#ImageMap\" border=0>\n<MAP name=\"ImageMap\">\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=33\" alt=\"217 Links en rechts\" target=\"\" coords=320,380,386,469>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=32\" alt=\"216 Onder, boven, voor en achter\" target=\"\" coords=244,379,310,467>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=26\" alt=\"200 Maak je slaapkamer\" target=\"\" coords=698,199,761,287>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=31\" alt=\"206 Teken je eigen huis\" target=\"\" coords=472,199,538,288>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=25\" alt=\"199 Hoek: Huizen bouwen\" target=\"\" coords=397,291,462,378>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=24\" alt=\"196 Praatplaat: Soorten huizen\" target=\"\" coords=397,111,461,197>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=23\" alt=\"195 Woorden: Het huis\" target=\"\" coords=397,18,462,110>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=30\" alt=\"205 Ruim de straat op\" target=\"\" coords=246,200,312,289>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=29\" alt=\"203 Doeblad: Houd je straat schoon\" target=\"\" coords=169,245,236,334>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=27\" alt=\"201 Woorden: De straat\" target=\"\" coords=96,246,161,335>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=28\" alt=\"202 Bewegen: Stoeptegelspellen\" target=\"\" coords=95,156,160,243>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=22\" alt=\"193 Wonen in je straat\" target=\"\" coords=20,200,81,289>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=34\" alt=\"727 Teken het leukste schoolplein\" target=\"\" coords=20,64,85,152>\n</MAP>',1332833192),(31,'b3d2d71e2cf221571284dd46678e5639','Periode 1',1332833192),(32,'64c94844e8cb89391929c01b32bc08f6','Periode 3',1332833192),(33,'9d26a8643cf42f3b82a12c81eaa7b5c2','<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" src=\"http://localhost/jeelo19/file.php/15/Inrichten_van_je_eigen_omgeving_56.gif\" alt=\"Vrije tijd in je buurt\" title=\"Vrije tijd in je buurt\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_56\" /> <map name=\"m_Inrichten_van_je_eigen_omgeving_56\" id=\"m_Inrichten_van_je_eigen_omgeving_56\"> <area shape=\"rect\" coords=\"398,384,458,468\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=91\" title=\"179 Soorten kaarten\" alt=\"179 Soorten kaarten\" /> <area shape=\"rect\" coords=\"324,382,384,466\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=89\" title=\"177 Een kaart lezen\" alt=\"177 Een kaart lezen\" /> <area shape=\"rect\" coords=\"250,383,310,467\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=87\" title=\"176 Onderdelen van een kaart\" alt=\"176 Onderdelen van een kaart\" /> <area shape=\"rect\" coords=\"173,293,233,377\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=103\" title=\"218 Toerisme in Nederland\" alt=\"218 Toerisme in Nederland\" /> <area shape=\"rect\" coords=\"550,247,610,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=98\" title=\"184 Ontwerp een speelplein\" alt=\"184 Ontwerp een speelplein\" /> <area shape=\"rect\" coords=\"550,157,610,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=97\" title=\"183 Maak een rondleiding\" alt=\"183 Maak een rondleiding\" /> <area shape=\"rect\" coords=\"473,202,533,286\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=93\" title=\"181 Openbare speelruimtes\" alt=\"181 Openbare speelruimtes\" /> <area shape=\"rect\" coords=\"398,111,458,195\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=100\" title=\"207 Leven in een iddeleeuwse stad\" alt=\"207 Leven in een iddeleeuwse stad\" /> <area shape=\"rect\" coords=\"398,203,458,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=102\" title=\"211 Maak samen een nieuwe wijk\" alt=\"211 Maak samen een nieuwe wijk\" /> <area shape=\"rect\" coords=\"324,204,384,288\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=84\" title=\"8 Werken met google maps\" alt=\"8 Werken met google maps\" /> <area shape=\"rect\" coords=\"248,203,308,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=99\" title=\"190 Zoek naar vrijetijdsbestedingen\" alt=\"190 Zoek naar vrijetijdsbestedingen\" /> <area shape=\"rect\" coords=\"172,201,232,285\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=95\" title=\"182 Soorten vrijetijdsbesteding\" alt=\"182 Soorten vrijetijdsbesteding\" /> <area shape=\"rect\" coords=\"98,247,158,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=86\" title=\"175 Plein: Vrije tijd in je buurt\" alt=\"175 Plein: Vrije tijd in je buurt\" /> <area shape=\"rect\" coords=\"98,157,158,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=85\" title=\"174 Rondleiding: Vrije tijd in je buurt\" alt=\"174 Rondleiding: Vrije tijd in je buurt\" /> <area shape=\"rect\" coords=\"97,67,157,151\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=105\" title=\"727 Teken het leukste schoolplein\" alt=\"727 Teken het leukste schoolplein\" /> </map>',1332833228),(34,'ae1c9ad426858571477834e273b1d070','Periode 1 of 2',1332833228),(35,'f9c0d0a28002c4e78688487a98d61443','Periode 2',1332833228),(36,'f4158e3508889e40febff5783ec057ae','<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_34\" title=\"Zorg voor je wijk\" alt=\"Zorg voor je wijk\" src=\"http://localhost/jeelo19/file.php/16/Inrichten_van_je_eigen_omgeving_34.gif\" /> <map id=\"m_Inrichten_van_je_eigen_omgeving_34\" name=\"m_Inrichten_van_je_eigen_omgeving_34\"> <area alt=\"210 Een plattegrond lezen\" title=\"210 Een plattegrond lezen\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=133\" coords=\"250,383,310,467\" shape=\"rect\" /> <area alt=\"173 Maak samen een speelveld\" title=\"173 Maak samen een speelveld\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=132\" coords=\"550,247,610,331\" shape=\"rect\" /> <area alt=\"172 Schilder samen een straat\" title=\"172 Schilder samen een straat\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=131\" coords=\"550,157,610,241\" shape=\"rect\" /> <area alt=\"167 Een huis van vroeger\" title=\"167 Een huis van vroeger\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=125\" coords=\"473,202,533,286\" shape=\"rect\" /> <area alt=\"171 Teken je huis van binnen en buiten\" title=\"171 Teken je huis van binnen en buiten\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=130\" coords=\"398,111,458,195\" shape=\"rect\" /> <area alt=\"166 Buizen door de wijk\" title=\"166 Buizen door de wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=123\" coords=\"398,203,458,287\" shape=\"rect\" /> <area alt=\"165 Soorten huizen\" title=\"165 Soorten huizen\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=121\" coords=\"324,204,384,288\" shape=\"rect\" /> <area alt=\"169 Maak de wijk schoon\" title=\"169 Maak de wijk schoon\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=129\" coords=\"248,203,308,287\" shape=\"rect\" /> <area alt=\"168 Een groene en schone wijk\" title=\"168 Een groene en schone wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=127\" coords=\"172,201,232,285\" shape=\"rect\" /> <area alt=\"164 Speelplek: Zorg voor je wijk\" title=\"164 Speelplek: Zorg voor je wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=120\" coords=\"98,247,158,331\" shape=\"rect\" /> <area alt=\"163 Straat: Zorg voor je wijk\" title=\"163 Straat: Zorg voor je wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=119\" coords=\"98,157,158,241\" shape=\"rect\" /> <area alt=\"727 Teken het leukste schoolplein\" title=\"727 Teken het leukste schoolplein\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=135\" coords=\"97,67,157,151\" shape=\"rect\" /> </map>',1332834871),(37,'781d626acbedb5c271c3157ab578ac46','Periode 1',1332834871),(38,'259a749c0bbb24b2eb6c95d6aa141cb0','Periode 2',1332834871),(39,'c42e0e6f6eb796a6612ee2ee89441fa2','Periode 3',1332834871),(40,'48b343078f26331f07dd66f07cc5cb84','<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_78\" title=\"Ontwikkeling van je gemeente\" alt=\"Ontwikkeling van je gemeente\" src=\"http://localhost/jeelo19/file.php/14/Inrichten_van_je_eigen_omgeving_78.gif\" /> <map id=\"m_Inrichten_van_je_eigen_omgeving_78\" name=\"m_Inrichten_van_je_eigen_omgeving_78\"> <area shape=\"rect\" coords=\"412,384,472,468\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=57\" title=\"179 Soorten kaarten\" alt=\"179 Soorten kaarten\" /> <area shape=\"rect\" coords=\"338,382,398,466\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=53\" title=\"177 Een kaart lezen\" alt=\"177 Een kaart lezen\" /> <area shape=\"rect\" coords=\"264,383,324,467\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=51\" title=\"176 Onderdelen van een kaart\" alt=\"176 Onderdelen van een kaart\" /> <area shape=\"rect\" coords=\"264,293,324,377\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=46\" title=\"8 Werk met google maps\" alt=\"8 Werk met google maps\" /> <area shape=\"rect\" coords=\"715,247,775,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=59\" title=\"180 Ontwerp een plein op schaal\" alt=\"180 Ontwerp een plein op schaal\" /> <area shape=\"rect\" coords=\"640,248,700,332\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=47\" title=\"9 Rekenen op schaal\" alt=\"9 Rekenen op schaal\" /> <area shape=\"rect\" coords=\"564,247,624,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=72\" title=\"208 Houd een enquete\" alt=\"208 Houd een enquete\" /> <area shape=\"rect\" coords=\"640,158,700,242\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=50\" title=\"170 Doe historisch onderzoek\" alt=\"170 Doe historisch onderzoek\" /> <area shape=\"rect\" coords=\"565,157,625,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=49\" title=\"111 Houd een interview\" alt=\"111 Houd een interview\" /> <area shape=\"rect\" coords=\"490,201,550,285\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=60\" title=\"185 Taken van de gemeente\" alt=\"185 Taken van de gemeente\" /> <area shape=\"rect\" coords=\"413,202,473,286\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=62\" title=\"186 Ruimtelijke ordening\" alt=\"186 Ruimtelijke ordening\" /> <area shape=\"rect\" coords=\"414,111,474,195\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=73\" title=\"209 Ontwikkeling van toerisme\" alt=\"209 Ontwikkeling van toerisme\" /> <area shape=\"rect\" coords=\"338,203,398,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=75\" title=\"211 Maak samen een nieuwe wijk\" alt=\"211 Maak samen een nieuwe wijk\" /> <area shape=\"rect\" coords=\"264,204,324,288\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=44\" title=\"7 Voorzieningen voor iedereen\" alt=\"7 Voorzieningen voor iedereen\" /> <area shape=\"rect\" coords=\"188,203,248,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=66\" title=\"189 Verstedelijking van Nederland\" alt=\"189 Verstedelijking van Nederland\" /> <area shape=\"rect\" coords=\"187,112,247,196\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=70\" title=\"192 Ontstaan van steden\" alt=\"192 Ontstaan van steden\" /> <area shape=\"rect\" coords=\"113,111,173,195\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=68\" title=\"191 Ontstaan van dorpen\" alt=\"191 Ontstaan van dorpen\" /> <area shape=\"rect\" coords=\"112,201,172,285\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=55\" title=\"178 Opbouw van een stad\" alt=\"178 Opbouw van een stad\" /> <area shape=\"rect\" coords=\"38,247,98,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=65\" title=\"188 Pleinontwerp: Ontwikkeling van je gemeente\" alt=\"188 Pleinontwerp: Ontwikkeling van je gemeente\" /> <area shape=\"rect\" coords=\"38,157,98,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=64\" title=\"187 Historisch onderzoek: Ontwikkeling van je gemeente\" alt=\"187 Historisch onderzoek: Ontwikkeling van je gemeente\" /> <area shape=\"rect\" coords=\"37,67,97,151\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=76\" title=\"727 Teken het leukste schoolplein\" alt=\"727 Teken het leukste schoolplein\" /></map>',1332833219),(41,'f9b8fa5597f39cfd7c0bf44d54a65fcc','Periode 1',1332833219),(42,'d18d72d5493447a67ad861f6f8465b1b','Periode 1 of 2',1332833219),(43,'b43157a27e0061146c02068b9a7d5432','Periode 2',1332833219);
/*!40000 ALTER TABLE `mdl_cache_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_capabilities`
--

DROP TABLE IF EXISTS `mdl_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_capabilities` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `captype` varchar(50) NOT NULL DEFAULT '',
  `contextlevel` bigint(10) unsigned NOT NULL DEFAULT '0',
  `component` varchar(100) NOT NULL DEFAULT '',
  `riskbitmask` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_capa_nam_uix` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=232 DEFAULT CHARSET=utf8 COMMENT='this defines all capabilities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_capabilities`
--

LOCK TABLES `mdl_capabilities` WRITE;
/*!40000 ALTER TABLE `mdl_capabilities` DISABLE KEYS */;
INSERT INTO `mdl_capabilities` VALUES (1,'moodle/site:doanything','admin',10,'moodle',62),(2,'moodle/legacy:guest','legacy',10,'moodle',0),(3,'moodle/legacy:user','legacy',10,'moodle',0),(4,'moodle/legacy:student','legacy',10,'moodle',16),(5,'moodle/legacy:teacher','legacy',10,'moodle',24),(6,'moodle/legacy:editingteacher','legacy',10,'moodle',28),(7,'moodle/legacy:coursecreator','legacy',10,'moodle',28),(8,'moodle/legacy:admin','legacy',10,'moodle',62),(9,'moodle/site:config','write',10,'moodle',62),(10,'moodle/site:readallmessages','read',10,'moodle',8),(11,'moodle/site:sendmessage','write',10,'moodle',16),(12,'moodle/site:approvecourse','write',10,'moodle',4),(13,'moodle/site:import','write',50,'moodle',28),(14,'moodle/site:backup','write',50,'moodle',28),(15,'moodle/backup:userinfo','read',50,'moodle',8),(16,'moodle/site:restore','write',50,'moodle',28),(17,'moodle/restore:createuser','write',10,'moodle',24),(18,'moodle/restore:userinfo','write',50,'moodle',30),(19,'moodle/restore:rolldates','write',50,'moodle',0),(20,'moodle/site:manageblocks','write',80,'moodle',20),(21,'moodle/site:accessallgroups','read',50,'moodle',0),(22,'moodle/site:viewfullnames','read',50,'moodle',0),(23,'moodle/site:viewreports','read',50,'moodle',8),(24,'moodle/site:trustcontent','write',50,'moodle',4),(25,'moodle/site:uploadusers','write',10,'moodle',24),(26,'moodle/site:langeditmaster','write',10,'moodle',6),(27,'moodle/site:langeditlocal','write',10,'moodle',6),(28,'moodle/user:create','write',10,'moodle',24),(29,'moodle/user:delete','write',10,'moodle',8),(30,'moodle/user:update','write',10,'moodle',24),(31,'moodle/user:viewdetails','read',50,'moodle',0),(32,'moodle/user:viewhiddendetails','read',50,'moodle',8),(33,'moodle/user:loginas','write',50,'moodle',30),(34,'moodle/role:assign','write',50,'moodle',28),(35,'moodle/role:override','write',50,'moodle',28),(36,'moodle/role:safeoverride','write',50,'moodle',16),(37,'moodle/role:manage','write',10,'moodle',28),(38,'moodle/role:unassignself','write',50,'moodle',0),(39,'moodle/role:viewhiddenassigns','read',50,'moodle',0),(40,'moodle/role:switchroles','read',50,'moodle',12),(41,'moodle/category:manage','write',40,'moodle',4),(42,'moodle/category:viewhiddencategories','read',40,'moodle',0),(43,'moodle/course:create','write',40,'moodle',4),(44,'moodle/course:request','write',10,'moodle',0),(45,'moodle/course:delete','write',50,'moodle',32),(46,'moodle/course:update','write',50,'moodle',4),(47,'moodle/course:view','read',50,'moodle',0),(48,'moodle/course:bulkmessaging','write',50,'moodle',16),(49,'moodle/course:viewhiddenuserfields','read',50,'moodle',8),(50,'moodle/course:viewhiddencourses','read',50,'moodle',0),(51,'moodle/course:visibility','write',50,'moodle',0),(52,'moodle/course:managefiles','write',50,'moodle',4),(53,'moodle/course:manageactivities','write',50,'moodle',4),(54,'moodle/course:managemetacourse','write',50,'moodle',12),(55,'moodle/course:activityvisibility','write',50,'moodle',0),(56,'moodle/course:viewhiddenactivities','write',50,'moodle',0),(57,'moodle/course:viewparticipants','read',50,'moodle',0),(58,'moodle/course:changefullname','write',50,'moodle',4),(59,'moodle/course:changeshortname','write',50,'moodle',4),(60,'moodle/course:changeidnumber','write',50,'moodle',4),(61,'moodle/course:changecategory','write',50,'moodle',4),(62,'moodle/course:changesummary','write',50,'moodle',4),(63,'moodle/site:viewparticipants','read',10,'moodle',0),(64,'moodle/course:viewscales','read',50,'moodle',0),(65,'moodle/course:managescales','write',50,'moodle',0),(66,'moodle/course:managegroups','write',50,'moodle',0),(67,'moodle/course:reset','write',50,'moodle',32),(68,'moodle/blog:view','read',50,'moodle',0),(69,'moodle/blog:create','write',10,'moodle',16),(70,'moodle/blog:manageentries','write',50,'moodle',16),(71,'moodle/calendar:manageownentries','write',50,'moodle',16),(72,'moodle/calendar:managegroupentries','write',50,'moodle',16),(73,'moodle/calendar:manageentries','write',50,'moodle',16),(74,'moodle/user:editprofile','write',30,'moodle',24),(75,'moodle/user:editownprofile','write',10,'moodle',16),(76,'moodle/user:changeownpassword','write',10,'moodle',0),(77,'moodle/user:readuserposts','read',30,'moodle',0),(78,'moodle/user:readuserblogs','read',30,'moodle',0),(79,'moodle/user:viewuseractivitiesreport','read',30,'moodle',8),(80,'moodle/question:managecategory','write',50,'moodle',20),(81,'moodle/question:add','write',50,'moodle',20),(82,'moodle/question:editmine','write',50,'moodle',20),(83,'moodle/question:editall','write',50,'moodle',20),(84,'moodle/question:viewmine','read',50,'moodle',0),(85,'moodle/question:viewall','read',50,'moodle',0),(86,'moodle/question:usemine','read',50,'moodle',0),(87,'moodle/question:useall','read',50,'moodle',0),(88,'moodle/question:movemine','write',50,'moodle',0),(89,'moodle/question:moveall','write',50,'moodle',0),(90,'moodle/question:config','write',10,'moodle',2),(91,'moodle/site:doclinks','read',10,'moodle',0),(92,'moodle/course:sectionvisibility','write',50,'moodle',0),(93,'moodle/course:useremail','write',50,'moodle',0),(94,'moodle/course:viewhiddensections','write',50,'moodle',0),(95,'moodle/course:setcurrentsection','write',50,'moodle',0),(96,'moodle/site:mnetlogintoremote','read',10,'moodle',0),(97,'moodle/grade:viewall','read',50,'moodle',8),(98,'moodle/grade:view','read',50,'moodle',0),(99,'moodle/grade:viewhidden','read',50,'moodle',8),(100,'moodle/grade:import','write',50,'moodle',12),(101,'moodle/grade:export','read',50,'moodle',8),(102,'moodle/grade:manage','write',50,'moodle',12),(103,'moodle/grade:edit','write',50,'moodle',12),(104,'moodle/grade:manageoutcomes','write',50,'moodle',0),(105,'moodle/grade:manageletters','write',50,'moodle',0),(106,'moodle/grade:hide','write',50,'moodle',0),(107,'moodle/grade:lock','write',50,'moodle',0),(108,'moodle/grade:unlock','write',50,'moodle',0),(109,'moodle/my:manageblocks','write',10,'moodle',0),(110,'moodle/notes:view','read',50,'moodle',0),(111,'moodle/notes:manage','write',50,'moodle',16),(112,'moodle/tag:manage','write',10,'moodle',16),(113,'moodle/tag:create','write',10,'moodle',16),(114,'moodle/tag:edit','write',10,'moodle',16),(115,'moodle/tag:editblocks','write',10,'moodle',0),(116,'moodle/block:view','read',80,'moodle',0),(117,'mod/assignment:view','read',70,'mod/assignment',0),(118,'mod/assignment:submit','write',70,'mod/assignment',0),(119,'mod/assignment:grade','write',70,'mod/assignment',4),(120,'mod/chat:chat','write',70,'mod/chat',16),(121,'mod/chat:readlog','read',70,'mod/chat',0),(122,'mod/chat:deletelog','write',70,'mod/chat',0),(123,'mod/choice:choose','write',70,'mod/choice',0),(124,'mod/choice:readresponses','read',70,'mod/choice',0),(125,'mod/choice:deleteresponses','write',70,'mod/choice',0),(126,'mod/choice:downloadresponses','read',70,'mod/choice',0),(127,'mod/data:viewentry','read',70,'mod/data',0),(128,'mod/data:writeentry','write',70,'mod/data',16),(129,'mod/data:comment','write',70,'mod/data',16),(130,'mod/data:viewrating','read',70,'mod/data',0),(131,'mod/data:rate','write',70,'mod/data',0),(132,'mod/data:approve','write',70,'mod/data',16),(133,'mod/data:manageentries','write',70,'mod/data',16),(134,'mod/data:managecomments','write',70,'mod/data',16),(135,'mod/data:managetemplates','write',70,'mod/data',20),(136,'mod/data:viewalluserpresets','read',70,'mod/data',0),(137,'mod/data:manageuserpresets','write',70,'mod/data',20),(138,'mod/forum:viewdiscussion','read',70,'mod/forum',0),(139,'mod/forum:viewhiddentimedposts','read',70,'mod/forum',0),(140,'mod/forum:startdiscussion','write',70,'mod/forum',16),(141,'mod/forum:replypost','write',70,'mod/forum',16),(142,'mod/forum:addnews','write',70,'mod/forum',16),(143,'mod/forum:replynews','write',70,'mod/forum',16),(144,'mod/forum:viewrating','read',70,'mod/forum',0),(145,'mod/forum:viewanyrating','read',70,'mod/forum',0),(146,'mod/forum:rate','write',70,'mod/forum',0),(147,'mod/forum:createattachment','write',70,'mod/forum',16),(148,'mod/forum:deleteownpost','read',70,'mod/forum',0),(149,'mod/forum:deleteanypost','read',70,'mod/forum',0),(150,'mod/forum:splitdiscussions','read',70,'mod/forum',0),(151,'mod/forum:movediscussions','read',70,'mod/forum',0),(152,'mod/forum:editanypost','write',70,'mod/forum',16),(153,'mod/forum:viewqandawithoutposting','read',70,'mod/forum',0),(154,'mod/forum:viewsubscribers','read',70,'mod/forum',0),(155,'mod/forum:managesubscriptions','read',70,'mod/forum',16),(156,'mod/forum:initialsubscriptions','read',70,'mod/forum',0),(157,'mod/forum:throttlingapplies','write',70,'mod/forum',16),(158,'mod/glossary:write','write',70,'mod/glossary',16),(159,'mod/glossary:manageentries','write',70,'mod/glossary',16),(160,'mod/glossary:managecategories','write',70,'mod/glossary',16),(161,'mod/glossary:comment','write',70,'mod/glossary',16),(162,'mod/glossary:managecomments','write',70,'mod/glossary',16),(163,'mod/glossary:import','write',70,'mod/glossary',16),(164,'mod/glossary:export','read',70,'mod/glossary',0),(165,'mod/glossary:approve','write',70,'mod/glossary',16),(166,'mod/glossary:rate','write',70,'mod/glossary',0),(167,'mod/glossary:viewrating','read',70,'mod/glossary',0),(168,'mod/hotpot:attempt','read',70,'mod/hotpot',0),(169,'mod/hotpot:viewreport','read',70,'mod/hotpot',0),(170,'mod/hotpot:grade','read',70,'mod/hotpot',0),(171,'mod/hotpot:deleteattempt','read',70,'mod/hotpot',0),(172,'mod/lams:participate','write',70,'mod/lams',0),(173,'mod/lams:manage','write',70,'mod/lams',0),(174,'mod/lesson:edit','write',70,'mod/lesson',4),(175,'mod/lesson:manage','write',70,'mod/lesson',0),(176,'mod/quiz:view','read',70,'mod/quiz',0),(177,'mod/quiz:attempt','write',70,'mod/quiz',16),(178,'mod/quiz:reviewmyattempts','read',70,'mod/quiz',0),(179,'mod/quiz:manage','write',70,'mod/quiz',16),(180,'mod/quiz:preview','write',70,'mod/quiz',0),(181,'mod/quiz:grade','write',70,'mod/quiz',16),(182,'mod/quiz:viewreports','read',70,'mod/quiz',8),(183,'mod/quiz:deleteattempts','write',70,'mod/quiz',32),(184,'mod/quiz:ignoretimelimits','read',70,'mod/quiz',0),(185,'mod/quiz:emailconfirmsubmission','read',70,'mod/quiz',0),(186,'mod/quiz:emailnotifysubmission','read',70,'mod/quiz',0),(187,'mod/scorm:viewreport','read',70,'mod/scorm',0),(188,'mod/scorm:skipview','write',70,'mod/scorm',0),(189,'mod/scorm:savetrack','write',70,'mod/scorm',0),(190,'mod/scorm:viewscores','read',70,'mod/scorm',0),(191,'mod/scorm:deleteresponses','read',70,'mod/scorm',0),(192,'mod/survey:participate','read',70,'mod/survey',0),(193,'mod/survey:readresponses','read',70,'mod/survey',0),(194,'mod/survey:download','read',70,'mod/survey',0),(195,'mod/wiki:participate','write',70,'mod/wiki',16),(196,'mod/wiki:manage','write',70,'mod/wiki',16),(197,'mod/wiki:overridelock','write',70,'mod/wiki',0),(198,'mod/workshop:participate','write',70,'mod/workshop',16),(199,'mod/workshop:manage','write',70,'mod/workshop',16),(200,'block/online_users:viewlist','read',80,'block/online_users',0),(201,'block/rss_client:createprivatefeeds','write',80,'block/rss_client',0),(202,'block/rss_client:createsharedfeeds','write',80,'block/rss_client',16),(203,'block/rss_client:manageownfeeds','write',80,'block/rss_client',0),(204,'block/rss_client:manageanyfeeds','write',80,'block/rss_client',16),(205,'enrol/authorize:managepayments','write',10,'enrol/authorize',8),(206,'enrol/authorize:uploadcsv','write',10,'enrol/authorize',4),(207,'gradeexport/ods:view','read',50,'gradeexport/ods',8),(208,'gradeexport/ods:publish','read',50,'gradeexport/ods',8),(209,'gradeexport/txt:view','read',50,'gradeexport/txt',8),(210,'gradeexport/txt:publish','read',50,'gradeexport/txt',8),(211,'gradeexport/xls:view','read',50,'gradeexport/xls',8),(212,'gradeexport/xls:publish','read',50,'gradeexport/xls',8),(213,'gradeexport/xml:view','read',50,'gradeexport/xml',8),(214,'gradeexport/xml:publish','read',50,'gradeexport/xml',8),(215,'gradeimport/csv:view','write',50,'gradeimport/csv',0),(216,'gradeimport/xml:view','write',50,'gradeimport/xml',0),(217,'gradeimport/xml:publish','write',50,'gradeimport/xml',0),(218,'gradereport/grader:view','read',50,'gradereport/grader',8),(219,'gradereport/outcomes:view','read',50,'gradereport/outcomes',8),(220,'gradereport/overview:view','read',50,'gradereport/overview',8),(221,'gradereport/user:view','read',50,'gradereport/user',8),(222,'coursereport/log:view','read',50,'coursereport/log',8),(223,'coursereport/log:viewlive','read',50,'coursereport/log',8),(224,'coursereport/log:viewtoday','read',50,'coursereport/log',8),(225,'coursereport/outline:view','read',50,'coursereport/outline',8),(226,'coursereport/participation:view','read',50,'coursereport/participation',8),(227,'coursereport/stats:view','read',50,'coursereport/stats',8),(228,'report/courseoverview:view','read',10,'report/courseoverview',8),(229,'report/security:view','read',10,'report/security',2),(230,'report/unittest:view','read',10,'report/unittest',32),(231,'mod/launcher:access','write',10,'mod/launcher',0);
/*!40000 ALTER TABLE `mdl_capabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_chat`
--

DROP TABLE IF EXISTS `mdl_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_chat` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `keepdays` bigint(11) NOT NULL DEFAULT '0',
  `studentlogs` smallint(4) NOT NULL DEFAULT '0',
  `chattime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `schedule` smallint(4) NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_chat_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Each of these is a chat room';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_chat`
--

LOCK TABLES `mdl_chat` WRITE;
/*!40000 ALTER TABLE `mdl_chat` DISABLE KEYS */;
INSERT INTO `mdl_chat` VALUES (1,2,'Test chat','Test chat<br /> ',0,0,1329316200,0,1329316389);
/*!40000 ALTER TABLE `mdl_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_chat_messages`
--

DROP TABLE IF EXISTS `mdl_chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_chat_messages` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `chatid` bigint(10) NOT NULL DEFAULT '0',
  `userid` bigint(10) NOT NULL DEFAULT '0',
  `groupid` bigint(10) NOT NULL DEFAULT '0',
  `system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `timestamp` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_chatmess_use_ix` (`userid`),
  KEY `mdl_chatmess_gro_ix` (`groupid`),
  KEY `mdl_chatmess_timcha_ix` (`timestamp`,`chatid`),
  KEY `mdl_chatmess_cha_ix` (`chatid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all the actual chat messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_chat_messages`
--

LOCK TABLES `mdl_chat_messages` WRITE;
/*!40000 ALTER TABLE `mdl_chat_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_chat_users`
--

DROP TABLE IF EXISTS `mdl_chat_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_chat_users` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `chatid` bigint(11) NOT NULL DEFAULT '0',
  `userid` bigint(11) NOT NULL DEFAULT '0',
  `groupid` bigint(11) NOT NULL DEFAULT '0',
  `version` varchar(16) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `firstping` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastping` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastmessageping` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sid` varchar(32) NOT NULL DEFAULT '',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_chatuser_use_ix` (`userid`),
  KEY `mdl_chatuser_las_ix` (`lastping`),
  KEY `mdl_chatuser_gro_ix` (`groupid`),
  KEY `mdl_chatuser_cha_ix` (`chatid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Keeps track of which users are in which chat rooms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_chat_users`
--

LOCK TABLES `mdl_chat_users` WRITE;
/*!40000 ALTER TABLE `mdl_chat_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_chat_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_choice`
--

DROP TABLE IF EXISTS `mdl_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_choice` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `format` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `publish` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `showresults` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `display` smallint(4) unsigned NOT NULL DEFAULT '0',
  `allowupdate` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `showunanswered` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `limitanswers` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_choi_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Available choices are stored here';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_choice`
--

LOCK TABLES `mdl_choice` WRITE;
/*!40000 ALTER TABLE `mdl_choice` DISABLE KEYS */;
INSERT INTO `mdl_choice` VALUES (1,3,'test choice',' Blabla ',1,0,0,0,0,0,0,0,0,1326975312),(2,2,'Test choice',' Test choice ',1,1,1,0,0,0,0,0,0,1331205250);
/*!40000 ALTER TABLE `mdl_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_choice_answers`
--

DROP TABLE IF EXISTS `mdl_choice_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_choice_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `choiceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `optionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_choiansw_use_ix` (`userid`),
  KEY `mdl_choiansw_cho_ix` (`choiceid`),
  KEY `mdl_choiansw_opt_ix` (`optionid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='choices performed by users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_choice_answers`
--

LOCK TABLES `mdl_choice_answers` WRITE;
/*!40000 ALTER TABLE `mdl_choice_answers` DISABLE KEYS */;
INSERT INTO `mdl_choice_answers` VALUES (1,2,2,3,1331205204);
/*!40000 ALTER TABLE `mdl_choice_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_choice_options`
--

DROP TABLE IF EXISTS `mdl_choice_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_choice_options` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `choiceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `text` text,
  `maxanswers` bigint(10) unsigned DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_choiopti_cho_ix` (`choiceid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='available options to choice';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_choice_options`
--

LOCK TABLES `mdl_choice_options` WRITE;
/*!40000 ALTER TABLE `mdl_choice_options` DISABLE KEYS */;
INSERT INTO `mdl_choice_options` VALUES (1,1,'blabla',0,1326975312),(2,1,'blabla',0,1326975312),(3,2,'Choice 1',0,1331205250),(4,2,'Choice 2',0,1331205250);
/*!40000 ALTER TABLE `mdl_choice_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_config`
--

DROP TABLE IF EXISTS `mdl_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_conf_nam_uix` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=434 DEFAULT CHARSET=utf8 COMMENT='Moodle configuration variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_config`
--

LOCK TABLES `mdl_config` WRITE;
/*!40000 ALTER TABLE `mdl_config` DISABLE KEYS */;
INSERT INTO `mdl_config` VALUES (1,'unicodedb','1'),(2,'statsrolesupgraded','1323876845'),(3,'auth','email'),(4,'auth_pop3mailbox','INBOX'),(5,'enrol','manual'),(6,'enrol_plugins_enabled','manual'),(7,'style','default'),(8,'template','default'),(9,'theme','children-education'),(10,'filter_multilang_converted','1'),(429,'registerauth',''),(12,'guestloginbutton','1'),(13,'alternateloginurl',''),(14,'forgottenpasswordurl',''),(15,'auth_instructions',''),(16,'allowemailaddresses',''),(17,'denyemailaddresses',''),(18,'verifychangedemail','1'),(19,'recaptchapublickey',''),(20,'recaptchaprivatekey',''),(21,'nodefaultuserrolelists','0'),(22,'autologinguests','0'),(23,'hiddenuserfields',''),(24,'allowuserswitchrolestheycantassign','0'),(25,'enablecourserequests','0'),(26,'courserequestnotify',''),(27,'timezone','99'),(28,'forcetimezone','99'),(29,'country','0'),(30,'geoipfile','/home/menno/php_projects/jeelo/moodle_data/geoip/GeoLiteCity.dat'),(31,'googlemapkey',''),(32,'autolang','1'),(33,'lang','en_utf8'),(34,'langmenu','1'),(35,'langlist',''),(36,'langcache','1'),(37,'locale',''),(38,'latinexcelexport','0'),(39,'cachetext','60'),(40,'filteruploadedfiles','0'),(41,'filtermatchoneperpage','0'),(42,'filtermatchonepertext','0'),(43,'filterall','0'),(44,'filter_multilang_force_old','0'),(45,'filter_mediaplugin_enable_mp3','1'),(46,'filter_mediaplugin_enable_swf','0'),(47,'filter_mediaplugin_enable_mov','1'),(48,'filter_mediaplugin_enable_wmv','1'),(49,'filter_mediaplugin_enable_mpg','1'),(50,'filter_mediaplugin_enable_avi','1'),(51,'filter_mediaplugin_enable_flv','1'),(52,'filter_mediaplugin_enable_ram','1'),(53,'filter_mediaplugin_enable_rpm','1'),(54,'filter_mediaplugin_enable_rm','1'),(55,'filter_mediaplugin_enable_youtube','0'),(56,'filter_mediaplugin_enable_ogg','1'),(57,'filter_mediaplugin_enable_ogv','1'),(58,'filter_tex_latexpreamble','\\usepackage[latin1]{inputenc}\n\\usepackage{amsmath}\n\\usepackage{amsfonts}\n\\RequirePackage{amsmath,amssymb,latexsym}\n'),(59,'filter_tex_latexbackground','#FFFFFF'),(60,'filter_tex_density','120'),(61,'filter_tex_pathlatex','/usr/bin/latex'),(62,'filter_tex_pathdvips','/usr/bin/dvips'),(63,'filter_tex_pathconvert','/usr/bin/convert'),(64,'filter_tex_convertformat','gif'),(65,'filter_censor_badwords',''),(66,'protectusernames','1'),(67,'forcelogin','0'),(68,'forceloginforprofiles','1'),(69,'opentogoogle','0'),(70,'maxbytes','0'),(71,'messaging','1'),(72,'allowobjectembed','0'),(73,'enabletrusttext','0'),(74,'maxeditingtime','1800'),(75,'fullnamedisplay','language'),(76,'extendedusernamechars','0'),(77,'sitepolicy',''),(78,'bloglevel','4'),(79,'usetags','1'),(80,'keeptagnamecase','1'),(81,'profilesforenrolledusersonly','1'),(82,'cronclionly','0'),(83,'cronremotepassword',''),(84,'passwordpolicy','1'),(85,'minpasswordlength','8'),(86,'minpassworddigits','1'),(87,'minpasswordlower','1'),(88,'minpasswordupper','1'),(89,'minpasswordnonalphanum','1'),(90,'disableuserimages','0'),(91,'emailchangeconfirmation','1'),(92,'enablenotes','1'),(93,'loginhttps','0'),(94,'cookiesecure','0'),(95,'cookiehttponly','0'),(96,'regenloginsession','1'),(97,'excludeoldflashclients','10.0.12'),(98,'loginpasswordautocomplete','0'),(99,'restrictmodulesfor','none'),(100,'restrictbydefault','0'),(101,'displayloginfailures',''),(102,'notifyloginfailures',''),(103,'notifyloginthreshold','10'),(104,'runclamonupload','0'),(105,'pathtoclam',''),(106,'quarantinedir',''),(107,'clamfailureonupload','donothing'),(108,'themelist',''),(109,'allowuserthemes','0'),(110,'allowcoursethemes','0'),(111,'allowcategorythemes','0'),(112,'allowuserblockhiding','1'),(113,'showblocksonmodpages','0'),(114,'hideactivitytypenavlink','0'),(115,'calendar_adminseesall','0'),(116,'calendar_site_timeformat','0'),(117,'calendar_startwday','0'),(118,'calendar_weekend','65'),(119,'calendar_lookahead','21'),(120,'calendar_maxevents','10'),(121,'enablecalendarexport','1'),(122,'calendar_exportsalt','yxerahG5YXEf1J3zf2MRw3FykWp8abNfyhihrXahCCtqRPAaiU0pGlZmKujt'),(123,'htmleditor','1'),(124,'editorbackgroundcolor','#ffffff'),(125,'editorfontfamily','Trebuchet MS,Verdana,Arial,Helvetica,sans-serif'),(126,'editorfontsize',''),(127,'editorfontlist','Trebuchet:Trebuchet MS,Verdana,Arial,Helvetica,sans-serif;Arial:arial,helvetica,sans-serif;Courier New:courier new,courier,monospace;Georgia:georgia,times new roman,times,serif;Tahoma:tahoma,arial,helvetica,sans-serif;Times New Roman:times new roman,times,serif;Verdana:verdana,arial,helvetica,sans-serif;Impact:impact;Wingdings:wingdings'),(128,'editorkillword','1'),(129,'editorhidebuttons',''),(130,'emoticons',':-){:}smiley{;}:){:}smiley{;}:-D{:}biggrin{;};-){:}wink{;}:-/{:}mixed{;}V-.{:}thoughtful{;}:-P{:}tongueout{;}B-){:}cool{;}^-){:}approve{;}8-){:}wideeyes{;}:o){:}clown{;}:-({:}sad{;}:({:}sad{;}8-.{:}shy{;}:-I{:}blush{;}:-X{:}kiss{;}8-o{:}surprise{;}P-|{:}blackeye{;}8-[{:}angry{;}xx-P{:}dead{;}|-.{:}sleepy{;}}-]{:}evil{;}(h){:}heart{;}(heart){:}heart{;}(y){:}yes{;}(n){:}no{;}(martin){:}martin{;}( ){:}egg'),(131,'formatstringstriptags','1'),(132,'docroot','http://docs.moodle.org'),(133,'doctonewwindow','0'),(134,'mymoodleredirect','0'),(135,'mycoursesperpage','21'),(136,'enableajax','1'),(137,'disablecourseajax','1'),(138,'gdversion','2'),(139,'zip',''),(140,'unzip',''),(141,'pathtodu',''),(142,'aspellpath',''),(143,'smtphosts',''),(144,'smtpuser',''),(145,'smtppass',''),(146,'smtpmaxbulk','1'),(147,'noreplyaddress','noreply@localhost'),(148,'digestmailtime','17'),(149,'sitemailcharset','0'),(150,'allowusermailcharset','0'),(151,'mailnewline','LF'),(152,'supportpage',''),(153,'dbsessions','0'),(154,'sessiontimeout','7200'),(155,'sessioncookie',''),(156,'sessioncookiepath','/'),(157,'sessioncookiedomain',''),(158,'enablerssfeeds','0'),(159,'debug','38911'),(160,'debugdisplay','1'),(161,'xmlstrictheaders','0'),(162,'debugsmtp','0'),(163,'perfdebug','7'),(164,'enablestats','0'),(165,'statsfirstrun','none'),(166,'statsmaxruntime','0'),(167,'statsruntimedays','31'),(168,'statsruntimestarthour','0'),(169,'statsruntimestartminute','0'),(170,'statsuserthreshold','0'),(171,'statscatdepth','1'),(172,'framename','_top'),(173,'slasharguments','1'),(174,'getremoteaddrconf','0'),(175,'proxyhost',''),(176,'proxyport','0'),(177,'proxytype','HTTP'),(178,'proxyuser',''),(179,'proxypassword',''),(180,'longtimenosee','120'),(181,'deleteunconfirmed','168'),(182,'deleteincompleteusers','0'),(183,'loglifetime','0'),(184,'disablegradehistory','0'),(185,'gradehistorylifetime','0'),(186,'extramemorylimit','128M'),(187,'cachetype',''),(188,'rcache','0'),(189,'rcachettl','10'),(190,'intcachemax','10'),(191,'memcachedhosts',''),(192,'memcachedpconn','0'),(193,'enableglobalsearch','0'),(194,'smartpix','0'),(195,'enablehtmlpurifier','0'),(196,'enablegroupings','0'),(197,'experimentalsplitrestore','0'),(198,'enableimsccimport','0'),(199,'enablesafebrowserintegration','0'),(200,'mnet_dispatcher_mode','off'),(201,'mnet_localhost_id','1'),(202,'mnet_all_hosts_id','2'),(203,'version','2007101591.08'),(204,'release','1.9.15+ (Build: 20111205)'),(205,'assignment_type_online_version','2005042900'),(206,'hotpot_showtimes','0'),(207,'hotpot_excelencodings',''),(208,'hotpot_initialdisable','1'),(209,'journal_showrecentactivity','1'),(210,'journal_initialdisable','1'),(211,'lams_initialdisable','1'),(212,'quiz_review','16777215'),(213,'quiz_attemptonlast','0'),(214,'quiz_attempts','0'),(215,'quiz_grademethod',''),(216,'quiz_decimalpoints','2'),(217,'quiz_maximumgrade','10'),(218,'quiz_password',''),(219,'quiz_popup','0'),(220,'quiz_questionsperpage','0'),(221,'quiz_shuffleanswers','1'),(222,'quiz_shufflequestions','0'),(223,'quiz_subnet',''),(224,'quiz_timelimit','0'),(225,'quiz_optionflags','1'),(226,'quiz_penaltyscheme','1'),(227,'quiz_delay1','0'),(228,'quiz_delay2','0'),(229,'quiz_fix_review','0'),(230,'quiz_fix_attemptonlast','0'),(231,'quiz_fix_attempts','0'),(232,'quiz_fix_grademethod','0'),(233,'quiz_fix_decimalpoints','0'),(234,'quiz_fix_password','0'),(235,'quiz_fix_popup','0'),(236,'quiz_fix_questionsperpage','0'),(237,'quiz_fix_shuffleanswers','0'),(238,'quiz_fix_shufflequestions','0'),(239,'quiz_fix_subnet','0'),(240,'quiz_fix_timelimit','0'),(241,'quiz_fix_adaptive','0'),(242,'quiz_fix_penaltyscheme','0'),(243,'quiz_fix_delay1','0'),(244,'quiz_fix_delay2','0'),(245,'resource_hide_repository','1'),(246,'workshop_initialdisable','1'),(247,'qtype_calculated_version','2006032200'),(248,'qtype_essay_version','2006032200'),(249,'qtype_match_version','2006032200'),(250,'qtype_multianswer_version','2008050800'),(251,'qtype_multichoice_version','2007081700'),(252,'qtype_numerical_version','2006121500'),(253,'qtype_randomsamatch_version','2006042800'),(254,'qtype_shortanswer_version','2006032200'),(255,'qtype_truefalse_version','2006032200'),(256,'backup_version','2009111300'),(257,'backup_release','1.9.7'),(258,'blocks_version','2007081300'),(259,'enrol_authorize_version','2006112903'),(260,'enrol_paypal_version','2006092200'),(261,'gradeexport_ods_version','2007092701'),(262,'gradeexport_txt_version','2007092700'),(263,'gradeexport_xls_version','2007092700'),(264,'gradeexport_xml_version','2007092700'),(265,'gradeimport_csv_version','2007072500'),(266,'gradeimport_xml_version','2007092700'),(267,'gradereport_grader_version','2007091700'),(268,'gradereport_outcomes_version','2007073000'),(269,'gradereport_overview_version','2009022500'),(270,'gradereport_user_version','2007092500'),(271,'coursereport_log_version','2007101504'),(272,'coursereport_outline_version','2007101501'),(273,'coursereport_participation_version','2007101501'),(274,'coursereport_stats_version','2007101501'),(275,'report_courseoverview_version','2007101503'),(276,'report_security_version','2007101500'),(277,'report_unittest_version','2007101501'),(278,'adminblocks_initialised','1'),(279,'siteidentifier','o9zZYyl3HYYKaE4rlGEXkklgOheMjJDJlocalhost'),(280,'rolesactive','1'),(281,'guestroleid','6'),(282,'creatornewroleid','3'),(283,'notloggedinroleid','6'),(284,'defaultuserroleid','7'),(285,'defaultcourseroleid','5'),(286,'nonmetacoursesyncroleids',''),(287,'defaultrequestcategory','1'),(288,'gradebookroles','5'),(289,'enableoutcomes','0'),(290,'grade_profilereport','user'),(291,'grade_aggregationposition','1'),(292,'grade_includescalesinaggregation','1'),(293,'grade_hiddenasdate','0'),(294,'gradepublishing','0'),(295,'grade_export_displaytype','1'),(296,'grade_export_decimalpoints','2'),(297,'grade_navmethod','0'),(298,'gradeexport',''),(299,'unlimitedgrades','0'),(300,'grade_hideforcedsettings','1'),(301,'grade_aggregation','6'),(302,'grade_aggregation_flag','0'),(303,'grade_aggregations_visible','0,10,11,12,2,4,6,8,13'),(304,'grade_aggregateonlygraded','1'),(305,'grade_aggregateonlygraded_flag','2'),(306,'grade_aggregateoutcomes','0'),(307,'grade_aggregateoutcomes_flag','2'),(308,'grade_aggregatesubcats','0'),(309,'grade_aggregatesubcats_flag','2'),(310,'grade_keephigh','0'),(311,'grade_keephigh_flag','3'),(312,'grade_droplow','0'),(313,'grade_droplow_flag','2'),(314,'grade_displaytype','1'),(315,'grade_decimalpoints','2'),(316,'grade_item_advanced','iteminfo,idnumber,gradepass,plusfactor,multfactor,display,decimals,hiddenuntil,locktime'),(317,'grade_report_studentsperpage','100'),(318,'grade_report_quickgrading','1'),(319,'grade_report_showquickfeedback','0'),(320,'grade_report_fixedstudents','0'),(321,'grade_report_meanselection','1'),(322,'grade_report_showcalculations','0'),(323,'grade_report_showeyecons','0'),(324,'grade_report_showaverages','1'),(325,'grade_report_showlocks','0'),(326,'grade_report_showranges','0'),(327,'grade_report_showuserimage','1'),(328,'grade_report_showuseridnumber','0'),(329,'grade_report_showactivityicons','1'),(330,'grade_report_shownumberofgrades','0'),(331,'grade_report_averagesdisplaytype','inherit'),(332,'grade_report_rangesdisplaytype','inherit'),(333,'grade_report_averagesdecimalpoints','inherit'),(334,'grade_report_rangesdecimalpoints','inherit'),(335,'grade_report_overview_showrank','0'),(336,'grade_report_overview_showtotalsifcontainhidden','0'),(337,'grade_report_user_showrank','0'),(338,'grade_report_user_showpercentage','2'),(339,'grade_report_user_showhiddenitems','1'),(340,'grade_report_user_showtotalsifcontainhidden','0'),(341,'assignment_maxbytes','1048576'),(342,'assignment_itemstocount','1'),(343,'assignment_showrecentsubmissions','1'),(344,'chat_method','header_js'),(345,'chat_refresh_userlist','10'),(346,'chat_old_ping','35'),(347,'chat_refresh_room','5'),(348,'chat_normal_updatemode','jsupdate'),(349,'chat_serverhost','localhost'),(350,'chat_serverip','127.0.0.1'),(351,'chat_serverport','9111'),(352,'chat_servermax','100'),(353,'data_enablerssfeeds','0'),(354,'forum_displaymode','3'),(355,'forum_replytouser','1'),(356,'forum_shortpost','300'),(357,'forum_longpost','600'),(358,'forum_manydiscussions','100'),(359,'forum_maxbytes','512000'),(360,'forum_trackreadposts','1'),(361,'forum_oldpostdays','14'),(362,'forum_usermarksread','0'),(363,'forum_cleanreadtime','2'),(364,'forum_enablerssfeeds','0'),(365,'forum_enabletimedposts','0'),(366,'forum_logblocked','1'),(367,'forum_ajaxrating','0'),(368,'glossary_entbypage','10'),(369,'glossary_dupentries','0'),(370,'glossary_allowcomments','0'),(371,'glossary_linkbydefault','1'),(372,'glossary_defaultapproval','1'),(373,'glossary_enablerssfeeds','0'),(374,'glossary_linkentries','0'),(375,'glossary_casesensitive','0'),(376,'glossary_fullmatch','0'),(377,'lams_serverurl',''),(378,'lams_serverid',''),(379,'lams_serverkey',''),(380,'resource_framesize','130'),(381,'resource_websearch','http://google.com/'),(382,'resource_defaulturl','http://'),(383,'resource_secretphrase','b93Gq8IM8Sj90Y0rOYrD'),(384,'resource_popup',''),(385,'resource_popupresizable','checked'),(386,'resource_popupscrollbars','checked'),(387,'resource_popupdirectories','checked'),(388,'resource_popuplocation','checked'),(389,'resource_popupmenubar','checked'),(390,'resource_popuptoolbar','checked'),(391,'resource_popupstatus','checked'),(392,'resource_popupwidth','620'),(393,'resource_popupheight','450'),(394,'resource_autofilerename','1'),(395,'resource_blockdeletingfile','1'),(396,'scorm_grademethod','1'),(397,'scorm_maxgrade','100'),(398,'scorm_maxattempts','0'),(399,'scorm_whatgrade','0'),(400,'scorm_framewidth','100%'),(401,'scorm_frameheight','500'),(402,'scorm_popup','0'),(403,'scorm_resizable','0'),(404,'scorm_scrollbars','0'),(405,'scorm_directories','0'),(406,'scorm_location','0'),(407,'scorm_menubar','0'),(408,'scorm_toolbar','0'),(409,'scorm_status','0'),(410,'scorm_skipview','0'),(411,'scorm_hidebrowse','0'),(412,'scorm_hidetoc','0'),(413,'scorm_hidenav','0'),(414,'scorm_auto','0'),(415,'scorm_updatefreq','0'),(416,'block_course_list_adminview','all'),(417,'block_course_list_hideallcourseslink','0'),(418,'block_online_users_timetosee','5'),(419,'defaultallowedmodules',''),(420,'coursemanager','3'),(421,'frontpage','1'),(422,'frontpageloggedin','1'),(423,'maxcategorydepth','0'),(424,'coursesperpage','20'),(425,'allowvisiblecoursesinhiddencategories','0'),(426,'defaultfrontpageroleid','0'),(427,'supportname','Admin User'),(428,'supportemail','m.deridder@solin.nl'),(430,'siteguest','1'),(431,'jsrev','1'),(432,'themerev','1'),(433,'session_error_counter','18');
/*!40000 ALTER TABLE `mdl_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_config_plugins`
--

DROP TABLE IF EXISTS `mdl_config_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_config_plugins` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin` varchar(100) NOT NULL DEFAULT 'core',
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_confplug_plunam_uix` (`plugin`,`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Moodle modules and plugins configuration variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_config_plugins`
--

LOCK TABLES `mdl_config_plugins` WRITE;
/*!40000 ALTER TABLE `mdl_config_plugins` DISABLE KEYS */;
INSERT INTO `mdl_config_plugins` VALUES (1,'moodlecourse','format','weeks'),(2,'moodlecourse','numsections','10'),(3,'moodlecourse','hiddensections','0'),(4,'moodlecourse','newsitems','5'),(5,'moodlecourse','showgrades','1'),(6,'moodlecourse','showreports','0'),(7,'moodlecourse','maxbytes','2097152'),(8,'moodlecourse','metacourse','0'),(9,'qtype_random','selectmanual','0'),(10,'blocks/section_links','numsections1','22'),(11,'blocks/section_links','incby1','2'),(12,'blocks/section_links','numsections2','40'),(13,'blocks/section_links','incby2','5'),(14,'mnet','openssl_history','a:0:{}'),(15,'mnet','openssl_generations','3'),(16,'mnet','openssl','-----BEGIN CERTIFICATE-----\nMIIDszCCAxygAwIBAgIBADANBgkqhkiG9w0BAQQFADCBnjELMAkGA1UEBhMCTkwx\nDjAMBgNVBAgTBUJyZWRhMQ4wDAYDVQQHEwVCcmVkYTEXMBUGA1UEChMOSmVlbG8g\nTGF1bmNoZXIxDzANBgNVBAsTBk1vb2RsZTEhMB8GA1UEAxMYaHR0cDovL2xvY2Fs\naG9zdC9qZWVsbzE5MSIwIAYJKoZIhvcNAQkBFhNtLmRlcmlkZGVyQHNvbGluLm5s\nMB4XDTEyMDIxNTE1MDY0NFoXDTEyMDMxNDE1MDY0NFowgZ4xCzAJBgNVBAYTAk5M\nMQ4wDAYDVQQIEwVCcmVkYTEOMAwGA1UEBxMFQnJlZGExFzAVBgNVBAoTDkplZWxv\nIExhdW5jaGVyMQ8wDQYDVQQLEwZNb29kbGUxITAfBgNVBAMTGGh0dHA6Ly9sb2Nh\nbGhvc3QvamVlbG8xOTEiMCAGCSqGSIb3DQEJARYTbS5kZXJpZGRlckBzb2xpbi5u\nbDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAu89LmMXZkrCqLdBaLOZgPuSD\njQupDD1D46Oh9IfbB1XiVt7VqI79/lot4UkKuiaMsL4HBQZZAM6Ucnua0YZLMh7z\nA2aoYWkQnJSxAVJ1cG4hSKh28qrpZJAurtmmydFKE8ODZkIbg6+5kzWZtS4ubBY3\nU+rrOwmjIqXJOAKHL7kCAwEAAaOB/jCB+zAdBgNVHQ4EFgQUIra+jAOl9KP2p/1z\nNuwWKSp4O5QwgcsGA1UdIwSBwzCBwIAUIra+jAOl9KP2p/1zNuwWKSp4O5ShgaSk\ngaEwgZ4xCzAJBgNVBAYTAk5MMQ4wDAYDVQQIEwVCcmVkYTEOMAwGA1UEBxMFQnJl\nZGExFzAVBgNVBAoTDkplZWxvIExhdW5jaGVyMQ8wDQYDVQQLEwZNb29kbGUxITAf\nBgNVBAMTGGh0dHA6Ly9sb2NhbGhvc3QvamVlbG8xOTEiMCAGCSqGSIb3DQEJARYT\nbS5kZXJpZGRlckBzb2xpbi5ubIIBADAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEB\nBAUAA4GBAIZcWM1Tfxagmt2/dzzw+QHwSqALl1dsJ3u11t6GvJqKQYOvdbOZ+s8M\nJdy0Z/ic+QHD8m2xrDxOu7B+b415x3V9L1ExLc2uMuXSqNVOUlS5H4EolKxHKkd+\nR8W5G4E5OxTE81DIvT74Gp6FAcQJLUXYTsHg5P0ghQ0JkypGMuoy\n-----END CERTIFICATE-----\n@@@@@@@@-----BEGIN RSA PRIVATE KEY-----\nMIICXgIBAAKBgQC7z0uYxdmSsKot0Fos5mA+5IONC6kMPUPjo6H0h9sHVeJW3tWo\njv3+Wi3hSQq6JoywvgcFBlkAzpRye5rRhksyHvMDZqhhaRCclLEBUnVwbiFIqHby\nqulkkC6u2abJ0UoTw4NmQhuDr7mTNZm1Li5sFjdT6us7CaMipck4AocvuQIDAQAB\nAoGBALEQ85kJj+O5I/klop8KZFtnXo+wGqUrbcJFGABPxbTYyBhW5uGQTu9rXi40\niySOC77mqf+WyHr2SQbWelRoZKMwcQtRZCXJHFgGGU/MCgvEBWKuwxO1zAoRcEGW\nJ6zZiZDn7DcL9NMgnds2NkEbIXuginUWGFuML/Z5S4BGD2TxAkEA9VOSYz9llw9d\n9mDCcYp6emgKtsxpFBlrYkQUTnExEWln8Png//onCCmJzvwQr8A08YcuFY6+QHOe\n8jccxYynMwJBAMP7G0npuX2j99votR6xjardZIIfuuO6UDJuYMcQqPgh28LnhpVc\nBFDIjPjU3a5McffmVYcU/E+xRLg4MUYHXWMCQQCpdOm4HnF478dyyRFmxkWlybok\n3Ht0w742KVpxeKRxJ4MBpEjz6AIQFEk5rUmFbNnlP//oKipmcLcJDmKUXnybAkAm\nw61zIkLpYhxtqArjRlVyPZZa0rHhx4GDaCfGWDpD0laop6kMNAY6gGC5+0jZ6A8G\n7M1wCauai8K++YZthplnAkEA0g+iTJINnHotFaDhkfPXNXXUQHclWsb0Hl5v7jh6\nhODplXthll5GScTuD6WrJbz6fcamSZjHeRg9jQ48l+AtWA==\n-----END RSA PRIVATE KEY-----\n');
/*!40000 ALTER TABLE `mdl_config_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_context`
--

DROP TABLE IF EXISTS `mdl_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_context` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextlevel` bigint(10) unsigned NOT NULL DEFAULT '0',
  `instanceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  `depth` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_cont_conins_uix` (`contextlevel`,`instanceid`),
  KEY `mdl_cont_ins_ix` (`instanceid`),
  KEY `mdl_cont_pat_ix` (`path`)
) ENGINE=MyISAM AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='one of these must be set';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_context`
--

LOCK TABLES `mdl_context` WRITE;
/*!40000 ALTER TABLE `mdl_context` DISABLE KEYS */;
INSERT INTO `mdl_context` VALUES (1,10,0,'/1',1),(2,50,1,'/1/2',2),(3,40,1,'/1/3',2),(4,80,1,'/1/2/4',3),(5,80,2,'/1/2/5',3),(6,80,3,'/1/2/6',3),(7,80,4,'/1/2/7',3),(8,50,2,'/1/31/8',3),(9,80,7,'/1/31/8/9',4),(10,80,8,'/1/31/8/10',4),(11,80,9,'/1/31/8/11',4),(12,80,10,'/1/31/8/12',4),(13,80,11,'/1/31/8/13',4),(14,80,12,'/1/31/8/14',4),(15,70,1,'/1/31/8/15',4),(16,80,13,'/1/31/8/16',4),(17,80,14,'/1/31/8/17',4),(18,80,5,'/1/18',2),(19,80,6,'/1/19',2),(20,50,3,'/1/3/20',3),(21,80,15,'/1/3/20/21',4),(22,80,16,'/1/3/20/22',4),(23,80,17,'/1/3/20/23',4),(24,80,18,'/1/3/20/24',4),(25,80,19,'/1/3/20/25',4),(26,80,20,'/1/3/20/26',4),(27,70,2,'/1/3/20/27',4),(28,80,21,'/1/3/20/28',4),(29,80,22,'/1/3/20/29',4),(30,70,3,'/1/2/30',3),(31,40,2,'/1/31',2),(32,50,4,'/1/31/32',3),(33,80,23,'/1/31/32/33',4),(34,80,24,'/1/31/32/34',4),(35,80,25,'/1/31/32/35',4),(36,80,26,'/1/31/32/36',4),(37,80,27,'/1/31/32/37',4),(38,80,28,'/1/31/32/38',4),(39,70,4,'/1/31/32/39',4),(40,80,29,'/1/31/32/40',4),(41,80,30,'/1/31/32/41',4),(42,50,5,'/1/31/42',3),(43,50,6,'/1/31/43',3),(44,40,3,'/1/44',2),(45,50,7,'/1/44/45',3),(46,80,47,'/1/44/45/46',4),(47,80,48,'/1/44/45/47',4),(48,80,49,'/1/44/45/48',4),(49,80,50,'/1/44/45/49',4),(50,80,51,'/1/44/45/50',4),(51,80,52,'/1/44/45/51',4),(52,70,5,'/1/44/45/52',4),(53,80,53,'/1/44/45/53',4),(54,80,54,'/1/44/45/54',4),(55,50,8,'/1/44/55',3),(56,50,9,'/1/44/56',3),(57,50,10,'/1/44/57',3),(58,80,39,'/1/31/43/58',4),(59,80,40,'/1/31/43/59',4),(60,80,41,'/1/31/43/60',4),(61,80,42,'/1/31/43/61',4),(62,80,43,'/1/31/43/62',4),(63,80,44,'/1/31/43/63',4),(64,70,6,'/1/31/43/64',4),(65,80,45,'/1/31/43/65',4),(66,80,46,'/1/31/43/66',4),(67,80,31,'/1/31/42/67',4),(68,80,32,'/1/31/42/68',4),(69,80,33,'/1/31/42/69',4),(70,80,34,'/1/31/42/70',4),(71,80,35,'/1/31/42/71',4),(72,80,36,'/1/31/42/72',4),(73,70,7,'/1/31/42/73',4),(74,80,37,'/1/31/42/74',4),(75,80,38,'/1/31/42/75',4),(76,80,71,'/1/44/57/76',4),(77,80,72,'/1/44/57/77',4),(78,80,73,'/1/44/57/78',4),(79,80,74,'/1/44/57/79',4),(80,80,75,'/1/44/57/80',4),(81,80,76,'/1/44/57/81',4),(82,70,8,'/1/44/57/82',4),(83,80,77,'/1/44/57/83',4),(84,80,78,'/1/44/57/84',4),(85,80,63,'/1/44/56/85',4),(86,80,64,'/1/44/56/86',4),(87,80,65,'/1/44/56/87',4),(88,80,66,'/1/44/56/88',4),(89,80,67,'/1/44/56/89',4),(90,80,68,'/1/44/56/90',4),(91,70,9,'/1/44/56/91',4),(92,80,69,'/1/44/56/92',4),(93,80,70,'/1/44/56/93',4),(94,80,55,'/1/44/55/94',4),(95,80,56,'/1/44/55/95',4),(96,80,57,'/1/44/55/96',4),(97,80,58,'/1/44/55/97',4),(98,80,59,'/1/44/55/98',4),(99,80,60,'/1/44/55/99',4),(100,70,10,'/1/44/55/100',4),(101,80,61,'/1/44/55/101',4),(102,80,62,'/1/44/55/102',4),(103,30,1,'/1/103',2),(104,30,2,'/1/104',2),(105,70,11,'/1/31/43/105',4),(106,70,12,'/1/3/20/106',4),(107,50,11,'/1/31/107',3),(108,50,12,'/1/31/108',3),(109,70,13,'/1/31/8/109',4),(110,70,14,'/1/31/8/110',4),(111,40,4,'/1/111',2),(112,50,13,'/1/111/112',3),(113,70,15,'/1/111/112/113',4),(114,70,16,'/1/111/112/114',4),(115,70,17,'/1/111/112/115',4),(116,70,18,'/1/111/112/116',4),(117,70,19,'/1/111/112/117',4),(118,70,20,'/1/111/112/118',4),(119,70,21,'/1/111/112/119',4),(120,70,22,'/1/111/112/120',4),(121,70,23,'/1/111/112/121',4),(122,70,24,'/1/111/112/122',4),(123,70,25,'/1/111/112/123',4),(124,70,26,'/1/111/112/124',4),(125,70,27,'/1/111/112/125',4),(126,70,28,'/1/111/112/126',4),(127,70,29,'/1/111/112/127',4),(128,70,30,'/1/111/112/128',4),(129,70,31,'/1/111/112/129',4),(130,70,32,'/1/111/112/130',4),(131,70,33,'/1/111/112/131',4),(132,70,34,'/1/111/112/132',4),(133,80,95,'/1/111/112/133',4),(134,50,14,'/1/111/134',3),(135,70,35,'/1/111/134/135',4),(136,70,36,'/1/111/134/136',4),(137,70,37,'/1/111/134/137',4),(138,70,38,'/1/111/134/138',4),(139,70,39,'/1/111/134/139',4),(140,70,40,'/1/111/134/140',4),(141,70,41,'/1/111/134/141',4),(142,70,42,'/1/111/134/142',4),(143,70,43,'/1/111/134/143',4),(144,70,44,'/1/111/134/144',4),(145,70,45,'/1/111/134/145',4),(146,70,46,'/1/111/134/146',4),(147,70,47,'/1/111/134/147',4),(148,70,48,'/1/111/134/148',4),(149,70,49,'/1/111/134/149',4),(150,70,50,'/1/111/134/150',4),(151,70,51,'/1/111/134/151',4),(152,70,52,'/1/111/134/152',4),(153,70,53,'/1/111/134/153',4),(154,70,54,'/1/111/134/154',4),(155,70,55,'/1/111/134/155',4),(156,70,56,'/1/111/134/156',4),(157,70,57,'/1/111/134/157',4),(158,70,58,'/1/111/134/158',4),(159,70,59,'/1/111/134/159',4),(160,70,60,'/1/111/134/160',4),(161,70,61,'/1/111/134/161',4),(162,70,62,'/1/111/134/162',4),(163,70,63,'/1/111/134/163',4),(164,70,64,'/1/111/134/164',4),(165,70,65,'/1/111/134/165',4),(166,70,66,'/1/111/134/166',4),(167,70,67,'/1/111/134/167',4),(168,70,68,'/1/111/134/168',4),(169,70,69,'/1/111/134/169',4),(170,70,70,'/1/111/134/170',4),(171,70,71,'/1/111/134/171',4),(172,70,72,'/1/111/134/172',4),(173,70,73,'/1/111/134/173',4),(174,70,74,'/1/111/134/174',4),(175,70,75,'/1/111/134/175',4),(176,70,76,'/1/111/134/176',4),(177,50,15,'/1/111/177',3),(178,70,77,'/1/111/177/178',4),(179,70,78,'/1/111/177/179',4),(180,70,79,'/1/111/177/180',4),(181,70,80,'/1/111/177/181',4),(182,70,81,'/1/111/177/182',4),(183,70,82,'/1/111/177/183',4),(184,70,83,'/1/111/177/184',4),(185,70,84,'/1/111/177/185',4),(186,70,85,'/1/111/177/186',4),(187,70,86,'/1/111/177/187',4),(188,70,87,'/1/111/177/188',4),(189,70,88,'/1/111/177/189',4),(190,70,89,'/1/111/177/190',4),(191,70,90,'/1/111/177/191',4),(192,70,91,'/1/111/177/192',4),(193,70,92,'/1/111/177/193',4),(194,70,93,'/1/111/177/194',4),(195,70,94,'/1/111/177/195',4),(196,70,95,'/1/111/177/196',4),(197,70,96,'/1/111/177/197',4),(198,70,97,'/1/111/177/198',4),(199,70,98,'/1/111/177/199',4),(200,70,99,'/1/111/177/200',4),(201,70,100,'/1/111/177/201',4),(202,70,101,'/1/111/177/202',4),(203,70,102,'/1/111/177/203',4),(204,70,103,'/1/111/177/204',4),(205,70,104,'/1/111/177/205',4),(206,70,105,'/1/111/177/206',4),(207,80,97,'/1/111/177/207',4),(208,50,16,'/1/111/208',3),(209,70,106,'/1/111/208/209',4),(210,70,107,'/1/111/208/210',4),(211,70,108,'/1/111/208/211',4),(212,70,109,'/1/111/208/212',4),(213,70,110,'/1/111/208/213',4),(214,70,111,'/1/111/208/214',4),(215,70,112,'/1/111/208/215',4),(216,70,113,'/1/111/208/216',4),(217,70,114,'/1/111/208/217',4),(218,70,115,'/1/111/208/218',4),(219,70,116,'/1/111/208/219',4),(220,70,117,'/1/111/208/220',4),(221,70,118,'/1/111/208/221',4),(222,70,119,'/1/111/208/222',4),(223,70,120,'/1/111/208/223',4),(224,70,121,'/1/111/208/224',4),(225,70,122,'/1/111/208/225',4),(226,70,123,'/1/111/208/226',4),(227,70,124,'/1/111/208/227',4),(228,70,125,'/1/111/208/228',4),(229,70,126,'/1/111/208/229',4),(230,70,127,'/1/111/208/230',4),(231,70,128,'/1/111/208/231',4),(232,70,129,'/1/111/208/232',4),(233,70,130,'/1/111/208/233',4),(234,70,131,'/1/111/208/234',4),(235,70,132,'/1/111/208/235',4),(236,70,133,'/1/111/208/236',4),(237,70,134,'/1/111/208/237',4),(238,70,135,'/1/111/208/238',4),(239,80,98,'/1/111/208/239',4),(240,80,96,'/1/111/134/240',4),(241,50,17,'/1/3/241',3),(242,70,136,'/1/3/241/242',4),(243,70,137,'/1/3/241/243',4),(244,70,138,'/1/3/241/244',4),(245,70,139,'/1/3/241/245',4),(246,70,140,'/1/3/241/246',4),(247,70,141,'/1/3/241/247',4),(248,70,142,'/1/3/241/248',4),(249,70,143,'/1/3/241/249',4),(250,70,144,'/1/3/241/250',4),(251,70,145,'/1/3/241/251',4),(252,70,146,'/1/3/241/252',4),(253,70,147,'/1/3/241/253',4),(254,70,148,'/1/3/241/254',4),(255,70,149,'/1/3/241/255',4),(256,70,150,'/1/3/241/256',4),(257,70,151,'/1/3/241/257',4),(258,70,152,'/1/3/241/258',4),(259,70,153,'/1/3/241/259',4),(260,70,154,'/1/3/241/260',4),(261,70,155,'/1/3/241/261',4),(262,70,156,'/1/3/241/262',4),(263,70,157,'/1/3/241/263',4),(264,70,158,'/1/3/241/264',4),(265,70,159,'/1/3/241/265',4),(266,70,160,'/1/3/241/266',4),(267,70,161,'/1/3/241/267',4),(268,70,162,'/1/3/241/268',4),(269,70,163,'/1/3/241/269',4),(270,70,164,'/1/3/241/270',4),(271,70,165,'/1/3/241/271',4);
/*!40000 ALTER TABLE `mdl_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_context_temp`
--

DROP TABLE IF EXISTS `mdl_context_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_context_temp` (
  `id` bigint(10) unsigned NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '',
  `depth` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Used by build_context_path() in upgrade and cron to keep con';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_context_temp`
--

LOCK TABLES `mdl_context_temp` WRITE;
/*!40000 ALTER TABLE `mdl_context_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_context_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course`
--

DROP TABLE IF EXISTS `mdl_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '',
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `summary` text,
  `format` varchar(10) NOT NULL DEFAULT 'topics',
  `showgrades` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `modinfo` longtext,
  `newsitems` mediumint(5) unsigned NOT NULL DEFAULT '1',
  `teacher` varchar(100) NOT NULL DEFAULT 'Teacher',
  `teachers` varchar(100) NOT NULL DEFAULT 'Teachers',
  `student` varchar(100) NOT NULL DEFAULT 'Student',
  `students` varchar(100) NOT NULL DEFAULT 'Students',
  `guest` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `startdate` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enrolperiod` bigint(10) unsigned NOT NULL DEFAULT '0',
  `numsections` mediumint(5) unsigned NOT NULL DEFAULT '1',
  `marker` bigint(10) unsigned NOT NULL DEFAULT '0',
  `maxbytes` bigint(10) unsigned NOT NULL DEFAULT '0',
  `showreports` smallint(4) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `hiddensections` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `groupmode` smallint(4) unsigned NOT NULL DEFAULT '0',
  `groupmodeforce` smallint(4) unsigned NOT NULL DEFAULT '0',
  `defaultgroupingid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(30) NOT NULL DEFAULT '',
  `theme` varchar(50) NOT NULL DEFAULT '',
  `groupyear` varchar(30) NOT NULL DEFAULT '',
  `cost` varchar(10) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `metacourse` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `requested` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `restrictmodules` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `expirynotify` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `expirythreshold` bigint(10) unsigned NOT NULL DEFAULT '0',
  `notifystudents` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `enrollable` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `enrolstartdate` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enrolenddate` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enrol` varchar(20) NOT NULL DEFAULT '',
  `defaultrole` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_cour_cat_ix` (`category`),
  KEY `mdl_cour_idn_ix` (`idnumber`),
  KEY `mdl_cour_sho_ix` (`shortname`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Central course table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course`
--

LOCK TABLES `mdl_course` WRITE;
/*!40000 ALTER TABLE `mdl_course` DISABLE KEYS */;
INSERT INTO `mdl_course` VALUES (1,0,0,'','Jeelo Launcher','jeelo_launcher','','','site',1,'a:1:{i:3;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:3;s:3:\"mod\";s:8:\"launcher\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:8:\"Launcher\";}}',3,'Teacher','Teachers','Student','Students',0,0,0,0,0,0,0,1,0,0,0,0,'','','','','USD',0,1323877281,0,0,0,0,0,0,1,0,0,'',0),(2,2,100,'','Jaar 1/2 - Samen spelen','CF101','',' Jaar 1/2 - Samen spelen','weeks',1,'a:3:{i:1;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:1;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}i:13;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:13;s:3:\"mod\";s:4:\"chat\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:9:\"Test+chat\";}i:14;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"2\";s:2:\"cm\";i:14;s:3:\"mod\";s:6:\"choice\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"Test+choice\";}}',5,'Teacher','Teachers','Student','Students',0,1325026800,0,10,0,2097152,0,1,0,0,0,0,'','','1/2','','USD',1324980904,1325682205,0,0,0,0,864000,0,1,0,0,'',0),(3,1,99,'','Course Fullname 102','CF102','','Test Course 2 ','weeks',1,'a:2:{i:2;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"2\";s:2:\"cm\";i:2;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}i:12;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:12;s:3:\"mod\";s:6:\"choice\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"test+choice\";}}',5,'Teacher','Teachers','Student','Students',0,1325026800,0,10,0,2097152,0,1,0,0,0,0,'','','','','USD',1324980934,1324980934,0,0,0,0,864000,0,1,0,0,'',0),(4,2,99,'','Jaar 3/4 - Leven in een gezin','CF103','','','weeks',1,'a:1:{i:4;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"3\";s:2:\"cm\";i:4;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','3/4','','USD',1325605060,1325682195,0,0,0,0,864000,0,1,0,0,'',0),(5,2,98,'','Jaar 5/6 - Vrienden in een groep','CF104','','','weeks',1,'a:1:{i:7;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"6\";s:2:\"cm\";i:7;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','5/6','','USD',1325605111,1325682183,0,0,0,0,864000,0,1,0,0,'',0),(6,2,97,'','Jaar 7/8 - Waarderen van verschillen','CF105','','','weeks',1,'a:2:{i:6;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"5\";s:2:\"cm\";i:6;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}i:11;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:11;s:3:\"mod\";s:10:\"assignment\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:13:\"Test+activity\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','7/8','','USD',1325605140,1325682169,0,0,0,0,864000,0,1,0,0,'',0),(7,3,100,'','Jaar 1/2 - Wonen in je straat','CF106','','','weeks',1,'a:1:{i:5;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"4\";s:2:\"cm\";i:5;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','1/2','','USD',1325605204,1325682246,0,0,0,0,864000,0,1,0,0,'',0),(8,3,99,'','Jaar 3/4 - Zorg voor je wijk','CF107','','','weeks',1,'a:1:{i:10;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"9\";s:2:\"cm\";i:10;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','3/4','','USD',1325605237,1325682238,0,0,0,0,864000,0,1,0,0,'',0),(9,3,98,'','Jaar 5/6 - Vrije tijd in je stad of dorp','CF108','','','weeks',1,'a:1:{i:9;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"8\";s:2:\"cm\";i:9;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','5/6','','USD',1325605257,1325682231,0,0,0,0,864000,0,1,0,0,'',0),(10,3,97,'','Jaar 7/8 - Ontwikkelen van je gemeente','CF109','','','weeks',1,'a:1:{i:8;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"7\";s:2:\"cm\";i:8;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:10:\"News+forum\";}}',5,'Teacher','Teachers','Student','Students',0,1325631600,0,10,0,2097152,0,1,0,0,0,0,'','','7/8','','USD',1325605275,1325682222,0,0,0,0,864000,0,1,0,0,'',0),(13,4,100,'','Wonen in je straat','Wonen in je straat','','','topics',1,'a:20:{i:15;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"10\";s:2:\"cm\";i:15;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"Nieuwsforum\";}i:16;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:16;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+1\";s:4:\"name\";s:11:\"Periode%2B1\";}i:17;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:17;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource1%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D17%27%2C%27resource1%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:22:\"Film%3A+Afval+scheiden\";}i:18;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"2\";s:2:\"cm\";i:18;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource2%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D18%27%2C%27resource2%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:21:\"Film%3A+Glas+recyclen\";}i:19;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"2\";s:2:\"cm\";i:19;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+3\";s:4:\"name\";s:11:\"Periode%2B3\";}i:20;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"3\";s:2:\"cm\";i:20;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource3%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D20%27%2C%27resource3%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:27:\"Film%3A+Schoonmaken+in+huis\";}i:21;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"4\";s:2:\"cm\";i:21;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource4%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D21%27%2C%27resource4%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:35:\"Film%3A+Spullen+kopen+voor+je+kamer\";}i:22;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"1\";s:2:\"cm\";i:22;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:22:\"193+Wonen+in+je+straat\";}i:23;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"2\";s:2:\"cm\";i:23;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"195+Woorden%3A+Het+huis\";}i:24;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"3\";s:2:\"cm\";i:24;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:32:\"196+Praatplaat%3A+Soorten+huizen\";}i:25;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"4\";s:2:\"cm\";i:25;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"199+Hoek%3A+Huizen+bouwen\";}i:26;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"5\";s:2:\"cm\";i:26;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:22:\"200+Maak+je+slaapkamer\";}i:27;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"6\";s:2:\"cm\";i:27;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"201+Woorden%3A+De+straat\";}i:28;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"7\";s:2:\"cm\";i:28;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:32:\"202+Bewegen%3A+Stoeptegelspellen\";}i:29;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"8\";s:2:\"cm\";i:29;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:36:\"203+Doeblad%3A+Houd+je+straat+schoon\";}i:30;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"9\";s:2:\"cm\";i:30;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:21:\"205+Ruim+de+straat+op\";}i:31;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"10\";s:2:\"cm\";i:31;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"206+Teken+je+eigen+huis\";}i:32;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"11\";s:2:\"cm\";i:32;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:36:\"216+Onder%2C+boven%2C+voor+en+achter\";}i:33;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"12\";s:2:\"cm\";i:33;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:19:\"217+Links+en+rechts\";}i:34;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"13\";s:2:\"cm\";i:34;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"727+Teken+het+leukste+schoolplein\";}}',5,'Leraar','Leraren','Leerling','Leerlingen',0,1311112800,0,10,0,2097152,0,1,0,0,0,0,'','','1/2','','USD',1311028728,1332833192,0,0,0,0,864000,0,1,0,0,'',0),(14,4,101,'','Ontwikkeling van je gemeente','Ontwikkeling van je gemeente','','','topics',1,'a:42:{i:35;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"11\";s:2:\"cm\";i:35;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"Nieuwsforum\";}i:36;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"3\";s:2:\"cm\";i:36;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+1\";s:4:\"name\";s:11:\"Periode%2B1\";}i:37;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"5\";s:2:\"cm\";i:37;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource5%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D37%27%2C%27resource5%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:28:\"Film%3A+De+groei+van+Utrecht\";}i:38;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"6\";s:2:\"cm\";i:38;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource6%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D38%27%2C%27resource6%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:34:\"Film%3A+Het+ontstaan+van+Amsterdam\";}i:39;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"7\";s:2:\"cm\";i:39;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource7%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D39%27%2C%27resource7%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:37:\"Film%3A+Verstedelijking+van+Nederland\";}i:40;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"4\";s:2:\"cm\";i:40;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:14:\"Periode+1+of+2\";s:4:\"name\";s:20:\"Periode%2B1%2Bof%2B2\";}i:41;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"8\";s:2:\"cm\";i:41;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource8%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D41%27%2C%27resource8%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:26:\"Film%3A+De+overzichtskaart\";}i:42;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"5\";s:2:\"cm\";i:42;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+2\";s:4:\"name\";s:11:\"Periode%2B2\";}i:43;O:8:\"stdClass\":11:{s:2:\"id\";s:1:\"9\";s:2:\"cm\";i:43;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:294:\"onclick%3D%22this.target%3D%27resource9%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D43%27%2C%27resource9%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:38:\"Film%3A+Besluiten+door+de+gemeenteraad\";}i:44;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"14\";s:2:\"cm\";i:44;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"7+Voorzieningen+voor+iedereen\";}i:45;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"15\";s:2:\"cm\";i:45;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:35:\"7+Toets+Voorzieningen+voor+iedereen\";}i:46;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"16\";s:2:\"cm\";i:46;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:22:\"8+Werk+met+google+maps\";}i:47;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"17\";s:2:\"cm\";i:47;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:20:\"9+Rekenen+met+schaal\";}i:48;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"18\";s:2:\"cm\";i:48;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:26:\"9+Toets+Rekenen+met+schaal\";}i:49;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"19\";s:2:\"cm\";i:49;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:22:\"111+Houd+een+interview\";}i:50;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"20\";s:2:\"cm\";i:50;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:28:\"170+Doe+historisch+onderzoek\";}i:51;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"21\";s:2:\"cm\";i:51;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:28:\"176+Onderdelen+van+een+kaart\";}i:52;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"22\";s:2:\"cm\";i:52;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:34:\"176+Toets+Onderdelen+van+een+kaart\";}i:53;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"23\";s:2:\"cm\";i:53;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:19:\"177+Een+kaart+lezen\";}i:54;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"24\";s:2:\"cm\";i:54;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"177+Toets+Een+kaart+lezen\";}i:55;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"25\";s:2:\"cm\";i:55;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"178+Opbouw+van+een+stad\";}i:56;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"26\";s:2:\"cm\";i:56;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"178+Toets+Opbouw+van+een+stad\";}i:57;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"27\";s:2:\"cm\";i:57;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:19:\"179+Soorten+kaarten\";}i:58;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"28\";s:2:\"cm\";i:58;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"179+Toets+Soorten+kaarten\";}i:59;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"29\";s:2:\"cm\";i:59;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"180+Ontwerp+een+plein+op+schaal\";}i:60;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"30\";s:2:\"cm\";i:60;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"185+Taken+van+de+gemeente\";}i:61;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"31\";s:2:\"cm\";i:61;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"185+Toets+Taken+van+de+gemeente\";}i:62;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"32\";s:2:\"cm\";i:62;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"186+Ruimtelijke+ordening\";}i:63;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"33\";s:2:\"cm\";i:63;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:30:\"186+Toets+Ruimtelijke+ordening\";}i:64;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"34\";s:2:\"cm\";i:64;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:56:\"187+Historisch+onderzoek%3A+Ontwikkeling+van+je+gemeente\";}i:65;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"35\";s:2:\"cm\";i:65;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:48:\"188+Pleinontwerp%3A+Ontwikkeling+van+je+gemeente\";}i:66;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"36\";s:2:\"cm\";i:66;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"189+Verstedelijking+van+Nederland\";}i:67;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"37\";s:2:\"cm\";i:67;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:39:\"189+Toets+Verstedelijking+van+Nederland\";}i:68;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"38\";s:2:\"cm\";i:68;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"191+Ontstaan+van+dorpen\";}i:69;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"39\";s:2:\"cm\";i:69;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"191+Toets+Ontstaan+van+dorpen\";}i:70;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"40\";s:2:\"cm\";i:70;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"192+Ontstaan+van+steden\";}i:71;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"41\";s:2:\"cm\";i:71;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"192+Toets+Ontstaan+van+steden\";}i:72;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"42\";s:2:\"cm\";i:72;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:20:\"208+Houd+een+enquete\";}i:73;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"43\";s:2:\"cm\";i:73;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"209+Ontwikkeling+van+toerisme\";}i:74;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"44\";s:2:\"cm\";i:74;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:35:\"209+Toets+Ontwikkeling+van+toerisme\";}i:75;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"45\";s:2:\"cm\";i:75;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:30:\"211+Maak+samen+een+nieuwe+wijk\";}i:76;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"46\";s:2:\"cm\";i:76;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"727+Teken+het+leukste+schoolplein\";}}',5,'Leraar','Leraren','Leerling','Leerlingen',0,1311976800,0,10,0,2097152,0,1,0,0,0,0,'','','3/4','','USD',1311938759,1332833219,0,0,0,0,864000,0,1,0,0,'',0),(15,4,102,'','Vrije tijd in je buurt','Vrije tijd in je buurt','','','topics',1,'a:29:{i:77;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"12\";s:2:\"cm\";i:77;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"Nieuwsforum\";}i:78;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"6\";s:2:\"cm\";i:78;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:14:\"Periode+1+of+2\";s:4:\"name\";s:20:\"Periode%2B1%2Bof%2B2\";}i:79;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"10\";s:2:\"cm\";i:79;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:296:\"onclick%3D%22this.target%3D%27resource10%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D79%27%2C%27resource10%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:26:\"Film%3A+De+overzichtskaart\";}i:80;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"7\";s:2:\"cm\";i:80;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+2\";s:4:\"name\";s:11:\"Periode%2B2\";}i:81;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"11\";s:2:\"cm\";i:81;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:296:\"onclick%3D%22this.target%3D%27resource11%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D81%27%2C%27resource11%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:37:\"Film%3A+Wonen+in+een+middeleeuws+huis\";}i:82;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"12\";s:2:\"cm\";i:82;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:296:\"onclick%3D%22this.target%3D%27resource12%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D82%27%2C%27resource12%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:31:\"Film%3A+Een+middeleeuwse+straat\";}i:83;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"13\";s:2:\"cm\";i:83;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:296:\"onclick%3D%22this.target%3D%27resource13%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D83%27%2C%27resource13%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:45:\"Film%3A+Speeltoestellen+voor+openbare+ruimtes\";}i:84;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"47\";s:2:\"cm\";i:84;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:22:\"8+Werk+met+google+maps\";}i:85;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"48\";s:2:\"cm\";i:85;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:41:\"174+Rondleiding%3A+Vrije+tijd+in+je+buurt\";}i:86;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"49\";s:2:\"cm\";i:86;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:35:\"175+Plein%3A+Vrije+tijd+in+je+buurt\";}i:87;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"50\";s:2:\"cm\";i:87;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:28:\"176+Onderdelen+van+een+kaart\";}i:88;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"51\";s:2:\"cm\";i:88;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:34:\"176+Toets+Onderdelen+van+een+kaart\";}i:89;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"52\";s:2:\"cm\";i:89;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:19:\"177+Een+kaart+lezen\";}i:90;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"53\";s:2:\"cm\";i:90;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"177+Toets+Een+kaart+lezen\";}i:91;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"54\";s:2:\"cm\";i:91;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:19:\"179+Soorten+kaarten\";}i:92;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"55\";s:2:\"cm\";i:92;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"179+Toets+Soorten+kaarten\";}i:93;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"56\";s:2:\"cm\";i:93;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"181+Openbare+speelruimtes\";}i:94;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"57\";s:2:\"cm\";i:94;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"181+Toets+Openbare+speelruimtes\";}i:95;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"58\";s:2:\"cm\";i:95;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"182+Soorten+vrijetijdsbestedingen\";}i:96;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"59\";s:2:\"cm\";i:96;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:39:\"182+Toets+Soorten+vrijetijdsbestedingen\";}i:97;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"60\";s:2:\"cm\";i:97;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"183+Maak+een+rondleiding\";}i:98;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"61\";s:2:\"cm\";i:98;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:26:\"184+Ontwerp+een+speelplein\";}i:99;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"62\";s:2:\"cm\";i:99;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:35:\"190+Zoek+naar+vrijetijdsbestedingen\";}i:100;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"63\";s:2:\"cm\";i:100;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:34:\"207+Leven+in+een+middeleeuwse+stad\";}i:101;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"64\";s:2:\"cm\";i:101;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:40:\"207+Toets+Leven+in+een+middeleeuwse+stad\";}i:102;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"65\";s:2:\"cm\";i:102;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:30:\"211+Maak+samen+een+nieuwe+wijk\";}i:103;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"66\";s:2:\"cm\";i:103;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"218+Toerisme+in+Nederland\";}i:104;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"67\";s:2:\"cm\";i:104;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"218+Toets+Toerisme+in+Nederland\";}i:105;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"68\";s:2:\"cm\";i:105;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"727+Teken+het+leukste+schoolplein\";}}',5,'Leraar','Leraren','Leerling','Leerlingen',0,1311976800,0,10,0,2097152,0,1,0,0,0,0,'','','5/6','','USD',1311938721,1332833227,0,0,0,0,864000,0,1,0,0,'',0),(16,4,103,'','Zorg voor je wijk','Zorg voor je wijk','','','topics',1,'a:30:{i:106;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"13\";s:2:\"cm\";i:106;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"Nieuwsforum\";}i:107;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"8\";s:2:\"cm\";i:107;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+1\";s:4:\"name\";s:11:\"Periode%2B1\";}i:108;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"14\";s:2:\"cm\";i:108;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource14%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D108%27%2C%27resource14%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:22:\"Film%3A+Afval+scheiden\";}i:109;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"15\";s:2:\"cm\";i:109;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource15%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D109%27%2C%27resource15%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:18:\"Film%3A+Groenafval\";}i:110;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"16\";s:2:\"cm\";i:110;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource16%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D110%27%2C%27resource16%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:17:\"Film%3A+Restafval\";}i:111;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"17\";s:2:\"cm\";i:111;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource17%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D111%27%2C%27resource17%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:17:\"Film%3A+Glasafval\";}i:112;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"18\";s:2:\"cm\";i:112;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource18%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D112%27%2C%27resource18%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:18:\"Film%3A+Oud+papier\";}i:113;O:8:\"stdClass\":10:{s:2:\"id\";s:1:\"9\";s:2:\"cm\";i:113;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+2\";s:4:\"name\";s:11:\"Periode%2B2\";}i:114;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"19\";s:2:\"cm\";i:114;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource19%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D114%27%2C%27resource19%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:17:\"Film%3A+Het+riool\";}i:115;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"20\";s:2:\"cm\";i:115;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource20%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D115%27%2C%27resource20%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:48:\"Film%3A+Straatputten+en+leidingen+onder+de+grond\";}i:116;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"21\";s:2:\"cm\";i:116;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource21%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D116%27%2C%27resource21%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:57:\"Film%3A+De+waterzuivering%2C+de+waterleiding+en+het+riool\";}i:117;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"10\";s:2:\"cm\";i:117;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+3\";s:4:\"name\";s:11:\"Periode%2B3\";}i:118;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"22\";s:2:\"cm\";i:118;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource22%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D118%27%2C%27resource22%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:32:\"Film%3A+Zelf+een+speeltuin+maken\";}i:119;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"69\";s:2:\"cm\";i:119;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"163+Straat%3A+Zorg+voor+je+wijk\";}i:120;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"70\";s:2:\"cm\";i:120;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:34:\"164+Speelplek%3A+Zorg+voor+je+wijk\";}i:121;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"71\";s:2:\"cm\";i:121;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:18:\"165+Soorten+huizen\";}i:122;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"72\";s:2:\"cm\";i:122;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"165+Toets+Soorten+huizen\";}i:123;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"73\";s:2:\"cm\";i:123;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"166+Buizen+door+de+wijk\";}i:124;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"74\";s:2:\"cm\";i:124;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"166+Toets+Buizen+door+de+wijk\";}i:125;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"75\";s:2:\"cm\";i:125;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"167+Een+huis+van+vroeger\";}i:126;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"76\";s:2:\"cm\";i:126;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:30:\"167+Toets+Een+huis+van+vroeger\";}i:127;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"77\";s:2:\"cm\";i:127;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"168+Een+groene+en+schone+wijk\";}i:128;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"78\";s:2:\"cm\";i:128;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:35:\"168+Toets+Een+groene+en+schone+wijk\";}i:129;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"79\";s:2:\"cm\";i:129;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"169+Maak+de+wijk+schoon\";}i:130;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"80\";s:2:\"cm\";i:130;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:38:\"171+Teken+je+huis+van+binnen+en+buiten\";}i:131;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"81\";s:2:\"cm\";i:131;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"172+Schilder+samen+een+straat\";}i:132;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"82\";s:2:\"cm\";i:132;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:28:\"173+Maak+samen+een+speelveld\";}i:133;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"83\";s:2:\"cm\";i:133;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"210+Een+plattegrond+lezen\";}i:134;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"84\";s:2:\"cm\";i:134;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"210+Toets+Een+plattegrond+lezen\";}i:135;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"85\";s:2:\"cm\";i:135;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"727+Teken+het+leukste+schoolplein\";}}',5,'Leraar','Leraren','Leerling','Leerlingen',0,1311976800,0,10,0,2097152,0,1,0,0,0,0,'','','7/8','','USD',1311938681,1332833236,0,0,0,0,864000,0,1,0,0,'',0),(17,1,100,'','Zorg voor je wijk copy 1','Zorg voor je wijk_1','','','topics',1,'a:30:{i:136;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"14\";s:2:\"cm\";i:136;s:3:\"mod\";s:5:\"forum\";s:7:\"section\";s:1:\"0\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:11:\"Nieuwsforum\";}i:137;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"11\";s:2:\"cm\";i:137;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+1\";s:4:\"name\";s:11:\"Periode%2B1\";}i:138;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"23\";s:2:\"cm\";i:138;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource23%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D138%27%2C%27resource23%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:22:\"Film%3A+Afval+scheiden\";}i:139;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"24\";s:2:\"cm\";i:139;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource24%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D139%27%2C%27resource24%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:18:\"Film%3A+Groenafval\";}i:140;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"25\";s:2:\"cm\";i:140;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource25%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D140%27%2C%27resource25%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:17:\"Film%3A+Restafval\";}i:141;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"26\";s:2:\"cm\";i:141;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource26%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D141%27%2C%27resource26%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:17:\"Film%3A+Glasafval\";}i:142;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"27\";s:2:\"cm\";i:142;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource27%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D142%27%2C%27resource27%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:18:\"Film%3A+Oud+papier\";}i:143;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"12\";s:2:\"cm\";i:143;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+2\";s:4:\"name\";s:11:\"Periode%2B2\";}i:144;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"28\";s:2:\"cm\";i:144;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource28%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D144%27%2C%27resource28%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:17:\"Film%3A+Het+riool\";}i:145;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"29\";s:2:\"cm\";i:145;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource29%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D145%27%2C%27resource29%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:48:\"Film%3A+Straatputten+en+leidingen+onder+de+grond\";}i:146;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"30\";s:2:\"cm\";i:146;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource30%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D146%27%2C%27resource30%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:57:\"Film%3A+De+waterzuivering%2C+de+waterleiding+en+het+riool\";}i:147;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"13\";s:2:\"cm\";i:147;s:3:\"mod\";s:5:\"label\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:9:\"Periode+3\";s:4:\"name\";s:11:\"Periode%2B3\";}i:148;O:8:\"stdClass\":11:{s:2:\"id\";s:2:\"31\";s:2:\"cm\";i:148;s:3:\"mod\";s:8:\"resource\";s:7:\"section\";s:1:\"1\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:297:\"onclick%3D%22this.target%3D%27resource31%27%3B+return+openpopup%28%27%2Fmod%2Fresource%2Fview.php%3Finpopup%3Dtrue%26amp%3Bid%3D148%27%2C%27resource31%27%2C%27resizable%3D%2Cscrollbars%3D%2Cdirectories%3D%2Clocation%3D%2Cmenubar%3D%2Ctoolbar%3D%2Cstatus%3D%2Cwidth%3D680%2Cheight%3D540%27%29%3B%22\";s:4:\"icon\";s:9:\"f/web.gif\";s:4:\"name\";s:32:\"Film%3A+Zelf+een+speeltuin+maken\";}i:149;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"86\";s:2:\"cm\";i:149;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"163+Straat%3A+Zorg+voor+je+wijk\";}i:150;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"87\";s:2:\"cm\";i:150;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:34:\"164+Speelplek%3A+Zorg+voor+je+wijk\";}i:151;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"88\";s:2:\"cm\";i:151;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:18:\"165+Soorten+huizen\";}i:152;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"89\";s:2:\"cm\";i:152;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"165+Toets+Soorten+huizen\";}i:153;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"90\";s:2:\"cm\";i:153;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"166+Buizen+door+de+wijk\";}i:154;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"91\";s:2:\"cm\";i:154;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"166+Toets+Buizen+door+de+wijk\";}i:155;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"92\";s:2:\"cm\";i:155;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:24:\"167+Een+huis+van+vroeger\";}i:156;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"93\";s:2:\"cm\";i:156;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:30:\"167+Toets+Een+huis+van+vroeger\";}i:157;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"94\";s:2:\"cm\";i:157;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"168+Een+groene+en+schone+wijk\";}i:158;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"95\";s:2:\"cm\";i:158;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:35:\"168+Toets+Een+groene+en+schone+wijk\";}i:159;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"96\";s:2:\"cm\";i:159;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:23:\"169+Maak+de+wijk+schoon\";}i:160;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"97\";s:2:\"cm\";i:160;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:38:\"171+Teken+je+huis+van+binnen+en+buiten\";}i:161;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"98\";s:2:\"cm\";i:161;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:29:\"172+Schilder+samen+een+straat\";}i:162;O:8:\"stdClass\":10:{s:2:\"id\";s:2:\"99\";s:2:\"cm\";i:162;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:28:\"173+Maak+samen+een+speelveld\";}i:163;O:8:\"stdClass\":10:{s:2:\"id\";s:3:\"100\";s:2:\"cm\";i:163;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:25:\"210+Een+plattegrond+lezen\";}i:164;O:8:\"stdClass\":10:{s:2:\"id\";s:3:\"101\";s:2:\"cm\";i:164;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:31:\"210+Toets+Een+plattegrond+lezen\";}i:165;O:8:\"stdClass\":10:{s:2:\"id\";s:3:\"102\";s:2:\"cm\";i:165;s:3:\"mod\";s:5:\"scorm\";s:7:\"section\";s:1:\"2\";s:7:\"visible\";s:1:\"1\";s:9:\"groupmode\";s:1:\"0\";s:10:\"groupingid\";s:1:\"0\";s:16:\"groupmembersonly\";s:1:\"0\";s:5:\"extra\";s:0:\"\";s:4:\"name\";s:33:\"727+Teken+het+leukste+schoolplein\";}}',5,'Leraar','Leraren','Leerling','Leerlingen',0,1311976800,0,10,0,134217728,0,1,0,0,0,0,'','','','','USD',1311938681,1311938681,0,0,0,0,864000,0,1,0,0,'',0);
/*!40000 ALTER TABLE `mdl_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_allowed_modules`
--

DROP TABLE IF EXISTS `mdl_course_allowed_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_allowed_modules` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `module` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courallomodu_cou_ix` (`course`),
  KEY `mdl_courallomodu_mod_ix` (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='allowed modules foreach course';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_allowed_modules`
--

LOCK TABLES `mdl_course_allowed_modules` WRITE;
/*!40000 ALTER TABLE `mdl_course_allowed_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_course_allowed_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_categories`
--

DROP TABLE IF EXISTS `mdl_course_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `coursecount` bigint(10) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `depth` bigint(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `theme` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courcate_par_ix` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Course categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_categories`
--

LOCK TABLES `mdl_course_categories` WRITE;
/*!40000 ALTER TABLE `mdl_course_categories` DISABLE KEYS */;
INSERT INTO `mdl_course_categories` VALUES (1,'Miscellaneous','',0,0,2,1,0,1,'/1',NULL),(2,'Project 1 - Omgaan met elkaar',' Project 1 - Test project<br />',0,999,4,1,0,1,'/2',NULL),(3,'Project 2 - Inrichten van je eigen omgeving','',0,999,4,1,0,1,'/3',NULL),(4,'Project 04','',0,999,4,1,0,1,'/4',NULL);
/*!40000 ALTER TABLE `mdl_course_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_display`
--

DROP TABLE IF EXISTS `mdl_course_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_display` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `display` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courdisp_couuse_ix` (`course`,`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Stores info about how to display the course';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_display`
--

LOCK TABLES `mdl_course_display` WRITE;
/*!40000 ALTER TABLE `mdl_course_display` DISABLE KEYS */;
INSERT INTO `mdl_course_display` VALUES (1,2,2,0),(2,3,2,0),(3,4,2,0),(4,7,2,0),(5,6,2,0),(6,5,2,0),(7,10,2,0),(8,9,2,0),(9,8,2,0),(10,13,2,0),(11,15,2,0),(12,16,2,0),(13,14,2,0);
/*!40000 ALTER TABLE `mdl_course_display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_meta`
--

DROP TABLE IF EXISTS `mdl_course_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_meta` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `child_course` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courmeta_par_ix` (`parent_course`),
  KEY `mdl_courmeta_chi_ix` (`child_course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to store meta-courses relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_meta`
--

LOCK TABLES `mdl_course_meta` WRITE;
/*!40000 ALTER TABLE `mdl_course_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_course_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_modules`
--

DROP TABLE IF EXISTS `mdl_course_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_modules` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `module` bigint(10) unsigned NOT NULL DEFAULT '0',
  `instance` bigint(10) unsigned NOT NULL DEFAULT '0',
  `section` bigint(10) unsigned NOT NULL DEFAULT '0',
  `idnumber` varchar(100) DEFAULT NULL,
  `added` bigint(10) unsigned NOT NULL DEFAULT '0',
  `score` smallint(4) NOT NULL DEFAULT '0',
  `indent` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `visibleold` tinyint(1) NOT NULL DEFAULT '1',
  `groupmode` smallint(4) NOT NULL DEFAULT '0',
  `groupingid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupmembersonly` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courmodu_vis_ix` (`visible`),
  KEY `mdl_courmodu_cou_ix` (`course`),
  KEY `mdl_courmodu_mod_ix` (`module`),
  KEY `mdl_courmodu_ins_ix` (`instance`),
  KEY `mdl_courmodu_idncou_ix` (`idnumber`,`course`),
  KEY `mdl_courmodu_gro_ix` (`groupingid`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8 COMMENT='course_modules table retrofitted from MySQL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_modules`
--

LOCK TABLES `mdl_course_modules` WRITE;
/*!40000 ALTER TABLE `mdl_course_modules` DISABLE KEYS */;
INSERT INTO `mdl_course_modules` VALUES (1,2,5,1,1,NULL,1324980908,0,0,1,1,0,0,0),(2,3,5,2,12,NULL,1324980936,0,0,1,1,0,0,0),(3,1,19,1,23,'',1324983194,0,0,1,1,0,0,0),(4,4,5,3,24,NULL,1325605079,0,0,1,1,0,0,0),(5,7,5,4,37,NULL,1325605208,0,0,1,1,0,0,0),(6,6,5,5,36,NULL,1325682169,0,0,1,1,0,0,0),(7,5,5,6,35,NULL,1325682183,0,0,1,1,0,0,0),(8,10,5,7,50,NULL,1325682222,0,0,1,1,0,0,0),(9,9,5,8,49,NULL,1325682231,0,0,1,1,0,0,0),(10,8,5,9,48,NULL,1325682239,0,0,1,1,0,0,0),(11,6,1,1,51,'',1326115093,0,0,1,1,0,0,0),(12,3,3,1,13,'',1326975312,0,0,1,1,0,0,0),(13,2,2,1,2,'',1329316389,0,0,1,1,0,0,0),(14,2,3,2,2,'',1329316463,0,0,1,1,0,0,0),(15,13,5,10,123,'$@NULL@$',1311028738,0,0,1,1,0,0,0),(16,13,9,1,124,NULL,1312800599,0,0,1,1,0,0,0),(17,13,13,1,124,NULL,1312835042,0,0,1,1,0,0,0),(18,13,13,2,124,NULL,1312835240,0,0,1,1,0,0,0),(19,13,9,2,124,NULL,1312800636,0,0,1,1,0,0,0),(20,13,13,3,124,NULL,1312835308,0,0,1,1,0,0,0),(21,13,13,4,124,NULL,1312835356,0,0,1,1,0,0,0),(22,13,14,1,125,'L0193',1311942345,0,0,1,1,0,0,0),(23,13,14,2,125,'L0195',1311942392,0,0,1,1,0,0,0),(24,13,14,3,125,'L0196',1311942436,0,0,1,1,0,0,0),(25,13,14,4,125,'L0199',1311942481,0,0,1,1,0,0,0),(26,13,14,5,125,'L0200',1311942525,0,0,1,1,0,0,0),(27,13,14,6,125,'L0201',1311942570,0,0,1,1,0,0,0),(28,13,14,7,125,'L0202',1311942614,0,0,1,1,0,0,0),(29,13,14,8,125,'L0203',1311942659,0,0,1,1,0,0,0),(30,13,14,9,125,'L0205',1311942703,0,0,1,1,0,0,0),(31,13,14,10,125,'L0206',1311942748,0,0,1,1,0,0,0),(32,13,14,11,125,'L0216',1311942792,0,0,1,1,0,0,0),(33,13,14,12,125,'L0217',1311942837,0,0,1,1,0,0,0),(34,13,14,13,125,'L0727',1311942881,0,0,1,1,0,0,0),(35,14,5,11,134,'$@NULL@$',1311938763,0,0,1,1,0,0,0),(36,14,9,3,135,NULL,1312801298,0,0,1,1,0,0,0),(37,14,13,5,135,NULL,1312801326,0,0,1,1,0,0,0),(38,14,13,6,135,NULL,1312801356,0,0,1,1,0,0,0),(39,14,13,7,135,NULL,1312801390,0,0,1,1,0,0,0),(40,14,9,4,135,NULL,1312801404,0,0,1,1,0,0,0),(41,14,13,8,135,NULL,1312801432,0,0,1,1,0,0,0),(42,14,9,5,135,NULL,1312801452,0,0,1,1,0,0,0),(43,14,13,9,135,NULL,1312801487,0,0,1,1,0,0,0),(44,14,14,14,136,'L0007',1312892906,0,0,1,1,0,0,0),(45,14,14,15,136,'L0007T',1312892940,0,0,1,1,0,0,0),(46,14,14,16,136,'L0008',1312803582,0,0,1,1,0,0,0),(47,14,14,17,136,'L0009',1312803671,0,0,1,1,0,0,0),(48,14,14,18,136,'L0009T',1312803715,0,0,1,1,0,0,0),(49,14,14,19,136,'L0111',1312892990,0,0,1,1,0,0,0),(50,14,14,20,136,'L0170',1311939927,0,0,1,1,0,0,0),(51,14,14,21,136,'L0176',1311939973,0,0,1,1,0,0,0),(52,14,14,22,136,'L0176T',1311941022,0,0,1,1,0,0,0),(53,14,14,23,136,'L0177',1311940017,0,0,1,1,0,0,0),(54,14,14,24,136,'L0177T',1311941071,0,0,1,1,0,0,0),(55,14,14,25,136,'L0178',1311940062,0,0,1,1,0,0,0),(56,14,14,26,136,'L0178T',1311941123,0,0,1,1,0,0,0),(57,14,14,27,136,'L0179',1311940106,0,0,1,1,0,0,0),(58,14,14,28,136,'L0179T',1311941167,0,0,1,1,0,0,0),(59,14,14,29,136,'L0180',1311940151,0,0,1,1,0,0,0),(60,14,14,30,136,'L0185',1311940285,0,0,1,1,0,0,0),(61,14,14,31,136,'L0185T',1311941212,0,0,1,1,0,0,0),(62,14,14,32,136,'L0186',1311940329,0,0,1,1,0,0,0),(63,14,14,33,136,'L0186T',1311941257,0,0,1,1,0,0,0),(64,14,14,34,136,'L0187',1311940374,0,0,1,1,0,0,0),(65,14,14,35,136,'L0188',1311940418,0,0,1,1,0,0,0),(66,14,14,36,136,'L0189',1311940462,0,0,1,1,0,0,0),(67,14,14,37,136,'L0189T',1311941301,0,0,1,1,0,0,0),(68,14,14,38,136,'L0191',1311940507,0,0,1,1,0,0,0),(69,14,14,39,136,'L0191T',1311941346,0,0,1,1,0,0,0),(70,14,14,40,136,'L0192',1311940551,0,0,1,1,0,0,0),(71,14,14,41,136,'L0192T',1311941390,0,0,1,1,0,0,0),(72,14,14,42,136,'L0208',1311940596,0,0,1,1,0,0,0),(73,14,14,43,136,'L0209',1311947417,0,0,1,1,0,0,0),(74,14,14,44,136,'L0209T',1311941683,0,0,1,1,0,0,0),(75,14,14,45,136,'L0211',1311940852,0,0,1,1,0,0,0),(76,14,14,46,136,'L0727',1311940641,0,0,1,1,0,0,0),(77,15,5,12,145,'$@NULL@$',1311941791,0,0,1,1,0,0,0),(78,15,9,6,146,NULL,1312801095,0,0,1,1,0,0,0),(79,15,13,10,146,NULL,1312801128,0,0,1,1,0,0,0),(80,15,9,7,146,NULL,1312801140,0,0,1,1,0,0,0),(81,15,13,11,146,NULL,1312801171,0,0,1,1,0,0,0),(82,15,13,12,146,NULL,1312801201,0,0,1,1,0,0,0),(83,15,13,13,146,NULL,1312801236,0,0,1,1,0,0,0),(84,15,14,47,147,'L0008',1312893379,0,0,1,1,0,0,0),(85,15,14,48,147,'L0174',1311943686,0,0,1,1,0,0,0),(86,15,14,49,147,'L0175',1311943730,0,0,1,1,0,0,0),(87,15,14,50,147,'L0176',1311943775,0,0,1,1,0,0,0),(88,15,14,51,147,'L0176T',1311943820,0,0,1,1,0,0,0),(89,15,14,52,147,'L0177',1311943864,0,0,1,1,0,0,0),(90,15,14,53,147,'L0177T',1311943910,0,0,1,1,0,0,0),(91,15,14,54,147,'L0179',1312890484,0,0,1,1,0,0,0),(92,15,14,55,147,'L0179T',1312890521,0,0,1,1,0,0,0),(93,15,14,56,147,'L0181',1311944044,0,0,1,1,0,0,0),(94,15,14,57,147,'L0181T',1311944088,0,0,1,1,0,0,0),(95,15,14,58,147,'L0182',1311944133,0,0,1,1,0,0,0),(96,15,14,59,147,'L0182T',1311944177,0,0,1,1,0,0,0),(97,15,14,60,147,'L0183',1311944222,0,0,1,1,0,0,0),(98,15,14,61,147,'L0184',1311944266,0,0,1,1,0,0,0),(99,15,14,62,147,'L0190',1312890584,0,0,1,1,0,0,0),(100,15,14,63,147,'L0207',1311944310,0,0,1,1,0,0,0),(101,15,14,64,147,'L0207T',1311944355,0,0,1,1,0,0,0),(102,15,14,65,147,'L0211',1311944444,0,0,1,1,0,0,0),(103,15,14,66,147,'L0218',1311944488,0,0,1,1,0,0,0),(104,15,14,67,147,'L0218T',1311944533,0,0,1,1,0,0,0),(105,15,14,68,147,'L0727',1311944577,0,0,1,1,0,0,0),(106,16,5,13,156,'$@NULL@$',1311942926,0,0,1,1,0,0,0),(107,16,9,8,157,NULL,1312800671,0,0,1,1,0,0,0),(108,16,13,14,157,NULL,1312800708,0,0,1,1,0,0,0),(109,16,13,15,157,NULL,1312800739,0,0,1,1,0,0,0),(110,16,13,16,157,NULL,1312800771,0,0,1,1,0,0,0),(111,16,13,17,157,NULL,1312800805,0,0,1,1,0,0,0),(112,16,13,18,157,NULL,1312800837,0,0,1,1,0,0,0),(113,16,9,9,157,NULL,1312800858,0,0,1,1,0,0,0),(114,16,13,19,157,NULL,1312800888,0,0,1,1,0,0,0),(115,16,13,20,157,NULL,1312800931,0,0,1,1,0,0,0),(116,16,13,21,157,NULL,1312800967,0,0,1,1,0,0,0),(117,16,9,10,157,NULL,1312800979,0,0,1,1,0,0,0),(118,16,13,22,157,NULL,1312801011,0,0,1,1,0,0,0),(119,16,14,69,158,'L0163',1311942926,0,0,1,1,0,0,0),(120,16,14,70,158,'L0164',1311942970,0,0,1,1,0,0,0),(121,16,14,71,158,'L0165',1311943015,0,0,1,1,0,0,0),(122,16,14,72,158,'L0165T',1311943059,0,0,1,1,0,0,0),(123,16,14,73,158,'L0166',1311943104,0,0,1,1,0,0,0),(124,16,14,74,158,'L0166T',1311943148,0,0,1,1,0,0,0),(125,16,14,75,158,'L0167',1311945356,0,0,1,1,0,0,0),(126,16,14,76,158,'L0167T',1311943241,0,0,1,1,0,0,0),(127,16,14,77,158,'L0168',1311943286,0,0,1,1,0,0,0),(128,16,14,78,158,'L0168T',1311943330,0,0,1,1,0,0,0),(129,16,14,79,158,'L0169',1311943375,0,0,1,1,0,0,0),(130,16,14,80,158,'L0171',1311943419,0,0,1,1,0,0,0),(131,16,14,81,158,'L0172',1311943464,0,0,1,1,0,0,0),(132,16,14,82,158,'L0173',1311943508,0,0,1,1,0,0,0),(133,16,14,83,158,'L0210',1311943553,0,0,1,1,0,0,0),(134,16,14,84,158,'L0210T',1311943597,0,0,1,1,0,0,0),(135,16,14,85,158,'L0727',1311943641,0,0,1,1,0,0,0),(136,17,5,14,167,'$@NULL@$',1311942926,0,0,1,1,0,0,0),(137,17,9,11,168,NULL,1312800671,0,0,1,1,0,0,0),(138,17,13,23,168,NULL,1312800708,0,0,1,1,0,0,0),(139,17,13,24,168,NULL,1312800739,0,0,1,1,0,0,0),(140,17,13,25,168,NULL,1312800771,0,0,1,1,0,0,0),(141,17,13,26,168,NULL,1312800805,0,0,1,1,0,0,0),(142,17,13,27,168,NULL,1312800837,0,0,1,1,0,0,0),(143,17,9,12,168,NULL,1312800858,0,0,1,1,0,0,0),(144,17,13,28,168,NULL,1312800888,0,0,1,1,0,0,0),(145,17,13,29,168,NULL,1312800931,0,0,1,1,0,0,0),(146,17,13,30,168,NULL,1312800967,0,0,1,1,0,0,0),(147,17,9,13,168,NULL,1312800979,0,0,1,1,0,0,0),(148,17,13,31,168,NULL,1312801011,0,0,1,1,0,0,0),(149,17,14,86,169,'L0163',1311942926,0,0,1,1,0,0,0),(150,17,14,87,169,'L0164',1311942970,0,0,1,1,0,0,0),(151,17,14,88,169,'L0165',1311943015,0,0,1,1,0,0,0),(152,17,14,89,169,'L0165T',1311943059,0,0,1,1,0,0,0),(153,17,14,90,169,'L0166',1311943104,0,0,1,1,0,0,0),(154,17,14,91,169,'L0166T',1311943148,0,0,1,1,0,0,0),(155,17,14,92,169,'L0167',1311945356,0,0,1,1,0,0,0),(156,17,14,93,169,'L0167T',1311943241,0,0,1,1,0,0,0),(157,17,14,94,169,'L0168',1311943286,0,0,1,1,0,0,0),(158,17,14,95,169,'L0168T',1311943330,0,0,1,1,0,0,0),(159,17,14,96,169,'L0169',1311943375,0,0,1,1,0,0,0),(160,17,14,97,169,'L0171',1311943419,0,0,1,1,0,0,0),(161,17,14,98,169,'L0172',1311943464,0,0,1,1,0,0,0),(162,17,14,99,169,'L0173',1311943508,0,0,1,1,0,0,0),(163,17,14,100,169,'L0210',1311943553,0,0,1,1,0,0,0),(164,17,14,101,169,'L0210T',1311943597,0,0,1,1,0,0,0),(165,17,14,102,169,'L0727',1311943641,0,0,1,1,0,0,0);
/*!40000 ALTER TABLE `mdl_course_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_request`
--

DROP TABLE IF EXISTS `mdl_course_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_request` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(15) NOT NULL DEFAULT '',
  `summary` text NOT NULL,
  `reason` text NOT NULL,
  `requester` bigint(10) unsigned NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_courrequ_sho_ix` (`shortname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='course requests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_request`
--

LOCK TABLES `mdl_course_request` WRITE;
/*!40000 ALTER TABLE `mdl_course_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_course_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_course_sections`
--

DROP TABLE IF EXISTS `mdl_course_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_course_sections` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `section` bigint(10) unsigned NOT NULL DEFAULT '0',
  `summary` text,
  `sequence` text,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_coursect_cousec_ix` (`course`,`section`)
) ENGINE=MyISAM AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='to define the sections for each course';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_course_sections`
--

LOCK TABLES `mdl_course_sections` WRITE;
/*!40000 ALTER TABLE `mdl_course_sections` DISABLE KEYS */;
INSERT INTO `mdl_course_sections` VALUES (1,2,0,NULL,'1',1),(2,2,1,'','13,14',1),(3,2,2,'',NULL,1),(4,2,3,'',NULL,1),(5,2,4,'',NULL,1),(6,2,5,'',NULL,1),(7,2,6,'',NULL,1),(8,2,7,'',NULL,1),(9,2,8,'',NULL,1),(10,2,9,'',NULL,1),(11,2,10,'',NULL,1),(12,3,0,NULL,'2',1),(13,3,1,'blabla ','12',1),(14,3,2,'',NULL,1),(15,3,3,'',NULL,1),(16,3,4,'',NULL,1),(17,3,5,'',NULL,1),(18,3,6,'',NULL,1),(19,3,7,'',NULL,1),(20,3,8,'',NULL,1),(21,3,9,'',NULL,1),(22,3,10,'',NULL,1),(23,1,0,'','3',1),(24,4,0,NULL,'4',1),(25,4,1,'',NULL,1),(26,4,2,'',NULL,1),(27,4,3,'',NULL,1),(28,4,4,'',NULL,1),(29,4,5,'',NULL,1),(30,4,6,'',NULL,1),(31,4,7,'',NULL,1),(32,4,8,'',NULL,1),(33,4,9,'',NULL,1),(34,4,10,'',NULL,1),(35,5,0,NULL,'7',1),(36,6,0,NULL,'6',1),(37,7,0,NULL,'5',1),(38,7,1,'',NULL,1),(39,7,2,'',NULL,1),(40,7,3,'',NULL,1),(41,7,4,'',NULL,1),(42,7,5,'',NULL,1),(43,7,6,'',NULL,1),(44,7,7,'',NULL,1),(45,7,8,'',NULL,1),(46,7,9,'',NULL,1),(47,7,10,'',NULL,1),(48,8,0,NULL,'10',1),(49,9,0,NULL,'9',1),(50,10,0,NULL,'8',1),(51,6,1,'','11',1),(52,6,2,'',NULL,1),(53,6,3,'',NULL,1),(54,6,4,'',NULL,1),(55,6,5,'',NULL,1),(56,6,6,'',NULL,1),(57,6,7,'',NULL,1),(58,6,8,'',NULL,1),(59,6,9,'',NULL,1),(60,6,10,'',NULL,1),(61,5,1,'',NULL,1),(62,5,2,'',NULL,1),(63,5,3,'',NULL,1),(64,5,4,'',NULL,1),(65,5,5,'',NULL,1),(66,5,6,'',NULL,1),(67,5,7,'',NULL,1),(68,5,8,'',NULL,1),(69,5,9,'',NULL,1),(70,5,10,'',NULL,1),(71,10,1,'',NULL,1),(72,10,2,'',NULL,1),(73,10,3,'',NULL,1),(74,10,4,'',NULL,1),(75,10,5,'',NULL,1),(76,10,6,'',NULL,1),(77,10,7,'',NULL,1),(78,10,8,'',NULL,1),(79,10,9,'',NULL,1),(80,10,10,'',NULL,1),(81,9,1,'',NULL,1),(82,9,2,'',NULL,1),(83,9,3,'',NULL,1),(84,9,4,'',NULL,1),(85,9,5,'',NULL,1),(86,9,6,'',NULL,1),(87,9,7,'',NULL,1),(88,9,8,'',NULL,1),(89,9,9,'',NULL,1),(90,9,10,'',NULL,1),(91,8,1,'',NULL,1),(92,8,2,'',NULL,1),(93,8,3,'',NULL,1),(94,8,4,'',NULL,1),(95,8,5,'',NULL,1),(96,8,6,'',NULL,1),(97,8,7,'',NULL,1),(98,8,8,'',NULL,1),(99,8,9,'',NULL,1),(100,8,10,'',NULL,1),(101,11,0,NULL,'',1),(102,11,1,'','',1),(103,11,2,'','',1),(104,11,3,'','',1),(105,11,4,'','',1),(106,11,5,'','',1),(107,11,6,'','',1),(108,11,7,'','',1),(109,11,8,'','',1),(110,11,9,'','',1),(111,11,10,'','',1),(112,12,0,NULL,'',1),(113,12,1,'','',1),(114,12,2,'','',1),(115,12,3,'','',1),(116,12,4,'','',1),(117,12,5,'','',1),(118,12,6,'','',1),(119,12,7,'','',1),(120,12,8,'','',1),(121,12,9,'','',1),(122,12,10,'','',1),(123,13,0,NULL,'15',1),(124,13,1,'<img hspace=\"0\" height=\"533\" border=\"0\" width=\"800\" vspace=\"0\" src=\"http://localhost/jeelo19/file.php/13/Inrichten_van_je_eigen_omgeving_12.gif\" alt=\"Wonen in je straat\" title=\"Wonen in je straat\" useMap=\"#ImageMap\" border=0>\n<MAP name=\"ImageMap\">\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=33\" alt=\"217 Links en rechts\" target=\"\" coords=320,380,386,469>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=32\" alt=\"216 Onder, boven, voor en achter\" target=\"\" coords=244,379,310,467>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=26\" alt=\"200 Maak je slaapkamer\" target=\"\" coords=698,199,761,287>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=31\" alt=\"206 Teken je eigen huis\" target=\"\" coords=472,199,538,288>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=25\" alt=\"199 Hoek: Huizen bouwen\" target=\"\" coords=397,291,462,378>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=24\" alt=\"196 Praatplaat: Soorten huizen\" target=\"\" coords=397,111,461,197>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=23\" alt=\"195 Woorden: Het huis\" target=\"\" coords=397,18,462,110>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=30\" alt=\"205 Ruim de straat op\" target=\"\" coords=246,200,312,289>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=29\" alt=\"203 Doeblad: Houd je straat schoon\" target=\"\" coords=169,245,236,334>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=27\" alt=\"201 Woorden: De straat\" target=\"\" coords=96,246,161,335>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=28\" alt=\"202 Bewegen: Stoeptegelspellen\" target=\"\" coords=95,156,160,243>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=22\" alt=\"193 Wonen in je straat\" target=\"\" coords=20,200,81,289>\n<AREA shape=RECT href=\"http://localhost/jeelo19/mod/scorm/view.php?id=34\" alt=\"727 Teken het leukste schoolplein\" target=\"\" coords=20,64,85,152>\n</MAP>','16,17,18,19,20,21',1),(125,13,2,'','22,23,24,25,26,27,28,29,30,31,32,33,34',1),(126,13,3,'','',1),(127,13,4,'','',1),(128,13,5,'','',1),(129,13,6,'','',1),(130,13,7,'','',1),(131,13,8,'','',1),(132,13,9,'','',1),(133,13,10,'','',1),(134,14,0,NULL,'35',1),(135,14,1,'<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_78\" title=\"Ontwikkeling van je gemeente\" alt=\"Ontwikkeling van je gemeente\" src=\"http://localhost/jeelo19/file.php/14/Inrichten_van_je_eigen_omgeving_78.gif\" /> <map id=\"m_Inrichten_van_je_eigen_omgeving_78\" name=\"m_Inrichten_van_je_eigen_omgeving_78\"> <area shape=\"rect\" coords=\"412,384,472,468\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=57\" title=\"179 Soorten kaarten\" alt=\"179 Soorten kaarten\" /> <area shape=\"rect\" coords=\"338,382,398,466\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=53\" title=\"177 Een kaart lezen\" alt=\"177 Een kaart lezen\" /> <area shape=\"rect\" coords=\"264,383,324,467\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=51\" title=\"176 Onderdelen van een kaart\" alt=\"176 Onderdelen van een kaart\" /> <area shape=\"rect\" coords=\"264,293,324,377\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=46\" title=\"8 Werk met google maps\" alt=\"8 Werk met google maps\" /> <area shape=\"rect\" coords=\"715,247,775,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=59\" title=\"180 Ontwerp een plein op schaal\" alt=\"180 Ontwerp een plein op schaal\" /> <area shape=\"rect\" coords=\"640,248,700,332\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=47\" title=\"9 Rekenen op schaal\" alt=\"9 Rekenen op schaal\" /> <area shape=\"rect\" coords=\"564,247,624,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=72\" title=\"208 Houd een enquete\" alt=\"208 Houd een enquete\" /> <area shape=\"rect\" coords=\"640,158,700,242\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=50\" title=\"170 Doe historisch onderzoek\" alt=\"170 Doe historisch onderzoek\" /> <area shape=\"rect\" coords=\"565,157,625,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=49\" title=\"111 Houd een interview\" alt=\"111 Houd een interview\" /> <area shape=\"rect\" coords=\"490,201,550,285\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=60\" title=\"185 Taken van de gemeente\" alt=\"185 Taken van de gemeente\" /> <area shape=\"rect\" coords=\"413,202,473,286\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=62\" title=\"186 Ruimtelijke ordening\" alt=\"186 Ruimtelijke ordening\" /> <area shape=\"rect\" coords=\"414,111,474,195\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=73\" title=\"209 Ontwikkeling van toerisme\" alt=\"209 Ontwikkeling van toerisme\" /> <area shape=\"rect\" coords=\"338,203,398,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=75\" title=\"211 Maak samen een nieuwe wijk\" alt=\"211 Maak samen een nieuwe wijk\" /> <area shape=\"rect\" coords=\"264,204,324,288\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=44\" title=\"7 Voorzieningen voor iedereen\" alt=\"7 Voorzieningen voor iedereen\" /> <area shape=\"rect\" coords=\"188,203,248,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=66\" title=\"189 Verstedelijking van Nederland\" alt=\"189 Verstedelijking van Nederland\" /> <area shape=\"rect\" coords=\"187,112,247,196\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=70\" title=\"192 Ontstaan van steden\" alt=\"192 Ontstaan van steden\" /> <area shape=\"rect\" coords=\"113,111,173,195\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=68\" title=\"191 Ontstaan van dorpen\" alt=\"191 Ontstaan van dorpen\" /> <area shape=\"rect\" coords=\"112,201,172,285\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=55\" title=\"178 Opbouw van een stad\" alt=\"178 Opbouw van een stad\" /> <area shape=\"rect\" coords=\"38,247,98,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=65\" title=\"188 Pleinontwerp: Ontwikkeling van je gemeente\" alt=\"188 Pleinontwerp: Ontwikkeling van je gemeente\" /> <area shape=\"rect\" coords=\"38,157,98,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=64\" title=\"187 Historisch onderzoek: Ontwikkeling van je gemeente\" alt=\"187 Historisch onderzoek: Ontwikkeling van je gemeente\" /> <area shape=\"rect\" coords=\"37,67,97,151\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=76\" title=\"727 Teken het leukste schoolplein\" alt=\"727 Teken het leukste schoolplein\" /></map>','36,37,38,39,40,41,42,43',1),(136,14,2,'','44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76',1),(137,14,3,'','',1),(138,14,4,'','',1),(139,14,5,'','',1),(140,14,6,'','',1),(141,14,7,'','',1),(142,14,8,'','',1),(143,14,9,'','',1),(144,14,10,'','',1),(145,15,0,NULL,'77',1),(146,15,1,'<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" src=\"http://localhost/jeelo19/file.php/15/Inrichten_van_je_eigen_omgeving_56.gif\" alt=\"Vrije tijd in je buurt\" title=\"Vrije tijd in je buurt\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_56\" /> <map name=\"m_Inrichten_van_je_eigen_omgeving_56\" id=\"m_Inrichten_van_je_eigen_omgeving_56\"> <area shape=\"rect\" coords=\"398,384,458,468\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=91\" title=\"179 Soorten kaarten\" alt=\"179 Soorten kaarten\" /> <area shape=\"rect\" coords=\"324,382,384,466\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=89\" title=\"177 Een kaart lezen\" alt=\"177 Een kaart lezen\" /> <area shape=\"rect\" coords=\"250,383,310,467\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=87\" title=\"176 Onderdelen van een kaart\" alt=\"176 Onderdelen van een kaart\" /> <area shape=\"rect\" coords=\"173,293,233,377\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=103\" title=\"218 Toerisme in Nederland\" alt=\"218 Toerisme in Nederland\" /> <area shape=\"rect\" coords=\"550,247,610,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=98\" title=\"184 Ontwerp een speelplein\" alt=\"184 Ontwerp een speelplein\" /> <area shape=\"rect\" coords=\"550,157,610,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=97\" title=\"183 Maak een rondleiding\" alt=\"183 Maak een rondleiding\" /> <area shape=\"rect\" coords=\"473,202,533,286\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=93\" title=\"181 Openbare speelruimtes\" alt=\"181 Openbare speelruimtes\" /> <area shape=\"rect\" coords=\"398,111,458,195\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=100\" title=\"207 Leven in een iddeleeuwse stad\" alt=\"207 Leven in een iddeleeuwse stad\" /> <area shape=\"rect\" coords=\"398,203,458,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=102\" title=\"211 Maak samen een nieuwe wijk\" alt=\"211 Maak samen een nieuwe wijk\" /> <area shape=\"rect\" coords=\"324,204,384,288\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=84\" title=\"8 Werken met google maps\" alt=\"8 Werken met google maps\" /> <area shape=\"rect\" coords=\"248,203,308,287\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=99\" title=\"190 Zoek naar vrijetijdsbestedingen\" alt=\"190 Zoek naar vrijetijdsbestedingen\" /> <area shape=\"rect\" coords=\"172,201,232,285\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=95\" title=\"182 Soorten vrijetijdsbesteding\" alt=\"182 Soorten vrijetijdsbesteding\" /> <area shape=\"rect\" coords=\"98,247,158,331\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=86\" title=\"175 Plein: Vrije tijd in je buurt\" alt=\"175 Plein: Vrije tijd in je buurt\" /> <area shape=\"rect\" coords=\"98,157,158,241\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=85\" title=\"174 Rondleiding: Vrije tijd in je buurt\" alt=\"174 Rondleiding: Vrije tijd in je buurt\" /> <area shape=\"rect\" coords=\"97,67,157,151\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=105\" title=\"727 Teken het leukste schoolplein\" alt=\"727 Teken het leukste schoolplein\" /> </map>','78,79,80,81,82,83',1),(147,15,2,'','84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105',1),(148,15,3,'','',1),(149,15,4,'','',1),(150,15,5,'','',1),(151,15,6,'','',1),(152,15,7,'','',1),(153,15,8,'','',1),(154,15,9,'','',1),(155,15,10,'','',1),(156,16,0,NULL,'106',1),(157,16,1,'<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_34\" title=\"Zorg voor je wijk\" alt=\"Zorg voor je wijk\" src=\"http://localhost/jeelo19/file.php/16/Inrichten_van_je_eigen_omgeving_34.gif\" /> <map id=\"m_Inrichten_van_je_eigen_omgeving_34\" name=\"m_Inrichten_van_je_eigen_omgeving_34\"> <area alt=\"210 Een plattegrond lezen\" title=\"210 Een plattegrond lezen\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=133\" coords=\"250,383,310,467\" shape=\"rect\" /> <area alt=\"173 Maak samen een speelveld\" title=\"173 Maak samen een speelveld\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=132\" coords=\"550,247,610,331\" shape=\"rect\" /> <area alt=\"172 Schilder samen een straat\" title=\"172 Schilder samen een straat\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=131\" coords=\"550,157,610,241\" shape=\"rect\" /> <area alt=\"167 Een huis van vroeger\" title=\"167 Een huis van vroeger\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=125\" coords=\"473,202,533,286\" shape=\"rect\" /> <area alt=\"171 Teken je huis van binnen en buiten\" title=\"171 Teken je huis van binnen en buiten\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=130\" coords=\"398,111,458,195\" shape=\"rect\" /> <area alt=\"166 Buizen door de wijk\" title=\"166 Buizen door de wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=123\" coords=\"398,203,458,287\" shape=\"rect\" /> <area alt=\"165 Soorten huizen\" title=\"165 Soorten huizen\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=121\" coords=\"324,204,384,288\" shape=\"rect\" /> <area alt=\"169 Maak de wijk schoon\" title=\"169 Maak de wijk schoon\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=129\" coords=\"248,203,308,287\" shape=\"rect\" /> <area alt=\"168 Een groene en schone wijk\" title=\"168 Een groene en schone wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=127\" coords=\"172,201,232,285\" shape=\"rect\" /> <area alt=\"164 Speelplek: Zorg voor je wijk\" title=\"164 Speelplek: Zorg voor je wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=120\" coords=\"98,247,158,331\" shape=\"rect\" /> <area alt=\"163 Straat: Zorg voor je wijk\" title=\"163 Straat: Zorg voor je wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=119\" coords=\"98,157,158,241\" shape=\"rect\" /> <area alt=\"727 Teken het leukste schoolplein\" title=\"727 Teken het leukste schoolplein\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=135\" coords=\"97,67,157,151\" shape=\"rect\" /> </map>','107,108,109,110,111,112,113,114,115,116,117,118',1),(158,16,2,'','119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135',1),(159,16,3,'','',1),(160,16,4,'','',1),(161,16,5,'','',1),(162,16,6,'','',1),(163,16,7,'','',1),(164,16,8,'','',1),(165,16,9,'','',1),(166,16,10,'','',1),(167,17,0,NULL,'136',1),(168,17,1,'<img width=\"800\" vspace=\"0\" hspace=\"0\" height=\"533\" border=\"0\" usemap=\"#m_Inrichten_van_je_eigen_omgeving_34\" title=\"Zorg voor je wijk\" alt=\"Zorg voor je wijk\" src=\"http://localhost/jeelo19/file.php/17/Inrichten_van_je_eigen_omgeving_34.gif\" /> <map id=\"m_Inrichten_van_je_eigen_omgeving_34\" name=\"m_Inrichten_van_je_eigen_omgeving_34\"> <area alt=\"210 Een plattegrond lezen\" title=\"210 Een plattegrond lezen\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=163\" coords=\"250,383,310,467\" shape=\"rect\" /> <area alt=\"173 Maak samen een speelveld\" title=\"173 Maak samen een speelveld\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=162\" coords=\"550,247,610,331\" shape=\"rect\" /> <area alt=\"172 Schilder samen een straat\" title=\"172 Schilder samen een straat\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=161\" coords=\"550,157,610,241\" shape=\"rect\" /> <area alt=\"167 Een huis van vroeger\" title=\"167 Een huis van vroeger\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=155\" coords=\"473,202,533,286\" shape=\"rect\" /> <area alt=\"171 Teken je huis van binnen en buiten\" title=\"171 Teken je huis van binnen en buiten\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=160\" coords=\"398,111,458,195\" shape=\"rect\" /> <area alt=\"166 Buizen door de wijk\" title=\"166 Buizen door de wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=153\" coords=\"398,203,458,287\" shape=\"rect\" /> <area alt=\"165 Soorten huizen\" title=\"165 Soorten huizen\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=151\" coords=\"324,204,384,288\" shape=\"rect\" /> <area alt=\"169 Maak de wijk schoon\" title=\"169 Maak de wijk schoon\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=159\" coords=\"248,203,308,287\" shape=\"rect\" /> <area alt=\"168 Een groene en schone wijk\" title=\"168 Een groene en schone wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=157\" coords=\"172,201,232,285\" shape=\"rect\" /> <area alt=\"164 Speelplek: Zorg voor je wijk\" title=\"164 Speelplek: Zorg voor je wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=150\" coords=\"98,247,158,331\" shape=\"rect\" /> <area alt=\"163 Straat: Zorg voor je wijk\" title=\"163 Straat: Zorg voor je wijk\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=149\" coords=\"98,157,158,241\" shape=\"rect\" /> <area alt=\"727 Teken het leukste schoolplein\" title=\"727 Teken het leukste schoolplein\" href=\"http://localhost/jeelo19/mod/scorm/view.php?id=165\" coords=\"97,67,157,151\" shape=\"rect\" /> </map>','137,138,139,140,141,142,143,144,145,146,147,148',1),(169,17,2,'','149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165',1),(170,17,3,'','',1),(171,17,4,'','',1),(172,17,5,'','',1),(173,17,6,'','',1),(174,17,7,'','',1),(175,17,8,'','',1),(176,17,9,'','',1),(177,17,10,'','',1);
/*!40000 ALTER TABLE `mdl_course_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_data`
--

DROP TABLE IF EXISTS `mdl_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `comments` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timeavailablefrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeavailableto` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeviewfrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeviewto` bigint(10) unsigned NOT NULL DEFAULT '0',
  `requiredentries` int(8) unsigned NOT NULL DEFAULT '0',
  `requiredentriestoview` int(8) unsigned NOT NULL DEFAULT '0',
  `maxentries` int(8) unsigned NOT NULL DEFAULT '0',
  `rssarticles` smallint(4) unsigned NOT NULL DEFAULT '0',
  `singletemplate` text,
  `listtemplate` text,
  `listtemplateheader` text,
  `listtemplatefooter` text,
  `addtemplate` text,
  `rsstemplate` text,
  `rsstitletemplate` text,
  `csstemplate` text,
  `jstemplate` text,
  `asearchtemplate` text,
  `approval` smallint(4) unsigned NOT NULL DEFAULT '0',
  `scale` bigint(10) NOT NULL DEFAULT '0',
  `assessed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `defaultsort` bigint(10) unsigned NOT NULL DEFAULT '0',
  `defaultsortdir` smallint(4) unsigned NOT NULL DEFAULT '0',
  `editany` smallint(4) unsigned NOT NULL DEFAULT '0',
  `notification` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_data_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='all database activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_data`
--

LOCK TABLES `mdl_data` WRITE;
/*!40000 ALTER TABLE `mdl_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_data_comments`
--

DROP TABLE IF EXISTS `mdl_data_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_data_comments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `recordid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `format` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_datacomm_rec_ix` (`recordid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to comment data records';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_data_comments`
--

LOCK TABLES `mdl_data_comments` WRITE;
/*!40000 ALTER TABLE `mdl_data_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_data_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_data_content`
--

DROP TABLE IF EXISTS `mdl_data_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_data_content` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `fieldid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `recordid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `content` longtext,
  `content1` longtext,
  `content2` longtext,
  `content3` longtext,
  `content4` longtext,
  PRIMARY KEY (`id`),
  KEY `mdl_datacont_rec_ix` (`recordid`),
  KEY `mdl_datacont_fie_ix` (`fieldid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='the content introduced in each record/fields';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_data_content`
--

LOCK TABLES `mdl_data_content` WRITE;
/*!40000 ALTER TABLE `mdl_data_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_data_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_data_fields`
--

DROP TABLE IF EXISTS `mdl_data_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_data_fields` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `param1` text,
  `param2` text,
  `param3` text,
  `param4` text,
  `param5` text,
  `param6` text,
  `param7` text,
  `param8` text,
  `param9` text,
  `param10` text,
  PRIMARY KEY (`id`),
  KEY `mdl_datafiel_typdat_ix` (`type`,`dataid`),
  KEY `mdl_datafiel_dat_ix` (`dataid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='every field available';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_data_fields`
--

LOCK TABLES `mdl_data_fields` WRITE;
/*!40000 ALTER TABLE `mdl_data_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_data_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_data_ratings`
--

DROP TABLE IF EXISTS `mdl_data_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_data_ratings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `recordid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rating` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_datarati_rec_ix` (`recordid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to rate data records';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_data_ratings`
--

LOCK TABLES `mdl_data_ratings` WRITE;
/*!40000 ALTER TABLE `mdl_data_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_data_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_data_records`
--

DROP TABLE IF EXISTS `mdl_data_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_data_records` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `dataid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `approved` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_datareco_dat_ix` (`dataid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='every record introduced';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_data_records`
--

LOCK TABLES `mdl_data_records` WRITE;
/*!40000 ALTER TABLE `mdl_data_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_data_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_enrol_authorize`
--

DROP TABLE IF EXISTS `mdl_enrol_authorize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_enrol_authorize` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `paymentmethod` enum('cc','echeck') NOT NULL DEFAULT 'cc',
  `refundinfo` smallint(4) unsigned NOT NULL DEFAULT '0',
  `ccname` varchar(255) NOT NULL DEFAULT '',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `transid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `status` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `settletime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `amount` varchar(10) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`),
  KEY `mdl_enroauth_cou_ix` (`courseid`),
  KEY `mdl_enroauth_use_ix` (`userid`),
  KEY `mdl_enroauth_sta_ix` (`status`),
  KEY `mdl_enroauth_tra_ix` (`transid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds all known information about authorize.net transactions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_enrol_authorize`
--

LOCK TABLES `mdl_enrol_authorize` WRITE;
/*!40000 ALTER TABLE `mdl_enrol_authorize` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_enrol_authorize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_enrol_authorize_refunds`
--

DROP TABLE IF EXISTS `mdl_enrol_authorize_refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_enrol_authorize_refunds` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `amount` varchar(10) NOT NULL DEFAULT '',
  `transid` bigint(20) unsigned DEFAULT '0',
  `settletime` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_enroauthrefu_tra_ix` (`transid`),
  KEY `mdl_enroauthrefu_ord_ix` (`orderid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Authorize.net refunds';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_enrol_authorize_refunds`
--

LOCK TABLES `mdl_enrol_authorize_refunds` WRITE;
/*!40000 ALTER TABLE `mdl_enrol_authorize_refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_enrol_authorize_refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_enrol_paypal`
--

DROP TABLE IF EXISTS `mdl_enrol_paypal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_enrol_paypal` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `business` varchar(255) NOT NULL DEFAULT '',
  `receiver_email` varchar(255) NOT NULL DEFAULT '',
  `receiver_id` varchar(255) NOT NULL DEFAULT '',
  `item_name` varchar(255) NOT NULL DEFAULT '',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `memo` varchar(255) NOT NULL DEFAULT '',
  `tax` varchar(255) NOT NULL DEFAULT '',
  `option_name1` varchar(255) NOT NULL DEFAULT '',
  `option_selection1_x` varchar(255) NOT NULL DEFAULT '',
  `option_name2` varchar(255) NOT NULL DEFAULT '',
  `option_selection2_x` varchar(255) NOT NULL DEFAULT '',
  `payment_status` varchar(255) NOT NULL DEFAULT '',
  `pending_reason` varchar(255) NOT NULL DEFAULT '',
  `reason_code` varchar(30) NOT NULL DEFAULT '',
  `txn_id` varchar(255) NOT NULL DEFAULT '',
  `parent_txn_id` varchar(255) NOT NULL DEFAULT '',
  `payment_type` varchar(30) NOT NULL DEFAULT '',
  `timeupdated` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds all known information about PayPal transactions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_enrol_paypal`
--

LOCK TABLES `mdl_enrol_paypal` WRITE;
/*!40000 ALTER TABLE `mdl_enrol_paypal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_enrol_paypal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_event`
--

DROP TABLE IF EXISTS `mdl_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_event` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `format` smallint(4) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `repeatid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modulename` varchar(20) NOT NULL DEFAULT '',
  `instance` bigint(10) unsigned NOT NULL DEFAULT '0',
  `eventtype` varchar(20) NOT NULL DEFAULT '',
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeduration` bigint(10) unsigned NOT NULL DEFAULT '0',
  `visible` smallint(4) NOT NULL DEFAULT '1',
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `sequence` bigint(10) unsigned NOT NULL DEFAULT '1',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_even_cou_ix` (`courseid`),
  KEY `mdl_even_use_ix` (`userid`),
  KEY `mdl_even_tim_ix` (`timestart`),
  KEY `mdl_even_tim2_ix` (`timeduration`),
  KEY `mdl_even_grocouvisuse_ix` (`groupid`,`courseid`,`visible`,`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='For everything with a time associated to it';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_event`
--

LOCK TABLES `mdl_event` WRITE;
/*!40000 ALTER TABLE `mdl_event` DISABLE KEYS */;
INSERT INTO `mdl_event` VALUES (2,'Test chat','Test chat<br /> ',0,2,0,0,0,'chat',1,'0',1329316200,0,1,'',1,1329316389);
/*!40000 ALTER TABLE `mdl_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_events_handlers`
--

DROP TABLE IF EXISTS `mdl_events_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_events_handlers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventname` varchar(166) NOT NULL DEFAULT '',
  `handlermodule` varchar(166) NOT NULL DEFAULT '',
  `handlerfile` varchar(255) NOT NULL DEFAULT '',
  `handlerfunction` mediumtext,
  `schedule` varchar(255) DEFAULT NULL,
  `status` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_evenhand_evehan_uix` (`eventname`,`handlermodule`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='This table is for storing which components requests what typ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_events_handlers`
--

LOCK TABLES `mdl_events_handlers` WRITE;
/*!40000 ALTER TABLE `mdl_events_handlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_events_handlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_events_queue`
--

DROP TABLE IF EXISTS `mdl_events_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_events_queue` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventdata` longtext NOT NULL,
  `stackdump` mediumtext,
  `userid` bigint(10) unsigned DEFAULT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_evenqueu_use_ix` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='This table is for storing queued events. It stores only one ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_events_queue`
--

LOCK TABLES `mdl_events_queue` WRITE;
/*!40000 ALTER TABLE `mdl_events_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_events_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_events_queue_handlers`
--

DROP TABLE IF EXISTS `mdl_events_queue_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_events_queue_handlers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `queuedeventid` bigint(10) unsigned NOT NULL,
  `handlerid` bigint(10) unsigned NOT NULL,
  `status` bigint(10) DEFAULT NULL,
  `errormessage` mediumtext,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_evenqueuhand_que_ix` (`queuedeventid`),
  KEY `mdl_evenqueuhand_han_ix` (`handlerid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='This is the list of queued handlers for processing. The even';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_events_queue_handlers`
--

LOCK TABLES `mdl_events_queue_handlers` WRITE;
/*!40000 ALTER TABLE `mdl_events_queue_handlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_events_queue_handlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum`
--

DROP TABLE IF EXISTS `mdl_forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('single','news','general','social','eachuser','teacher','qanda') NOT NULL DEFAULT 'general',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `assessed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `scale` bigint(10) NOT NULL DEFAULT '0',
  `maxbytes` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forcesubscribe` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `trackingtype` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rsstype` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rssarticles` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `warnafter` bigint(10) unsigned NOT NULL DEFAULT '0',
  `blockafter` bigint(10) unsigned NOT NULL DEFAULT '0',
  `blockperiod` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_foru_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Forums contain and structure discussion';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum`
--

LOCK TABLES `mdl_forum` WRITE;
/*!40000 ALTER TABLE `mdl_forum` DISABLE KEYS */;
INSERT INTO `mdl_forum` VALUES (1,2,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1324980908,0,0,0),(2,3,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1324980936,0,0,0),(3,4,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325605079,0,0,0),(4,7,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325605208,0,0,0),(5,6,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325682169,0,0,0),(6,5,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325682183,0,0,0),(7,10,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325682222,0,0,0),(8,9,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325682231,0,0,0),(9,8,'news','News forum','General news and announcements',0,0,0,1,0,1,1,0,0,1325682239,0,0,0),(10,13,'news','Nieuwsforum','Algemeen nieuws en aankondigingen',0,0,0,0,0,1,1,0,0,1311028738,0,0,0),(11,14,'news','Nieuwsforum','Algemeen nieuws en aankondigingen',0,0,0,0,0,1,1,0,0,1311938763,0,0,0),(12,15,'news','Nieuwsforum','Algemeen nieuws en aankondigingen',0,0,0,0,0,1,1,0,0,1311941791,0,0,0),(13,16,'news','Nieuwsforum','Algemeen nieuws en aankondigingen',0,0,0,0,0,1,1,0,0,1311942926,0,0,0),(14,17,'news','Nieuwsforum','Algemeen nieuws en aankondigingen',0,0,0,0,0,1,1,0,0,1311942926,0,0,0);
/*!40000 ALTER TABLE `mdl_forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_discussions`
--

DROP TABLE IF EXISTS `mdl_forum_discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_discussions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forum` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `firstpost` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) NOT NULL DEFAULT '-1',
  `assessed` tinyint(1) NOT NULL DEFAULT '1',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `usermodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forudisc_use_ix` (`userid`),
  KEY `mdl_forudisc_for_ix` (`forum`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Forums are composed of discussions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_discussions`
--

LOCK TABLES `mdl_forum_discussions` WRITE;
/*!40000 ALTER TABLE `mdl_forum_discussions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_discussions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_posts`
--

DROP TABLE IF EXISTS `mdl_forum_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_posts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `discussion` bigint(10) unsigned NOT NULL DEFAULT '0',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `format` tinyint(2) NOT NULL DEFAULT '0',
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `totalscore` smallint(4) NOT NULL DEFAULT '0',
  `mailnow` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forupost_use_ix` (`userid`),
  KEY `mdl_forupost_cre_ix` (`created`),
  KEY `mdl_forupost_mai_ix` (`mailed`),
  KEY `mdl_forupost_dis_ix` (`discussion`),
  KEY `mdl_forupost_par_ix` (`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='All posts are stored in this table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_posts`
--

LOCK TABLES `mdl_forum_posts` WRITE;
/*!40000 ALTER TABLE `mdl_forum_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_queue`
--

DROP TABLE IF EXISTS `mdl_forum_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_queue` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `discussionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `postid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_foruqueu_use_ix` (`userid`),
  KEY `mdl_foruqueu_dis_ix` (`discussionid`),
  KEY `mdl_foruqueu_pos_ix` (`postid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For keeping track of posts that will be mailed in digest for';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_queue`
--

LOCK TABLES `mdl_forum_queue` WRITE;
/*!40000 ALTER TABLE `mdl_forum_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_ratings`
--

DROP TABLE IF EXISTS `mdl_forum_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_ratings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `post` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rating` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forurati_use_ix` (`userid`),
  KEY `mdl_forurati_pos_ix` (`post`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='forum_ratings table retrofitted from MySQL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_ratings`
--

LOCK TABLES `mdl_forum_ratings` WRITE;
/*!40000 ALTER TABLE `mdl_forum_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_read`
--

DROP TABLE IF EXISTS `mdl_forum_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_read` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forumid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `discussionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `postid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `firstread` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastread` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_foruread_usefor_ix` (`userid`,`forumid`),
  KEY `mdl_foruread_usedis_ix` (`userid`,`discussionid`),
  KEY `mdl_foruread_usepos_ix` (`userid`,`postid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Tracks each users read posts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_read`
--

LOCK TABLES `mdl_forum_read` WRITE;
/*!40000 ALTER TABLE `mdl_forum_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_subscriptions`
--

DROP TABLE IF EXISTS `mdl_forum_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_subscriptions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forum` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forusubs_use_ix` (`userid`),
  KEY `mdl_forusubs_for_ix` (`forum`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Keeps track of who is subscribed to what forum';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_subscriptions`
--

LOCK TABLES `mdl_forum_subscriptions` WRITE;
/*!40000 ALTER TABLE `mdl_forum_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_forum_track_prefs`
--

DROP TABLE IF EXISTS `mdl_forum_track_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_forum_track_prefs` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forumid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forutracpref_usefor_ix` (`userid`,`forumid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Tracks each users untracked forums';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_forum_track_prefs`
--

LOCK TABLES `mdl_forum_track_prefs` WRITE;
/*!40000 ALTER TABLE `mdl_forum_track_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_forum_track_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary`
--

DROP TABLE IF EXISTS `mdl_glossary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `allowduplicatedentries` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `displayformat` varchar(50) NOT NULL DEFAULT 'dictionary',
  `mainglossary` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `showspecial` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `showalphabet` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `showall` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `allowcomments` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `allowprintview` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `usedynalink` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `defaultapproval` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `globalglossary` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `entbypage` smallint(3) unsigned NOT NULL DEFAULT '10',
  `editalways` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rsstype` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rssarticles` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `assessed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `scale` bigint(10) NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_glos_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='all glossaries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary`
--

LOCK TABLES `mdl_glossary` WRITE;
/*!40000 ALTER TABLE `mdl_glossary` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_alias`
--

DROP TABLE IF EXISTS `mdl_glossary_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_alias` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `entryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `alias` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_glosalia_ent_ix` (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='entries alias';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_alias`
--

LOCK TABLES `mdl_glossary_alias` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_categories`
--

DROP TABLE IF EXISTS `mdl_glossary_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `glossaryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `usedynalink` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_gloscate_glo_ix` (`glossaryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='all categories for glossary entries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_categories`
--

LOCK TABLES `mdl_glossary_categories` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_comments`
--

DROP TABLE IF EXISTS `mdl_glossary_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_comments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `entryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `entrycomment` text NOT NULL,
  `format` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_gloscomm_use_ix` (`userid`),
  KEY `mdl_gloscomm_ent_ix` (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='comments on glossary entries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_comments`
--

LOCK TABLES `mdl_glossary_comments` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_entries`
--

DROP TABLE IF EXISTS `mdl_glossary_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_entries` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `glossaryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `concept` varchar(255) NOT NULL DEFAULT '',
  `definition` text NOT NULL,
  `format` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `teacherentry` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sourceglossaryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `usedynalink` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `casesensitive` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `fullmatch` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `approved` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_glosentr_use_ix` (`userid`),
  KEY `mdl_glosentr_con_ix` (`concept`),
  KEY `mdl_glosentr_glo_ix` (`glossaryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='all glossary entries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_entries`
--

LOCK TABLES `mdl_glossary_entries` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_entries_categories`
--

DROP TABLE IF EXISTS `mdl_glossary_entries_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_entries_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `categoryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `entryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_glosentrcate_cat_ix` (`categoryid`),
  KEY `mdl_glosentrcate_ent_ix` (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='categories of each glossary entry';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_entries_categories`
--

LOCK TABLES `mdl_glossary_entries_categories` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_entries_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary_entries_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_formats`
--

DROP TABLE IF EXISTS `mdl_glossary_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_formats` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `popupformatname` varchar(50) NOT NULL DEFAULT '',
  `visible` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `showgroup` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `defaultmode` varchar(50) NOT NULL DEFAULT '',
  `defaulthook` varchar(50) NOT NULL DEFAULT '',
  `sortkey` varchar(50) NOT NULL DEFAULT '',
  `sortorder` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Setting of the display formats';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_formats`
--

LOCK TABLES `mdl_glossary_formats` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_formats` DISABLE KEYS */;
INSERT INTO `mdl_glossary_formats` VALUES (1,'continuous','continuous',1,1,'','','',''),(2,'dictionary','dictionary',1,1,'','','',''),(3,'encyclopedia','encyclopedia',1,1,'','','',''),(4,'entrylist','entrylist',1,1,'','','',''),(5,'faq','faq',1,1,'','','',''),(6,'fullwithauthor','fullwithauthor',1,1,'','','',''),(7,'fullwithoutauthor','fullwithoutauthor',1,1,'','','','');
/*!40000 ALTER TABLE `mdl_glossary_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_glossary_ratings`
--

DROP TABLE IF EXISTS `mdl_glossary_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_glossary_ratings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `entryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rating` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_glosrati_use_ix` (`userid`),
  KEY `mdl_glosrati_ent_ix` (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Contains user ratings for entries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_glossary_ratings`
--

LOCK TABLES `mdl_glossary_ratings` WRITE;
/*!40000 ALTER TABLE `mdl_glossary_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_glossary_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_categories`
--

DROP TABLE IF EXISTS `mdl_grade_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `parent` bigint(10) unsigned DEFAULT NULL,
  `depth` bigint(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) NOT NULL DEFAULT '',
  `aggregation` bigint(10) NOT NULL DEFAULT '0',
  `keephigh` bigint(10) NOT NULL DEFAULT '0',
  `droplow` bigint(10) NOT NULL DEFAULT '0',
  `aggregateonlygraded` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `aggregateoutcomes` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `aggregatesubcats` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_gradcate_cou_ix` (`courseid`),
  KEY `mdl_gradcate_par_ix` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='This table keeps information about categories, used for grou';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_categories`
--

LOCK TABLES `mdl_grade_categories` WRITE;
/*!40000 ALTER TABLE `mdl_grade_categories` DISABLE KEYS */;
INSERT INTO `mdl_grade_categories` VALUES (1,1,NULL,1,'/1/','?',11,0,0,1,0,0,1324983152,1324983152),(2,2,NULL,1,'/2/','?',11,0,0,1,0,0,1325778549,1325778549),(3,6,NULL,1,'/3/','?',11,0,0,1,0,0,1326105886,1326105886),(4,3,NULL,1,'/4/','?',11,0,0,1,0,0,1326975312,1326975312),(5,11,NULL,1,'/5/','?',11,0,0,1,0,0,1325778549,1328632893),(6,12,NULL,1,'/6/','?',11,0,0,1,0,0,1325778549,1328632955),(7,4,NULL,1,'/7/','?',11,0,0,1,0,0,1328791611,1328791611),(8,5,NULL,1,'/8/','?',11,0,0,1,0,0,1328791611,1328791611),(9,7,NULL,1,'/9/','?',11,0,0,1,0,0,1328791611,1328791611),(10,8,NULL,1,'/10/','?',11,0,0,1,0,0,1328791611,1328791612),(11,9,NULL,1,'/11/','?',11,0,0,1,0,0,1328791612,1328791612),(12,10,NULL,1,'/12/','?',11,0,0,1,0,0,1328791612,1328791612),(13,13,NULL,1,'/13/','?',11,0,0,1,0,0,1311028789,1332833011),(14,14,NULL,1,'/14/','?',11,0,0,1,0,0,1311938782,1332833038),(15,15,NULL,1,'/15/','?',11,0,0,1,0,0,1311943652,1332833065),(16,16,NULL,1,'/16/','?',11,0,0,1,0,0,1311942892,1332833089),(17,17,NULL,1,'/17/','?',11,0,0,1,0,0,1311942892,1332837940);
/*!40000 ALTER TABLE `mdl_grade_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_categories_history`
--

DROP TABLE IF EXISTS `mdl_grade_categories_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_categories_history` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldid` bigint(10) unsigned NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `loggeduser` bigint(10) unsigned DEFAULT NULL,
  `courseid` bigint(10) unsigned NOT NULL,
  `parent` bigint(10) unsigned DEFAULT NULL,
  `depth` bigint(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) NOT NULL DEFAULT '',
  `aggregation` bigint(10) NOT NULL DEFAULT '0',
  `keephigh` bigint(10) NOT NULL DEFAULT '0',
  `droplow` bigint(10) NOT NULL DEFAULT '0',
  `aggregateonlygraded` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `aggregateoutcomes` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `aggregatesubcats` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_gradcatehist_act_ix` (`action`),
  KEY `mdl_gradcatehist_old_ix` (`oldid`),
  KEY `mdl_gradcatehist_cou_ix` (`courseid`),
  KEY `mdl_gradcatehist_par_ix` (`parent`),
  KEY `mdl_gradcatehist_log_ix` (`loggeduser`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='History of grade_categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_categories_history`
--

LOCK TABLES `mdl_grade_categories_history` WRITE;
/*!40000 ALTER TABLE `mdl_grade_categories_history` DISABLE KEYS */;
INSERT INTO `mdl_grade_categories_history` VALUES (1,1,1,'system',1324983152,2,1,NULL,0,NULL,'?',11,0,0,1,0,0),(2,2,1,'system',1324983152,2,1,NULL,1,'/1/','?',11,0,0,1,0,0),(3,1,2,'system',1325778549,2,2,NULL,0,NULL,'?',11,0,0,1,0,0),(4,2,2,'system',1325778549,2,2,NULL,1,'/2/','?',11,0,0,1,0,0),(5,1,3,'system',1326105886,2,6,NULL,0,NULL,'?',11,0,0,1,0,0),(6,2,3,'system',1326105886,2,6,NULL,1,'/3/','?',11,0,0,1,0,0),(7,1,4,'system',1326975312,2,3,NULL,0,NULL,'?',11,0,0,1,0,0),(8,2,4,'system',1326975312,2,3,NULL,1,'/4/','?',11,0,0,1,0,0),(9,1,5,'system',1328632893,2,11,NULL,0,NULL,'?',11,0,0,1,0,0),(10,2,5,'system',1328632893,2,11,NULL,1,'/5/','?',11,0,0,1,0,0),(11,2,5,'restore',1328632893,2,11,NULL,1,'/5/','?',11,0,0,1,0,0),(12,1,6,'system',1328632955,2,12,NULL,0,NULL,'?',11,0,0,1,0,0),(13,2,6,'system',1328632955,2,12,NULL,1,'/6/','?',11,0,0,1,0,0),(14,2,6,'restore',1328632955,2,12,NULL,1,'/6/','?',11,0,0,1,0,0),(15,1,7,'system',1328791611,2,4,NULL,0,NULL,'?',11,0,0,1,0,0),(16,2,7,'system',1328791611,2,4,NULL,1,'/7/','?',11,0,0,1,0,0),(17,1,8,'system',1328791611,2,5,NULL,0,NULL,'?',11,0,0,1,0,0),(18,2,8,'system',1328791611,2,5,NULL,1,'/8/','?',11,0,0,1,0,0),(19,1,9,'system',1328791611,2,7,NULL,0,NULL,'?',11,0,0,1,0,0),(20,2,9,'system',1328791611,2,7,NULL,1,'/9/','?',11,0,0,1,0,0),(21,1,10,'system',1328791611,2,8,NULL,0,NULL,'?',11,0,0,1,0,0),(22,2,10,'system',1328791612,2,8,NULL,1,'/10/','?',11,0,0,1,0,0),(23,1,11,'system',1328791612,2,9,NULL,0,NULL,'?',11,0,0,1,0,0),(24,2,11,'system',1328791612,2,9,NULL,1,'/11/','?',11,0,0,1,0,0),(25,1,12,'system',1328791612,2,10,NULL,0,NULL,'?',11,0,0,1,0,0),(26,2,12,'system',1328791612,2,10,NULL,1,'/12/','?',11,0,0,1,0,0),(27,1,13,'system',1332833011,2,13,NULL,0,NULL,'?',6,0,0,1,0,0),(28,2,13,'system',1332833011,2,13,NULL,1,'/13/','?',6,0,0,1,0,0),(29,2,13,'restore',1332833011,2,13,NULL,1,'/13/','?',11,0,0,1,0,0),(30,1,14,'system',1332833038,2,14,NULL,0,NULL,'?',6,0,0,1,0,0),(31,2,14,'system',1332833038,2,14,NULL,1,'/14/','?',6,0,0,1,0,0),(32,2,14,'restore',1332833038,2,14,NULL,1,'/14/','?',11,0,0,1,0,0),(33,1,15,'system',1332833065,2,15,NULL,0,NULL,'?',6,0,0,1,0,0),(34,2,15,'system',1332833065,2,15,NULL,1,'/15/','?',6,0,0,1,0,0),(35,2,15,'restore',1332833065,2,15,NULL,1,'/15/','?',11,0,0,1,0,0),(36,1,16,'system',1332833089,2,16,NULL,0,NULL,'?',6,0,0,1,0,0),(37,2,16,'system',1332833089,2,16,NULL,1,'/16/','?',6,0,0,1,0,0),(38,2,16,'restore',1332833089,2,16,NULL,1,'/16/','?',11,0,0,1,0,0),(39,1,17,'system',1332837940,2,17,NULL,0,NULL,'?',6,0,0,1,0,0),(40,2,17,'system',1332837940,2,17,NULL,1,'/17/','?',6,0,0,1,0,0),(41,2,17,'restore',1332837940,2,17,NULL,1,'/17/','?',11,0,0,1,0,0);
/*!40000 ALTER TABLE `mdl_grade_categories_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_grades`
--

DROP TABLE IF EXISTS `mdl_grade_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `rawgrade` decimal(10,5) DEFAULT NULL,
  `rawgrademax` decimal(10,5) NOT NULL DEFAULT '100.00000',
  `rawgrademin` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `rawscaleid` bigint(10) unsigned DEFAULT NULL,
  `usermodified` bigint(10) unsigned DEFAULT NULL,
  `finalgrade` decimal(10,5) DEFAULT NULL,
  `hidden` bigint(10) unsigned NOT NULL DEFAULT '0',
  `locked` bigint(10) unsigned NOT NULL DEFAULT '0',
  `locktime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `exported` bigint(10) unsigned NOT NULL DEFAULT '0',
  `overridden` bigint(10) unsigned NOT NULL DEFAULT '0',
  `excluded` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedback` mediumtext,
  `feedbackformat` bigint(10) unsigned NOT NULL DEFAULT '0',
  `information` mediumtext,
  `informationformat` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradgrad_useite_uix` (`userid`,`itemid`),
  KEY `mdl_gradgrad_locloc_ix` (`locked`,`locktime`),
  KEY `mdl_gradgrad_ite_ix` (`itemid`),
  KEY `mdl_gradgrad_use_ix` (`userid`),
  KEY `mdl_gradgrad_raw_ix` (`rawscaleid`),
  KEY `mdl_gradgrad_use2_ix` (`usermodified`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='grade_grades  This table keeps individual grades for each us';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_grades`
--

LOCK TABLES `mdl_grade_grades` WRITE;
/*!40000 ALTER TABLE `mdl_grade_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_grades_history`
--

DROP TABLE IF EXISTS `mdl_grade_grades_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_grades_history` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldid` bigint(10) unsigned NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `loggeduser` bigint(10) unsigned DEFAULT NULL,
  `itemid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `rawgrade` decimal(10,5) DEFAULT NULL,
  `rawgrademax` decimal(10,5) NOT NULL DEFAULT '100.00000',
  `rawgrademin` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `rawscaleid` bigint(10) unsigned DEFAULT NULL,
  `usermodified` bigint(10) unsigned DEFAULT NULL,
  `finalgrade` decimal(10,5) DEFAULT NULL,
  `hidden` bigint(10) unsigned NOT NULL DEFAULT '0',
  `locked` bigint(10) unsigned NOT NULL DEFAULT '0',
  `locktime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `exported` bigint(10) unsigned NOT NULL DEFAULT '0',
  `overridden` bigint(10) unsigned NOT NULL DEFAULT '0',
  `excluded` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedback` mediumtext,
  `feedbackformat` bigint(10) unsigned NOT NULL DEFAULT '0',
  `information` mediumtext,
  `informationformat` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_gradgradhist_act_ix` (`action`),
  KEY `mdl_gradgradhist_old_ix` (`oldid`),
  KEY `mdl_gradgradhist_ite_ix` (`itemid`),
  KEY `mdl_gradgradhist_use_ix` (`userid`),
  KEY `mdl_gradgradhist_raw_ix` (`rawscaleid`),
  KEY `mdl_gradgradhist_use2_ix` (`usermodified`),
  KEY `mdl_gradgradhist_log_ix` (`loggeduser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='History table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_grades_history`
--

LOCK TABLES `mdl_grade_grades_history` WRITE;
/*!40000 ALTER TABLE `mdl_grade_grades_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_grades_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_import_newitem`
--

DROP TABLE IF EXISTS `mdl_grade_import_newitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_import_newitem` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemname` varchar(255) NOT NULL DEFAULT '',
  `importcode` bigint(10) unsigned NOT NULL,
  `importer` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_gradimponewi_imp_ix` (`importer`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='temporary table for storing new grade_item names from grade ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_import_newitem`
--

LOCK TABLES `mdl_grade_import_newitem` WRITE;
/*!40000 ALTER TABLE `mdl_grade_import_newitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_import_newitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_import_values`
--

DROP TABLE IF EXISTS `mdl_grade_import_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_import_values` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(10) unsigned DEFAULT NULL,
  `newgradeitem` bigint(10) unsigned DEFAULT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `finalgrade` decimal(10,5) DEFAULT NULL,
  `feedback` mediumtext,
  `importcode` bigint(10) unsigned NOT NULL,
  `importer` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_gradimpovalu_ite_ix` (`itemid`),
  KEY `mdl_gradimpovalu_new_ix` (`newgradeitem`),
  KEY `mdl_gradimpovalu_imp_ix` (`importer`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Temporary table for importing grades';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_import_values`
--

LOCK TABLES `mdl_grade_import_values` WRITE;
/*!40000 ALTER TABLE `mdl_grade_import_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_import_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_items`
--

DROP TABLE IF EXISTS `mdl_grade_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_items` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned DEFAULT NULL,
  `categoryid` bigint(10) unsigned DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `itemtype` varchar(30) NOT NULL DEFAULT '',
  `itemmodule` varchar(30) DEFAULT NULL,
  `iteminstance` bigint(10) unsigned DEFAULT NULL,
  `itemnumber` bigint(10) unsigned DEFAULT NULL,
  `iteminfo` mediumtext,
  `idnumber` varchar(255) DEFAULT NULL,
  `calculation` mediumtext,
  `gradetype` smallint(4) NOT NULL DEFAULT '1',
  `grademax` decimal(10,5) NOT NULL DEFAULT '100.00000',
  `grademin` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `scaleid` bigint(10) unsigned DEFAULT NULL,
  `outcomeid` bigint(10) unsigned DEFAULT NULL,
  `gradepass` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `multfactor` decimal(10,5) NOT NULL DEFAULT '1.00000',
  `plusfactor` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `aggregationcoef` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `sortorder` bigint(10) NOT NULL DEFAULT '0',
  `display` bigint(10) NOT NULL DEFAULT '0',
  `decimals` tinyint(1) unsigned DEFAULT NULL,
  `hidden` bigint(10) NOT NULL DEFAULT '0',
  `locked` bigint(10) NOT NULL DEFAULT '0',
  `locktime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `needsupdate` bigint(10) NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_graditem_locloc_ix` (`locked`,`locktime`),
  KEY `mdl_graditem_itenee_ix` (`itemtype`,`needsupdate`),
  KEY `mdl_graditem_gra_ix` (`gradetype`),
  KEY `mdl_graditem_idncou_ix` (`idnumber`,`courseid`),
  KEY `mdl_graditem_cou_ix` (`courseid`),
  KEY `mdl_graditem_cat_ix` (`categoryid`),
  KEY `mdl_graditem_sca_ix` (`scaleid`),
  KEY `mdl_graditem_out_ix` (`outcomeid`)
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COMMENT='This table keeps information about gradeable items (ie colum';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_items`
--

LOCK TABLES `mdl_grade_items` WRITE;
/*!40000 ALTER TABLE `mdl_grade_items` DISABLE KEYS */;
INSERT INTO `mdl_grade_items` VALUES (1,1,NULL,NULL,'course',NULL,1,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1324983152,1324983152),(2,2,NULL,NULL,'course',NULL,2,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1325778549,1325778549),(3,6,NULL,NULL,'course',NULL,3,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1326105886,1326105886),(4,6,3,'Test activity','mod','assignment',1,0,NULL,'',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,NULL,0,0,0,0,1326115093,1326115093),(5,3,NULL,NULL,'course',NULL,4,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1326975312,1326975312),(6,11,NULL,NULL,'course',NULL,5,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,1,1325778549,1328632893),(7,12,NULL,NULL,'course',NULL,6,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,1,1325778549,1328632955),(8,4,NULL,NULL,'course',NULL,7,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1328791611,1328791611),(9,5,NULL,NULL,'course',NULL,8,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1328791611,1328791611),(10,7,NULL,NULL,'course',NULL,9,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1328791611,1328791611),(11,8,NULL,NULL,'course',NULL,10,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1328791611,1328791611),(12,9,NULL,NULL,'course',NULL,11,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1328791612,1328791612),(13,10,NULL,NULL,'course',NULL,12,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1328791612,1328791612),(14,13,NULL,NULL,'course',NULL,13,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1311028789,1332833011),(15,13,13,'193 Wonen in je straat','mod','scorm',1,0,NULL,'L0193',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,NULL,0,0,0,0,1332833011,1332833011),(16,13,13,'195 Woorden: Het huis','mod','scorm',2,0,NULL,'L0195',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,NULL,0,0,0,0,1332833011,1332833011),(17,13,13,'196 Praatplaat: Soorten huizen','mod','scorm',3,0,NULL,'L0196',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,NULL,0,0,0,0,1332833011,1332833011),(18,13,13,'199 Hoek: Huizen bouwen','mod','scorm',4,0,NULL,'L0199',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,NULL,0,0,0,0,1332833011,1332833011),(19,13,13,'200 Maak je slaapkamer','mod','scorm',5,0,NULL,'L0200',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,NULL,0,0,0,0,1332833011,1332833011),(20,13,13,'201 Woorden: De straat','mod','scorm',6,0,NULL,'L0201',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,NULL,0,0,0,0,1332833011,1332833011),(21,13,13,'202 Bewegen: Stoeptegelspellen','mod','scorm',7,0,NULL,'L0202',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,NULL,0,0,0,0,1332833011,1332833011),(22,13,13,'203 Doeblad: Houd je straat schoon','mod','scorm',8,0,NULL,'L0203',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,NULL,0,0,0,0,1332833011,1332833011),(23,13,13,'205 Ruim de straat op','mod','scorm',9,0,NULL,'L0205',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,NULL,0,0,0,0,1332833011,1332833011),(24,13,13,'206 Teken je eigen huis','mod','scorm',10,0,NULL,'L0206',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,NULL,0,0,0,0,1332833011,1332833011),(25,13,13,'216 Onder, boven, voor en achter','mod','scorm',11,0,NULL,'L0216',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,NULL,0,0,0,0,1332833011,1332833011),(26,13,13,'217 Links en rechts','mod','scorm',12,0,NULL,'L0217',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,NULL,0,0,0,0,1332833011,1332833011),(27,13,13,'727 Teken het leukste schoolplein','mod','scorm',13,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,NULL,0,0,0,0,1332833011,1332833011),(28,14,NULL,NULL,'course',NULL,14,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1311938782,1332833038),(29,14,14,'170 Doe historisch onderzoek','mod','scorm',20,0,NULL,'L0170',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,NULL,0,0,0,0,1332833038,1332833038),(30,14,14,'176 Onderdelen van een kaart','mod','scorm',21,0,NULL,'L0176',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,NULL,0,0,0,0,1332833038,1332833038),(31,14,14,'177 Een kaart lezen','mod','scorm',23,0,NULL,'L0177',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,NULL,0,0,0,0,1332833038,1332833038),(32,14,14,'178 Opbouw van een stad','mod','scorm',25,0,NULL,'L0178',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,NULL,0,0,0,0,1332833038,1332833038),(33,14,14,'179 Soorten kaarten','mod','scorm',27,0,NULL,'L0179',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,NULL,0,0,0,0,1332833038,1332833038),(34,14,14,'180 Ontwerp een plein op schaal','mod','scorm',29,0,NULL,'L0180',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,NULL,0,0,0,0,1332833038,1332833038),(35,14,14,'185 Taken van de gemeente','mod','scorm',30,0,NULL,'L0185',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,NULL,0,0,0,0,1332833038,1332833038),(36,14,14,'186 Ruimtelijke ordening','mod','scorm',32,0,NULL,'L0186',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,NULL,0,0,0,0,1332833038,1332833038),(37,14,14,'187 Historisch onderzoek: Ontwikkeling van je gemeente','mod','scorm',34,0,NULL,'L0187',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,NULL,0,0,0,0,1332833038,1332833038),(38,14,14,'188 Pleinontwerp: Ontwikkeling van je gemeente','mod','scorm',35,0,NULL,'L0188',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,NULL,0,0,0,0,1332833038,1332833038),(39,14,14,'189 Verstedelijking van Nederland','mod','scorm',36,0,NULL,'L0189',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,NULL,0,0,0,0,1332833038,1332833038),(40,14,14,'191 Ontstaan van dorpen','mod','scorm',38,0,NULL,'L0191',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,NULL,0,0,0,0,1332833038,1332833038),(41,14,14,'192 Ontstaan van steden','mod','scorm',40,0,NULL,'L0192',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,NULL,0,0,0,0,1332833038,1332833038),(42,14,14,'208 Houd een enquete','mod','scorm',42,0,NULL,'L0208',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,NULL,0,0,0,0,1332833038,1332833038),(43,14,14,'727 Teken het leukste schoolplein','mod','scorm',46,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,NULL,0,0,0,0,1332833038,1332833038),(44,14,14,'211 Maak samen een nieuwe wijk','mod','scorm',45,0,NULL,'L0211',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,NULL,0,0,0,0,1332833038,1332833038),(45,14,14,'176 Toets Onderdelen van een kaart','mod','scorm',22,0,NULL,'L0176T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,NULL,0,0,0,0,1332833038,1332833038),(46,14,14,'177 Toets Een kaart lezen','mod','scorm',24,0,NULL,'L0177T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',19,0,NULL,0,0,0,0,1332833038,1332833038),(47,14,14,'178 Toets Opbouw van een stad','mod','scorm',26,0,NULL,'L0178T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',20,0,NULL,0,0,0,0,1332833038,1332833038),(48,14,14,'179 Toets Soorten kaarten','mod','scorm',28,0,NULL,'L0179T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',21,0,NULL,0,0,0,0,1332833038,1332833038),(49,14,14,'185 Toets Taken van de gemeente','mod','scorm',31,0,NULL,'L0185T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',22,0,NULL,0,0,0,0,1332833038,1332833038),(50,14,14,'186 Toets Ruimtelijke ordening','mod','scorm',33,0,NULL,'L0186T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',23,0,NULL,0,0,0,0,1332833038,1332833038),(51,14,14,'189 Toets Verstedelijking van Nederland','mod','scorm',37,0,NULL,'L0189T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',24,0,NULL,0,0,0,0,1332833038,1332833038),(52,14,14,'191 Toets Ontstaan van dorpen','mod','scorm',39,0,NULL,'L0191T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',25,0,NULL,0,0,0,0,1332833038,1332833038),(53,14,14,'192 Toets Ontstaan van steden','mod','scorm',41,0,NULL,'L0192T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',26,0,NULL,0,0,0,0,1332833038,1332833038),(54,14,14,'209 Toets Ontwikkeling van toerisme','mod','scorm',44,0,NULL,'L0209T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',27,0,NULL,0,0,0,0,1332833038,1332833038),(55,14,14,'209 Ontwikkeling van toerisme','mod','scorm',43,0,NULL,'L0209',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',28,0,NULL,0,0,0,0,1332833038,1332833038),(56,14,14,'8 Werk met google maps','mod','scorm',16,0,NULL,'L0008',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',29,0,NULL,0,0,0,0,1332833038,1332833038),(57,14,14,'9 Rekenen met schaal','mod','scorm',17,0,NULL,'L0009',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',30,0,NULL,0,0,0,0,1332833038,1332833038),(58,14,14,'9 Toets Rekenen met schaal','mod','scorm',18,0,NULL,'L0009T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',31,0,NULL,0,0,0,0,1332833038,1332833038),(59,14,14,'7 Voorzieningen voor iedereen','mod','scorm',14,0,NULL,'L0007',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',32,0,NULL,0,0,0,0,1332833038,1332833038),(60,14,14,'7 Toets Voorzieningen voor iedereen','mod','scorm',15,0,NULL,'L0007T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',33,0,NULL,0,0,0,0,1332833038,1332833038),(61,14,14,'111 Houd een interview','mod','scorm',19,0,NULL,'L0111',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',34,0,NULL,0,0,0,0,1332833038,1332833038),(62,15,NULL,NULL,'course',NULL,15,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1311943652,1332833065),(63,15,15,'174 Rondleiding: Vrije tijd in je buurt','mod','scorm',48,0,NULL,'L0174',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,NULL,0,0,0,0,1332833065,1332833065),(64,15,15,'175 Plein: Vrije tijd in je buurt','mod','scorm',49,0,NULL,'L0175',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,NULL,0,0,0,0,1332833065,1332833065),(65,15,15,'176 Onderdelen van een kaart','mod','scorm',50,0,NULL,'L0176',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,NULL,0,0,0,0,1332833065,1332833065),(66,15,15,'176 Toets Onderdelen van een kaart','mod','scorm',51,0,NULL,'L0176T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,NULL,0,0,0,0,1332833065,1332833065),(67,15,15,'177 Een kaart lezen','mod','scorm',52,0,NULL,'L0177',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,NULL,0,0,0,0,1332833065,1332833065),(68,15,15,'177 Toets Een kaart lezen','mod','scorm',53,0,NULL,'L0177T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,NULL,0,0,0,0,1332833065,1332833065),(69,15,15,'181 Openbare speelruimtes','mod','scorm',56,0,NULL,'L0181',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,NULL,0,0,0,0,1332833065,1332833065),(70,15,15,'181 Toets Openbare speelruimtes','mod','scorm',57,0,NULL,'L0181T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,NULL,0,0,0,0,1332833065,1332833065),(71,15,15,'182 Soorten vrijetijdsbestedingen','mod','scorm',58,0,NULL,'L0182',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,NULL,0,0,0,0,1332833065,1332833065),(72,15,15,'182 Toets Soorten vrijetijdsbestedingen','mod','scorm',59,0,NULL,'L0182T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,NULL,0,0,0,0,1332833065,1332833065),(73,15,15,'183 Maak een rondleiding','mod','scorm',60,0,NULL,'L0183',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,NULL,0,0,0,0,1332833065,1332833065),(74,15,15,'184 Ontwerp een speelplein','mod','scorm',61,0,NULL,'L0184',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,NULL,0,0,0,0,1332833065,1332833065),(75,15,15,'207 Leven in een middeleeuwse stad','mod','scorm',63,0,NULL,'L0207',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,NULL,0,0,0,0,1332833065,1332833065),(76,15,15,'207 Toets Leven in een middeleeuwse stad','mod','scorm',64,0,NULL,'L0207T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,NULL,0,0,0,0,1332833065,1332833065),(77,15,15,'211 Maak samen een nieuwe wijk','mod','scorm',65,0,NULL,'L0211',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,NULL,0,0,0,0,1332833065,1332833065),(78,15,15,'218 Toerisme in Nederland','mod','scorm',66,0,NULL,'L0218',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,NULL,0,0,0,0,1332833065,1332833065),(79,15,15,'218 Toets Toerisme in Nederland','mod','scorm',67,0,NULL,'L0218T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,NULL,0,0,0,0,1332833065,1332833065),(80,15,15,'727 Teken het leukste schoolplein','mod','scorm',68,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',19,0,NULL,0,0,0,0,1332833065,1332833065),(81,15,15,'179 Soorten kaarten','mod','scorm',54,0,NULL,'L0179',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',20,0,NULL,0,0,0,0,1332833065,1332833065),(82,15,15,'179 Toets Soorten kaarten','mod','scorm',55,0,NULL,'L0179T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',21,0,NULL,0,0,0,0,1332833065,1332833065),(83,15,15,'190 Zoek naar vrijetijdsbestedingen','mod','scorm',62,0,NULL,'L0190',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',22,0,NULL,0,0,0,0,1332833065,1332833065),(84,15,15,'8 Werk met google maps','mod','scorm',47,0,NULL,'L0008',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',23,0,NULL,0,0,0,0,1332833065,1332833065),(85,16,NULL,NULL,'course',NULL,16,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,0,1311942892,1332833089),(86,16,16,'163 Straat: Zorg voor je wijk','mod','scorm',69,0,NULL,'L0163',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,NULL,0,0,0,0,1332833089,1332833089),(87,16,16,'164 Speelplek: Zorg voor je wijk','mod','scorm',70,0,NULL,'L0164',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,NULL,0,0,0,0,1332833089,1332833089),(88,16,16,'165 Soorten huizen','mod','scorm',71,0,NULL,'L0165',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,NULL,0,0,0,0,1332833089,1332833089),(89,16,16,'165 Toets Soorten huizen','mod','scorm',72,0,NULL,'L0165T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,NULL,0,0,0,0,1332833089,1332833089),(90,16,16,'166 Buizen door de wijk','mod','scorm',73,0,NULL,'L0166',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,NULL,0,0,0,0,1332833089,1332833089),(91,16,16,'166 Toets Buizen door de wijk','mod','scorm',74,0,NULL,'L0166T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,NULL,0,0,0,0,1332833089,1332833089),(92,16,16,'167 Toets Een huis van vroeger','mod','scorm',76,0,NULL,'L0167T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,NULL,0,0,0,0,1332833089,1332833089),(93,16,16,'168 Een groene en schone wijk','mod','scorm',77,0,NULL,'L0168',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,NULL,0,0,0,0,1332833089,1332833089),(94,16,16,'168 Toets Een groene en schone wijk','mod','scorm',78,0,NULL,'L0168T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,NULL,0,0,0,0,1332833089,1332833089),(95,16,16,'169 Maak de wijk schoon','mod','scorm',79,0,NULL,'L0169',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,NULL,0,0,0,0,1332833089,1332833089),(96,16,16,'171 Teken je huis van binnen en buiten','mod','scorm',80,0,NULL,'L0171',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,NULL,0,0,0,0,1332833089,1332833089),(97,16,16,'172 Schilder samen een straat','mod','scorm',81,0,NULL,'L0172',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,NULL,0,0,0,0,1332833089,1332833089),(98,16,16,'173 Maak samen een speelveld','mod','scorm',82,0,NULL,'L0173',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,NULL,0,0,0,0,1332833090,1332833090),(99,16,16,'210 Een plattegrond lezen','mod','scorm',83,0,NULL,'L0210',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,NULL,0,0,0,0,1332833090,1332833090),(100,16,16,'210 Toets Een plattegrond lezen','mod','scorm',84,0,NULL,'L0210T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,NULL,0,0,0,0,1332833090,1332833090),(101,16,16,'727 Teken het leukste schoolplein','mod','scorm',85,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,NULL,0,0,0,0,1332833090,1332833090),(102,16,16,'167 Een huis van vroeger','mod','scorm',75,0,NULL,'L0167',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,NULL,0,0,0,0,1332833090,1332833090),(103,17,NULL,NULL,'course',NULL,17,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,NULL,0,0,0,1,1311942892,1332837940),(104,17,17,'163 Straat: Zorg voor je wijk','mod','scorm',86,0,NULL,'L0163',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,NULL,0,0,0,1,1332837940,1332837940),(105,17,17,'164 Speelplek: Zorg voor je wijk','mod','scorm',87,0,NULL,'L0164',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,NULL,0,0,0,1,1332837940,1332837940),(106,17,17,'165 Soorten huizen','mod','scorm',88,0,NULL,'L0165',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,NULL,0,0,0,1,1332837940,1332837940),(107,17,17,'165 Toets Soorten huizen','mod','scorm',89,0,NULL,'L0165T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,NULL,0,0,0,1,1332837940,1332837940),(108,17,17,'166 Buizen door de wijk','mod','scorm',90,0,NULL,'L0166',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,NULL,0,0,0,1,1332837940,1332837940),(109,17,17,'166 Toets Buizen door de wijk','mod','scorm',91,0,NULL,'L0166T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,NULL,0,0,0,1,1332837940,1332837940),(110,17,17,'167 Toets Een huis van vroeger','mod','scorm',93,0,NULL,'L0167T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,NULL,0,0,0,1,1332837940,1332837940),(111,17,17,'168 Een groene en schone wijk','mod','scorm',94,0,NULL,'L0168',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,NULL,0,0,0,1,1332837940,1332837940),(112,17,17,'168 Toets Een groene en schone wijk','mod','scorm',95,0,NULL,'L0168T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,NULL,0,0,0,1,1332837940,1332837940),(113,17,17,'169 Maak de wijk schoon','mod','scorm',96,0,NULL,'L0169',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,NULL,0,0,0,1,1332837940,1332837940),(114,17,17,'171 Teken je huis van binnen en buiten','mod','scorm',97,0,NULL,'L0171',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,NULL,0,0,0,1,1332837940,1332837940),(115,17,17,'172 Schilder samen een straat','mod','scorm',98,0,NULL,'L0172',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,NULL,0,0,0,1,1332837940,1332837940),(116,17,17,'173 Maak samen een speelveld','mod','scorm',99,0,NULL,'L0173',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,NULL,0,0,0,1,1332837940,1332837940),(117,17,17,'210 Een plattegrond lezen','mod','scorm',100,0,NULL,'L0210',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,NULL,0,0,0,1,1332837940,1332837940),(118,17,17,'210 Toets Een plattegrond lezen','mod','scorm',101,0,NULL,'L0210T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,NULL,0,0,0,1,1332837940,1332837940),(119,17,17,'727 Teken het leukste schoolplein','mod','scorm',102,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,NULL,0,0,0,1,1332837940,1332837940),(120,17,17,'167 Een huis van vroeger','mod','scorm',92,0,NULL,'L0167',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,NULL,0,0,0,1,1332837940,1332837940);
/*!40000 ALTER TABLE `mdl_grade_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_items_history`
--

DROP TABLE IF EXISTS `mdl_grade_items_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_items_history` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldid` bigint(10) unsigned NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `loggeduser` bigint(10) unsigned DEFAULT NULL,
  `courseid` bigint(10) unsigned DEFAULT NULL,
  `categoryid` bigint(10) unsigned DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `itemtype` varchar(30) NOT NULL DEFAULT '',
  `itemmodule` varchar(30) DEFAULT NULL,
  `iteminstance` bigint(10) unsigned DEFAULT NULL,
  `itemnumber` bigint(10) unsigned DEFAULT NULL,
  `iteminfo` mediumtext,
  `idnumber` varchar(255) DEFAULT NULL,
  `calculation` mediumtext,
  `gradetype` smallint(4) NOT NULL DEFAULT '1',
  `grademax` decimal(10,5) NOT NULL DEFAULT '100.00000',
  `grademin` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `scaleid` bigint(10) unsigned DEFAULT NULL,
  `outcomeid` bigint(10) unsigned DEFAULT NULL,
  `gradepass` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `multfactor` decimal(10,5) NOT NULL DEFAULT '1.00000',
  `plusfactor` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `aggregationcoef` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `sortorder` bigint(10) NOT NULL DEFAULT '0',
  `hidden` bigint(10) NOT NULL DEFAULT '0',
  `locked` bigint(10) NOT NULL DEFAULT '0',
  `locktime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `needsupdate` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_graditemhist_act_ix` (`action`),
  KEY `mdl_graditemhist_old_ix` (`oldid`),
  KEY `mdl_graditemhist_cou_ix` (`courseid`),
  KEY `mdl_graditemhist_cat_ix` (`categoryid`),
  KEY `mdl_graditemhist_sca_ix` (`scaleid`),
  KEY `mdl_graditemhist_out_ix` (`outcomeid`),
  KEY `mdl_graditemhist_log_ix` (`loggeduser`)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='History of grade_items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_items_history`
--

LOCK TABLES `mdl_grade_items_history` WRITE;
/*!40000 ALTER TABLE `mdl_grade_items_history` DISABLE KEYS */;
INSERT INTO `mdl_grade_items_history` VALUES (1,1,1,'system',1324983152,2,1,NULL,NULL,'course',NULL,1,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(2,1,2,'system',1325778549,2,2,NULL,NULL,'course',NULL,2,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(3,1,3,'system',1326105886,2,6,NULL,NULL,'course',NULL,3,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(4,1,4,NULL,1326115093,2,6,3,'Test activity','mod','assignment',1,0,NULL,'',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,0,0,1),(5,1,5,'system',1326975312,2,3,NULL,NULL,'course',NULL,4,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(6,1,6,'system',1328632893,2,11,NULL,NULL,'course',NULL,5,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(7,2,6,'restore',1328632893,2,11,NULL,NULL,'course',NULL,5,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(8,1,7,'system',1328632955,2,12,NULL,NULL,'course',NULL,6,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(9,2,7,'restore',1328632955,2,12,NULL,NULL,'course',NULL,6,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(10,1,8,'system',1328791611,2,4,NULL,NULL,'course',NULL,7,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(11,1,9,'system',1328791611,2,5,NULL,NULL,'course',NULL,8,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(12,1,10,'system',1328791611,2,7,NULL,NULL,'course',NULL,9,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(13,1,11,'system',1328791611,2,8,NULL,NULL,'course',NULL,10,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(14,1,12,'system',1328791612,2,9,NULL,NULL,'course',NULL,11,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(15,1,13,'system',1328791612,2,10,NULL,NULL,'course',NULL,12,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(16,1,14,'system',1332833011,2,13,NULL,NULL,'course',NULL,13,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(17,2,14,'restore',1332833011,2,13,NULL,NULL,'course',NULL,13,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(18,1,15,'restore',1332833011,2,13,13,'193 Wonen in je straat','mod','scorm',1,0,NULL,'L0193',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,0,0,1),(19,1,16,'restore',1332833011,2,13,13,'195 Woorden: Het huis','mod','scorm',2,0,NULL,'L0195',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,0,0,1),(20,1,17,'restore',1332833011,2,13,13,'196 Praatplaat: Soorten huizen','mod','scorm',3,0,NULL,'L0196',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,0,0,1),(21,1,18,'restore',1332833011,2,13,13,'199 Hoek: Huizen bouwen','mod','scorm',4,0,NULL,'L0199',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,0,0,1),(22,1,19,'restore',1332833011,2,13,13,'200 Maak je slaapkamer','mod','scorm',5,0,NULL,'L0200',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,0,0,1),(23,1,20,'restore',1332833011,2,13,13,'201 Woorden: De straat','mod','scorm',6,0,NULL,'L0201',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,0,0,1),(24,1,21,'restore',1332833011,2,13,13,'202 Bewegen: Stoeptegelspellen','mod','scorm',7,0,NULL,'L0202',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,0,0,1),(25,1,22,'restore',1332833011,2,13,13,'203 Doeblad: Houd je straat schoon','mod','scorm',8,0,NULL,'L0203',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,0,0,1),(26,1,23,'restore',1332833011,2,13,13,'205 Ruim de straat op','mod','scorm',9,0,NULL,'L0205',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,0,0,1),(27,1,24,'restore',1332833011,2,13,13,'206 Teken je eigen huis','mod','scorm',10,0,NULL,'L0206',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,0,0,1),(28,1,25,'restore',1332833011,2,13,13,'216 Onder, boven, voor en achter','mod','scorm',11,0,NULL,'L0216',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,0,0,1),(29,1,26,'restore',1332833011,2,13,13,'217 Links en rechts','mod','scorm',12,0,NULL,'L0217',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,0,0,1),(30,1,27,'restore',1332833011,2,13,13,'727 Teken het leukste schoolplein','mod','scorm',13,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,0,0,1),(31,1,28,'system',1332833038,2,14,NULL,NULL,'course',NULL,14,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(32,2,28,'restore',1332833038,2,14,NULL,NULL,'course',NULL,14,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(33,1,29,'restore',1332833038,2,14,14,'170 Doe historisch onderzoek','mod','scorm',20,0,NULL,'L0170',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,0,0,1),(34,1,30,'restore',1332833038,2,14,14,'176 Onderdelen van een kaart','mod','scorm',21,0,NULL,'L0176',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,0,0,1),(35,1,31,'restore',1332833038,2,14,14,'177 Een kaart lezen','mod','scorm',23,0,NULL,'L0177',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,0,0,1),(36,1,32,'restore',1332833038,2,14,14,'178 Opbouw van een stad','mod','scorm',25,0,NULL,'L0178',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,0,0,1),(37,1,33,'restore',1332833038,2,14,14,'179 Soorten kaarten','mod','scorm',27,0,NULL,'L0179',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,0,0,1),(38,1,34,'restore',1332833038,2,14,14,'180 Ontwerp een plein op schaal','mod','scorm',29,0,NULL,'L0180',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,0,0,1),(39,1,35,'restore',1332833038,2,14,14,'185 Taken van de gemeente','mod','scorm',30,0,NULL,'L0185',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,0,0,1),(40,1,36,'restore',1332833038,2,14,14,'186 Ruimtelijke ordening','mod','scorm',32,0,NULL,'L0186',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,0,0,1),(41,1,37,'restore',1332833038,2,14,14,'187 Historisch onderzoek: Ontwikkeling van je gemeente','mod','scorm',34,0,NULL,'L0187',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,0,0,1),(42,1,38,'restore',1332833038,2,14,14,'188 Pleinontwerp: Ontwikkeling van je gemeente','mod','scorm',35,0,NULL,'L0188',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,0,0,1),(43,1,39,'restore',1332833038,2,14,14,'189 Verstedelijking van Nederland','mod','scorm',36,0,NULL,'L0189',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,0,0,1),(44,1,40,'restore',1332833038,2,14,14,'191 Ontstaan van dorpen','mod','scorm',38,0,NULL,'L0191',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,0,0,1),(45,1,41,'restore',1332833038,2,14,14,'192 Ontstaan van steden','mod','scorm',40,0,NULL,'L0192',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,0,0,1),(46,1,42,'restore',1332833038,2,14,14,'208 Houd een enquete','mod','scorm',42,0,NULL,'L0208',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,0,0,1),(47,1,43,'restore',1332833038,2,14,14,'727 Teken het leukste schoolplein','mod','scorm',46,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,0,0,1),(48,1,44,'restore',1332833038,2,14,14,'211 Maak samen een nieuwe wijk','mod','scorm',45,0,NULL,'L0211',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,0,0,1),(49,1,45,'restore',1332833038,2,14,14,'176 Toets Onderdelen van een kaart','mod','scorm',22,0,NULL,'L0176T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,0,0,1),(50,1,46,'restore',1332833038,2,14,14,'177 Toets Een kaart lezen','mod','scorm',24,0,NULL,'L0177T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',19,0,0,0,1),(51,1,47,'restore',1332833038,2,14,14,'178 Toets Opbouw van een stad','mod','scorm',26,0,NULL,'L0178T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',20,0,0,0,1),(52,1,48,'restore',1332833038,2,14,14,'179 Toets Soorten kaarten','mod','scorm',28,0,NULL,'L0179T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',21,0,0,0,1),(53,1,49,'restore',1332833038,2,14,14,'185 Toets Taken van de gemeente','mod','scorm',31,0,NULL,'L0185T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',22,0,0,0,1),(54,1,50,'restore',1332833038,2,14,14,'186 Toets Ruimtelijke ordening','mod','scorm',33,0,NULL,'L0186T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',23,0,0,0,1),(55,1,51,'restore',1332833038,2,14,14,'189 Toets Verstedelijking van Nederland','mod','scorm',37,0,NULL,'L0189T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',24,0,0,0,1),(56,1,52,'restore',1332833038,2,14,14,'191 Toets Ontstaan van dorpen','mod','scorm',39,0,NULL,'L0191T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',25,0,0,0,1),(57,1,53,'restore',1332833038,2,14,14,'192 Toets Ontstaan van steden','mod','scorm',41,0,NULL,'L0192T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',26,0,0,0,1),(58,1,54,'restore',1332833038,2,14,14,'209 Toets Ontwikkeling van toerisme','mod','scorm',44,0,NULL,'L0209T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',27,0,0,0,1),(59,1,55,'restore',1332833038,2,14,14,'209 Ontwikkeling van toerisme','mod','scorm',43,0,NULL,'L0209',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',28,0,0,0,1),(60,1,56,'restore',1332833038,2,14,14,'8 Werk met google maps','mod','scorm',16,0,NULL,'L0008',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',29,0,0,0,1),(61,1,57,'restore',1332833038,2,14,14,'9 Rekenen met schaal','mod','scorm',17,0,NULL,'L0009',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',30,0,0,0,1),(62,1,58,'restore',1332833038,2,14,14,'9 Toets Rekenen met schaal','mod','scorm',18,0,NULL,'L0009T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',31,0,0,0,1),(63,1,59,'restore',1332833038,2,14,14,'7 Voorzieningen voor iedereen','mod','scorm',14,0,NULL,'L0007',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',32,0,0,0,1),(64,1,60,'restore',1332833038,2,14,14,'7 Toets Voorzieningen voor iedereen','mod','scorm',15,0,NULL,'L0007T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',33,0,0,0,1),(65,1,61,'restore',1332833038,2,14,14,'111 Houd een interview','mod','scorm',19,0,NULL,'L0111',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',34,0,0,0,1),(66,1,62,'system',1332833065,2,15,NULL,NULL,'course',NULL,15,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(67,2,62,'restore',1332833065,2,15,NULL,NULL,'course',NULL,15,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(68,1,63,'restore',1332833065,2,15,15,'174 Rondleiding: Vrije tijd in je buurt','mod','scorm',48,0,NULL,'L0174',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,0,0,1),(69,1,64,'restore',1332833065,2,15,15,'175 Plein: Vrije tijd in je buurt','mod','scorm',49,0,NULL,'L0175',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,0,0,1),(70,1,65,'restore',1332833065,2,15,15,'176 Onderdelen van een kaart','mod','scorm',50,0,NULL,'L0176',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,0,0,1),(71,1,66,'restore',1332833065,2,15,15,'176 Toets Onderdelen van een kaart','mod','scorm',51,0,NULL,'L0176T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,0,0,1),(72,1,67,'restore',1332833065,2,15,15,'177 Een kaart lezen','mod','scorm',52,0,NULL,'L0177',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,0,0,1),(73,1,68,'restore',1332833065,2,15,15,'177 Toets Een kaart lezen','mod','scorm',53,0,NULL,'L0177T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,0,0,1),(74,1,69,'restore',1332833065,2,15,15,'181 Openbare speelruimtes','mod','scorm',56,0,NULL,'L0181',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,0,0,1),(75,1,70,'restore',1332833065,2,15,15,'181 Toets Openbare speelruimtes','mod','scorm',57,0,NULL,'L0181T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,0,0,1),(76,1,71,'restore',1332833065,2,15,15,'182 Soorten vrijetijdsbestedingen','mod','scorm',58,0,NULL,'L0182',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,0,0,1),(77,1,72,'restore',1332833065,2,15,15,'182 Toets Soorten vrijetijdsbestedingen','mod','scorm',59,0,NULL,'L0182T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,0,0,1),(78,1,73,'restore',1332833065,2,15,15,'183 Maak een rondleiding','mod','scorm',60,0,NULL,'L0183',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,0,0,1),(79,1,74,'restore',1332833065,2,15,15,'184 Ontwerp een speelplein','mod','scorm',61,0,NULL,'L0184',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,0,0,1),(80,1,75,'restore',1332833065,2,15,15,'207 Leven in een middeleeuwse stad','mod','scorm',63,0,NULL,'L0207',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,0,0,1),(81,1,76,'restore',1332833065,2,15,15,'207 Toets Leven in een middeleeuwse stad','mod','scorm',64,0,NULL,'L0207T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,0,0,1),(82,1,77,'restore',1332833065,2,15,15,'211 Maak samen een nieuwe wijk','mod','scorm',65,0,NULL,'L0211',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,0,0,1),(83,1,78,'restore',1332833065,2,15,15,'218 Toerisme in Nederland','mod','scorm',66,0,NULL,'L0218',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,0,0,1),(84,1,79,'restore',1332833065,2,15,15,'218 Toets Toerisme in Nederland','mod','scorm',67,0,NULL,'L0218T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,0,0,1),(85,1,80,'restore',1332833065,2,15,15,'727 Teken het leukste schoolplein','mod','scorm',68,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',19,0,0,0,1),(86,1,81,'restore',1332833065,2,15,15,'179 Soorten kaarten','mod','scorm',54,0,NULL,'L0179',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',20,0,0,0,1),(87,1,82,'restore',1332833065,2,15,15,'179 Toets Soorten kaarten','mod','scorm',55,0,NULL,'L0179T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',21,0,0,0,1),(88,1,83,'restore',1332833065,2,15,15,'190 Zoek naar vrijetijdsbestedingen','mod','scorm',62,0,NULL,'L0190',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',22,0,0,0,1),(89,1,84,'restore',1332833065,2,15,15,'8 Werk met google maps','mod','scorm',47,0,NULL,'L0008',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',23,0,0,0,1),(90,1,85,'system',1332833089,2,16,NULL,NULL,'course',NULL,16,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(91,2,85,'restore',1332833089,2,16,NULL,NULL,'course',NULL,16,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(92,1,86,'restore',1332833089,2,16,16,'163 Straat: Zorg voor je wijk','mod','scorm',69,0,NULL,'L0163',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,0,0,1),(93,1,87,'restore',1332833089,2,16,16,'164 Speelplek: Zorg voor je wijk','mod','scorm',70,0,NULL,'L0164',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,0,0,1),(94,1,88,'restore',1332833089,2,16,16,'165 Soorten huizen','mod','scorm',71,0,NULL,'L0165',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,0,0,1),(95,1,89,'restore',1332833089,2,16,16,'165 Toets Soorten huizen','mod','scorm',72,0,NULL,'L0165T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,0,0,1),(96,1,90,'restore',1332833089,2,16,16,'166 Buizen door de wijk','mod','scorm',73,0,NULL,'L0166',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,0,0,1),(97,1,91,'restore',1332833089,2,16,16,'166 Toets Buizen door de wijk','mod','scorm',74,0,NULL,'L0166T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,0,0,1),(98,1,92,'restore',1332833089,2,16,16,'167 Toets Een huis van vroeger','mod','scorm',76,0,NULL,'L0167T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,0,0,1),(99,1,93,'restore',1332833089,2,16,16,'168 Een groene en schone wijk','mod','scorm',77,0,NULL,'L0168',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,0,0,1),(100,1,94,'restore',1332833089,2,16,16,'168 Toets Een groene en schone wijk','mod','scorm',78,0,NULL,'L0168T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,0,0,1),(101,1,95,'restore',1332833089,2,16,16,'169 Maak de wijk schoon','mod','scorm',79,0,NULL,'L0169',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,0,0,1),(102,1,96,'restore',1332833089,2,16,16,'171 Teken je huis van binnen en buiten','mod','scorm',80,0,NULL,'L0171',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,0,0,1),(103,1,97,'restore',1332833089,2,16,16,'172 Schilder samen een straat','mod','scorm',81,0,NULL,'L0172',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,0,0,1),(104,1,98,'restore',1332833090,2,16,16,'173 Maak samen een speelveld','mod','scorm',82,0,NULL,'L0173',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,0,0,1),(105,1,99,'restore',1332833090,2,16,16,'210 Een plattegrond lezen','mod','scorm',83,0,NULL,'L0210',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,0,0,1),(106,1,100,'restore',1332833090,2,16,16,'210 Toets Een plattegrond lezen','mod','scorm',84,0,NULL,'L0210T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,0,0,1),(107,1,101,'restore',1332833090,2,16,16,'727 Teken het leukste schoolplein','mod','scorm',85,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,0,0,1),(108,1,102,'restore',1332833090,2,16,16,'167 Een huis van vroeger','mod','scorm',75,0,NULL,'L0167',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,0,0,1),(109,1,103,'system',1332837940,2,17,NULL,NULL,'course',NULL,17,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(110,2,103,'restore',1332837940,2,17,NULL,NULL,'course',NULL,17,NULL,NULL,NULL,NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',1,0,0,0,1),(111,1,104,'restore',1332837940,2,17,17,'163 Straat: Zorg voor je wijk','mod','scorm',86,0,NULL,'L0163',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',2,0,0,0,1),(112,1,105,'restore',1332837940,2,17,17,'164 Speelplek: Zorg voor je wijk','mod','scorm',87,0,NULL,'L0164',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',3,0,0,0,1),(113,1,106,'restore',1332837940,2,17,17,'165 Soorten huizen','mod','scorm',88,0,NULL,'L0165',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',4,0,0,0,1),(114,1,107,'restore',1332837940,2,17,17,'165 Toets Soorten huizen','mod','scorm',89,0,NULL,'L0165T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',5,0,0,0,1),(115,1,108,'restore',1332837940,2,17,17,'166 Buizen door de wijk','mod','scorm',90,0,NULL,'L0166',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',6,0,0,0,1),(116,1,109,'restore',1332837940,2,17,17,'166 Toets Buizen door de wijk','mod','scorm',91,0,NULL,'L0166T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',7,0,0,0,1),(117,1,110,'restore',1332837940,2,17,17,'167 Toets Een huis van vroeger','mod','scorm',93,0,NULL,'L0167T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',8,0,0,0,1),(118,1,111,'restore',1332837940,2,17,17,'168 Een groene en schone wijk','mod','scorm',94,0,NULL,'L0168',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',9,0,0,0,1),(119,1,112,'restore',1332837940,2,17,17,'168 Toets Een groene en schone wijk','mod','scorm',95,0,NULL,'L0168T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',10,0,0,0,1),(120,1,113,'restore',1332837940,2,17,17,'169 Maak de wijk schoon','mod','scorm',96,0,NULL,'L0169',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',11,0,0,0,1),(121,1,114,'restore',1332837940,2,17,17,'171 Teken je huis van binnen en buiten','mod','scorm',97,0,NULL,'L0171',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',12,0,0,0,1),(122,1,115,'restore',1332837940,2,17,17,'172 Schilder samen een straat','mod','scorm',98,0,NULL,'L0172',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',13,0,0,0,1),(123,1,116,'restore',1332837940,2,17,17,'173 Maak samen een speelveld','mod','scorm',99,0,NULL,'L0173',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',14,0,0,0,1),(124,1,117,'restore',1332837940,2,17,17,'210 Een plattegrond lezen','mod','scorm',100,0,NULL,'L0210',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',15,0,0,0,1),(125,1,118,'restore',1332837940,2,17,17,'210 Toets Een plattegrond lezen','mod','scorm',101,0,NULL,'L0210T',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',16,0,0,0,1),(126,1,119,'restore',1332837940,2,17,17,'727 Teken het leukste schoolplein','mod','scorm',102,0,NULL,'L0727',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',17,0,0,0,1),(127,1,120,'restore',1332837940,2,17,17,'167 Een huis van vroeger','mod','scorm',92,0,NULL,'L0167',NULL,1,'100.00000','0.00000',NULL,NULL,'0.00000','1.00000','0.00000','0.00000',18,0,0,0,1);
/*!40000 ALTER TABLE `mdl_grade_items_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_letters`
--

DROP TABLE IF EXISTS `mdl_grade_letters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_letters` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `lowerboundary` decimal(10,5) NOT NULL,
  `letter` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_gradlett_conlow_ix` (`contextid`,`lowerboundary`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Repository for grade letters, for courses and other moodle e';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_letters`
--

LOCK TABLES `mdl_grade_letters` WRITE;
/*!40000 ALTER TABLE `mdl_grade_letters` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_letters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_outcomes`
--

DROP TABLE IF EXISTS `mdl_grade_outcomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_outcomes` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned DEFAULT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `fullname` text NOT NULL,
  `scaleid` bigint(10) unsigned DEFAULT NULL,
  `description` text,
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `usermodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradoutc_cousho_uix` (`courseid`,`shortname`),
  KEY `mdl_gradoutc_cou_ix` (`courseid`),
  KEY `mdl_gradoutc_sca_ix` (`scaleid`),
  KEY `mdl_gradoutc_use_ix` (`usermodified`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='This table describes the outcomes used in the system. An out';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_outcomes`
--

LOCK TABLES `mdl_grade_outcomes` WRITE;
/*!40000 ALTER TABLE `mdl_grade_outcomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_outcomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_outcomes_courses`
--

DROP TABLE IF EXISTS `mdl_grade_outcomes_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_outcomes_courses` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `outcomeid` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradoutccour_couout_uix` (`courseid`,`outcomeid`),
  KEY `mdl_gradoutccour_cou_ix` (`courseid`),
  KEY `mdl_gradoutccour_out_ix` (`outcomeid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='stores what outcomes are used in what courses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_outcomes_courses`
--

LOCK TABLES `mdl_grade_outcomes_courses` WRITE;
/*!40000 ALTER TABLE `mdl_grade_outcomes_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_outcomes_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_outcomes_history`
--

DROP TABLE IF EXISTS `mdl_grade_outcomes_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_outcomes_history` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldid` bigint(10) unsigned NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `loggeduser` bigint(10) unsigned DEFAULT NULL,
  `courseid` bigint(10) unsigned DEFAULT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `fullname` text NOT NULL,
  `scaleid` bigint(10) unsigned DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `mdl_gradoutchist_act_ix` (`action`),
  KEY `mdl_gradoutchist_old_ix` (`oldid`),
  KEY `mdl_gradoutchist_cou_ix` (`courseid`),
  KEY `mdl_gradoutchist_sca_ix` (`scaleid`),
  KEY `mdl_gradoutchist_log_ix` (`loggeduser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='History table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_outcomes_history`
--

LOCK TABLES `mdl_grade_outcomes_history` WRITE;
/*!40000 ALTER TABLE `mdl_grade_outcomes_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_outcomes_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_grade_settings`
--

DROP TABLE IF EXISTS `mdl_grade_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_grade_settings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradsett_counam_uix` (`courseid`,`name`),
  KEY `mdl_gradsett_cou_ix` (`courseid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='gradebook settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_grade_settings`
--

LOCK TABLES `mdl_grade_settings` WRITE;
/*!40000 ALTER TABLE `mdl_grade_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_grade_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_groupings`
--

DROP TABLE IF EXISTS `mdl_groupings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_groupings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `configdata` text,
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_grou_cou2_ix` (`courseid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='A grouping is a collection of groups. WAS: groups_groupings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_groupings`
--

LOCK TABLES `mdl_groupings` WRITE;
/*!40000 ALTER TABLE `mdl_groupings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_groupings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_groupings_groups`
--

DROP TABLE IF EXISTS `mdl_groupings_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_groupings_groups` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupingid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeadded` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_grougrou_gro_ix` (`groupingid`),
  KEY `mdl_grougrou_gro2_ix` (`groupid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Link a grouping to a group (note, groups can be in multiple ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_groupings_groups`
--

LOCK TABLES `mdl_groupings_groups` WRITE;
/*!40000 ALTER TABLE `mdl_groupings_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_groupings_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_groups`
--

DROP TABLE IF EXISTS `mdl_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_groups` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `name` varchar(254) NOT NULL DEFAULT '',
  `description` text,
  `enrolmentkey` varchar(50) DEFAULT NULL,
  `picture` bigint(10) unsigned NOT NULL DEFAULT '0',
  `hidepicture` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_grou_cou_ix` (`courseid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Each record represents a group.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_groups`
--

LOCK TABLES `mdl_groups` WRITE;
/*!40000 ALTER TABLE `mdl_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_groups_members`
--

DROP TABLE IF EXISTS `mdl_groups_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_groups_members` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeadded` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_groumemb_gro_ix` (`groupid`),
  KEY `mdl_groumemb_use_ix` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Link a user to a group.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_groups_members`
--

LOCK TABLES `mdl_groups_members` WRITE;
/*!40000 ALTER TABLE `mdl_groups_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_groups_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_hotpot`
--

DROP TABLE IF EXISTS `mdl_hotpot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_hotpot` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `summary` text NOT NULL,
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `location` smallint(4) unsigned NOT NULL DEFAULT '0',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `outputformat` smallint(4) unsigned NOT NULL DEFAULT '1',
  `navigation` smallint(4) unsigned NOT NULL DEFAULT '1',
  `studentfeedback` smallint(4) unsigned NOT NULL DEFAULT '0',
  `studentfeedbackurl` varchar(255) NOT NULL DEFAULT '',
  `forceplugins` smallint(4) unsigned NOT NULL DEFAULT '0',
  `shownextquiz` smallint(4) unsigned NOT NULL DEFAULT '0',
  `review` smallint(4) NOT NULL DEFAULT '0',
  `grade` bigint(10) NOT NULL DEFAULT '0',
  `grademethod` smallint(4) NOT NULL DEFAULT '1',
  `attempts` mediumint(6) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `clickreporting` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='details about Hot Potatoes quizzes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_hotpot`
--

LOCK TABLES `mdl_hotpot` WRITE;
/*!40000 ALTER TABLE `mdl_hotpot` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_hotpot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_hotpot_attempts`
--

DROP TABLE IF EXISTS `mdl_hotpot_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_hotpot_attempts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hotpot` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `starttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `endtime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `score` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `penalties` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `attempt` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `status` smallint(4) unsigned NOT NULL DEFAULT '1',
  `clickreportid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_hotpatte_use_ix` (`userid`),
  KEY `mdl_hotpatte_hot_ix` (`hotpot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='details about Hot Potatoes quiz attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_hotpot_attempts`
--

LOCK TABLES `mdl_hotpot_attempts` WRITE;
/*!40000 ALTER TABLE `mdl_hotpot_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_hotpot_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_hotpot_details`
--

DROP TABLE IF EXISTS `mdl_hotpot_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_hotpot_details` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attempt` bigint(10) unsigned NOT NULL DEFAULT '0',
  `details` text,
  PRIMARY KEY (`id`),
  KEY `mdl_hotpdeta_att_ix` (`attempt`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='raw details (as XML) of Hot Potatoes quiz attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_hotpot_details`
--

LOCK TABLES `mdl_hotpot_details` WRITE;
/*!40000 ALTER TABLE `mdl_hotpot_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_hotpot_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_hotpot_questions`
--

DROP TABLE IF EXISTS `mdl_hotpot_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_hotpot_questions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `type` smallint(4) unsigned NOT NULL DEFAULT '0',
  `text` bigint(10) unsigned NOT NULL DEFAULT '0',
  `hotpot` bigint(10) unsigned NOT NULL DEFAULT '0',
  `md5key` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_hotpques_md5_ix` (`md5key`),
  KEY `mdl_hotpques_hot_ix` (`hotpot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='details about questions in Hot Potatoes quiz attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_hotpot_questions`
--

LOCK TABLES `mdl_hotpot_questions` WRITE;
/*!40000 ALTER TABLE `mdl_hotpot_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_hotpot_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_hotpot_responses`
--

DROP TABLE IF EXISTS `mdl_hotpot_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_hotpot_responses` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attempt` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `score` mediumint(6) NOT NULL DEFAULT '0',
  `weighting` mediumint(6) NOT NULL DEFAULT '0',
  `correct` varchar(255) NOT NULL DEFAULT '',
  `wrong` varchar(255) NOT NULL DEFAULT '',
  `ignored` varchar(255) NOT NULL DEFAULT '',
  `hints` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `clues` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `checks` mediumint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_hotpresp_att_ix` (`attempt`),
  KEY `mdl_hotpresp_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='details about responses in Hot Potatoes quiz attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_hotpot_responses`
--

LOCK TABLES `mdl_hotpot_responses` WRITE;
/*!40000 ALTER TABLE `mdl_hotpot_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_hotpot_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_hotpot_strings`
--

DROP TABLE IF EXISTS `mdl_hotpot_strings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_hotpot_strings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `string` text NOT NULL,
  `md5key` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_hotpstri_md5_ix` (`md5key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='strings used in Hot Potatoes questions and responses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_hotpot_strings`
--

LOCK TABLES `mdl_hotpot_strings` WRITE;
/*!40000 ALTER TABLE `mdl_hotpot_strings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_hotpot_strings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_journal`
--

DROP TABLE IF EXISTS `mdl_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_journal` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` tinyint(2) NOT NULL DEFAULT '0',
  `days` mediumint(5) unsigned NOT NULL DEFAULT '7',
  `assessed` bigint(10) NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_jour_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='data for each journal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_journal`
--

LOCK TABLES `mdl_journal` WRITE;
/*!40000 ALTER TABLE `mdl_journal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_journal_entries`
--

DROP TABLE IF EXISTS `mdl_journal_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_journal_entries` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `journal` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `format` tinyint(2) NOT NULL DEFAULT '0',
  `rating` bigint(10) DEFAULT '0',
  `entrycomment` text,
  `teacher` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemarked` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_jourentr_use_ix` (`userid`),
  KEY `mdl_jourentr_jou_ix` (`journal`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='All the journal entries of all people';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_journal_entries`
--

LOCK TABLES `mdl_journal_entries` WRITE;
/*!40000 ALTER TABLE `mdl_journal_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_journal_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_label`
--

DROP TABLE IF EXISTS `mdl_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_label` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_labe_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Defines labels';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_label`
--

LOCK TABLES `mdl_label` WRITE;
/*!40000 ALTER TABLE `mdl_label` DISABLE KEYS */;
INSERT INTO `mdl_label` VALUES (1,13,'Periode 1','Periode 1',1314006527),(2,13,'Periode 3','Periode 3',1312800636),(3,14,'Periode 1','Periode 1',1312801298),(4,14,'Periode 1 of 2','Periode 1 of 2',1312801404),(5,14,'Periode 2','Periode 2',1312801452),(6,15,'Periode 1 of 2','Periode 1 of 2',1312801095),(7,15,'Periode 2','Periode 2',1312801140),(8,16,'Periode 1','Periode 1',1312800671),(9,16,'Periode 2','Periode 2',1312800858),(10,16,'Periode 3','Periode 3',1312800979),(11,17,'Periode 1','Periode 1',1312800671),(12,17,'Periode 2','Periode 2',1312800858),(13,17,'Periode 3','Periode 3',1312800979);
/*!40000 ALTER TABLE `mdl_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lams`
--

DROP TABLE IF EXISTS `mdl_lams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lams` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `introduction` text NOT NULL,
  `learning_session_id` bigint(20) DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lams_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='LAMS activity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lams`
--

LOCK TABLES `mdl_lams` WRITE;
/*!40000 ALTER TABLE `mdl_lams` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_launcher`
--

DROP TABLE IF EXISTS `mdl_launcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_launcher` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` mediumtext,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `average_loadtime` double DEFAULT '0',
  `installed` bigint(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_laun_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Default comment for launcher, please edit me';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_launcher`
--

LOCK TABLES `mdl_launcher` WRITE;
/*!40000 ALTER TABLE `mdl_launcher` DISABLE KEYS */;
INSERT INTO `mdl_launcher` VALUES (1,1,'Launcher',NULL,0,0,0,0,0);
/*!40000 ALTER TABLE `mdl_launcher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_launcher_moodles`
--

DROP TABLE IF EXISTS `mdl_launcher_moodles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_launcher_moodles` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT NULL,
  `admin_email` varchar(100) NOT NULL DEFAULT '',
  `domain` varchar(100) NOT NULL DEFAULT '',
  `server_name` varchar(100) NOT NULL DEFAULT '',
  `launcher_id` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Known current moodle environments.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_launcher_moodles`
--

LOCK TABLES `mdl_launcher_moodles` WRITE;
/*!40000 ALTER TABLE `mdl_launcher_moodles` DISABLE KEYS */;
INSERT INTO `mdl_launcher_moodles` VALUES (35,'jeelotarget1','jeelotarget1','','m.deridder@solin.nl','jeelotarget1.jeelo.nl','localhost',3);
/*!40000 ALTER TABLE `mdl_launcher_moodles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson`
--

DROP TABLE IF EXISTS `mdl_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `practice` smallint(3) unsigned NOT NULL DEFAULT '0',
  `modattempts` smallint(3) unsigned NOT NULL DEFAULT '0',
  `usepassword` smallint(3) unsigned NOT NULL DEFAULT '0',
  `password` varchar(32) NOT NULL DEFAULT '',
  `dependency` bigint(10) unsigned NOT NULL DEFAULT '0',
  `conditions` text NOT NULL,
  `grade` smallint(3) NOT NULL DEFAULT '0',
  `custom` smallint(3) unsigned NOT NULL DEFAULT '0',
  `ongoing` smallint(3) unsigned NOT NULL DEFAULT '0',
  `usemaxgrade` smallint(3) NOT NULL DEFAULT '0',
  `maxanswers` smallint(3) unsigned NOT NULL DEFAULT '4',
  `maxattempts` smallint(3) unsigned NOT NULL DEFAULT '5',
  `review` smallint(3) unsigned NOT NULL DEFAULT '0',
  `nextpagedefault` smallint(3) unsigned NOT NULL DEFAULT '0',
  `feedback` smallint(3) unsigned NOT NULL DEFAULT '1',
  `minquestions` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxpages` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timed` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxtime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `retake` smallint(3) unsigned NOT NULL DEFAULT '1',
  `activitylink` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mediafile` varchar(255) NOT NULL DEFAULT '',
  `mediaheight` bigint(10) unsigned NOT NULL DEFAULT '100',
  `mediawidth` bigint(10) unsigned NOT NULL DEFAULT '650',
  `mediaclose` smallint(3) unsigned NOT NULL DEFAULT '0',
  `slideshow` smallint(3) unsigned NOT NULL DEFAULT '0',
  `width` bigint(10) unsigned NOT NULL DEFAULT '640',
  `height` bigint(10) unsigned NOT NULL DEFAULT '480',
  `bgcolor` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `displayleft` smallint(3) unsigned NOT NULL DEFAULT '0',
  `displayleftif` smallint(3) unsigned NOT NULL DEFAULT '0',
  `progressbar` smallint(3) unsigned NOT NULL DEFAULT '0',
  `highscores` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxhighscores` bigint(10) unsigned NOT NULL DEFAULT '0',
  `available` bigint(10) unsigned NOT NULL DEFAULT '0',
  `deadline` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_less_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines lesson';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson`
--

LOCK TABLES `mdl_lesson` WRITE;
/*!40000 ALTER TABLE `mdl_lesson` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_answers`
--

DROP TABLE IF EXISTS `mdl_lesson_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `jumpto` bigint(11) NOT NULL DEFAULT '0',
  `grade` smallint(3) unsigned NOT NULL DEFAULT '0',
  `score` bigint(10) NOT NULL DEFAULT '0',
  `flags` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` text,
  `response` text,
  PRIMARY KEY (`id`),
  KEY `mdl_lessansw_les_ix` (`lessonid`),
  KEY `mdl_lessansw_pag_ix` (`pageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines lesson_answers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_answers`
--

LOCK TABLES `mdl_lesson_answers` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_attempts`
--

DROP TABLE IF EXISTS `mdl_lesson_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_attempts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answerid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `retry` smallint(3) unsigned NOT NULL DEFAULT '0',
  `correct` bigint(10) unsigned NOT NULL DEFAULT '0',
  `useranswer` text,
  `timeseen` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lessatte_use_ix` (`userid`),
  KEY `mdl_lessatte_les_ix` (`lessonid`),
  KEY `mdl_lessatte_pag_ix` (`pageid`),
  KEY `mdl_lessatte_ans_ix` (`answerid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines lesson_attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_attempts`
--

LOCK TABLES `mdl_lesson_attempts` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_branch`
--

DROP TABLE IF EXISTS `mdl_lesson_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_branch` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `retry` bigint(10) unsigned NOT NULL DEFAULT '0',
  `flag` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timeseen` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lessbran_use_ix` (`userid`),
  KEY `mdl_lessbran_les_ix` (`lessonid`),
  KEY `mdl_lessbran_pag_ix` (`pageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='branches for each lesson/user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_branch`
--

LOCK TABLES `mdl_lesson_branch` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_default`
--

DROP TABLE IF EXISTS `mdl_lesson_default`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_default` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `practice` smallint(3) unsigned NOT NULL DEFAULT '0',
  `modattempts` smallint(3) unsigned NOT NULL DEFAULT '0',
  `usepassword` smallint(3) unsigned NOT NULL DEFAULT '0',
  `password` varchar(32) NOT NULL DEFAULT '',
  `conditions` text NOT NULL,
  `grade` smallint(3) NOT NULL DEFAULT '0',
  `custom` smallint(3) unsigned NOT NULL DEFAULT '0',
  `ongoing` smallint(3) unsigned NOT NULL DEFAULT '0',
  `usemaxgrade` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxanswers` smallint(3) unsigned NOT NULL DEFAULT '4',
  `maxattempts` smallint(3) unsigned NOT NULL DEFAULT '5',
  `review` smallint(3) unsigned NOT NULL DEFAULT '0',
  `nextpagedefault` smallint(3) unsigned NOT NULL DEFAULT '0',
  `feedback` smallint(3) unsigned NOT NULL DEFAULT '1',
  `minquestions` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxpages` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timed` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxtime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `retake` smallint(3) unsigned NOT NULL DEFAULT '1',
  `mediaheight` bigint(10) unsigned NOT NULL DEFAULT '100',
  `mediawidth` bigint(10) unsigned NOT NULL DEFAULT '650',
  `mediaclose` smallint(3) unsigned NOT NULL DEFAULT '0',
  `slideshow` smallint(3) unsigned NOT NULL DEFAULT '0',
  `width` bigint(10) unsigned NOT NULL DEFAULT '640',
  `height` bigint(10) unsigned NOT NULL DEFAULT '480',
  `bgcolor` varchar(7) DEFAULT '#FFFFFF',
  `displayleft` smallint(3) unsigned NOT NULL DEFAULT '0',
  `displayleftif` smallint(3) unsigned NOT NULL DEFAULT '0',
  `progressbar` smallint(3) unsigned NOT NULL DEFAULT '0',
  `highscores` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxhighscores` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines lesson_default';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_default`
--

LOCK TABLES `mdl_lesson_default` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_default` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_default` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_grades`
--

DROP TABLE IF EXISTS `mdl_lesson_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` double unsigned NOT NULL DEFAULT '0',
  `late` smallint(3) unsigned NOT NULL DEFAULT '0',
  `completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lessgrad_use_ix` (`userid`),
  KEY `mdl_lessgrad_les_ix` (`lessonid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines lesson_grades';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_grades`
--

LOCK TABLES `mdl_lesson_grades` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_high_scores`
--

DROP TABLE IF EXISTS `mdl_lesson_high_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_high_scores` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `gradeid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(5) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_lesshighscor_use_ix` (`userid`),
  KEY `mdl_lesshighscor_les_ix` (`lessonid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='high scores for each lesson';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_high_scores`
--

LOCK TABLES `mdl_lesson_high_scores` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_high_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_high_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_pages`
--

DROP TABLE IF EXISTS `mdl_lesson_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_pages` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `prevpageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `nextpageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `qtype` smallint(3) unsigned NOT NULL DEFAULT '0',
  `qoption` smallint(3) unsigned NOT NULL DEFAULT '0',
  `layout` smallint(3) unsigned NOT NULL DEFAULT '1',
  `display` smallint(3) unsigned NOT NULL DEFAULT '1',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `contents` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_lesspage_les_ix` (`lessonid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines lesson_pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_pages`
--

LOCK TABLES `mdl_lesson_pages` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_lesson_timer`
--

DROP TABLE IF EXISTS `mdl_lesson_timer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_lesson_timer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `starttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lessontime` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lesstime_use_ix` (`userid`),
  KEY `mdl_lesstime_les_ix` (`lessonid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='lesson timer for each lesson';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_lesson_timer`
--

LOCK TABLES `mdl_lesson_timer` WRITE;
/*!40000 ALTER TABLE `mdl_lesson_timer` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_lesson_timer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_log`
--

DROP TABLE IF EXISTS `mdl_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `module` varchar(20) NOT NULL DEFAULT '',
  `cmid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `action` varchar(40) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL DEFAULT '',
  `info` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_log_coumodact_ix` (`course`,`module`,`action`),
  KEY `mdl_log_tim_ix` (`time`),
  KEY `mdl_log_act_ix` (`action`),
  KEY `mdl_log_usecou_ix` (`userid`,`course`),
  KEY `mdl_log_cmi_ix` (`cmid`)
) ENGINE=MyISAM AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COMMENT='Every action is logged as far as possible';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_log`
--

LOCK TABLES `mdl_log` WRITE;
/*!40000 ALTER TABLE `mdl_log` DISABLE KEYS */;
INSERT INTO `mdl_log` VALUES (1,1323877094,2,'127.0.0.1',1,'user',0,'update','view.php?id=2&course=1',''),(2,1323877282,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(3,1324977671,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(4,1324977672,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(5,1324979827,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(6,1324979827,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(7,1324980904,2,'0.0.0.0',1,'course',0,'new','view.php?id=2','Course Fullname 101 (ID 2)'),(8,1324980908,2,'0.0.0.0',2,'course',0,'view','view.php?id=2','2'),(9,1324980909,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(10,1324980934,2,'0.0.0.0',1,'course',0,'new','view.php?id=3','Course Fullname 102 (ID 3)'),(11,1324980936,2,'0.0.0.0',3,'course',0,'view','view.php?id=3','3'),(12,1324981272,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(13,1324981364,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(14,1324981369,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(15,1324981369,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(16,1324981672,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(17,1324981698,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(18,1324981716,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(19,1324981904,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(20,1324981917,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(21,1324982035,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(22,1324982042,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(23,1324982066,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(24,1324982114,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(25,1324982133,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(26,1324982288,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(27,1324982379,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(28,1324983194,2,'0.0.0.0',1,'course',0,'add mod','../mod/launcher/view.php?id=3','launcher 1'),(29,1324983194,2,'0.0.0.0',1,'launcher',3,'add','view.php?id=3','1'),(30,1324983194,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(31,1324983194,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(32,1324983866,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(33,1324992853,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(34,1324992853,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(35,1324992869,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(36,1324996401,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(37,1325070927,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(38,1325070928,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(39,1325496915,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(40,1325496915,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(41,1325497703,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(42,1325513832,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(43,1325513832,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(44,1325514079,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(45,1325514079,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(46,1325514386,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(47,1325514390,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(48,1325514391,2,'0.0.0.0',1,'user',0,'logout','view.php?id=2&course=1','2'),(49,1325514465,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(50,1325514473,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(51,1325514478,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(52,1325514478,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(53,1325515756,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(54,1325518041,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(55,1325521371,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(56,1325584457,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(57,1325584459,2,'0.0.0.0',1,'user',0,'logout','view.php?id=2&course=1','2'),(58,1325584468,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(59,1325584468,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(60,1325586086,2,'0.0.0.0',1,'user',0,'login','view.php?id=0&course=1','2'),(61,1325595109,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(62,1325598224,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(63,1325599434,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(64,1325601442,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(65,1325601560,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(66,1325601610,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(67,1325602347,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(68,1325602774,2,'0.0.0.0',2,'course',0,'update','edit.php?id=2','2'),(69,1325602774,2,'0.0.0.0',2,'course',0,'view','view.php?id=2','2'),(70,1325602778,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(71,1325602964,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(72,1325604800,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(73,1325605006,2,'0.0.0.0',2,'course',0,'update','edit.php?id=2','2'),(74,1325605006,2,'0.0.0.0',2,'course',0,'view','view.php?id=2','2'),(75,1325605010,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(76,1325605060,2,'0.0.0.0',1,'course',0,'new','view.php?id=4','Leerjaar 3/4 - Leven in een gezin (ID 4)'),(77,1325605063,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(78,1325605079,2,'0.0.0.0',4,'course',0,'update','edit.php?id=4','4'),(79,1325605079,2,'0.0.0.0',4,'course',0,'view','view.php?id=4','4'),(80,1325605111,2,'0.0.0.0',1,'course',0,'new','view.php?id=5','Jaar 5/6 - Vrienden in een groep (ID 5)'),(81,1325605113,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(82,1325605140,2,'0.0.0.0',1,'course',0,'new','view.php?id=6','Jaar 7/8 - Waarderen van verschillen (ID 6)'),(83,1325605142,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(84,1325605204,2,'0.0.0.0',1,'course',0,'new','view.php?id=7','Jaar 1/2 - Wonen in je straat (ID 7)'),(85,1325605208,2,'0.0.0.0',7,'course',0,'view','view.php?id=7','7'),(86,1325605209,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(87,1325605237,2,'0.0.0.0',1,'course',0,'new','view.php?id=8','Jaar 3/4 - Zorg voor je wijk (ID 8)'),(88,1325605257,2,'0.0.0.0',1,'course',0,'new','view.php?id=9','Jaar 5/6 - Vrije tijd in je stad of dorp (ID 9)'),(89,1325605275,2,'0.0.0.0',1,'course',0,'new','view.php?id=10','Jaar 7/8 - Ontwikkelen van je gemeente (ID 10)'),(90,1325605276,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(91,1325606114,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(92,1325673692,0,'127.0.0.1',0,'login',0,'error','index.php','stoasadmin'),(93,1325673697,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(94,1325673698,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(95,1325673934,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(96,1325673945,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(97,1325673959,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(98,1325680884,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(99,1325682137,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(100,1325682169,2,'127.0.0.1',6,'course',0,'update','edit.php?id=6','6'),(101,1325682169,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(102,1325682183,2,'127.0.0.1',5,'course',0,'update','edit.php?id=5','5'),(103,1325682183,2,'127.0.0.1',5,'course',0,'view','view.php?id=5','5'),(104,1325682195,2,'127.0.0.1',4,'course',0,'update','edit.php?id=4','4'),(105,1325682195,2,'127.0.0.1',4,'course',0,'view','view.php?id=4','4'),(106,1325682205,2,'127.0.0.1',2,'course',0,'update','edit.php?id=2','2'),(107,1325682205,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(108,1325682222,2,'127.0.0.1',10,'course',0,'update','edit.php?id=10','10'),(109,1325682222,2,'127.0.0.1',10,'course',0,'view','view.php?id=10','10'),(110,1325682231,2,'127.0.0.1',9,'course',0,'update','edit.php?id=9','9'),(111,1325682231,2,'127.0.0.1',9,'course',0,'view','view.php?id=9','9'),(112,1325682238,2,'127.0.0.1',8,'course',0,'update','edit.php?id=8','8'),(113,1325682239,2,'127.0.0.1',8,'course',0,'view','view.php?id=8','8'),(114,1325682246,2,'127.0.0.1',7,'course',0,'update','edit.php?id=7','7'),(115,1325682246,2,'127.0.0.1',7,'course',0,'view','view.php?id=7','7'),(116,1325682250,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(117,1325687274,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(118,1325687278,2,'127.0.0.1',5,'course',0,'view','view.php?id=5','5'),(119,1325766068,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(120,1325768019,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(121,1325771021,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(122,1325775025,0,'127.0.0.1',0,'login',0,'error','index.php','admin'),(123,1325775028,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(124,1325775028,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(125,1326100577,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(126,1326100577,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(127,1326101417,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(128,1326103078,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(129,1326114322,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(130,1326115059,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(131,1326115065,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(132,1326115067,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(133,1326115093,2,'127.0.0.1',6,'course',0,'add mod','../mod/assignment/view.php?id=11','assignment 1'),(134,1326115093,2,'127.0.0.1',6,'assignment',11,'add','view.php?id=11','1'),(135,1326115093,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(136,1326117917,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(137,1326119197,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(138,1326121625,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(139,1326122380,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(140,1326122380,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(141,1326199007,2,'0.0.0.0',1,'course',0,'view','view.php?id=1','1'),(142,1326808448,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(143,1326808448,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(144,1326885036,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(145,1326885418,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(146,1326886022,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(147,1326886448,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(148,1326967865,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(149,1326967865,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(150,1326971757,2,'127.0.0.1',7,'course',0,'view','view.php?id=7','7'),(151,1326972365,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(152,1326972365,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(153,1326974317,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(154,1326974318,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(155,1326974711,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(156,1326974742,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(157,1326975217,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(158,1326975312,2,'127.0.0.1',3,'course',0,'add mod','../mod/choice/view.php?id=12','choice 1'),(159,1326975312,2,'127.0.0.1',3,'choice',12,'add','view.php?id=12','1'),(160,1326975312,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(161,1326975315,2,'127.0.0.1',3,'choice',12,'view','view.php?id=12','1'),(162,1326975321,2,'127.0.0.1',3,'choice',12,'view','view.php?id=12','1'),(163,1326975810,2,'127.0.0.1',3,'choice',12,'view','view.php?id=12','1'),(164,1326976660,2,'127.0.0.1',3,'course',0,'editsection','editsection.php?id=13','1'),(165,1326976660,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(166,1326976857,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(167,1326976864,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(168,1326976868,2,'127.0.0.1',3,'course',0,'view','view.php?id=3','3'),(169,1326979501,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(170,1326979565,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(171,1326979567,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(172,1326979567,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(173,1326979570,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(174,1326979570,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(175,1326979776,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(176,1326981656,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(177,1326981656,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(178,1326988854,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(179,1326988854,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(180,1327500310,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(181,1327500310,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(182,1327500780,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(183,1327515653,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(184,1327515672,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(185,1327515678,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(186,1327515682,2,'127.0.0.1',1,'user',0,'logout','view.php?id=2&course=1','2'),(187,1327515685,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(188,1327515826,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(189,1327516608,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(190,1327516745,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(191,1327591405,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(192,1327591408,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(193,1327934839,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(194,1327934839,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(195,1327934859,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(196,1327935297,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(197,1328526375,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(198,1328534143,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(199,1328535282,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(200,1328535827,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(201,1328608110,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(202,1328608110,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(203,1328627963,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(204,1328790110,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(205,1328791536,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(206,1328799063,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(207,1328800564,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(208,1328801640,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(209,1328803324,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(210,1328804448,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(211,1329213729,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(212,1329219538,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(213,1329219573,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(214,1329305831,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(215,1329305913,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(216,1329309241,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(217,1329316263,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(218,1329316355,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(219,1329316373,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(220,1329316375,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(221,1329316389,2,'127.0.0.1',2,'course',0,'add mod','../mod/chat/view.php?id=13','chat 1'),(222,1329316389,2,'127.0.0.1',2,'chat',13,'add','view.php?id=13','1'),(223,1329316389,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(224,1329316463,2,'127.0.0.1',2,'course',0,'add mod','../mod/choice/view.php?id=14','choice 2'),(225,1329316463,2,'127.0.0.1',2,'choice',14,'add','view.php?id=14','2'),(226,1329316463,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(227,1329316472,2,'127.0.0.1',2,'course',0,'update mod','../mod/choice/view.php?id=14','choice 2'),(228,1329316472,2,'127.0.0.1',2,'choice',14,'update','view.php?id=14','2'),(229,1329316472,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(230,1329316475,2,'127.0.0.1',2,'choice',14,'view','view.php?id=14','2'),(231,1329316485,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(232,1329316589,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(233,1329317358,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(234,1329317423,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(235,1329317430,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(236,1329317543,2,'127.0.0.1',10,'course',0,'view','view.php?id=10','10'),(237,1329317555,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(238,1329317708,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(239,1329318291,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(240,1329318865,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(241,1329320138,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(242,1329320143,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(243,1329321224,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(244,1329384990,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(245,1329384990,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(246,1329385464,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(247,1329386805,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(248,1329386927,2,'127.0.0.1',1,'role',0,'add','admin/roles/manage.php?action=add','Substitute'),(249,1329386951,2,'127.0.0.1',1,'role',0,'delete','admin/roles/action=delete&roleid=8','Substitute'),(250,1329387453,2,'127.0.0.1',1,'role',0,'duplicate','admin/roles/manage.php?roleid=9&action=duplicate','Non-editing teacher copy 1'),(251,1329387996,2,'127.0.0.1',1,'role',0,'edit','admin/roles/manage.php?action=edit&roleid=9','Substitute'),(252,1329388010,2,'127.0.0.1',1,'role',0,'duplicate','admin/roles/manage.php?roleid=10&action=duplicate','Administrator copy 1'),(253,1329388051,2,'127.0.0.1',1,'role',0,'edit','admin/roles/manage.php?action=edit&roleid=10','Manager'),(254,1329388079,2,'127.0.0.1',1,'role',0,'edit','admin/roles/manage.php?action=edit&roleid=10','Manager'),(255,1329388730,2,'127.0.0.1',1,'role',0,'delete','admin/roles/action=delete&roleid=10','Manager'),(256,1329389210,2,'127.0.0.1',1,'role',0,'duplicate','admin/roles/manage.php?roleid=11&action=duplicate','Non-editing teacher copy 1'),(257,1329389244,2,'127.0.0.1',1,'role',0,'edit','admin/roles/manage.php?action=edit&roleid=11','School leader'),(258,1329389522,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(259,1329390291,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(260,1329391325,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(261,1329392138,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(262,1329393090,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(263,1329393090,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(264,1329393322,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(265,1329393401,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(266,1329393523,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(267,1329394209,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create','ERROR: Could not instantiate mail function.'),(268,1329398209,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(269,1329398359,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(270,1329398391,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(271,1329398713,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(272,1329398882,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(273,1329398910,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(274,1329398917,2,'127.0.0.1',7,'course',0,'view','view.php?id=7','7'),(275,1329399586,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(276,1329400186,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(277,1329400314,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(278,1329403068,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(279,1329403092,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(280,1329403100,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(281,1329403404,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(282,1329403410,2,'127.0.0.1',10,'course',0,'view','view.php?id=10','10'),(283,1329405307,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(284,1330333778,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(285,1330333779,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(286,1330348487,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(287,1330350538,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(288,1330352371,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(289,1330353254,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(290,1330357018,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(291,1330361600,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(292,1330363187,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(293,1330512597,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(294,1330512950,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(295,1330513353,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(296,1330513585,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(297,1330513610,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(298,1330513933,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(299,1330513984,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(300,1330517308,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(301,1330519567,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(302,1330522935,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(303,1330522977,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(304,1330524595,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(305,1330525362,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(306,1330526318,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(307,1330526422,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(308,1330531616,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(309,1330600045,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(310,1330607393,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(311,1330679780,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(312,1330680290,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(313,1330680296,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(314,1330680304,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(315,1330680321,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(316,1330680324,2,'127.0.0.1',1,'user',0,'logout','view.php?id=2&course=1','2'),(317,1330680328,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(318,1330680328,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(319,1330680656,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(320,1330680662,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(321,1330681116,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(322,1330681116,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(323,1330681428,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(324,1330681831,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(325,1330684300,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(326,1330691496,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(327,1330692529,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(328,1330703688,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(329,1330703921,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(330,1330704245,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(331,1330706729,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(332,1330939622,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(333,1330940420,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(334,1330944603,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(335,1330944728,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(336,1330945756,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(337,1331036681,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(338,1331042852,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(339,1331049672,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(340,1331117192,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(341,1331122572,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(342,1331122729,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(343,1331129729,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(344,1331197838,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(345,1331204340,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(346,1331204341,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(347,1331204762,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(348,1331204764,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(349,1331204963,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(350,1331204965,2,'127.0.0.1',5,'course',0,'view','view.php?id=5','5'),(351,1331204969,2,'127.0.0.1',5,'course',0,'view','view.php?id=5','5'),(352,1331205043,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(353,1331205113,2,'127.0.0.1',6,'course',0,'update mod','../mod/assignment/view.php?id=11','assignment 1'),(354,1331205113,2,'127.0.0.1',6,'assignment',11,'update','view.php?id=11','1'),(355,1331205113,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(356,1331205115,2,'127.0.0.1',6,'assignment',11,'view','view.php?id=11','1'),(357,1331205135,2,'127.0.0.1',6,'assignment',11,'view submission','submissions.php?id=11','1'),(358,1331205140,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(359,1331205142,2,'127.0.0.1',6,'assignment',11,'view','view.php?id=11','1'),(360,1331205147,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(361,1331205152,2,'127.0.0.1',6,'forum',6,'view forum','view.php?id=6','5'),(362,1331205157,2,'127.0.0.1',6,'assignment',11,'view','view.php?id=11','1'),(363,1331205183,2,'127.0.0.1',6,'course',0,'update mod','../mod/assignment/view.php?id=11','assignment 1'),(364,1331205183,2,'127.0.0.1',6,'assignment',11,'update','view.php?id=11','1'),(365,1331205183,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(366,1331205186,2,'127.0.0.1',6,'assignment',11,'view','view.php?id=11','1'),(367,1331205193,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(368,1331205195,2,'127.0.0.1',7,'course',0,'view','view.php?id=7','7'),(369,1331205199,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(370,1331205201,2,'127.0.0.1',2,'choice',14,'view','view.php?id=14','2'),(371,1331205204,2,'127.0.0.1',2,'choice',14,'choose','view.php?id=14','2'),(372,1331205204,2,'127.0.0.1',2,'choice',14,'view','view.php?id=14','2'),(373,1331205250,2,'127.0.0.1',2,'course',0,'update mod','../mod/choice/view.php?id=14','choice 2'),(374,1331205250,2,'127.0.0.1',2,'choice',14,'update','view.php?id=14','2'),(375,1331205250,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(376,1331205252,2,'127.0.0.1',2,'choice',14,'view','view.php?id=14','2'),(377,1331205266,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(378,1331221936,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(379,1331221936,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(380,1331640981,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(381,1331653595,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(382,1331653596,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(383,1331717699,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(384,1331717700,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(385,1331734597,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(386,1331735439,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(387,1331738974,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(388,1331739337,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(389,1331807418,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(390,1331812351,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(391,1331813260,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(392,1331817637,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(393,1331823400,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(394,1332148072,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(395,1332148072,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(396,1332151198,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(397,1332153883,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(398,1332154005,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(399,1332154493,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(400,1332161956,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(401,1332162646,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(402,1332169329,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(403,1332170526,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(404,1332170601,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(405,1332170604,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(406,1332170749,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(407,1332171353,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(408,1332171495,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(409,1332171655,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(410,1332171663,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(411,1332171951,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(412,1332172063,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(413,1332172366,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(414,1332172657,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(415,1332173606,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(416,1332175398,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(417,1332176548,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(418,1332176846,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(419,1332236498,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(420,1332246756,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(421,1332246920,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(422,1332251276,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(423,1332329599,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(424,1332413911,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(425,1332418111,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(426,1332431617,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(427,1332432004,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(428,1332432048,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(429,1332437809,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(430,1332437840,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(431,1332749294,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(432,1332759492,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(433,1332760956,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(434,1332761354,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(435,1332762443,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(436,1332762456,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(437,1332762745,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(438,1332762757,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(439,1332763000,2,'127.0.0.1',1,'library',0,'mailer','http://localhost/jeelo19/mod/launcher/view.php?id=3&controller=moodle&action=create_school','ERROR: Could not instantiate mail function.'),(440,1332763101,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(441,1332766189,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(442,1332766783,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(443,1332767391,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(444,1332767403,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(445,1332767415,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(446,1332767968,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(447,1332767977,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(448,1332775476,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(449,1332775483,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(450,1332775543,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(451,1332775556,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(452,1332775564,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(453,1332775570,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(454,1332775886,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(455,1332775904,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(456,1332776120,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(457,1332776123,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(458,1332776398,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(459,1332776421,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(460,1332832105,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(461,1332832806,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(462,1332832835,2,'127.0.0.1',6,'course',0,'view','view.php?id=6','6'),(463,1332832848,2,'127.0.0.1',2,'course',0,'view','view.php?id=2','2'),(464,1332832858,2,'127.0.0.1',2,'forum',1,'view forum','view.php?id=1','1'),(465,1332832863,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(466,1332832910,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(467,1332832948,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(468,1332833010,2,'127.0.0.1',0,'upload',0,'upload','','/home/menno/php_projects/jeelo19/moodle_data/13/Inrichten_van_je_eigen_omgeving_12.gif'),(469,1332833013,2,'127.0.0.1',13,'course',0,'view','view.php?id=13','13'),(470,1332833016,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(471,1332833036,2,'127.0.0.1',0,'upload',0,'upload','','/home/menno/php_projects/jeelo19/moodle_data/14/Inrichten_van_je_eigen_omgeving_78.gif'),(472,1332833040,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(473,1332833064,2,'127.0.0.1',0,'upload',0,'upload','','/home/menno/php_projects/jeelo19/moodle_data/15/Inrichten_van_je_eigen_omgeving_56.gif'),(474,1332833067,2,'127.0.0.1',15,'course',0,'view','view.php?id=15','15'),(475,1332833069,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(476,1332833088,2,'127.0.0.1',0,'upload',0,'upload','','/home/menno/php_projects/jeelo19/moodle_data/16/Inrichten_van_je_eigen_omgeving_34.gif'),(477,1332833092,2,'127.0.0.1',16,'course',0,'view','view.php?id=16','16'),(478,1332833093,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(479,1332833192,2,'127.0.0.1',13,'course',0,'update','edit.php?id=13','13'),(480,1332833192,2,'127.0.0.1',13,'course',0,'view','view.php?id=13','13'),(481,1332833195,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(482,1332833219,2,'127.0.0.1',14,'course',0,'update','edit.php?id=14','14'),(483,1332833219,2,'127.0.0.1',14,'course',0,'view','view.php?id=14','14'),(484,1332833227,2,'127.0.0.1',15,'course',0,'update','edit.php?id=15','15'),(485,1332833228,2,'127.0.0.1',15,'course',0,'view','view.php?id=15','15'),(486,1332833236,2,'127.0.0.1',16,'course',0,'update','edit.php?id=16','16'),(487,1332833236,2,'127.0.0.1',16,'course',0,'view','view.php?id=16','16'),(488,1332833239,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(489,1332833950,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(490,1332834871,2,'127.0.0.1',16,'course',0,'view','view.php?id=16','16'),(491,1332834877,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(492,1332837879,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(493,1332837938,2,'127.0.0.1',0,'upload',0,'upload','','/home/menno/php_projects/jeelo19/moodle_data/17/Inrichten_van_je_eigen_omgeving_34.gif'),(494,1332839364,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(495,1332842276,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(496,1332842442,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1'),(497,1332844976,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(498,1332845320,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(499,1332845444,2,'127.0.0.1',1,'user',0,'login','view.php?id=0&course=1','2'),(500,1332847421,2,'127.0.0.1',1,'course',0,'view','view.php?id=1','1');
/*!40000 ALTER TABLE `mdl_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_log_display`
--

DROP TABLE IF EXISTS `mdl_log_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_log_display` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(20) NOT NULL DEFAULT '',
  `action` varchar(40) NOT NULL DEFAULT '',
  `mtable` varchar(30) NOT NULL DEFAULT '',
  `field` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_logdisp_modact_uix` (`module`,`action`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='For a particular module/action, specifies a moodle table/fie';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_log_display`
--

LOCK TABLES `mdl_log_display` WRITE;
/*!40000 ALTER TABLE `mdl_log_display` DISABLE KEYS */;
INSERT INTO `mdl_log_display` VALUES (1,'user','view','user','CONCAT(firstname,\' \',lastname)'),(2,'course','user report','user','CONCAT(firstname,\' \',lastname)'),(3,'course','view','course','fullname'),(4,'course','update','course','fullname'),(5,'course','enrol','course','fullname'),(6,'course','unenrol','course','fullname'),(7,'course','report log','course','fullname'),(8,'course','report live','course','fullname'),(9,'course','report outline','course','fullname'),(10,'course','report participation','course','fullname'),(11,'course','report stats','course','fullname'),(12,'message','write','user','CONCAT(firstname,\' \',lastname)'),(13,'message','read','user','CONCAT(firstname,\' \',lastname)'),(14,'message','add contact','user','CONCAT(firstname,\' \',lastname)'),(15,'message','remove contact','user','CONCAT(firstname,\' \',lastname)'),(16,'message','block contact','user','CONCAT(firstname,\' \',lastname)'),(17,'message','unblock contact','user','CONCAT(firstname,\' \',lastname)'),(18,'group','view','groups','name'),(19,'tag','update','tag','name'),(20,'assignment','view','assignment','name'),(21,'assignment','add','assignment','name'),(22,'assignment','update','assignment','name'),(23,'assignment','view submission','assignment','name'),(24,'assignment','upload','assignment','name'),(25,'chat','view','chat','name'),(26,'chat','add','chat','name'),(27,'chat','update','chat','name'),(28,'chat','report','chat','name'),(29,'chat','talk','chat','name'),(30,'choice','view','choice','name'),(31,'choice','update','choice','name'),(32,'choice','add','choice','name'),(33,'choice','report','choice','name'),(34,'choice','choose','choice','name'),(35,'choice','choose again','choice','name'),(36,'data','view','data','name'),(37,'data','add','data','name'),(38,'data','update','data','name'),(39,'data','record delete','data','name'),(40,'data','fields add','data_fields','name'),(41,'data','fields update','data_fields','name'),(42,'data','templates saved','data','name'),(43,'data','templates def','data','name'),(44,'forum','add','forum','name'),(45,'forum','update','forum','name'),(46,'forum','add discussion','forum_discussions','name'),(47,'forum','add post','forum_posts','subject'),(48,'forum','update post','forum_posts','subject'),(49,'forum','user report','user','CONCAT(firstname,\' \',lastname)'),(50,'forum','move discussion','forum_discussions','name'),(51,'forum','view subscribers','forum','name'),(52,'forum','view discussion','forum_discussions','name'),(53,'forum','view forum','forum','name'),(54,'forum','subscribe','forum','name'),(55,'forum','unsubscribe','forum','name'),(56,'glossary','add','glossary','name'),(57,'glossary','update','glossary','name'),(58,'glossary','view','glossary','name'),(59,'glossary','view all','glossary','name'),(60,'glossary','add entry','glossary','name'),(61,'glossary','update entry','glossary','name'),(62,'glossary','add category','glossary','name'),(63,'glossary','update category','glossary','name'),(64,'glossary','delete category','glossary','name'),(65,'glossary','add comment','glossary','name'),(66,'glossary','update comment','glossary','name'),(67,'glossary','delete comment','glossary','name'),(68,'glossary','approve entry','glossary','name'),(69,'glossary','view entry','glossary_entries','concept'),(70,'journal','view','journal','name'),(71,'journal','add entry','journal','name'),(72,'journal','update entry','journal','name'),(73,'journal','view responses','journal','name'),(74,'label','add','label','name'),(75,'label','update','label','name'),(76,'lesson','start','lesson','name'),(77,'lesson','end','lesson','name'),(78,'lesson','view','lesson_pages','title'),(79,'quiz','add','quiz','name'),(80,'quiz','update','quiz','name'),(81,'quiz','view','quiz','name'),(82,'quiz','report','quiz','name'),(83,'quiz','attempt','quiz','name'),(84,'quiz','submit','quiz','name'),(85,'quiz','review','quiz','name'),(86,'quiz','editquestions','quiz','name'),(87,'quiz','preview','quiz','name'),(88,'quiz','start attempt','quiz','name'),(89,'quiz','close attempt','quiz','name'),(90,'quiz','continue attempt','quiz','name'),(91,'resource','view','resource','name'),(92,'resource','update','resource','name'),(93,'resource','add','resource','name'),(94,'scorm','view','scorm','name'),(95,'scorm','review','scorm','name'),(96,'scorm','update','scorm','name'),(97,'scorm','add','scorm','name'),(98,'survey','add','survey','name'),(99,'survey','update','survey','name'),(100,'survey','download','survey','name'),(101,'survey','view form','survey','name'),(102,'survey','view graph','survey','name'),(103,'survey','view report','survey','name'),(104,'survey','submit','survey','name'),(105,'workshop','assessments','workshop','name'),(106,'workshop','close','workshop','name'),(107,'workshop','display','workshop','name'),(108,'workshop','resubmit','workshop','name'),(109,'workshop','set up','workshop','name'),(110,'workshop','submissions','workshop','name'),(111,'workshop','view','workshop','name'),(112,'workshop','update','workshop','name');
/*!40000 ALTER TABLE `mdl_log_display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_message`
--

DROP TABLE IF EXISTS `mdl_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_message` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `useridfrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `useridto` bigint(10) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `format` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) NOT NULL DEFAULT '0',
  `messagetype` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_mess_use_ix` (`useridfrom`),
  KEY `mdl_mess_use2_ix` (`useridto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all unread messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_message`
--

LOCK TABLES `mdl_message` WRITE;
/*!40000 ALTER TABLE `mdl_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_message_contacts`
--

DROP TABLE IF EXISTS `mdl_message_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_message_contacts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contactid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `blocked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_messcont_usecon_uix` (`userid`,`contactid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Maintains lists of relationships between users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_message_contacts`
--

LOCK TABLES `mdl_message_contacts` WRITE;
/*!40000 ALTER TABLE `mdl_message_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_message_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_message_read`
--

DROP TABLE IF EXISTS `mdl_message_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_message_read` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `useridfrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `useridto` bigint(10) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `format` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) NOT NULL DEFAULT '0',
  `timeread` bigint(10) NOT NULL DEFAULT '0',
  `messagetype` varchar(50) NOT NULL DEFAULT '',
  `mailed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_messread_use_ix` (`useridfrom`),
  KEY `mdl_messread_use2_ix` (`useridto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all messages that have been read';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_message_read`
--

LOCK TABLES `mdl_message_read` WRITE;
/*!40000 ALTER TABLE `mdl_message_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_message_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_application`
--

DROP TABLE IF EXISTS `mdl_mnet_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_application` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `display_name` varchar(50) NOT NULL DEFAULT '',
  `xmlrpc_server_url` varchar(255) NOT NULL DEFAULT '',
  `sso_land_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Information about applications on remote hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_application`
--

LOCK TABLES `mdl_mnet_application` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_application` DISABLE KEYS */;
INSERT INTO `mdl_mnet_application` VALUES (1,'moodle','Moodle','/mnet/xmlrpc/server.php','/auth/mnet/land.php'),(2,'mahara','Mahara','/api/xmlrpc/server.php','/auth/xmlrpc/land.php');
/*!40000 ALTER TABLE `mdl_mnet_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_enrol_assignments`
--

DROP TABLE IF EXISTS `mdl_mnet_enrol_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_enrol_assignments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `hostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rolename` varchar(255) NOT NULL DEFAULT '',
  `enroltime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enroltype` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_mnetenroassi_hoscou_ix` (`hostid`,`courseid`),
  KEY `mdl_mnetenroassi_use_ix` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about enrolments on courses on remote hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_enrol_assignments`
--

LOCK TABLES `mdl_mnet_enrol_assignments` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_enrol_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_mnet_enrol_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_enrol_course`
--

DROP TABLE IF EXISTS `mdl_mnet_enrol_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_enrol_course` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `remoteid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `cat_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `cat_name` varchar(255) NOT NULL DEFAULT '',
  `cat_description` mediumtext NOT NULL,
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(15) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `summary` mediumtext NOT NULL,
  `startdate` bigint(10) unsigned NOT NULL DEFAULT '0',
  `cost` varchar(10) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT '',
  `defaultroleid` smallint(4) unsigned NOT NULL DEFAULT '0',
  `defaultrolename` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetenrocour_hosrem_uix` (`hostid`,`remoteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about courses on remote hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_enrol_course`
--

LOCK TABLES `mdl_mnet_enrol_course` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_enrol_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_mnet_enrol_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_host`
--

DROP TABLE IF EXISTS `mdl_mnet_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_host` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `wwwroot` varchar(255) NOT NULL DEFAULT '',
  `ip_address` varchar(39) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `public_key` mediumtext NOT NULL,
  `public_key_expires` bigint(10) unsigned NOT NULL DEFAULT '0',
  `transport` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `portno` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `last_connect_time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `last_log_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `force_theme` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `theme` varchar(100) DEFAULT NULL,
  `applicationid` bigint(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_mnethost_app_ix` (`applicationid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Information about the local and remote hosts for RPC';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_host`
--

LOCK TABLES `mdl_mnet_host` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_host` DISABLE KEYS */;
INSERT INTO `mdl_mnet_host` VALUES (1,0,'http://localhost/jeelo19','127.0.0.1','','-----BEGIN CERTIFICATE-----\nMIIDszCCAxygAwIBAgIBADANBgkqhkiG9w0BAQQFADCBnjELMAkGA1UEBhMCTkwx\nDjAMBgNVBAgTBUJyZWRhMQ4wDAYDVQQHEwVCcmVkYTEXMBUGA1UEChMOSmVlbG8g\nTGF1bmNoZXIxDzANBgNVBAsTBk1vb2RsZTEhMB8GA1UEAxMYaHR0cDovL2xvY2Fs\naG9zdC9qZWVsbzE5MSIwIAYJKoZIhvcNAQkBFhNtLmRlcmlkZGVyQHNvbGluLm5s\nMB4XDTEyMDIxNTE1MDY0NFoXDTEyMDMxNDE1MDY0NFowgZ4xCzAJBgNVBAYTAk5M\nMQ4wDAYDVQQIEwVCcmVkYTEOMAwGA1UEBxMFQnJlZGExFzAVBgNVBAoTDkplZWxv\nIExhdW5jaGVyMQ8wDQYDVQQLEwZNb29kbGUxITAfBgNVBAMTGGh0dHA6Ly9sb2Nh\nbGhvc3QvamVlbG8xOTEiMCAGCSqGSIb3DQEJARYTbS5kZXJpZGRlckBzb2xpbi5u\nbDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAu89LmMXZkrCqLdBaLOZgPuSD\njQupDD1D46Oh9IfbB1XiVt7VqI79/lot4UkKuiaMsL4HBQZZAM6Ucnua0YZLMh7z\nA2aoYWkQnJSxAVJ1cG4hSKh28qrpZJAurtmmydFKE8ODZkIbg6+5kzWZtS4ubBY3\nU+rrOwmjIqXJOAKHL7kCAwEAAaOB/jCB+zAdBgNVHQ4EFgQUIra+jAOl9KP2p/1z\nNuwWKSp4O5QwgcsGA1UdIwSBwzCBwIAUIra+jAOl9KP2p/1zNuwWKSp4O5ShgaSk\ngaEwgZ4xCzAJBgNVBAYTAk5MMQ4wDAYDVQQIEwVCcmVkYTEOMAwGA1UEBxMFQnJl\nZGExFzAVBgNVBAoTDkplZWxvIExhdW5jaGVyMQ8wDQYDVQQLEwZNb29kbGUxITAf\nBgNVBAMTGGh0dHA6Ly9sb2NhbGhvc3QvamVlbG8xOTEiMCAGCSqGSIb3DQEJARYT\nbS5kZXJpZGRlckBzb2xpbi5ubIIBADAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEB\nBAUAA4GBAIZcWM1Tfxagmt2/dzzw+QHwSqALl1dsJ3u11t6GvJqKQYOvdbOZ+s8M\nJdy0Z/ic+QHD8m2xrDxOu7B+b415x3V9L1ExLc2uMuXSqNVOUlS5H4EolKxHKkd+\nR8W5G4E5OxTE81DIvT74Gp6FAcQJLUXYTsHg5P0ghQ0JkypGMuoy\n-----END CERTIFICATE-----\n',1331737604,0,0,0,0,0,'',1),(2,0,'','','All Hosts','',0,0,0,0,0,0,NULL,1);
/*!40000 ALTER TABLE `mdl_mnet_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_host2service`
--

DROP TABLE IF EXISTS `mdl_mnet_host2service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_host2service` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `serviceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subscribe` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnethost_hosser_uix` (`hostid`,`serviceid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about the services for a given host';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_host2service`
--

LOCK TABLES `mdl_mnet_host2service` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_host2service` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_mnet_host2service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_log`
--

DROP TABLE IF EXISTS `mdl_mnet_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `remoteid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `coursename` varchar(40) NOT NULL DEFAULT '',
  `module` varchar(20) NOT NULL DEFAULT '',
  `cmid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `action` varchar(40) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL DEFAULT '',
  `info` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_mnetlog_hosusecou_ix` (`hostid`,`userid`,`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store session data from users migrating to other sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_log`
--

LOCK TABLES `mdl_mnet_log` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_mnet_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_rpc`
--

DROP TABLE IF EXISTS `mdl_mnet_rpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_rpc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `function_name` varchar(40) NOT NULL DEFAULT '',
  `xmlrpc_path` varchar(80) NOT NULL DEFAULT '',
  `parent_type` varchar(6) NOT NULL DEFAULT '',
  `parent` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `help` mediumtext NOT NULL,
  `profile` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_mnetrpc_enaxml_ix` (`enabled`,`xmlrpc_path`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Functions or methods that we may publish or subscribe to';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_rpc`
--

LOCK TABLES `mdl_mnet_rpc` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_rpc` DISABLE KEYS */;
INSERT INTO `mdl_mnet_rpc` VALUES (1,'user_authorise','auth/mnet/auth.php/user_authorise','auth','mnet',0,'Return user data for the provided token, compare with user_agent string.','a:3:{i:0;a:2:{s:4:\"type\";s:5:\"array\";s:11:\"description\";s:44:\"$userdata Array of user info for remote host\";}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:45:\"token - The unique ID provided by remotehost.\";}i:2;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:30:\"useragent - User Agent string.\";}}'),(2,'keepalive_server','auth/mnet/auth.php/keepalive_server','auth','mnet',0,'Receives an array of usernames from a remote machine and prods their\\n sessions to keep them alive','a:2:{i:0;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:30:\"\\\"All ok\\\" or an error message\";}i:1;a:2:{s:4:\"type\";s:5:\"array\";s:11:\"description\";s:29:\"array - An array of usernames\";}}'),(3,'kill_children','auth/mnet/auth.php/kill_children','auth','mnet',0,'The IdP uses this function to kill child sessions on other hosts','a:3:{i:0;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:39:\"A plaintext report of what has happened\";}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:39:\"username - Username for session to kill\";}i:2;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:47:\"useragent - SHA1 hash of user agent to look for\";}}'),(4,'refresh_log','auth/mnet/auth.php/refresh_log','auth','mnet',0,'Receives an array of log entries from an SP and adds them to the mnet_log\\n table','a:2:{i:0;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:30:\"\\\"All ok\\\" or an error message\";}i:1;a:2:{s:4:\"type\";s:5:\"array\";s:11:\"description\";s:29:\"array - An array of usernames\";}}'),(5,'fetch_user_image','auth/mnet/auth.php/fetch_user_image','auth','mnet',0,'Returns the user\'s image as a base64 encoded string.','a:2:{i:0;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:17:\"The encoded image\";}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:29:\"username - The id of the user\";}}'),(6,'fetch_theme_info','auth/mnet/auth.php/fetch_theme_info','auth','mnet',0,'Returns the theme information and logo url as strings.','a:1:{i:0;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:14:\"The theme info\";}}'),(7,'update_enrolments','auth/mnet/auth.php/update_enrolments','auth','mnet',0,'Invoke this function _on_ the IDP to update it with enrolment info local to\\n the SP right after calling user_authorise()\\n \\n Normally called by the SP after calling','a:3:{i:0;a:2:{s:4:\"type\";s:7:\"boolean\";s:11:\"description\";N;}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:23:\"username - The username\";}i:2;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:77:\"courses - Assoc array of courses following the structure of mnet_enrol_course\";}}'),(8,'keepalive_client','auth/mnet/auth.php/keepalive_client','auth','mnet',0,'Poll the IdP server to let it know that a user it has authenticated is still\\n online','a:1:{i:0;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";N;}}'),(9,'kill_child','auth/mnet/auth.php/kill_child','auth','mnet',0,'TODO:Untested When the IdP requests that child sessions are terminated,\\n this function will be called on each of the child hosts. The machine that\\n calls the function (over xmlrpc) provides us with the mnethostid we need.','a:3:{i:0;a:2:{s:4:\"type\";s:7:\"boolean\";s:11:\"description\";s:15:\"True on success\";}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:39:\"username - Username for session to kill\";}i:2;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:47:\"useragent - SHA1 hash of user agent to look for\";}}'),(10,'available_courses','enrol/mnet/enrol.php/available_courses','enrol','mnet',0,'Does Foo','a:1:{i:0;a:2:{s:4:\"type\";s:7:\"boolean\";s:11:\"description\";s:47:\"Whether the user can login from the remote host\";}}'),(11,'user_enrolments','enrol/mnet/enrol.php/user_enrolments','enrol','mnet',0,'No description given.','a:2:{i:0;a:2:{s:4:\"type\";s:4:\"void\";s:11:\"description\";s:0:\"\";}i:1;s:6:\"userid\";}'),(12,'enrol_user','enrol/mnet/enrol.php/enrol_user','enrol','mnet',0,'Enrols user to course with the default role','a:3:{i:0;a:2:{s:4:\"type\";s:7:\"boolean\";s:11:\"description\";s:41:\"Whether the enrolment has been successful\";}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:37:\"user - The username of the remote use\";}i:2;a:2:{s:4:\"type\";s:3:\"int\";s:11:\"description\";s:37:\"courseid - The id of the local course\";}}'),(13,'unenrol_user','enrol/mnet/enrol.php/unenrol_user','enrol','mnet',0,'Unenrol a user from a course','a:3:{i:0;a:2:{s:4:\"type\";s:7:\"boolean\";s:11:\"description\";s:47:\"Whether the user can login from the remote host\";}i:1;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:23:\"username - The username\";}i:2;a:2:{s:4:\"type\";s:3:\"int\";s:11:\"description\";s:37:\"courseid - The id of the local course\";}}'),(14,'course_enrolments','enrol/mnet/enrol.php/course_enrolments','enrol','mnet',0,'Get a list of users from the client server who are enrolled in a course','a:3:{i:0;a:2:{s:4:\"type\";s:5:\"array\";s:11:\"description\";s:39:\"Array of usernames who are homed on the\";}i:1;a:2:{s:4:\"type\";s:3:\"int\";s:11:\"description\";s:24:\"courseid - The Course ID\";}i:2;a:2:{s:4:\"type\";s:6:\"string\";s:11:\"description\";s:47:\"roles - Comma-separated list of role shortnames\";}}');
/*!40000 ALTER TABLE `mdl_mnet_rpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_service`
--

DROP TABLE IF EXISTS `mdl_mnet_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_service` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT '',
  `description` varchar(40) NOT NULL DEFAULT '',
  `apiversion` varchar(10) NOT NULL DEFAULT '',
  `offer` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='A service is a group of functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_service`
--

LOCK TABLES `mdl_mnet_service` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_service` DISABLE KEYS */;
INSERT INTO `mdl_mnet_service` VALUES (1,'sso_idp','','1',1),(2,'sso_sp','','1',1),(3,'mnet_enrol','','1',1);
/*!40000 ALTER TABLE `mdl_mnet_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_service2rpc`
--

DROP TABLE IF EXISTS `mdl_mnet_service2rpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_service2rpc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `serviceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rpcid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetserv_rpcser_uix` (`rpcid`,`serviceid`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Group functions or methods under a service';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_service2rpc`
--

LOCK TABLES `mdl_mnet_service2rpc` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_service2rpc` DISABLE KEYS */;
INSERT INTO `mdl_mnet_service2rpc` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,2,8),(9,2,9),(10,3,10),(11,3,11),(12,3,12),(13,3,13),(14,3,14);
/*!40000 ALTER TABLE `mdl_mnet_service2rpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_session`
--

DROP TABLE IF EXISTS `mdl_mnet_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_session` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(100) NOT NULL DEFAULT '',
  `token` varchar(40) NOT NULL DEFAULT '',
  `mnethostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `useragent` varchar(40) NOT NULL DEFAULT '',
  `confirm_timeout` bigint(10) unsigned NOT NULL DEFAULT '0',
  `session_id` varchar(40) NOT NULL DEFAULT '',
  `expires` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetsess_tok_uix` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store session data from users migrating to other sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_session`
--

LOCK TABLES `mdl_mnet_session` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_mnet_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_mnet_sso_access_control`
--

DROP TABLE IF EXISTS `mdl_mnet_sso_access_control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_mnet_sso_access_control` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL DEFAULT '',
  `mnet_host_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `accessctrl` varchar(20) NOT NULL DEFAULT 'allow',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetssoaccecont_mneuse_uix` (`mnet_host_id`,`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Users by host permitted (or not) to login from a remote prov';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_mnet_sso_access_control`
--

LOCK TABLES `mdl_mnet_sso_access_control` WRITE;
/*!40000 ALTER TABLE `mdl_mnet_sso_access_control` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_mnet_sso_access_control` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_modules`
--

DROP TABLE IF EXISTS `mdl_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_modules` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `version` bigint(10) NOT NULL DEFAULT '0',
  `cron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastcron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `search` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_modu_nam_ix` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='modules available in the site';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_modules`
--

LOCK TABLES `mdl_modules` WRITE;
/*!40000 ALTER TABLE `mdl_modules` DISABLE KEYS */;
INSERT INTO `mdl_modules` VALUES (1,'assignment',2007101511,60,0,'',1),(2,'chat',2009031100,300,0,'',1),(3,'choice',2007101509,0,0,'',1),(4,'data',2007101515,60,0,'',1),(5,'forum',2007101513,60,0,'',1),(6,'glossary',2007101509,0,0,'',1),(7,'hotpot',2007101513,0,0,'',0),(8,'journal',2007101509,60,0,'',0),(9,'label',2007101510,0,0,'',1),(10,'lams',2007101509,0,0,'',0),(11,'lesson',2008112601,0,0,'',1),(12,'quiz',2007101511,0,0,'',1),(13,'resource',2007101511,0,0,'',1),(14,'scorm',2007110503,300,0,'',1),(15,'survey',2007101509,0,0,'',1),(16,'wiki',2007101509,3600,0,'',1),(17,'workshop',2007101510,60,0,'',0),(20,'soda',2011101601,0,0,'',0),(19,'launcher',2012030201,0,0,'',1);
/*!40000 ALTER TABLE `mdl_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_post`
--

DROP TABLE IF EXISTS `mdl_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_post` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(20) NOT NULL DEFAULT '',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `moduleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `coursemoduleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(128) NOT NULL DEFAULT '',
  `summary` longtext,
  `content` longtext,
  `uniquehash` varchar(128) NOT NULL DEFAULT '',
  `rating` bigint(10) unsigned NOT NULL DEFAULT '0',
  `format` bigint(10) unsigned NOT NULL DEFAULT '0',
  `attachment` varchar(100) DEFAULT NULL,
  `publishstate` enum('draft','site','public') NOT NULL DEFAULT 'draft',
  `lastmodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned NOT NULL DEFAULT '0',
  `usermodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_post_iduse_uix` (`id`,`userid`),
  KEY `mdl_post_las_ix` (`lastmodified`),
  KEY `mdl_post_mod_ix` (`module`),
  KEY `mdl_post_sub_ix` (`subject`),
  KEY `mdl_post_use_ix` (`usermodified`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Generic post table to hold data blog entries etc in differen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_post`
--

LOCK TABLES `mdl_post` WRITE;
/*!40000 ALTER TABLE `mdl_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question`
--

DROP TABLE IF EXISTS `mdl_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(10) NOT NULL DEFAULT '0',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `questiontext` text NOT NULL,
  `questiontextformat` tinyint(2) NOT NULL DEFAULT '0',
  `image` varchar(255) NOT NULL DEFAULT '',
  `generalfeedback` text NOT NULL,
  `defaultgrade` bigint(10) unsigned NOT NULL DEFAULT '1',
  `penalty` double NOT NULL DEFAULT '0.1',
  `qtype` varchar(20) NOT NULL DEFAULT '',
  `length` bigint(10) unsigned NOT NULL DEFAULT '1',
  `stamp` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) NOT NULL DEFAULT '',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `createdby` bigint(10) unsigned DEFAULT NULL,
  `modifiedby` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_ques_cat_ix` (`category`),
  KEY `mdl_ques_par_ix` (`parent`),
  KEY `mdl_ques_cre_ix` (`createdby`),
  KEY `mdl_ques_mod_ix` (`modifiedby`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='The questions themselves';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question`
--

LOCK TABLES `mdl_question` WRITE;
/*!40000 ALTER TABLE `mdl_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_answers`
--

DROP TABLE IF EXISTS `mdl_question_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` text NOT NULL,
  `fraction` double NOT NULL DEFAULT '0',
  `feedback` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_quesansw_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Answers, with a fractional grade (0-1) and feedback';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_answers`
--

LOCK TABLES `mdl_question_answers` WRITE;
/*!40000 ALTER TABLE `mdl_question_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_attempts`
--

DROP TABLE IF EXISTS `mdl_question_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_attempts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `modulename` varchar(20) NOT NULL DEFAULT 'quiz',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Student attempts. This table gets extended by the modules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_attempts`
--

LOCK TABLES `mdl_question_attempts` WRITE;
/*!40000 ALTER TABLE `mdl_question_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_calculated`
--

DROP TABLE IF EXISTS `mdl_question_calculated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_calculated` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tolerance` varchar(20) NOT NULL DEFAULT '0.0',
  `tolerancetype` bigint(10) NOT NULL DEFAULT '1',
  `correctanswerlength` bigint(10) NOT NULL DEFAULT '2',
  `correctanswerformat` bigint(10) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `mdl_quescalc_ans_ix` (`answer`),
  KEY `mdl_quescalc_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options for questions of type calculated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_calculated`
--

LOCK TABLES `mdl_question_calculated` WRITE;
/*!40000 ALTER TABLE `mdl_question_calculated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_calculated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_categories`
--

DROP TABLE IF EXISTS `mdl_question_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `info` text NOT NULL,
  `stamp` varchar(255) NOT NULL DEFAULT '',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  KEY `mdl_quescate_con_ix` (`contextid`),
  KEY `mdl_quescate_par_ix` (`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Categories are for grouping questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_categories`
--

LOCK TABLES `mdl_question_categories` WRITE;
/*!40000 ALTER TABLE `mdl_question_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_dataset_definitions`
--

DROP TABLE IF EXISTS `mdl_question_dataset_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_dataset_definitions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` bigint(10) NOT NULL DEFAULT '0',
  `options` varchar(255) NOT NULL DEFAULT '',
  `itemcount` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesdatadefi_cat_ix` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Organises and stores properties for dataset items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_dataset_definitions`
--

LOCK TABLES `mdl_question_dataset_definitions` WRITE;
/*!40000 ALTER TABLE `mdl_question_dataset_definitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_dataset_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_dataset_items`
--

DROP TABLE IF EXISTS `mdl_question_dataset_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_dataset_items` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `definition` bigint(10) unsigned NOT NULL DEFAULT '0',
  `itemnumber` bigint(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_quesdataitem_def_ix` (`definition`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Individual dataset items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_dataset_items`
--

LOCK TABLES `mdl_question_dataset_items` WRITE;
/*!40000 ALTER TABLE `mdl_question_dataset_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_dataset_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_datasets`
--

DROP TABLE IF EXISTS `mdl_question_datasets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_datasets` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `datasetdefinition` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesdata_quedat_ix` (`question`,`datasetdefinition`),
  KEY `mdl_quesdata_que_ix` (`question`),
  KEY `mdl_quesdata_dat_ix` (`datasetdefinition`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Many-many relation between questions and dataset definitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_datasets`
--

LOCK TABLES `mdl_question_datasets` WRITE;
/*!40000 ALTER TABLE `mdl_question_datasets` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_datasets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_match`
--

DROP TABLE IF EXISTS `mdl_question_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_match` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `subquestions` varchar(255) NOT NULL DEFAULT '',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_quesmatc_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines fixed matching questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_match`
--

LOCK TABLES `mdl_question_match` WRITE;
/*!40000 ALTER TABLE `mdl_question_match` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_match_sub`
--

DROP TABLE IF EXISTS `mdl_question_match_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_match_sub` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `questiontext` text NOT NULL,
  `answertext` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_quesmatcsub_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines the subquestions that make up a matching question';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_match_sub`
--

LOCK TABLES `mdl_question_match_sub` WRITE;
/*!40000 ALTER TABLE `mdl_question_match_sub` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_match_sub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_multianswer`
--

DROP TABLE IF EXISTS `mdl_question_multianswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_multianswer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sequence` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_quesmult_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options for multianswer questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_multianswer`
--

LOCK TABLES `mdl_question_multianswer` WRITE;
/*!40000 ALTER TABLE `mdl_question_multianswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_multianswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_multichoice`
--

DROP TABLE IF EXISTS `mdl_question_multichoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_multichoice` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `layout` smallint(4) NOT NULL DEFAULT '0',
  `answers` varchar(255) NOT NULL DEFAULT '',
  `single` smallint(4) NOT NULL DEFAULT '0',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '1',
  `correctfeedback` text NOT NULL,
  `partiallycorrectfeedback` text NOT NULL,
  `incorrectfeedback` text NOT NULL,
  `answernumbering` varchar(10) NOT NULL DEFAULT 'abc',
  PRIMARY KEY (`id`),
  KEY `mdl_quesmult_que2_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options for multiple choice questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_multichoice`
--

LOCK TABLES `mdl_question_multichoice` WRITE;
/*!40000 ALTER TABLE `mdl_question_multichoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_multichoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_numerical`
--

DROP TABLE IF EXISTS `mdl_question_numerical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_numerical` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tolerance` varchar(255) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesnume_ans_ix` (`answer`),
  KEY `mdl_quesnume_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options for numerical questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_numerical`
--

LOCK TABLES `mdl_question_numerical` WRITE;
/*!40000 ALTER TABLE `mdl_question_numerical` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_numerical` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_numerical_units`
--

DROP TABLE IF EXISTS `mdl_question_numerical_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_numerical_units` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `multiplier` decimal(40,20) NOT NULL DEFAULT '1.00000000000000000000',
  `unit` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quesnumeunit_queuni_uix` (`question`,`unit`),
  KEY `mdl_quesnumeunit_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Optional unit options for numerical questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_numerical_units`
--

LOCK TABLES `mdl_question_numerical_units` WRITE;
/*!40000 ALTER TABLE `mdl_question_numerical_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_numerical_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_randomsamatch`
--

DROP TABLE IF EXISTS `mdl_question_randomsamatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_randomsamatch` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `choose` bigint(10) unsigned NOT NULL DEFAULT '4',
  PRIMARY KEY (`id`),
  KEY `mdl_quesrand_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about a random short-answer matching question';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_randomsamatch`
--

LOCK TABLES `mdl_question_randomsamatch` WRITE;
/*!40000 ALTER TABLE `mdl_question_randomsamatch` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_randomsamatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_sessions`
--

DROP TABLE IF EXISTS `mdl_question_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_sessions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attemptid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `questionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `newest` bigint(10) unsigned NOT NULL DEFAULT '0',
  `newgraded` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sumpenalty` double NOT NULL DEFAULT '0',
  `manualcomment` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quessess_attque_uix` (`attemptid`,`questionid`),
  KEY `mdl_quessess_att_ix` (`attemptid`),
  KEY `mdl_quessess_que_ix` (`questionid`),
  KEY `mdl_quessess_new_ix` (`newest`),
  KEY `mdl_quessess_new2_ix` (`newgraded`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Gives ids of the newest open and newest graded states';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_sessions`
--

LOCK TABLES `mdl_question_sessions` WRITE;
/*!40000 ALTER TABLE `mdl_question_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_shortanswer`
--

DROP TABLE IF EXISTS `mdl_question_shortanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_shortanswer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answers` varchar(255) NOT NULL DEFAULT '',
  `usecase` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesshor_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options for short answer questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_shortanswer`
--

LOCK TABLES `mdl_question_shortanswer` WRITE;
/*!40000 ALTER TABLE `mdl_question_shortanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_shortanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_states`
--

DROP TABLE IF EXISTS `mdl_question_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_states` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attempt` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `originalquestion` bigint(10) unsigned NOT NULL DEFAULT '0',
  `seq_number` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `answer` text NOT NULL,
  `timestamp` bigint(10) unsigned NOT NULL DEFAULT '0',
  `event` smallint(4) unsigned NOT NULL DEFAULT '0',
  `grade` double NOT NULL DEFAULT '0',
  `raw_grade` double NOT NULL DEFAULT '0',
  `penalty` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesstat_att_ix` (`attempt`),
  KEY `mdl_quesstat_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user responses to an attempt, and percentage grades';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_states`
--

LOCK TABLES `mdl_question_states` WRITE;
/*!40000 ALTER TABLE `mdl_question_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_question_truefalse`
--

DROP TABLE IF EXISTS `mdl_question_truefalse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_question_truefalse` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `trueanswer` bigint(10) unsigned NOT NULL DEFAULT '0',
  `falseanswer` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_questrue_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options for True-False questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_question_truefalse`
--

LOCK TABLES `mdl_question_truefalse` WRITE;
/*!40000 ALTER TABLE `mdl_question_truefalse` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_question_truefalse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_quiz`
--

DROP TABLE IF EXISTS `mdl_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_quiz` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `optionflags` bigint(10) unsigned NOT NULL DEFAULT '0',
  `penaltyscheme` smallint(4) unsigned NOT NULL DEFAULT '0',
  `attempts` mediumint(6) NOT NULL DEFAULT '0',
  `attemptonlast` smallint(4) NOT NULL DEFAULT '0',
  `grademethod` smallint(4) NOT NULL DEFAULT '1',
  `decimalpoints` smallint(4) NOT NULL DEFAULT '2',
  `review` bigint(10) unsigned NOT NULL DEFAULT '0',
  `questionsperpage` bigint(10) NOT NULL DEFAULT '0',
  `shufflequestions` smallint(4) NOT NULL DEFAULT '0',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '0',
  `questions` text NOT NULL,
  `sumgrades` bigint(10) NOT NULL DEFAULT '0',
  `grade` bigint(10) NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timelimit` bigint(10) unsigned NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `popup` smallint(4) NOT NULL DEFAULT '0',
  `delay1` bigint(10) NOT NULL DEFAULT '0',
  `delay2` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quiz_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Main information about each quiz';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_quiz`
--

LOCK TABLES `mdl_quiz` WRITE;
/*!40000 ALTER TABLE `mdl_quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_quiz_attempts`
--

DROP TABLE IF EXISTS `mdl_quiz_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_quiz_attempts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `attempt` mediumint(6) NOT NULL DEFAULT '0',
  `sumgrades` double NOT NULL DEFAULT '0',
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `layout` text NOT NULL,
  `preview` smallint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quizatte_uni_uix` (`uniqueid`),
  KEY `mdl_quizatte_use_ix` (`userid`),
  KEY `mdl_quizatte_qui_ix` (`quiz`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores various attempts on a quiz';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_quiz_attempts`
--

LOCK TABLES `mdl_quiz_attempts` WRITE;
/*!40000 ALTER TABLE `mdl_quiz_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_quiz_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_quiz_feedback`
--

DROP TABLE IF EXISTS `mdl_quiz_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_quiz_feedback` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quizid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedbacktext` text NOT NULL,
  `mingrade` double NOT NULL DEFAULT '0',
  `maxgrade` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quizfeed_qui_ix` (`quizid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Feedback given to students based on their overall score on t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_quiz_feedback`
--

LOCK TABLES `mdl_quiz_feedback` WRITE;
/*!40000 ALTER TABLE `mdl_quiz_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_quiz_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_quiz_grades`
--

DROP TABLE IF EXISTS `mdl_quiz_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_quiz_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` double NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quizgrad_use_ix` (`userid`),
  KEY `mdl_quizgrad_qui_ix` (`quiz`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Final quiz grade (may be best of several attempts)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_quiz_grades`
--

LOCK TABLES `mdl_quiz_grades` WRITE;
/*!40000 ALTER TABLE `mdl_quiz_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_quiz_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_quiz_question_instances`
--

DROP TABLE IF EXISTS `mdl_quiz_question_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_quiz_question_instances` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` mediumint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quizquesinst_qui_ix` (`quiz`),
  KEY `mdl_quizquesinst_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='The grade for a question in a quiz';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_quiz_question_instances`
--

LOCK TABLES `mdl_quiz_question_instances` WRITE;
/*!40000 ALTER TABLE `mdl_quiz_question_instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_quiz_question_instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_quiz_question_versions`
--

DROP TABLE IF EXISTS `mdl_quiz_question_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_quiz_question_versions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldquestion` bigint(10) unsigned NOT NULL DEFAULT '0',
  `newquestion` bigint(10) unsigned NOT NULL DEFAULT '0',
  `originalquestion` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quizquesvers_qui_ix` (`quiz`),
  KEY `mdl_quizquesvers_old_ix` (`oldquestion`),
  KEY `mdl_quizquesvers_new_ix` (`newquestion`),
  KEY `mdl_quizquesvers_ori_ix` (`originalquestion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='quiz_question_versions table retrofitted from MySQL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_quiz_question_versions`
--

LOCK TABLES `mdl_quiz_question_versions` WRITE;
/*!40000 ALTER TABLE `mdl_quiz_question_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_quiz_question_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_resource`
--

DROP TABLE IF EXISTS `mdl_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_resource` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(30) NOT NULL DEFAULT '',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `summary` text,
  `alltext` mediumtext NOT NULL,
  `popup` text NOT NULL,
  `options` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_reso_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='each record is one resource and its config data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_resource`
--

LOCK TABLES `mdl_resource` WRITE;
/*!40000 ALTER TABLE `mdl_resource` DISABLE KEYS */;
INSERT INTO `mdl_resource` VALUES (1,13,'Film: Afval scheiden','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_afvalscheiden01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312835042),(2,13,'Film: Glas recyclen','file','http://www.schooltv.nl/beeldbank/clippopup/20031203_afval01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312835257),(3,13,'Film: Schoonmaken in huis','file','http://www.schooltv.nl/beeldbank/clippopup/20031203_wassen01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312835308),(4,13,'Film: Spullen kopen voor je kamer','file','http://www.schooltv.nl/beeldbank/clippopup/20050725_kamer01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312835356),(5,14,'Film: De groei van Utrecht','file','http://www.schooltv.nl/beeldbank/clippopup/20090710_stad02','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834915),(6,14,'Film: Het ontstaan van Amsterdam','file','http://www.schooltv.nl/beeldbank/clippopup/20040317_amsterdam01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834932),(7,14,'Film: Verstedelijking van Nederland','file','http://www.schooltv.nl/beeldbank/clippopup/20090710_stad01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834948),(8,14,'Film: De overzichtskaart','file','http://www.schooltv.nl/beeldbank/clippopup/20100301_kaart01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834963),(9,14,'Film: Besluiten door de gemeenteraad','file','http://www.schooltv.nl/beeldbank/clippopup/20051221_gemeenteraad01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834978),(10,15,'Film: De overzichtskaart','file','http://www.schooltv.nl/beeldbank/clippopup/20100301_kaart01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834802),(11,15,'Film: Wonen in een middeleeuws huis','file','http://www.schooltv.nl/beeldbank/clippopup/20050614_middeleeuwen06','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834820),(12,15,'Film: Een middeleeuwse straat','file','http://www.schooltv.nl/beeldbank/clippopup/20050614_middeleeuwen05','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834835),(13,15,'Film: Speeltoestellen voor openbare ruimtes','file','http://www.schooltv.nl/beeldbank/clippopup/20100601_speeltoestel01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834866),(14,16,'Film: Afval scheiden','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_afvalscheiden01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834615),(15,16,'Film: Groenafval','file','http://www.schooltv.nl/beeldbank/clippopup/20021104_compost02','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834632),(16,16,'Film: Restafval','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_restafval01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834649),(17,16,'Film: Glasafval','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_glasrecycling01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834666),(18,16,'Film: Oud papier','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_papierfabriek01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834705),(19,16,'Film: Het riool','file','http://www.schooltv.nl/beeldbank/clippopup/20030701_water01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834723),(20,16,'Film: Straatputten en leidingen onder de grond','file','http://www.schooltv.nl/beeldbank/clippopup/20030701_water02','<!--[if gte mso 9]><xml>&#010; <w:WordDocument>&#010;  <w:View>Normal</w:View>&#010;  <w:Zoom>0</w:Zoom>&#010;  <w:TrackMoves/>&#010;  <w:TrackFormatting/>&#010;  <w:HyphenationZone>21</w:HyphenationZone>&#010;  <w:PunctuationKerning/>&#010;  <w:ValidateAgainstSchemas/>&#010;  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>&#010;  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>&#010;  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>&#010;  <w:DoNotPromoteQF/>&#010;  <w:LidThemeOther>NL</w:LidThemeOther>&#010;  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>&#010;  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>&#010;  <w:Compatibility>&#010;   <w:BreakWrappedTables/>&#010;   <w:SnapToGridInCell/>&#010;   <w:WrapTextWithPunct/>&#010;   <w:UseAsianBreakRules/>&#010;   <w:DontGrowAutofit/>&#010;   <w:SplitPgBreakAndParaMark/>&#010;   <w:DontVertAlignCellWithSp/>&#010;   <w:DontBreakConstrainedForcedTables/>&#010;   <w:DontVertAlignInTxbx/>&#010;   <w:Word11KerningPairs/>&#010;   <w:CachedColBalance/>&#010;  </w:Compatibility>&#010;  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>&#010;  <m:mathPr>&#010;   <m:mathFont m:val=\"Cambria Math\"/>&#010;   <m:brkBin m:val=\"before\"/>&#010;   <m:brkBinSub m:val=\"&#45;-\"/>&#010;   <m:smallFrac m:val=\"off\"/>&#010;   <m:dispDef/>&#010;   <m:lMargin m:val=\"0\"/>&#010;   <m:rMargin m:val=\"0\"/>&#010;   <m:defJc m:val=\"centerGroup\"/>&#010;   <m:wrapIndent m:val=\"1440\"/>&#010;   <m:intLim m:val=\"subSup\"/>&#010;   <m:naryLim m:val=\"undOvr\"/>&#010;  </m:mathPr></w:WordDocument>&#010;</xml><![endif]--><!--[if gte mso 9]><xml>&#010; <w:LatentStyles DefLockedState=\"false\" DefUnhideWhenUsed=\"true\"&#010;  DefSemiHidden=\"true\" DefQFormat=\"false\" DefPriority=\"99\"&#010;  LatentStyleCount=\"267\">&#010;  <w:LsdException Locked=\"false\" Priority=\"0\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Normal\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"heading 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 7\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 8\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 9\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 7\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 8\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 9\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"35\" QFormat=\"true\" Name=\"caption\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"10\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Title\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"1\" Name=\"Default Paragraph Font\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"11\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Subtitle\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"22\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Strong\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"20\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Emphasis\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"59\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Table Grid\"/>&#010;  <w:LsdException Locked=\"false\" UnhideWhenUsed=\"false\" Name=\"Placeholder Text\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"1\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"No Spacing\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" UnhideWhenUsed=\"false\" Name=\"Revision\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"34\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"List Paragraph\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"29\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Quote\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"30\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Intense Quote\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"19\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Subtle Emphasis\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"21\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Intense Emphasis\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"31\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Subtle Reference\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"32\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Intense Reference\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"33\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Book Title\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"37\" Name=\"Bibliography\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" QFormat=\"true\" Name=\"TOC Heading\"/>&#010; </w:LatentStyles>&#010;</xml><![endif]--><!--[if gte mso 10]>&#010;<style>&#010; /* Style Definitions */&#010; table.MsoNormalTable&#010;	{mso-style-name:Standaardtabel;&#010;	mso-tstyle-rowband-size:0;&#010;	mso-tstyle-colband-size:0;&#010;	mso-style-noshow:yes;&#010;	mso-style-priority:99;&#010;	mso-style-qformat:yes;&#010;	mso-style-parent:\"\";&#010;	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;&#010;	mso-para-margin:0cm;&#010;	mso-para-margin-bottom:.0001pt;&#010;	mso-pagination:widow-orphan;&#010;	font-size:11.0pt;&#010;	font-family:\"Calibri\",\"sans-serif\";&#010;	mso-ascii-font-family:Calibri;&#010;	mso-ascii-theme-font:minor-latin;&#010;	mso-fareast-font-family:\"Times New Roman\";&#010;	mso-fareast-theme-font:minor-fareast;&#010;	mso-hansi-font-family:Calibri;&#010;	mso-hansi-theme-font:minor-latin;&#010;	mso-bidi-font-family:\"Times New Roman\";&#010;	mso-bidi-theme-font:minor-bidi;}&#010;</style>&#010;<![endif]-->\n<p class=\"LijstopsommingZR\"><a href=\"http://www.schooltv.nl/beeldbank/clip/20030701_water02\"><span style=\"color: windowtext; text-decoration: none;\"><br /></span></a></p>','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834740),(21,16,'Film: De waterzuivering, de waterleiding en het riool','file','http://www.schooltv.nl/beeldbank/clippopup/20060913_waterz_animatie','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834762),(22,16,'Film: Zelf een speeltuin maken','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_speeltuinmaken01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834779),(23,17,'Film: Afval scheiden','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_afvalscheiden01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834615),(24,17,'Film: Groenafval','file','http://www.schooltv.nl/beeldbank/clippopup/20021104_compost02','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834632),(25,17,'Film: Restafval','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_restafval01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834649),(26,17,'Film: Glasafval','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_glasrecycling01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834666),(27,17,'Film: Oud papier','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_papierfabriek01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834705),(28,17,'Film: Het riool','file','http://www.schooltv.nl/beeldbank/clippopup/20030701_water01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834723),(29,17,'Film: Straatputten en leidingen onder de grond','file','http://www.schooltv.nl/beeldbank/clippopup/20030701_water02','<!--[if gte mso 9]><xml>&#010; <w:WordDocument>&#010;  <w:View>Normal</w:View>&#010;  <w:Zoom>0</w:Zoom>&#010;  <w:TrackMoves/>&#010;  <w:TrackFormatting/>&#010;  <w:HyphenationZone>21</w:HyphenationZone>&#010;  <w:PunctuationKerning/>&#010;  <w:ValidateAgainstSchemas/>&#010;  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>&#010;  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>&#010;  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>&#010;  <w:DoNotPromoteQF/>&#010;  <w:LidThemeOther>NL</w:LidThemeOther>&#010;  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>&#010;  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>&#010;  <w:Compatibility>&#010;   <w:BreakWrappedTables/>&#010;   <w:SnapToGridInCell/>&#010;   <w:WrapTextWithPunct/>&#010;   <w:UseAsianBreakRules/>&#010;   <w:DontGrowAutofit/>&#010;   <w:SplitPgBreakAndParaMark/>&#010;   <w:DontVertAlignCellWithSp/>&#010;   <w:DontBreakConstrainedForcedTables/>&#010;   <w:DontVertAlignInTxbx/>&#010;   <w:Word11KerningPairs/>&#010;   <w:CachedColBalance/>&#010;  </w:Compatibility>&#010;  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>&#010;  <m:mathPr>&#010;   <m:mathFont m:val=\"Cambria Math\"/>&#010;   <m:brkBin m:val=\"before\"/>&#010;   <m:brkBinSub m:val=\"&#45;-\"/>&#010;   <m:smallFrac m:val=\"off\"/>&#010;   <m:dispDef/>&#010;   <m:lMargin m:val=\"0\"/>&#010;   <m:rMargin m:val=\"0\"/>&#010;   <m:defJc m:val=\"centerGroup\"/>&#010;   <m:wrapIndent m:val=\"1440\"/>&#010;   <m:intLim m:val=\"subSup\"/>&#010;   <m:naryLim m:val=\"undOvr\"/>&#010;  </m:mathPr></w:WordDocument>&#010;</xml><![endif]--><!--[if gte mso 9]><xml>&#010; <w:LatentStyles DefLockedState=\"false\" DefUnhideWhenUsed=\"true\"&#010;  DefSemiHidden=\"true\" DefQFormat=\"false\" DefPriority=\"99\"&#010;  LatentStyleCount=\"267\">&#010;  <w:LsdException Locked=\"false\" Priority=\"0\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Normal\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"heading 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 7\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 8\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 9\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 7\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 8\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"toc 9\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"35\" QFormat=\"true\" Name=\"caption\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"10\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Title\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"1\" Name=\"Default Paragraph Font\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"11\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Subtitle\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"22\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Strong\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"20\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Emphasis\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"59\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Table Grid\"/>&#010;  <w:LsdException Locked=\"false\" UnhideWhenUsed=\"false\" Name=\"Placeholder Text\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"1\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"No Spacing\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" UnhideWhenUsed=\"false\" Name=\"Revision\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"34\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"List Paragraph\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"29\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Quote\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"30\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Intense Quote\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 1\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 2\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 3\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 4\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 5\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"60\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Shading Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"61\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light List Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"62\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Light Grid Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"63\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 1 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"64\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Shading 2 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"65\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 1 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"66\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium List 2 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"67\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 1 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"68\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 2 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"69\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Medium Grid 3 Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"70\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Dark List Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"71\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Shading Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"72\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful List Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"73\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" Name=\"Colorful Grid Accent 6\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"19\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Subtle Emphasis\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"21\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Intense Emphasis\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"31\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Subtle Reference\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"32\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Intense Reference\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"33\" SemiHidden=\"false\"&#010;   UnhideWhenUsed=\"false\" QFormat=\"true\" Name=\"Book Title\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"37\" Name=\"Bibliography\"/>&#010;  <w:LsdException Locked=\"false\" Priority=\"39\" QFormat=\"true\" Name=\"TOC Heading\"/>&#010; </w:LatentStyles>&#010;</xml><![endif]--><!--[if gte mso 10]>&#010;<style>&#010; /* Style Definitions */&#010; table.MsoNormalTable&#010;	{mso-style-name:Standaardtabel;&#010;	mso-tstyle-rowband-size:0;&#010;	mso-tstyle-colband-size:0;&#010;	mso-style-noshow:yes;&#010;	mso-style-priority:99;&#010;	mso-style-qformat:yes;&#010;	mso-style-parent:\"\";&#010;	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;&#010;	mso-para-margin:0cm;&#010;	mso-para-margin-bottom:.0001pt;&#010;	mso-pagination:widow-orphan;&#010;	font-size:11.0pt;&#010;	font-family:\"Calibri\",\"sans-serif\";&#010;	mso-ascii-font-family:Calibri;&#010;	mso-ascii-theme-font:minor-latin;&#010;	mso-fareast-font-family:\"Times New Roman\";&#010;	mso-fareast-theme-font:minor-fareast;&#010;	mso-hansi-font-family:Calibri;&#010;	mso-hansi-theme-font:minor-latin;&#010;	mso-bidi-font-family:\"Times New Roman\";&#010;	mso-bidi-theme-font:minor-bidi;}&#010;</style>&#010;<![endif]-->\n<p class=\"LijstopsommingZR\"><a href=\"http://www.schooltv.nl/beeldbank/clip/20030701_water02\"><span style=\"color: windowtext; text-decoration: none;\"><br /></span></a></p>','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834740),(30,17,'Film: De waterzuivering, de waterleiding en het riool','file','http://www.schooltv.nl/beeldbank/clippopup/20060913_waterz_animatie','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834762),(31,17,'Film: Zelf een speeltuin maken','file','http://www.schooltv.nl/beeldbank/clippopup/20050115_speeltuinmaken01','','','resizable=,scrollbars=,directories=,location=,menubar=,toolbar=,status=,width=680,height=540','',1312834779);
/*!40000 ALTER TABLE `mdl_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role`
--

DROP TABLE IF EXISTS `mdl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_role_sor_uix` (`sortorder`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='moodle roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role`
--

LOCK TABLES `mdl_role` WRITE;
/*!40000 ALTER TABLE `mdl_role` DISABLE KEYS */;
INSERT INTO `mdl_role` VALUES (1,'Administrator','admin','Administrators can usually do anything on the site, in all courses.',0),(2,'Course creator','coursecreator','Course creators can create new courses.',1),(3,'Teacher','editingteacher','Teachers can do anything within a course, including changing the activities and grading students.',2),(4,'Non-editing teacher','teacher','Non-editing teachers can teach in courses and grade students, but may not alter activities.',3),(5,'Student','student','Students generally have fewer privileges within a course.',4),(6,'Guest','guest','Guests have minimal privileges and usually can not enter text anywhere.',5),(7,'Authenticated user','user','All logged in users.',6),(9,'Substitute','substitute',' Substitute is a duplicate of Non-editing teacher. Substitutes get enrolled in all courses.<br /> ',7),(11,'School leader','schoolleader','School leader is a duplicate of Non-editing teacher.<br />A school leader gets enrolled in all courses.<br /> ',8);
/*!40000 ALTER TABLE `mdl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role_allow_assign`
--

DROP TABLE IF EXISTS `mdl_role_allow_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role_allow_assign` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `allowassign` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolealloassi_rolall_uix` (`roleid`,`allowassign`),
  KEY `mdl_rolealloassi_rol_ix` (`roleid`),
  KEY `mdl_rolealloassi_all_ix` (`allowassign`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='this defines what role can assign what role';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role_allow_assign`
--

LOCK TABLES `mdl_role_allow_assign` WRITE;
/*!40000 ALTER TABLE `mdl_role_allow_assign` DISABLE KEYS */;
INSERT INTO `mdl_role_allow_assign` VALUES (1,1,1),(2,1,2),(3,1,4),(4,1,3),(5,1,5),(6,1,6),(7,2,4),(8,2,3),(9,2,5),(10,2,6),(11,3,4),(12,3,5),(13,3,6),(15,1,9),(17,1,11);
/*!40000 ALTER TABLE `mdl_role_allow_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role_allow_override`
--

DROP TABLE IF EXISTS `mdl_role_allow_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role_allow_override` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `allowoverride` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolealloover_rolall_uix` (`roleid`,`allowoverride`),
  KEY `mdl_rolealloover_rol_ix` (`roleid`),
  KEY `mdl_rolealloover_all_ix` (`allowoverride`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='this defines what role can override what role';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role_allow_override`
--

LOCK TABLES `mdl_role_allow_override` WRITE;
/*!40000 ALTER TABLE `mdl_role_allow_override` DISABLE KEYS */;
INSERT INTO `mdl_role_allow_override` VALUES (1,1,1),(2,1,2),(3,1,4),(4,1,3),(5,1,5),(6,1,6),(7,1,7),(9,1,9),(11,1,11);
/*!40000 ALTER TABLE `mdl_role_allow_override` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role_assignments`
--

DROP TABLE IF EXISTS `mdl_role_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role_assignments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modifierid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enrol` varchar(20) NOT NULL DEFAULT '',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_roleassi_conroluse_uix` (`contextid`,`roleid`,`userid`),
  KEY `mdl_roleassi_sor_ix` (`sortorder`),
  KEY `mdl_roleassi_rol_ix` (`roleid`),
  KEY `mdl_roleassi_con_ix` (`contextid`),
  KEY `mdl_roleassi_use_ix` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='assigning roles to different context';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role_assignments`
--

LOCK TABLES `mdl_role_assignments` WRITE;
/*!40000 ALTER TABLE `mdl_role_assignments` DISABLE KEYS */;
INSERT INTO `mdl_role_assignments` VALUES (1,1,1,2,0,0,0,1323876931,0,'manual',0);
/*!40000 ALTER TABLE `mdl_role_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role_capabilities`
--

DROP TABLE IF EXISTS `mdl_role_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role_capabilities` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `capability` varchar(255) NOT NULL DEFAULT '',
  `permission` bigint(10) NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modifierid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolecapa_rolconcap_uix` (`roleid`,`contextid`,`capability`),
  KEY `mdl_rolecapa_rol_ix` (`roleid`),
  KEY `mdl_rolecapa_con_ix` (`contextid`),
  KEY `mdl_rolecapa_mod_ix` (`modifierid`),
  KEY `mdl_rolecapa_cap_ix` (`capability`)
) ENGINE=MyISAM AUTO_INCREMENT=998 DEFAULT CHARSET=utf8 COMMENT='permission has to be signed, overriding a capability for a p';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role_capabilities`
--

LOCK TABLES `mdl_role_capabilities` WRITE;
/*!40000 ALTER TABLE `mdl_role_capabilities` DISABLE KEYS */;
INSERT INTO `mdl_role_capabilities` VALUES (1,1,1,'moodle/legacy:admin',1,1323876844,0),(2,1,2,'moodle/legacy:coursecreator',1,1323876844,0),(3,1,3,'moodle/legacy:editingteacher',1,1323876844,0),(4,1,4,'moodle/legacy:teacher',1,1323876844,0),(5,1,5,'moodle/legacy:student',1,1323876844,0),(6,1,6,'moodle/legacy:guest',1,1323876844,0),(7,1,7,'moodle/legacy:user',1,1323876844,0),(8,1,1,'moodle/site:doanything',1,1323876844,0),(9,1,1,'moodle/site:config',1,1323876844,0),(10,1,1,'moodle/site:readallmessages',1,1323876844,0),(11,1,3,'moodle/site:readallmessages',1,1323876844,0),(12,1,1,'moodle/site:sendmessage',1,1323876844,0),(13,1,7,'moodle/site:sendmessage',1,1323876844,0),(14,1,1,'moodle/site:approvecourse',1,1323876844,0),(15,1,3,'moodle/site:import',1,1323876844,0),(16,1,1,'moodle/site:import',1,1323876844,0),(17,1,3,'moodle/site:backup',1,1323876844,0),(18,1,1,'moodle/site:backup',1,1323876844,0),(19,1,1,'moodle/backup:userinfo',1,1323876844,0),(20,1,3,'moodle/site:restore',1,1323876844,0),(21,1,1,'moodle/site:restore',1,1323876844,0),(22,1,1,'moodle/restore:createuser',1,1323876844,0),(23,1,1,'moodle/restore:userinfo',1,1323876844,0),(24,1,2,'moodle/restore:rolldates',1,1323876844,0),(25,1,1,'moodle/restore:rolldates',1,1323876844,0),(26,1,3,'moodle/site:manageblocks',1,1323876844,0),(27,1,1,'moodle/site:manageblocks',1,1323876844,0),(28,1,4,'moodle/site:accessallgroups',1,1323876844,0),(29,1,3,'moodle/site:accessallgroups',1,1323876844,0),(30,1,1,'moodle/site:accessallgroups',1,1323876844,0),(31,1,4,'moodle/site:viewfullnames',1,1323876844,0),(32,1,3,'moodle/site:viewfullnames',1,1323876844,0),(33,1,1,'moodle/site:viewfullnames',1,1323876844,0),(34,1,4,'moodle/site:viewreports',1,1323876844,0),(35,1,3,'moodle/site:viewreports',1,1323876844,0),(36,1,1,'moodle/site:viewreports',1,1323876844,0),(37,1,3,'moodle/site:trustcontent',1,1323876844,0),(38,1,1,'moodle/site:trustcontent',1,1323876844,0),(39,1,1,'moodle/site:uploadusers',1,1323876844,0),(40,1,1,'moodle/site:langeditmaster',-1,1323876844,0),(41,1,1,'moodle/site:langeditlocal',1,1323876844,0),(42,1,1,'moodle/user:create',1,1323876844,0),(43,1,1,'moodle/user:delete',1,1323876844,0),(44,1,1,'moodle/user:update',1,1323876844,0),(45,1,6,'moodle/user:viewdetails',1,1323876844,0),(46,1,5,'moodle/user:viewdetails',1,1323876844,0),(47,1,4,'moodle/user:viewdetails',1,1323876844,0),(48,1,3,'moodle/user:viewdetails',1,1323876844,0),(49,1,1,'moodle/user:viewdetails',1,1323876844,0),(50,1,4,'moodle/user:viewhiddendetails',1,1323876844,0),(51,1,3,'moodle/user:viewhiddendetails',1,1323876844,0),(52,1,1,'moodle/user:viewhiddendetails',1,1323876844,0),(53,1,1,'moodle/user:loginas',1,1323876844,0),(54,1,3,'moodle/role:assign',1,1323876844,0),(55,1,1,'moodle/role:assign',1,1323876844,0),(56,1,1,'moodle/role:override',1,1323876844,0),(57,1,3,'moodle/role:safeoverride',1,1323876844,0),(58,1,1,'moodle/role:manage',1,1323876844,0),(59,1,4,'moodle/role:unassignself',1,1323876844,0),(60,1,3,'moodle/role:unassignself',1,1323876844,0),(61,1,2,'moodle/role:unassignself',1,1323876844,0),(62,1,1,'moodle/role:unassignself',1,1323876844,0),(63,1,4,'moodle/role:viewhiddenassigns',1,1323876844,0),(64,1,3,'moodle/role:viewhiddenassigns',1,1323876844,0),(65,1,1,'moodle/role:viewhiddenassigns',1,1323876844,0),(66,1,3,'moodle/role:switchroles',1,1323876844,0),(67,1,1,'moodle/role:switchroles',1,1323876844,0),(68,1,1,'moodle/category:manage',1,1323876844,0),(69,1,2,'moodle/category:viewhiddencategories',1,1323876844,0),(70,1,1,'moodle/category:viewhiddencategories',1,1323876844,0),(71,1,2,'moodle/course:create',1,1323876844,0),(72,1,1,'moodle/course:create',1,1323876844,0),(73,1,7,'moodle/course:request',1,1323876844,0),(74,1,1,'moodle/course:delete',1,1323876844,0),(75,1,3,'moodle/course:update',1,1323876844,0),(76,1,1,'moodle/course:update',1,1323876844,0),(77,1,6,'moodle/course:view',1,1323876844,0),(78,1,5,'moodle/course:view',1,1323876844,0),(79,1,4,'moodle/course:view',1,1323876844,0),(80,1,3,'moodle/course:view',1,1323876844,0),(81,1,4,'moodle/course:bulkmessaging',1,1323876844,0),(82,1,3,'moodle/course:bulkmessaging',1,1323876844,0),(83,1,1,'moodle/course:bulkmessaging',1,1323876844,0),(84,1,4,'moodle/course:viewhiddenuserfields',1,1323876844,0),(85,1,3,'moodle/course:viewhiddenuserfields',1,1323876844,0),(86,1,1,'moodle/course:viewhiddenuserfields',1,1323876844,0),(87,1,2,'moodle/course:viewhiddencourses',1,1323876844,0),(88,1,4,'moodle/course:viewhiddencourses',1,1323876844,0),(89,1,3,'moodle/course:viewhiddencourses',1,1323876844,0),(90,1,1,'moodle/course:viewhiddencourses',1,1323876844,0),(91,1,3,'moodle/course:visibility',1,1323876844,0),(92,1,1,'moodle/course:visibility',1,1323876844,0),(93,1,3,'moodle/course:managefiles',1,1323876844,0),(94,1,1,'moodle/course:managefiles',1,1323876844,0),(95,1,3,'moodle/course:manageactivities',1,1323876844,0),(96,1,1,'moodle/course:manageactivities',1,1323876844,0),(97,1,3,'moodle/course:managemetacourse',1,1323876844,0),(98,1,1,'moodle/course:managemetacourse',1,1323876844,0),(99,1,3,'moodle/course:activityvisibility',1,1323876844,0),(100,1,1,'moodle/course:activityvisibility',1,1323876844,0),(101,1,4,'moodle/course:viewhiddenactivities',1,1323876844,0),(102,1,3,'moodle/course:viewhiddenactivities',1,1323876844,0),(103,1,1,'moodle/course:viewhiddenactivities',1,1323876844,0),(104,1,5,'moodle/course:viewparticipants',1,1323876844,0),(105,1,4,'moodle/course:viewparticipants',1,1323876844,0),(106,1,3,'moodle/course:viewparticipants',1,1323876844,0),(107,1,1,'moodle/course:viewparticipants',1,1323876844,0),(108,1,3,'moodle/course:changefullname',1,1323876844,0),(109,1,1,'moodle/course:changefullname',1,1323876844,0),(110,1,3,'moodle/course:changeshortname',1,1323876844,0),(111,1,1,'moodle/course:changeshortname',1,1323876844,0),(112,1,3,'moodle/course:changeidnumber',1,1323876844,0),(113,1,1,'moodle/course:changeidnumber',1,1323876844,0),(114,1,3,'moodle/course:changecategory',1,1323876844,0),(115,1,1,'moodle/course:changecategory',1,1323876844,0),(116,1,3,'moodle/course:changesummary',1,1323876844,0),(117,1,1,'moodle/course:changesummary',1,1323876844,0),(118,1,1,'moodle/site:viewparticipants',1,1323876844,0),(119,1,5,'moodle/course:viewscales',1,1323876844,0),(120,1,4,'moodle/course:viewscales',1,1323876844,0),(121,1,3,'moodle/course:viewscales',1,1323876844,0),(122,1,1,'moodle/course:viewscales',1,1323876844,0),(123,1,3,'moodle/course:managescales',1,1323876844,0),(124,1,1,'moodle/course:managescales',1,1323876844,0),(125,1,3,'moodle/course:managegroups',1,1323876844,0),(126,1,1,'moodle/course:managegroups',1,1323876844,0),(127,1,3,'moodle/course:reset',1,1323876844,0),(128,1,1,'moodle/course:reset',1,1323876844,0),(129,1,6,'moodle/blog:view',1,1323876844,0),(130,1,7,'moodle/blog:view',1,1323876844,0),(131,1,5,'moodle/blog:view',1,1323876844,0),(132,1,4,'moodle/blog:view',1,1323876844,0),(133,1,3,'moodle/blog:view',1,1323876844,0),(134,1,1,'moodle/blog:view',1,1323876844,0),(135,1,7,'moodle/blog:create',1,1323876844,0),(136,1,1,'moodle/blog:create',1,1323876844,0),(137,1,4,'moodle/blog:manageentries',1,1323876844,0),(138,1,3,'moodle/blog:manageentries',1,1323876844,0),(139,1,1,'moodle/blog:manageentries',1,1323876844,0),(140,1,7,'moodle/calendar:manageownentries',1,1323876844,0),(141,1,1,'moodle/calendar:manageownentries',1,1323876844,0),(142,1,4,'moodle/calendar:managegroupentries',1,1323876844,0),(143,1,3,'moodle/calendar:managegroupentries',1,1323876844,0),(144,1,1,'moodle/calendar:managegroupentries',1,1323876844,0),(145,1,4,'moodle/calendar:manageentries',1,1323876844,0),(146,1,3,'moodle/calendar:manageentries',1,1323876844,0),(147,1,1,'moodle/calendar:manageentries',1,1323876844,0),(148,1,1,'moodle/user:editprofile',1,1323876844,0),(149,1,6,'moodle/user:editownprofile',-1000,1323876844,0),(150,1,7,'moodle/user:editownprofile',1,1323876844,0),(151,1,1,'moodle/user:editownprofile',1,1323876844,0),(152,1,6,'moodle/user:changeownpassword',-1000,1323876844,0),(153,1,7,'moodle/user:changeownpassword',1,1323876844,0),(154,1,1,'moodle/user:changeownpassword',1,1323876844,0),(155,1,5,'moodle/user:readuserposts',1,1323876844,0),(156,1,4,'moodle/user:readuserposts',1,1323876844,0),(157,1,3,'moodle/user:readuserposts',1,1323876844,0),(158,1,1,'moodle/user:readuserposts',1,1323876844,0),(159,1,5,'moodle/user:readuserblogs',1,1323876844,0),(160,1,4,'moodle/user:readuserblogs',1,1323876844,0),(161,1,3,'moodle/user:readuserblogs',1,1323876844,0),(162,1,1,'moodle/user:readuserblogs',1,1323876844,0),(163,1,3,'moodle/question:managecategory',1,1323876844,0),(164,1,1,'moodle/question:managecategory',1,1323876844,0),(165,1,3,'moodle/question:add',1,1323876844,0),(166,1,1,'moodle/question:add',1,1323876844,0),(167,1,3,'moodle/question:editmine',1,1323876844,0),(168,1,1,'moodle/question:editmine',1,1323876844,0),(169,1,3,'moodle/question:editall',1,1323876844,0),(170,1,1,'moodle/question:editall',1,1323876844,0),(171,1,3,'moodle/question:viewmine',1,1323876844,0),(172,1,1,'moodle/question:viewmine',1,1323876844,0),(173,1,3,'moodle/question:viewall',1,1323876844,0),(174,1,1,'moodle/question:viewall',1,1323876844,0),(175,1,3,'moodle/question:usemine',1,1323876844,0),(176,1,1,'moodle/question:usemine',1,1323876844,0),(177,1,3,'moodle/question:useall',1,1323876844,0),(178,1,1,'moodle/question:useall',1,1323876844,0),(179,1,3,'moodle/question:movemine',1,1323876844,0),(180,1,1,'moodle/question:movemine',1,1323876844,0),(181,1,3,'moodle/question:moveall',1,1323876844,0),(182,1,1,'moodle/question:moveall',1,1323876845,0),(183,1,1,'moodle/question:config',1,1323876845,0),(184,1,4,'moodle/site:doclinks',1,1323876845,0),(185,1,3,'moodle/site:doclinks',1,1323876845,0),(186,1,1,'moodle/site:doclinks',1,1323876845,0),(187,1,3,'moodle/course:sectionvisibility',1,1323876845,0),(188,1,1,'moodle/course:sectionvisibility',1,1323876845,0),(189,1,3,'moodle/course:useremail',1,1323876845,0),(190,1,1,'moodle/course:useremail',1,1323876845,0),(191,1,3,'moodle/course:viewhiddensections',1,1323876845,0),(192,1,1,'moodle/course:viewhiddensections',1,1323876845,0),(193,1,3,'moodle/course:setcurrentsection',1,1323876845,0),(194,1,1,'moodle/course:setcurrentsection',1,1323876845,0),(195,1,1,'moodle/site:mnetlogintoremote',1,1323876845,0),(196,1,4,'moodle/grade:viewall',1,1323876845,0),(197,1,3,'moodle/grade:viewall',1,1323876845,0),(198,1,1,'moodle/grade:viewall',1,1323876845,0),(199,1,5,'moodle/grade:view',1,1323876845,0),(200,1,4,'moodle/grade:viewhidden',1,1323876845,0),(201,1,3,'moodle/grade:viewhidden',1,1323876845,0),(202,1,1,'moodle/grade:viewhidden',1,1323876845,0),(203,1,3,'moodle/grade:import',1,1323876845,0),(204,1,1,'moodle/grade:import',1,1323876845,0),(205,1,4,'moodle/grade:export',1,1323876845,0),(206,1,3,'moodle/grade:export',1,1323876845,0),(207,1,1,'moodle/grade:export',1,1323876845,0),(208,1,3,'moodle/grade:manage',1,1323876845,0),(209,1,1,'moodle/grade:manage',1,1323876845,0),(210,1,3,'moodle/grade:edit',1,1323876845,0),(211,1,1,'moodle/grade:edit',1,1323876845,0),(212,1,3,'moodle/grade:manageoutcomes',1,1323876845,0),(213,1,1,'moodle/grade:manageoutcomes',1,1323876845,0),(214,1,3,'moodle/grade:manageletters',1,1323876845,0),(215,1,1,'moodle/grade:manageletters',1,1323876845,0),(216,1,3,'moodle/grade:hide',1,1323876845,0),(217,1,1,'moodle/grade:hide',1,1323876845,0),(218,1,3,'moodle/grade:lock',1,1323876845,0),(219,1,1,'moodle/grade:lock',1,1323876845,0),(220,1,3,'moodle/grade:unlock',1,1323876845,0),(221,1,1,'moodle/grade:unlock',1,1323876845,0),(222,1,7,'moodle/my:manageblocks',1,1323876845,0),(223,1,4,'moodle/notes:view',1,1323876845,0),(224,1,3,'moodle/notes:view',1,1323876845,0),(225,1,1,'moodle/notes:view',1,1323876845,0),(226,1,4,'moodle/notes:manage',1,1323876845,0),(227,1,3,'moodle/notes:manage',1,1323876845,0),(228,1,1,'moodle/notes:manage',1,1323876845,0),(229,1,4,'moodle/tag:manage',1,1323876845,0),(230,1,3,'moodle/tag:manage',1,1323876845,0),(231,1,1,'moodle/tag:manage',1,1323876845,0),(232,1,1,'moodle/tag:create',1,1323876845,0),(233,1,7,'moodle/tag:create',1,1323876845,0),(234,1,1,'moodle/tag:edit',1,1323876845,0),(235,1,7,'moodle/tag:edit',1,1323876845,0),(236,1,4,'moodle/tag:editblocks',1,1323876845,0),(237,1,3,'moodle/tag:editblocks',1,1323876845,0),(238,1,1,'moodle/tag:editblocks',1,1323876845,0),(239,1,6,'moodle/block:view',1,1323876845,0),(240,1,7,'moodle/block:view',1,1323876845,0),(241,1,5,'moodle/block:view',1,1323876845,0),(242,1,4,'moodle/block:view',1,1323876845,0),(243,1,3,'moodle/block:view',1,1323876845,0),(244,1,2,'moodle/block:view',1,1323876845,0),(245,1,6,'mod/assignment:view',1,1323876846,0),(246,1,5,'mod/assignment:view',1,1323876846,0),(247,1,4,'mod/assignment:view',1,1323876846,0),(248,1,3,'mod/assignment:view',1,1323876846,0),(249,1,1,'mod/assignment:view',1,1323876846,0),(250,1,5,'mod/assignment:submit',1,1323876846,0),(251,1,4,'mod/assignment:grade',1,1323876846,0),(252,1,3,'mod/assignment:grade',1,1323876846,0),(253,1,1,'mod/assignment:grade',1,1323876846,0),(254,1,5,'mod/chat:chat',1,1323876847,0),(255,1,4,'mod/chat:chat',1,1323876847,0),(256,1,3,'mod/chat:chat',1,1323876847,0),(257,1,1,'mod/chat:chat',1,1323876847,0),(258,1,5,'mod/chat:readlog',1,1323876847,0),(259,1,4,'mod/chat:readlog',1,1323876847,0),(260,1,3,'mod/chat:readlog',1,1323876847,0),(261,1,1,'mod/chat:readlog',1,1323876847,0),(262,1,4,'mod/chat:deletelog',1,1323876847,0),(263,1,3,'mod/chat:deletelog',1,1323876847,0),(264,1,1,'mod/chat:deletelog',1,1323876847,0),(265,1,5,'mod/choice:choose',1,1323876848,0),(266,1,4,'mod/choice:choose',1,1323876848,0),(267,1,3,'mod/choice:choose',1,1323876848,0),(268,1,1,'mod/choice:choose',1,1323876848,0),(269,1,4,'mod/choice:readresponses',1,1323876848,0),(270,1,3,'mod/choice:readresponses',1,1323876848,0),(271,1,1,'mod/choice:readresponses',1,1323876848,0),(272,1,4,'mod/choice:deleteresponses',1,1323876848,0),(273,1,3,'mod/choice:deleteresponses',1,1323876848,0),(274,1,1,'mod/choice:deleteresponses',1,1323876848,0),(275,1,4,'mod/choice:downloadresponses',1,1323876848,0),(276,1,3,'mod/choice:downloadresponses',1,1323876848,0),(277,1,1,'mod/choice:downloadresponses',1,1323876848,0),(278,1,6,'mod/data:viewentry',1,1323876850,0),(279,1,5,'mod/data:viewentry',1,1323876850,0),(280,1,4,'mod/data:viewentry',1,1323876850,0),(281,1,3,'mod/data:viewentry',1,1323876850,0),(282,1,1,'mod/data:viewentry',1,1323876850,0),(283,1,5,'mod/data:writeentry',1,1323876850,0),(284,1,4,'mod/data:writeentry',1,1323876850,0),(285,1,3,'mod/data:writeentry',1,1323876850,0),(286,1,1,'mod/data:writeentry',1,1323876850,0),(287,1,5,'mod/data:comment',1,1323876850,0),(288,1,4,'mod/data:comment',1,1323876850,0),(289,1,3,'mod/data:comment',1,1323876850,0),(290,1,1,'mod/data:comment',1,1323876850,0),(291,1,4,'mod/data:viewrating',1,1323876850,0),(292,1,3,'mod/data:viewrating',1,1323876850,0),(293,1,1,'mod/data:viewrating',1,1323876850,0),(294,1,4,'mod/data:rate',1,1323876850,0),(295,1,3,'mod/data:rate',1,1323876850,0),(296,1,1,'mod/data:rate',1,1323876850,0),(297,1,4,'mod/data:approve',1,1323876850,0),(298,1,3,'mod/data:approve',1,1323876850,0),(299,1,1,'mod/data:approve',1,1323876850,0),(300,1,4,'mod/data:manageentries',1,1323876850,0),(301,1,3,'mod/data:manageentries',1,1323876850,0),(302,1,1,'mod/data:manageentries',1,1323876850,0),(303,1,4,'mod/data:managecomments',1,1323876850,0),(304,1,3,'mod/data:managecomments',1,1323876850,0),(305,1,1,'mod/data:managecomments',1,1323876850,0),(306,1,3,'mod/data:managetemplates',1,1323876850,0),(307,1,1,'mod/data:managetemplates',1,1323876850,0),(308,1,4,'mod/data:viewalluserpresets',1,1323876850,0),(309,1,3,'mod/data:viewalluserpresets',1,1323876850,0),(310,1,1,'mod/data:viewalluserpresets',1,1323876850,0),(311,1,1,'mod/data:manageuserpresets',1,1323876850,0),(312,1,6,'mod/forum:viewdiscussion',1,1323876853,0),(313,1,5,'mod/forum:viewdiscussion',1,1323876853,0),(314,1,4,'mod/forum:viewdiscussion',1,1323876853,0),(315,1,3,'mod/forum:viewdiscussion',1,1323876853,0),(316,1,1,'mod/forum:viewdiscussion',1,1323876853,0),(317,1,4,'mod/forum:viewhiddentimedposts',1,1323876853,0),(318,1,3,'mod/forum:viewhiddentimedposts',1,1323876853,0),(319,1,1,'mod/forum:viewhiddentimedposts',1,1323876853,0),(320,1,5,'mod/forum:startdiscussion',1,1323876853,0),(321,1,4,'mod/forum:startdiscussion',1,1323876853,0),(322,1,3,'mod/forum:startdiscussion',1,1323876853,0),(323,1,1,'mod/forum:startdiscussion',1,1323876853,0),(324,1,5,'mod/forum:replypost',1,1323876853,0),(325,1,4,'mod/forum:replypost',1,1323876853,0),(326,1,3,'mod/forum:replypost',1,1323876853,0),(327,1,1,'mod/forum:replypost',1,1323876853,0),(328,1,4,'mod/forum:addnews',1,1323876853,0),(329,1,3,'mod/forum:addnews',1,1323876853,0),(330,1,1,'mod/forum:addnews',1,1323876853,0),(331,1,4,'mod/forum:replynews',1,1323876853,0),(332,1,3,'mod/forum:replynews',1,1323876853,0),(333,1,1,'mod/forum:replynews',1,1323876853,0),(334,1,5,'mod/forum:viewrating',1,1323876853,0),(335,1,4,'mod/forum:viewrating',1,1323876853,0),(336,1,3,'mod/forum:viewrating',1,1323876853,0),(337,1,1,'mod/forum:viewrating',1,1323876853,0),(338,1,4,'mod/forum:viewanyrating',1,1323876853,0),(339,1,3,'mod/forum:viewanyrating',1,1323876853,0),(340,1,1,'mod/forum:viewanyrating',1,1323876853,0),(341,1,4,'mod/forum:rate',1,1323876853,0),(342,1,3,'mod/forum:rate',1,1323876853,0),(343,1,1,'mod/forum:rate',1,1323876853,0),(344,1,5,'mod/forum:createattachment',1,1323876853,0),(345,1,4,'mod/forum:createattachment',1,1323876853,0),(346,1,3,'mod/forum:createattachment',1,1323876853,0),(347,1,1,'mod/forum:createattachment',1,1323876853,0),(348,1,5,'mod/forum:deleteownpost',1,1323876853,0),(349,1,4,'mod/forum:deleteownpost',1,1323876853,0),(350,1,3,'mod/forum:deleteownpost',1,1323876853,0),(351,1,1,'mod/forum:deleteownpost',1,1323876853,0),(352,1,4,'mod/forum:deleteanypost',1,1323876853,0),(353,1,3,'mod/forum:deleteanypost',1,1323876853,0),(354,1,1,'mod/forum:deleteanypost',1,1323876853,0),(355,1,4,'mod/forum:splitdiscussions',1,1323876853,0),(356,1,3,'mod/forum:splitdiscussions',1,1323876853,0),(357,1,1,'mod/forum:splitdiscussions',1,1323876853,0),(358,1,4,'mod/forum:movediscussions',1,1323876853,0),(359,1,3,'mod/forum:movediscussions',1,1323876853,0),(360,1,1,'mod/forum:movediscussions',1,1323876853,0),(361,1,4,'mod/forum:editanypost',1,1323876853,0),(362,1,3,'mod/forum:editanypost',1,1323876853,0),(363,1,1,'mod/forum:editanypost',1,1323876853,0),(364,1,4,'mod/forum:viewqandawithoutposting',1,1323876853,0),(365,1,3,'mod/forum:viewqandawithoutposting',1,1323876853,0),(366,1,1,'mod/forum:viewqandawithoutposting',1,1323876853,0),(367,1,4,'mod/forum:viewsubscribers',1,1323876853,0),(368,1,3,'mod/forum:viewsubscribers',1,1323876853,0),(369,1,1,'mod/forum:viewsubscribers',1,1323876853,0),(370,1,4,'mod/forum:managesubscriptions',1,1323876853,0),(371,1,3,'mod/forum:managesubscriptions',1,1323876853,0),(372,1,1,'mod/forum:managesubscriptions',1,1323876853,0),(373,1,4,'mod/forum:initialsubscriptions',1,1323876853,0),(374,1,3,'mod/forum:initialsubscriptions',1,1323876853,0),(375,1,5,'mod/forum:initialsubscriptions',1,1323876853,0),(376,1,5,'mod/glossary:write',1,1323876855,0),(377,1,4,'mod/glossary:write',1,1323876855,0),(378,1,3,'mod/glossary:write',1,1323876855,0),(379,1,1,'mod/glossary:write',1,1323876855,0),(380,1,4,'mod/glossary:manageentries',1,1323876855,0),(381,1,3,'mod/glossary:manageentries',1,1323876855,0),(382,1,1,'mod/glossary:manageentries',1,1323876855,0),(383,1,4,'mod/glossary:managecategories',1,1323876855,0),(384,1,3,'mod/glossary:managecategories',1,1323876855,0),(385,1,1,'mod/glossary:managecategories',1,1323876855,0),(386,1,5,'mod/glossary:comment',1,1323876855,0),(387,1,4,'mod/glossary:comment',1,1323876855,0),(388,1,3,'mod/glossary:comment',1,1323876855,0),(389,1,1,'mod/glossary:comment',1,1323876855,0),(390,1,4,'mod/glossary:managecomments',1,1323876855,0),(391,1,3,'mod/glossary:managecomments',1,1323876855,0),(392,1,1,'mod/glossary:managecomments',1,1323876855,0),(393,1,4,'mod/glossary:import',1,1323876855,0),(394,1,3,'mod/glossary:import',1,1323876855,0),(395,1,1,'mod/glossary:import',1,1323876855,0),(396,1,4,'mod/glossary:export',1,1323876855,0),(397,1,3,'mod/glossary:export',1,1323876855,0),(398,1,1,'mod/glossary:export',1,1323876855,0),(399,1,4,'mod/glossary:approve',1,1323876855,0),(400,1,3,'mod/glossary:approve',1,1323876855,0),(401,1,1,'mod/glossary:approve',1,1323876855,0),(402,1,4,'mod/glossary:rate',1,1323876855,0),(403,1,3,'mod/glossary:rate',1,1323876855,0),(404,1,1,'mod/glossary:rate',1,1323876855,0),(405,1,4,'mod/glossary:viewrating',1,1323876855,0),(406,1,3,'mod/glossary:viewrating',1,1323876855,0),(407,1,1,'mod/glossary:viewrating',1,1323876855,0),(408,1,5,'mod/hotpot:attempt',1,1323876857,0),(409,1,4,'mod/hotpot:attempt',1,1323876857,0),(410,1,3,'mod/hotpot:attempt',1,1323876857,0),(411,1,1,'mod/hotpot:attempt',1,1323876857,0),(412,1,4,'mod/hotpot:viewreport',1,1323876857,0),(413,1,3,'mod/hotpot:viewreport',1,1323876857,0),(414,1,1,'mod/hotpot:viewreport',1,1323876857,0),(415,1,4,'mod/hotpot:grade',1,1323876857,0),(416,1,3,'mod/hotpot:grade',1,1323876857,0),(417,1,1,'mod/hotpot:grade',1,1323876857,0),(418,1,3,'mod/hotpot:deleteattempt',1,1323876857,0),(419,1,1,'mod/hotpot:deleteattempt',1,1323876857,0),(420,1,5,'mod/lams:participate',1,1323876859,0),(421,1,4,'mod/lams:manage',1,1323876859,0),(422,1,3,'mod/lams:manage',1,1323876859,0),(423,1,1,'mod/lams:manage',1,1323876859,0),(424,1,3,'mod/lesson:edit',1,1323876862,0),(425,1,1,'mod/lesson:edit',1,1323876862,0),(426,1,4,'mod/lesson:manage',1,1323876862,0),(427,1,3,'mod/lesson:manage',1,1323876862,0),(428,1,1,'mod/lesson:manage',1,1323876862,0),(429,1,6,'mod/quiz:view',1,1323876867,0),(430,1,5,'mod/quiz:view',1,1323876867,0),(431,1,4,'mod/quiz:view',1,1323876867,0),(432,1,3,'mod/quiz:view',1,1323876867,0),(433,1,1,'mod/quiz:view',1,1323876867,0),(434,1,5,'mod/quiz:attempt',1,1323876867,0),(435,1,5,'mod/quiz:reviewmyattempts',1,1323876867,0),(436,1,3,'mod/quiz:manage',1,1323876867,0),(437,1,1,'mod/quiz:manage',1,1323876867,0),(438,1,4,'mod/quiz:preview',1,1323876867,0),(439,1,3,'mod/quiz:preview',1,1323876867,0),(440,1,1,'mod/quiz:preview',1,1323876867,0),(441,1,4,'mod/quiz:grade',1,1323876867,0),(442,1,3,'mod/quiz:grade',1,1323876867,0),(443,1,1,'mod/quiz:grade',1,1323876867,0),(444,1,4,'mod/quiz:viewreports',1,1323876867,0),(445,1,3,'mod/quiz:viewreports',1,1323876867,0),(446,1,1,'mod/quiz:viewreports',1,1323876867,0),(447,1,3,'mod/quiz:deleteattempts',1,1323876867,0),(448,1,1,'mod/quiz:deleteattempts',1,1323876867,0),(449,1,4,'mod/scorm:viewreport',1,1323876871,0),(450,1,3,'mod/scorm:viewreport',1,1323876871,0),(451,1,1,'mod/scorm:viewreport',1,1323876871,0),(452,1,5,'mod/scorm:skipview',1,1323876871,0),(453,1,5,'mod/scorm:savetrack',1,1323876871,0),(454,1,4,'mod/scorm:savetrack',1,1323876871,0),(455,1,3,'mod/scorm:savetrack',1,1323876871,0),(456,1,1,'mod/scorm:savetrack',1,1323876871,0),(457,1,5,'mod/scorm:viewscores',1,1323876871,0),(458,1,4,'mod/scorm:viewscores',1,1323876871,0),(459,1,3,'mod/scorm:viewscores',1,1323876871,0),(460,1,1,'mod/scorm:viewscores',1,1323876871,0),(461,1,4,'mod/scorm:deleteresponses',1,1323876871,0),(462,1,3,'mod/scorm:deleteresponses',1,1323876871,0),(463,1,1,'mod/scorm:deleteresponses',1,1323876871,0),(464,1,5,'mod/survey:participate',1,1323876872,0),(465,1,4,'mod/survey:participate',1,1323876872,0),(466,1,3,'mod/survey:participate',1,1323876872,0),(467,1,1,'mod/survey:participate',1,1323876872,0),(468,1,4,'mod/survey:readresponses',1,1323876872,0),(469,1,3,'mod/survey:readresponses',1,1323876872,0),(470,1,1,'mod/survey:readresponses',1,1323876872,0),(471,1,4,'mod/survey:download',1,1323876872,0),(472,1,3,'mod/survey:download',1,1323876872,0),(473,1,1,'mod/survey:download',1,1323876872,0),(474,1,5,'mod/wiki:participate',1,1323876874,0),(475,1,4,'mod/wiki:participate',1,1323876874,0),(476,1,3,'mod/wiki:participate',1,1323876874,0),(477,1,1,'mod/wiki:participate',1,1323876874,0),(478,1,4,'mod/wiki:manage',1,1323876874,0),(479,1,3,'mod/wiki:manage',1,1323876874,0),(480,1,1,'mod/wiki:manage',1,1323876874,0),(481,1,4,'mod/wiki:overridelock',1,1323876874,0),(482,1,3,'mod/wiki:overridelock',1,1323876874,0),(483,1,1,'mod/wiki:overridelock',1,1323876874,0),(484,1,5,'mod/workshop:participate',1,1323876877,0),(485,1,4,'mod/workshop:manage',1,1323876877,0),(486,1,3,'mod/workshop:manage',1,1323876877,0),(487,1,1,'mod/workshop:manage',1,1323876877,0),(488,1,7,'block/online_users:viewlist',1,1323876924,0),(489,1,6,'block/online_users:viewlist',1,1323876924,0),(490,1,5,'block/online_users:viewlist',1,1323876924,0),(491,1,4,'block/online_users:viewlist',1,1323876924,0),(492,1,3,'block/online_users:viewlist',1,1323876924,0),(493,1,1,'block/online_users:viewlist',1,1323876924,0),(494,1,4,'block/rss_client:createprivatefeeds',1,1323876925,0),(495,1,3,'block/rss_client:createprivatefeeds',1,1323876925,0),(496,1,1,'block/rss_client:createprivatefeeds',1,1323876925,0),(497,1,3,'block/rss_client:createsharedfeeds',1,1323876925,0),(498,1,1,'block/rss_client:createsharedfeeds',1,1323876925,0),(499,1,4,'block/rss_client:manageownfeeds',1,1323876925,0),(500,1,3,'block/rss_client:manageownfeeds',1,1323876925,0),(501,1,1,'block/rss_client:manageownfeeds',1,1323876925,0),(502,1,1,'block/rss_client:manageanyfeeds',1,1323876925,0),(503,1,1,'enrol/authorize:managepayments',1,1323876926,0),(504,1,1,'enrol/authorize:uploadcsv',1,1323876926,0),(505,1,4,'gradeexport/ods:view',1,1323876927,0),(506,1,3,'gradeexport/ods:view',1,1323876927,0),(507,1,1,'gradeexport/ods:view',1,1323876927,0),(508,1,1,'gradeexport/ods:publish',1,1323876927,0),(509,1,4,'gradeexport/txt:view',1,1323876927,0),(510,1,3,'gradeexport/txt:view',1,1323876927,0),(511,1,1,'gradeexport/txt:view',1,1323876927,0),(512,1,1,'gradeexport/txt:publish',1,1323876927,0),(513,1,4,'gradeexport/xls:view',1,1323876927,0),(514,1,3,'gradeexport/xls:view',1,1323876927,0),(515,1,1,'gradeexport/xls:view',1,1323876927,0),(516,1,1,'gradeexport/xls:publish',1,1323876927,0),(517,1,4,'gradeexport/xml:view',1,1323876927,0),(518,1,3,'gradeexport/xml:view',1,1323876927,0),(519,1,1,'gradeexport/xml:view',1,1323876927,0),(520,1,1,'gradeexport/xml:publish',1,1323876927,0),(521,1,3,'gradeimport/csv:view',1,1323876928,0),(522,1,1,'gradeimport/csv:view',1,1323876928,0),(523,1,3,'gradeimport/xml:view',1,1323876928,0),(524,1,1,'gradeimport/xml:view',1,1323876928,0),(525,1,1,'gradeimport/xml:publish',1,1323876928,0),(526,1,4,'gradereport/grader:view',1,1323876928,0),(527,1,3,'gradereport/grader:view',1,1323876928,0),(528,1,1,'gradereport/grader:view',1,1323876928,0),(529,1,4,'gradereport/outcomes:view',1,1323876928,0),(530,1,3,'gradereport/outcomes:view',1,1323876928,0),(531,1,1,'gradereport/outcomes:view',1,1323876928,0),(532,1,5,'gradereport/overview:view',1,1323876928,0),(533,1,1,'gradereport/overview:view',1,1323876928,0),(534,1,5,'gradereport/user:view',1,1323876928,0),(535,1,4,'gradereport/user:view',1,1323876928,0),(536,1,3,'gradereport/user:view',1,1323876928,0),(537,1,1,'gradereport/user:view',1,1323876928,0),(538,1,4,'coursereport/log:view',1,1323876929,0),(539,1,3,'coursereport/log:view',1,1323876929,0),(540,1,1,'coursereport/log:view',1,1323876929,0),(541,1,4,'coursereport/log:viewlive',1,1323876929,0),(542,1,3,'coursereport/log:viewlive',1,1323876929,0),(543,1,1,'coursereport/log:viewlive',1,1323876929,0),(544,1,4,'coursereport/log:viewtoday',1,1323876929,0),(545,1,3,'coursereport/log:viewtoday',1,1323876929,0),(546,1,1,'coursereport/log:viewtoday',1,1323876929,0),(547,1,4,'coursereport/outline:view',1,1323876929,0),(548,1,3,'coursereport/outline:view',1,1323876929,0),(549,1,1,'coursereport/outline:view',1,1323876929,0),(550,1,4,'coursereport/participation:view',1,1323876929,0),(551,1,3,'coursereport/participation:view',1,1323876929,0),(552,1,1,'coursereport/participation:view',1,1323876929,0),(553,1,4,'coursereport/stats:view',1,1323876929,0),(554,1,3,'coursereport/stats:view',1,1323876929,0),(555,1,1,'coursereport/stats:view',1,1323876929,0),(556,1,4,'report/courseoverview:view',1,1323876930,0),(557,1,3,'report/courseoverview:view',1,1323876930,0),(558,1,1,'report/courseoverview:view',1,1323876930,0),(559,1,1,'report/security:view',1,1323876930,0),(560,1,1,'report/unittest:view',1,1323876930,0),(561,1,1,'mod/launcher:access',1,1325601845,2),(563,1,9,'block/online_users:viewlist',1,1329387996,2),(564,1,9,'block/rss_client:createprivatefeeds',1,1329387996,2),(565,1,9,'block/rss_client:manageownfeeds',1,1329387996,2),(566,1,9,'coursereport/log:view',1,1329387996,2),(567,1,9,'coursereport/log:viewlive',1,1329387996,2),(568,1,9,'coursereport/log:viewtoday',1,1329387996,2),(569,1,9,'coursereport/outline:view',1,1329387996,2),(570,1,9,'coursereport/participation:view',1,1329387996,2),(571,1,9,'coursereport/stats:view',1,1329387996,2),(572,1,9,'gradeexport/ods:view',1,1329387996,2),(573,1,9,'gradeexport/txt:view',1,1329387996,2),(574,1,9,'gradeexport/xls:view',1,1329387996,2),(575,1,9,'gradeexport/xml:view',1,1329387996,2),(576,1,9,'gradereport/grader:view',1,1329387996,2),(577,1,9,'gradereport/outcomes:view',1,1329387996,2),(578,1,9,'gradereport/user:view',1,1329387996,2),(579,1,9,'mod/assignment:grade',1,1329387996,2),(580,1,9,'mod/assignment:view',1,1329387996,2),(581,1,9,'mod/chat:chat',1,1329387996,2),(582,1,9,'mod/chat:deletelog',1,1329387996,2),(583,1,9,'mod/chat:readlog',1,1329387996,2),(584,1,9,'mod/choice:choose',1,1329387996,2),(585,1,9,'mod/choice:deleteresponses',1,1329387996,2),(586,1,9,'mod/choice:downloadresponses',1,1329387996,2),(587,1,9,'mod/choice:readresponses',1,1329387996,2),(588,1,9,'mod/data:approve',1,1329387996,2),(589,1,9,'mod/data:comment',1,1329387996,2),(590,1,9,'mod/data:managecomments',1,1329387996,2),(591,1,9,'mod/data:manageentries',1,1329387996,2),(592,1,9,'mod/data:rate',1,1329387996,2),(593,1,9,'mod/data:viewalluserpresets',1,1329387996,2),(594,1,9,'mod/data:viewentry',1,1329387996,2),(595,1,9,'mod/data:viewrating',1,1329387996,2),(596,1,9,'mod/data:writeentry',1,1329387996,2),(597,1,9,'mod/forum:addnews',1,1329387996,2),(598,1,9,'mod/forum:createattachment',1,1329387996,2),(599,1,9,'mod/forum:deleteanypost',1,1329387996,2),(600,1,9,'mod/forum:deleteownpost',1,1329387996,2),(601,1,9,'mod/forum:editanypost',1,1329387996,2),(602,1,9,'mod/forum:initialsubscriptions',1,1329387996,2),(603,1,9,'mod/forum:managesubscriptions',1,1329387996,2),(604,1,9,'mod/forum:movediscussions',1,1329387996,2),(605,1,9,'mod/forum:rate',1,1329387996,2),(606,1,9,'mod/forum:replynews',1,1329387996,2),(607,1,9,'mod/forum:replypost',1,1329387996,2),(608,1,9,'mod/forum:splitdiscussions',1,1329387996,2),(609,1,9,'mod/forum:startdiscussion',1,1329387996,2),(610,1,9,'mod/forum:viewanyrating',1,1329387996,2),(611,1,9,'mod/forum:viewdiscussion',1,1329387996,2),(612,1,9,'mod/forum:viewhiddentimedposts',1,1329387996,2),(613,1,9,'mod/forum:viewqandawithoutposting',1,1329387996,2),(614,1,9,'mod/forum:viewrating',1,1329387996,2),(615,1,9,'mod/forum:viewsubscribers',1,1329387996,2),(616,1,9,'mod/glossary:approve',1,1329387996,2),(617,1,9,'mod/glossary:comment',1,1329387996,2),(618,1,9,'mod/glossary:export',1,1329387996,2),(619,1,9,'mod/glossary:import',1,1329387996,2),(620,1,9,'mod/glossary:managecategories',1,1329387996,2),(621,1,9,'mod/glossary:managecomments',1,1329387996,2),(622,1,9,'mod/glossary:manageentries',1,1329387996,2),(623,1,9,'mod/glossary:rate',1,1329387996,2),(624,1,9,'mod/glossary:viewrating',1,1329387996,2),(625,1,9,'mod/glossary:write',1,1329387996,2),(626,1,9,'mod/hotpot:attempt',1,1329387996,2),(627,1,9,'mod/hotpot:grade',1,1329387996,2),(628,1,9,'mod/hotpot:viewreport',1,1329387996,2),(629,1,9,'mod/lams:manage',1,1329387996,2),(630,1,9,'mod/lesson:manage',1,1329387996,2),(631,1,9,'mod/quiz:grade',1,1329387996,2),(632,1,9,'mod/quiz:preview',1,1329387996,2),(633,1,9,'mod/quiz:view',1,1329387996,2),(634,1,9,'mod/quiz:viewreports',1,1329387996,2),(635,1,9,'mod/scorm:deleteresponses',1,1329387996,2),(636,1,9,'mod/scorm:savetrack',1,1329387996,2),(637,1,9,'mod/scorm:viewreport',1,1329387996,2),(638,1,9,'mod/scorm:viewscores',1,1329387996,2),(639,1,9,'mod/survey:download',1,1329387996,2),(640,1,9,'mod/survey:participate',1,1329387996,2),(641,1,9,'mod/survey:readresponses',1,1329387996,2),(642,1,9,'mod/wiki:manage',1,1329387996,2),(643,1,9,'mod/wiki:overridelock',1,1329387996,2),(644,1,9,'mod/wiki:participate',1,1329387996,2),(645,1,9,'mod/workshop:manage',1,1329387996,2),(646,1,9,'moodle/block:view',1,1329387996,2),(647,1,9,'moodle/blog:manageentries',1,1329387996,2),(648,1,9,'moodle/blog:view',1,1329387996,2),(649,1,9,'moodle/calendar:manageentries',1,1329387996,2),(650,1,9,'moodle/calendar:managegroupentries',1,1329387996,2),(651,1,9,'moodle/course:bulkmessaging',1,1329387996,2),(652,1,9,'moodle/course:view',1,1329387996,2),(653,1,9,'moodle/course:viewhiddenactivities',1,1329387996,2),(654,1,9,'moodle/course:viewhiddencourses',1,1329387996,2),(655,1,9,'moodle/course:viewhiddenuserfields',1,1329387996,2),(656,1,9,'moodle/course:viewparticipants',1,1329387996,2),(657,1,9,'moodle/course:viewscales',1,1329387996,2),(658,1,9,'moodle/grade:export',1,1329387996,2),(659,1,9,'moodle/grade:viewall',1,1329387996,2),(660,1,9,'moodle/grade:viewhidden',1,1329387996,2),(661,1,9,'moodle/legacy:teacher',1,1323876844,0),(662,1,9,'moodle/notes:manage',1,1329387996,2),(663,1,9,'moodle/notes:view',1,1329387996,2),(664,1,9,'moodle/role:unassignself',1,1329387996,2),(665,1,9,'moodle/role:viewhiddenassigns',1,1329387996,2),(666,1,9,'moodle/site:accessallgroups',1,1329387996,2),(667,1,9,'moodle/site:doclinks',1,1329387996,2),(668,1,9,'moodle/site:viewfullnames',1,1329387996,2),(669,1,9,'moodle/site:viewreports',1,1329387996,2),(670,1,9,'moodle/tag:editblocks',1,1329387996,2),(671,1,9,'moodle/tag:manage',1,1329387996,2),(672,1,9,'moodle/user:readuserblogs',1,1329387996,2),(673,1,9,'moodle/user:readuserposts',1,1329387996,2),(674,1,9,'moodle/user:viewdetails',1,1329387996,2),(675,1,9,'moodle/user:viewhiddendetails',1,1329387996,2),(676,1,9,'report/courseoverview:view',1,1329387996,2),(997,1,11,'report/courseoverview:view',1,1329389244,2),(996,1,11,'moodle/user:viewhiddendetails',1,1329389244,2),(995,1,11,'moodle/user:viewdetails',1,1329389244,2),(994,1,11,'moodle/user:readuserposts',1,1329389244,2),(992,1,11,'moodle/tag:manage',1,1329389244,2),(987,1,11,'moodle/site:accessallgroups',1,1329389244,2),(985,1,11,'moodle/role:unassignself',1,1329389244,2),(982,1,11,'moodle/legacy:teacher',1,1323876844,0),(980,1,11,'moodle/grade:viewall',1,1329389244,2),(979,1,11,'moodle/grade:export',1,1329389244,2),(977,1,11,'moodle/course:viewparticipants',1,1329389244,2),(976,1,11,'moodle/course:viewhiddenuserfields',1,1329389244,2),(975,1,11,'moodle/course:viewhiddencourses',1,1329389244,2),(972,1,11,'moodle/course:bulkmessaging',1,1329389244,2),(971,1,11,'moodle/calendar:managegroupentries',1,1329389244,2),(970,1,11,'moodle/calendar:manageentries',1,1329389244,2),(969,1,11,'moodle/blog:view',1,1329389244,2),(968,1,11,'moodle/blog:manageentries',1,1329389244,2),(963,1,11,'mod/wiki:manage',1,1329389244,2),(962,1,11,'mod/survey:readresponses',1,1329389244,2),(961,1,11,'mod/survey:participate',1,1329389244,2),(960,1,11,'mod/survey:download',1,1329389244,2),(959,1,11,'mod/scorm:viewscores',1,1329389244,2),(958,1,11,'mod/scorm:viewreport',1,1329389244,2),(957,1,11,'mod/scorm:savetrack',1,1329389244,2),(955,1,11,'mod/quiz:viewreports',1,1329389244,2),(953,1,11,'mod/quiz:preview',1,1329389244,2),(952,1,11,'mod/quiz:grade',1,1329389244,2),(951,1,11,'mod/lesson:manage',1,1329389244,2),(948,1,11,'mod/hotpot:grade',1,1329389244,2),(945,1,11,'mod/glossary:viewrating',1,1329389244,2),(944,1,11,'mod/glossary:rate',1,1329389244,2),(943,1,11,'mod/glossary:manageentries',1,1329389244,2),(941,1,11,'mod/glossary:managecategories',1,1329389244,2),(935,1,11,'mod/forum:viewrating',1,1329389244,2),(934,1,11,'mod/forum:viewqandawithoutposting',1,1329389244,2),(932,1,11,'mod/forum:viewdiscussion',1,1329389244,2),(931,1,11,'mod/forum:viewanyrating',1,1329389244,2),(930,1,11,'mod/forum:startdiscussion',1,1329389244,2),(929,1,11,'mod/forum:splitdiscussions',1,1329389244,2),(927,1,11,'mod/forum:replynews',1,1329389244,2),(926,1,11,'mod/forum:rate',1,1329389244,2),(925,1,11,'mod/forum:movediscussions',1,1329389244,2),(924,1,11,'mod/forum:managesubscriptions',1,1329389244,2),(922,1,11,'mod/forum:editanypost',1,1329389244,2),(921,1,11,'mod/forum:deleteownpost',1,1329389244,2),(920,1,11,'mod/forum:deleteanypost',1,1329389244,2),(919,1,11,'mod/forum:createattachment',1,1329389244,2),(912,1,11,'mod/data:manageentries',1,1329389244,2),(911,1,11,'mod/data:managecomments',1,1329389244,2),(909,1,11,'mod/data:approve',1,1329389244,2),(907,1,11,'mod/choice:downloadresponses',1,1329389244,2),(906,1,11,'mod/choice:deleteresponses',1,1329389244,2),(904,1,11,'mod/chat:readlog',1,1329389244,2),(902,1,11,'mod/chat:chat',1,1329389244,2),(899,1,11,'gradereport/user:view',1,1329389244,2),(889,1,11,'coursereport/log:viewtoday',1,1329389244,2),(887,1,11,'coursereport/log:view',1,1329389244,2),(884,1,11,'block/online_users:viewlist',1,1329389244,2),(908,1,11,'mod/choice:readresponses',1,1329389244,2),(984,1,11,'moodle/notes:view',1,1329389244,2),(983,1,11,'moodle/notes:manage',1,1329389244,2),(981,1,11,'moodle/grade:viewhidden',1,1329389244,2),(886,1,11,'block/rss_client:manageownfeeds',1,1329389244,2),(885,1,11,'block/rss_client:createprivatefeeds',1,1329389244,2),(893,1,11,'gradeexport/ods:view',1,1329389244,2),(892,1,11,'coursereport/stats:view',1,1329389244,2),(891,1,11,'coursereport/participation:view',1,1329389244,2),(890,1,11,'coursereport/outline:view',1,1329389244,2),(888,1,11,'coursereport/log:viewlive',1,1329389244,2),(905,1,11,'mod/choice:choose',1,1329389244,2),(903,1,11,'mod/chat:deletelog',1,1329389244,2),(901,1,11,'mod/assignment:view',1,1329389244,2),(900,1,11,'mod/assignment:grade',1,1329389244,2),(898,1,11,'gradereport/outcomes:view',1,1329389244,2),(897,1,11,'gradereport/grader:view',1,1329389244,2),(896,1,11,'gradeexport/xml:view',1,1329389244,2),(895,1,11,'gradeexport/xls:view',1,1329389244,2),(894,1,11,'gradeexport/txt:view',1,1329389244,2),(993,1,11,'moodle/user:readuserblogs',1,1329389244,2),(990,1,11,'moodle/site:viewreports',1,1329389244,2),(989,1,11,'moodle/site:viewfullnames',1,1329389244,2),(991,1,11,'moodle/tag:editblocks',1,1329389244,2),(988,1,11,'moodle/site:doclinks',1,1329389244,2),(986,1,11,'moodle/role:viewhiddenassigns',1,1329389244,2),(978,1,11,'moodle/course:viewscales',1,1329389244,2),(974,1,11,'moodle/course:viewhiddenactivities',1,1329389244,2),(973,1,11,'moodle/course:view',1,1329389244,2),(967,1,11,'moodle/block:view',1,1329389244,2),(966,1,11,'mod/workshop:manage',1,1329389244,2),(964,1,11,'mod/wiki:overridelock',1,1329389244,2),(965,1,11,'mod/wiki:participate',1,1329389244,2),(956,1,11,'mod/scorm:deleteresponses',1,1329389244,2),(954,1,11,'mod/quiz:view',1,1329389244,2),(946,1,11,'mod/glossary:write',1,1329389244,2),(947,1,11,'mod/hotpot:attempt',1,1329389244,2),(950,1,11,'mod/lams:manage',1,1329389244,2),(949,1,11,'mod/hotpot:viewreport',1,1329389244,2),(939,1,11,'mod/glossary:export',1,1329389244,2),(940,1,11,'mod/glossary:import',1,1329389244,2),(942,1,11,'mod/glossary:managecomments',1,1329389244,2),(938,1,11,'mod/glossary:comment',1,1329389244,2),(937,1,11,'mod/glossary:approve',1,1329389244,2),(936,1,11,'mod/forum:viewsubscribers',1,1329389244,2),(933,1,11,'mod/forum:viewhiddentimedposts',1,1329389244,2),(928,1,11,'mod/forum:replypost',1,1329389244,2),(923,1,11,'mod/forum:initialsubscriptions',1,1329389244,2),(918,1,11,'mod/forum:addnews',1,1329389244,2),(917,1,11,'mod/data:writeentry',1,1329389244,2),(916,1,11,'mod/data:viewrating',1,1329389244,2),(915,1,11,'mod/data:viewentry',1,1329389244,2),(914,1,11,'mod/data:viewalluserpresets',1,1329389244,2),(913,1,11,'mod/data:rate',1,1329389244,2),(910,1,11,'mod/data:comment',1,1329389244,2);
/*!40000 ALTER TABLE `mdl_role_capabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role_names`
--

DROP TABLE IF EXISTS `mdl_role_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role_names` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolename_rolcon_uix` (`roleid`,`contextid`),
  KEY `mdl_rolename_rol_ix` (`roleid`),
  KEY `mdl_rolename_con_ix` (`contextid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='role names in native strings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role_names`
--

LOCK TABLES `mdl_role_names` WRITE;
/*!40000 ALTER TABLE `mdl_role_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_role_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_role_sortorder`
--

DROP TABLE IF EXISTS `mdl_role_sortorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_role_sortorder` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL,
  `roleid` bigint(10) unsigned NOT NULL,
  `contextid` bigint(10) unsigned NOT NULL,
  `sortoder` bigint(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolesort_userolcon_uix` (`userid`,`roleid`,`contextid`),
  KEY `mdl_rolesort_use_ix` (`userid`),
  KEY `mdl_rolesort_rol_ix` (`roleid`),
  KEY `mdl_rolesort_con_ix` (`contextid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='sort order of course managers in a course';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_role_sortorder`
--

LOCK TABLES `mdl_role_sortorder` WRITE;
/*!40000 ALTER TABLE `mdl_role_sortorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_role_sortorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scale`
--

DROP TABLE IF EXISTS `mdl_scale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scale` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `scale` text NOT NULL,
  `description` text NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_scal_cou_ix` (`courseid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Defines grading scales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scale`
--

LOCK TABLES `mdl_scale` WRITE;
/*!40000 ALTER TABLE `mdl_scale` DISABLE KEYS */;
INSERT INTO `mdl_scale` VALUES (1,0,0,'Separate and Connected ways of knowing','Mostly Separate Knowing,Separate and Connected,Mostly Connected Knowing','<h1> Ratings </h1>\n\n<p>Individual posts can be rated using a scale based on the theory of <strong>separate and connected knowing</strong>.\n\nThis theory may help you to look at human interactions in a new way. It describes two different ways that we can evaluate and learn about the things we see and hear.\n\nAlthough each of us may use these two methods in different amounts at different times, it may be useful to imagine two people as examples, one who is a mostly separate knower (Jim) and the other a mostly connected knower (Mary).\n</p>\n\n<ul>\n\n  <li>Jim likes to remain as \'objective\' as possible without including his feelings and emotions. When in a discussion with other people who may have different ideas, he likes to defend his own ideas, using logic to find holes in his opponent\'s ideas. He is critical of new ideas unless they are proven facts from reputable sources such as textbooks, respected teachers or his own direct experience. Jim is a very <strong>separate knower</strong>.\n\n  </li>\n\n  <li>Mary is more sensitive to other people. She is skilled at empathy and tends to listen and ask questions until she feels she can connect and &quot;understand things from their point of view&quot;. She learns by trying to share the experiences that led to the knowledge she finds in other people. When talking to others, she avoids confrontation and will often try to help the other person if she can see a way to do so, using logical suggestions. Mary is a very <strong>connected knower</strong>.</li>\n\n</ul>\n\n<p>Did you notice in these examples that the separate knower is male and the connected knower is female? Some studies have shown that statistically this tends to be the case, however individual people can be anywhere in the spectrum between these two extremes.\n\nFor a collaborative and effective group of learners it may be best if everyone were able to use BOTH ways of knowing.\n\nIn a particular situation like an online forum, a single post by a person may exhibit either of these characteristics, or even both. Someone who is generally very connected may post a very separate-sounding message, and vice versa. The purpose of rating each post using this scale is to:\n</p>\n\n<ol style=\"list-style:lower-alpha\">\n\n  <li> help you think about these issues when reading other posts </li>\n\n  <li> provide feedback to each author on how they are being seen by others </li>\n\n</ol>\n\nThe results are not used towards student assessment in any way, they are just to help improve communication and learning.\n\n<hr />\n<p>\nIn case you\'re interested, here are some references to papers by the authors who originally developed these ideas:\n</p>\n\n<ul>\n  <li>Belenky, M.F., Clinchy, B.M., Goldberger, N.R., &amp; Tarule, J.M. (1986). \n\n    Women\'s ways of knowing: the development of self, voice, and mind. New York, \n\n    NY: Basic Books.</li>\n\n  <li>Clinchy, B.M. (1989a). The development of thoughtfulness in college women: \n\n    Integrating reason and care. American Behavioural Scientist, 32(6), 647-657.</li>\n\n  <li>Clinchy, B.M. (1989b). On critical thinking &amp; connected knowing. Liberal \n\n    education, 75(5), 14-19.</li>\n\n  <li>Clinchy, B.M. (1996). Connected and separate knowing; Toward a marriage \n\n    of two minds. In N.R. Goldberger, Tarule, J.M., Clinchy, B.M. &amp;</li>\n\n  <li>Belenky, M.F. (Eds.), Knowledge, Difference, and Power; Essays inspired \n\n    by &#8220;Women&#8217;s Ways of Knowing&#8221; (pp. 205-247). New York, NY: \n\n    Basic Books.</li>\n\n  <li>Galotti, K. M., Clinchy, B. M., Ainsworth, K., Lavin, B., &amp; Mansfield, \n\n    A. F. (1999). A New Way of Assessing Ways of Knowing: The Attitudes Towards \n\n    Thinking and Learning Survey (ATTLS). Sex Roles, 40(9/10), 745-766.</li>\n\n  <li>Galotti, K. M., Reimer, R. L., &amp; Drebus, D. W. (2001). Ways of knowing \n\n    as learning styles: Learning MAGIC with a partner. Sex Roles, 44(7/8), 419-436. \n\n  </li>\n\n</ul>\n\n',1326115077);
/*!40000 ALTER TABLE `mdl_scale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scale_history`
--

DROP TABLE IF EXISTS `mdl_scale_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scale_history` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldid` bigint(10) unsigned NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `loggeduser` bigint(10) unsigned DEFAULT NULL,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `scale` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_scalhist_act_ix` (`action`),
  KEY `mdl_scalhist_old_ix` (`oldid`),
  KEY `mdl_scalhist_cou_ix` (`courseid`),
  KEY `mdl_scalhist_log_ix` (`loggeduser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='History table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scale_history`
--

LOCK TABLES `mdl_scale_history` WRITE;
/*!40000 ALTER TABLE `mdl_scale_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scale_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm`
--

DROP TABLE IF EXISTS `mdl_scorm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `summary` text NOT NULL,
  `version` varchar(9) NOT NULL DEFAULT '',
  `maxgrade` double NOT NULL DEFAULT '0',
  `grademethod` tinyint(2) NOT NULL DEFAULT '0',
  `whatgrade` bigint(10) NOT NULL DEFAULT '0',
  `maxattempt` bigint(10) NOT NULL DEFAULT '1',
  `updatefreq` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `md5hash` varchar(32) NOT NULL DEFAULT '',
  `launch` bigint(10) unsigned NOT NULL DEFAULT '0',
  `skipview` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `hidebrowse` tinyint(1) NOT NULL DEFAULT '0',
  `hidetoc` tinyint(1) NOT NULL DEFAULT '0',
  `hidenav` tinyint(1) NOT NULL DEFAULT '0',
  `auto` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `popup` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `options` varchar(255) NOT NULL DEFAULT '',
  `width` bigint(10) unsigned NOT NULL DEFAULT '100',
  `height` bigint(10) unsigned NOT NULL DEFAULT '600',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_scor_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='each table is one SCORM module and its configuration';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm`
--

LOCK TABLES `mdl_scorm` WRITE;
/*!40000 ALTER TABLE `mdl_scorm` DISABLE KEYS */;
INSERT INTO `mdl_scorm` VALUES (1,13,'193 Wonen in je straat','./../../Zip/NoMedia/L0193.zip','193 Wonen in je straat<br />','SCORM_1.2',100,1,0,0,2,'41e7e7c4c8341477fa51c107d73a9db4',1,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(2,13,'195 Woorden: Het huis','./../../Zip/NoMedia/L0195.zip','195 Woorden: Het huis<br />','SCORM_1.2',100,1,0,0,2,'889c9498b6793dd694075a37bcf1a500',3,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(3,13,'196 Praatplaat: Soorten huizen','./../../Zip/NoMedia/L0196.zip','196 Praatplaat: Soorten huizen<br />','SCORM_1.2',100,1,0,0,2,'2b4880dd5feddb6174ce50815d1977e4',5,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(4,13,'199 Hoek: Huizen bouwen','./../../Zip/NoMedia/L0199.zip','199 Hoek: Huizen bouwen<br />','SCORM_1.2',100,1,0,0,2,'331d62664129dd339484fb7e18d9f303',7,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(5,13,'200 Maak je slaapkamer','./../../Zip/NoMedia/L0200.zip','200 Maak je slaapkamer<br />','SCORM_1.2',100,1,0,0,2,'8f88b49e85b864d75513cc20bfe6ae15',9,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(6,13,'201 Woorden: De straat','./../../Zip/NoMedia/L0201.zip','201 Woorden: De straat<br />','SCORM_1.2',100,1,0,0,2,'241f3558249d952a2676f9b8d697137d',11,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(7,13,'202 Bewegen: Stoeptegelspellen','./../../Zip/NoMedia/L0202.zip','202 Bewegen: Stoeptegelspellen<br />','SCORM_1.2',100,1,0,0,2,'d6c20b6074db66cb6d7fce693ced12af',13,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(8,13,'203 Doeblad: Houd je straat schoon','./../../Zip/NoMedia/L0203.zip','203 Doeblad: Houd je straat schoon<br />','SCORM_1.2',100,1,0,0,2,'08e327e210d100b5abd0583ff1d2b999',15,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(9,13,'205 Ruim de straat op','./../../Zip/NoMedia/L0205.zip','205 Ruim de straat op<br />','SCORM_1.2',100,1,0,0,2,'ba553748b7036b7fbfa0b9fd0e4d7d28',17,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(10,13,'206 Teken je eigen huis','./../../Zip/NoMedia/L0206.zip','206 Teken je eigen huis<br />','SCORM_1.2',100,1,0,0,2,'7c62a3921eb131220efc086a2ff74551',19,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(11,13,'216 Onder, boven, voor en achter','./../../Zip/NoMedia/L0216.zip','216 Onder, boven, voor en achter<br />','SCORM_1.2',100,1,0,0,2,'bc94a1aec9288f62ed28b1a8eb8d3b96',21,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(12,13,'217 Links en rechts','./../../Zip/NoMedia/L0217.zip','217 Links en rechts<br />','SCORM_1.2',100,1,0,0,2,'d1d7276ca35f8bc52ea84e7a75a3e650',23,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(13,13,'727 Teken het leukste schoolplein','./../../Zip/NoMedia/L0727.zip','727 Teken het leukste schoolplein<br />','SCORM_1.2',100,1,0,0,2,'b62299a92ed8b3c73d9d8ec57fa2b297',25,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833010),(14,14,'7 Voorzieningen voor iedereen','./../../Zip/NoMedia/L0007.zip','7 Voorzieningen voor iedereen','SCORM_1.2',100,1,0,0,2,'9dfa36f58e6af0f854ba4a224b65fed1',27,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(15,14,'7 Toets Voorzieningen voor iedereen','./../../Zip/NoMedia/L0007T.zip','7 Toets Voorzieningen voor iedereen','SCORM_1.2',100,1,0,0,2,'bb1b4e26207d68cebf59a64a4c4ede51',29,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(16,14,'8 Werk met google maps','./../../Zip/NoMedia/L0008.zip','8 Werk met google maps','SCORM_1.2',100,1,0,0,2,'cc2f3ca5199170d4a98c8fe949d69fc3',31,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(17,14,'9 Rekenen met schaal','./../../Zip/NoMedia/L0009.zip','9 Rekenen met schaal','SCORM_1.2',100,1,0,0,2,'9226884122b7d7e38518ad682a4b2353',33,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(18,14,'9 Toets Rekenen met schaal','./../../Zip/NoMedia/L0009T.zip','9 Toets Rekenen met schaal','SCORM_1.2',100,1,0,0,2,'d700cc34c52e903d6da14d1d595a4553',35,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(19,14,'111 Houd een interview','./../../Zip/NoMedia/L0111.zip','111 Houd een interview','SCORM_1.2',100,1,0,0,2,'c3779dad3ad2e96a905a2c92ccf150ec',37,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(20,14,'170 Doe historisch onderzoek','./../../Zip/NoMedia/L0170.zip','170 Doe historisch onderzoek<br />','SCORM_1.2',100,1,0,0,2,'93ab09b87abaf70c2349f8640eb6e38c',39,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(21,14,'176 Onderdelen van een kaart','./../../Zip/NoMedia/L0176.zip','176 Onderdelen van een kaart<br />','SCORM_1.2',100,1,0,0,2,'600bbf2e325cb1fed2e1a7c2c1383e28',41,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(22,14,'176 Toets Onderdelen van een kaart','./../../Zip/NoMedia/L0176T.zip','176 Toets Onderdelen van een kaart<br />','SCORM_1.2',100,1,0,0,2,'7c8a0d19fd23dc5f4ce7cb26ff462145',43,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(23,14,'177 Een kaart lezen','./../../Zip/NoMedia/L0177.zip','177 Een kaart lezen<br />','SCORM_1.2',100,1,0,0,2,'9a06f77817326e426874330790ac32e4',45,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(24,14,'177 Toets Een kaart lezen','./../../Zip/NoMedia/L0177T.zip','177 Toets Een kaart lezen<br />','SCORM_1.2',100,1,0,0,2,'04ff532904211e1d5756f47f5e9071e4',47,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(25,14,'178 Opbouw van een stad','./../../Zip/NoMedia/L0178.zip','178 Opbouw van een stad<br />','SCORM_1.2',100,1,0,0,2,'49a594881db6391f441eba6070d95686',49,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(26,14,'178 Toets Opbouw van een stad','./../../Zip/NoMedia/L0178T.zip','178 Toets Opbouw van een stad<br />','SCORM_1.2',100,1,0,0,2,'a920468ca68945f42df54e0bd1419913',51,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(27,14,'179 Soorten kaarten','./../../Zip/NoMedia/L0179.zip','179 Soorten kaarten<br />','SCORM_1.2',100,1,0,0,2,'1a35df61bea69d9876039f5afb1c98ca',53,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(28,14,'179 Toets Soorten kaarten','./../../Zip/NoMedia/L0179T.zip','179 Toets Soorten kaarten<br />','SCORM_1.2',100,1,0,0,2,'9c1be747be8c8a5ed8ecfca42574ecfa',55,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(29,14,'180 Ontwerp een plein op schaal','./../../Zip/NoMedia/L0180.zip','180 Ontwerp een plein op schaal<br />','SCORM_1.2',100,1,0,0,2,'f02c9bcbca3df3614b7ea1a2ba28938a',57,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(30,14,'185 Taken van de gemeente','./../../Zip/NoMedia/L0185.zip','185 Taken van de gemeente<br />','SCORM_1.2',100,1,0,0,2,'e9de204b50ac650d7f1d22a866ae57b0',59,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(31,14,'185 Toets Taken van de gemeente','./../../Zip/NoMedia/L0185T.zip','185 Toets Taken van de gemeente<br />','SCORM_1.2',100,1,0,0,2,'263174b2fbf963fb8fba46d0baec14f2',61,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(32,14,'186 Ruimtelijke ordening','./../../Zip/NoMedia/L0186.zip','186 Ruimtelijke ordening<br />','SCORM_1.2',100,1,0,0,2,'df730af473d2f1d00dd71ef323ba91be',63,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(33,14,'186 Toets Ruimtelijke ordening','./../../Zip/NoMedia/L0186T.zip','186 Toets Ruimtelijke ordening<br />','SCORM_1.2',100,1,0,0,2,'d94acb40b887ab4b439fcc89628213f5',65,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(34,14,'187 Historisch onderzoek: Ontwikkeling van je gemeente','./../../Zip/NoMedia/L0187.zip','187 Historisch onderzoek: Ontwikkeling van je gemeente<br />','SCORM_1.2',100,1,0,0,2,'b14921aa9d24d32dd7db6e5b53eddf39',67,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(35,14,'188 Pleinontwerp: Ontwikkeling van je gemeente','./../../Zip/NoMedia/L0188.zip','188 Pleinontwerp: Ontwikkeling van je gemeente<br />','SCORM_1.2',100,1,0,0,2,'8b3aee6ca4d29c4737eb027dd4b545ac',69,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(36,14,'189 Verstedelijking van Nederland','./../../Zip/NoMedia/L0189.zip','189 Verstedelijking van Nederland<br />','SCORM_1.2',100,1,0,0,2,'2c47a41dc55f1c687313b983d3834931',71,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(37,14,'189 Toets Verstedelijking van Nederland','./../../Zip/NoMedia/L0189T.zip','189 Toets Verstedelijking van Nederland<br />','SCORM_1.2',100,1,0,0,2,'c6c45f843b154f6c1144c099d9d4876e',73,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(38,14,'191 Ontstaan van dorpen','./../../Zip/NoMedia/L0191.zip','191 Ontstaan van dorpen<br />','SCORM_1.2',100,1,0,0,2,'8cf47e435e0c84bb2941b19d2c551f40',75,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(39,14,'191 Toets Ontstaan van dorpen','./../../Zip/NoMedia/L0191T.zip','191 Toets Ontstaan van dorpen<br />','SCORM_1.2',100,1,0,0,2,'204aebdeae748b378129d233735028ac',77,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(40,14,'192 Ontstaan van steden','./../../Zip/NoMedia/L0192.zip','192 Ontstaan van steden<br />','SCORM_1.2',100,1,0,0,2,'12ddf0e355003941e8d7d29671031b9b',79,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(41,14,'192 Toets Ontstaan van steden','./../../Zip/NoMedia/L0192T.zip','192 Toets Ontstaan van steden<br />','SCORM_1.2',100,1,0,0,2,'bae7aa0be2c9c355626f2d903514ebff',81,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(42,14,'208 Houd een enquete','./../../Zip/NoMedia/L0208.zip','208 Houd een enquete<br />','SCORM_1.2',100,1,0,0,2,'ce17a5bd2ce924db1c8edde6bf2ad369',83,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(43,14,'209 Ontwikkeling van toerisme','./../../Zip/NoMedia/L0209.zip','209 Ontwikkeling van toerisme','SCORM_1.2',100,1,0,0,2,'f2a73605868d9790e87f0ac1cb4d42bf',85,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(44,14,'209 Toets Ontwikkeling van toerisme','./../../Zip/NoMedia/L0209T.zip','209 Toets Ontwikkeling van toerisme<br />','SCORM_1.2',100,1,0,0,2,'2beb42a48c849c4bbb5a906f6b48638a',87,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(45,14,'211 Maak samen een nieuwe wijk','./../../Zip/NoMedia/L0211.zip','211 Maak samen een nieuwe wijk<br />','SCORM_1.2',100,1,0,0,2,'7c5a6c014c1327f167900d53f1c4e3bf',89,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(46,14,'727 Teken het leukste schoolplein','./../../Zip/NoMedia/L0727.zip','727 Teken het leukste schoolplein<br />','SCORM_1.2',100,1,0,0,2,'b62299a92ed8b3c73d9d8ec57fa2b297',91,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833037),(47,15,'8 Werk met google maps','./../../Zip/NoMedia/L0008.zip','8 Werk met google maps','SCORM_1.2',100,1,0,0,2,'cc2f3ca5199170d4a98c8fe949d69fc3',93,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(48,15,'174 Rondleiding: Vrije tijd in je buurt','./../../Zip/NoMedia/L0174.zip','174 Rondleiding: Vrije tijd in je buurt<br />','SCORM_1.2',100,1,0,0,2,'bd57443dd5a5657eef9ea70b382d9011',95,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(49,15,'175 Plein: Vrije tijd in je buurt','./../../Zip/NoMedia/L0175.zip','175 Plein: Vrije tijd in je buurt<br />','SCORM_1.2',100,1,0,0,2,'27c9989339340695974c77f534ccf035',97,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(50,15,'176 Onderdelen van een kaart','./../../Zip/NoMedia/L0176.zip','176 Onderdelen van een kaart<br />','SCORM_1.2',100,1,0,0,2,'600bbf2e325cb1fed2e1a7c2c1383e28',99,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(51,15,'176 Toets Onderdelen van een kaart','./../../Zip/NoMedia/L0176T.zip','176 Toets Onderdelen van een kaart<br />','SCORM_1.2',100,1,0,0,2,'7c8a0d19fd23dc5f4ce7cb26ff462145',101,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(52,15,'177 Een kaart lezen','./../../Zip/NoMedia/L0177.zip','177 Een kaart lezen<br />','SCORM_1.2',100,1,0,0,2,'9a06f77817326e426874330790ac32e4',103,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(53,15,'177 Toets Een kaart lezen','./../../Zip/NoMedia/L0177T.zip','177 Toets Een kaart lezen<br />','SCORM_1.2',100,1,0,0,2,'04ff532904211e1d5756f47f5e9071e4',105,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(54,15,'179 Soorten kaarten','./../../Zip/NoMedia/L0179.zip','179 Soorten kaarten','SCORM_1.2',100,1,0,0,2,'1a35df61bea69d9876039f5afb1c98ca',107,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(55,15,'179 Toets Soorten kaarten','./../../Zip/NoMedia/L0179T.zip','179 Toets Soorten kaarten','SCORM_1.2',100,1,0,0,2,'9c1be747be8c8a5ed8ecfca42574ecfa',109,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(56,15,'181 Openbare speelruimtes','./../../Zip/NoMedia/L0181.zip','181 Openbare speelruimtes<br />','SCORM_1.2',100,1,0,0,2,'2bbca49f43a0727ed30ef54bd3991f9f',111,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(57,15,'181 Toets Openbare speelruimtes','./../../Zip/NoMedia/L0181T.zip','181 Toets Openbare speelruimtes<br />','SCORM_1.2',100,1,0,0,2,'aa43d2031bed2d0ffb00882e592cf8b7',113,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(58,15,'182 Soorten vrijetijdsbestedingen','./../../Zip/NoMedia/L0182.zip','182 Soorten vrijetijdsbestedingen<br />','SCORM_1.2',100,1,0,0,2,'65a8b3f783976a5c2dad1faab5f476c6',115,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(59,15,'182 Toets Soorten vrijetijdsbestedingen','./../../Zip/NoMedia/L0182T.zip','182 Toets Soorten vrijetijdsbestedingen<br />','SCORM_1.2',100,1,0,0,2,'a4e67556350f3baaf3241f0c87d151c5',117,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(60,15,'183 Maak een rondleiding','./../../Zip/NoMedia/L0183.zip','183 Maak een rondleiding<br />','SCORM_1.2',100,1,0,0,2,'c3f0759ef07004d1e2960a970165e583',119,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(61,15,'184 Ontwerp een speelplein','./../../Zip/NoMedia/L0184.zip','184 Ontwerp een speelplein<br />','SCORM_1.2',100,1,0,0,2,'0c8c49ef25de1e407e9ba0120c874ccf',121,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(62,15,'190 Zoek naar vrijetijdsbestedingen','./../../Zip/NoMedia/L0190.zip','190 Zoek naar vrijetijdsbestedingen','SCORM_1.2',100,1,0,0,2,'2556e110aabb149a1e46a91cca91a2d0',123,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(63,15,'207 Leven in een middeleeuwse stad','./../../Zip/NoMedia/L0207.zip','207 Leven in een middeleeuwse stad<br />','SCORM_1.2',100,1,0,0,2,'54e91519e856c2313d3061ee083d5a54',125,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833064),(64,15,'207 Toets Leven in een middeleeuwse stad','./../../Zip/NoMedia/L0207T.zip','207 Toets Leven in een middeleeuwse stad<br />','SCORM_1.2',100,1,0,0,2,'7b09c67ae3f6440bd9694a6feb8ebfe3',127,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833065),(65,15,'211 Maak samen een nieuwe wijk','./../../Zip/NoMedia/L0211.zip','211 Maak samen een nieuwe wijk<br />','SCORM_1.2',100,1,0,0,2,'7c5a6c014c1327f167900d53f1c4e3bf',129,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833065),(66,15,'218 Toerisme in Nederland','./../../Zip/NoMedia/L0218.zip','218 Toerisme in Nederland<br />','SCORM_1.2',100,1,0,0,2,'5d97988c609d8078d36684d615487c28',131,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833065),(67,15,'218 Toets Toerisme in Nederland','./../../Zip/NoMedia/L0218T.zip','218 Toets Toerisme in Nederland<br />','SCORM_1.2',100,1,0,0,2,'5f103269196c9147b00429278f56c5de',133,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833065),(68,15,'727 Teken het leukste schoolplein','./../../Zip/NoMedia/L0727.zip','727 Teken het leukste schoolplein<br />','SCORM_1.2',100,1,0,0,2,'b62299a92ed8b3c73d9d8ec57fa2b297',135,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833065),(69,16,'163 Straat: Zorg voor je wijk','./../../Zip/NoMedia/L0163.zip','163 Straat: Zorg voor je wijk<br />','SCORM_1.2',100,1,0,0,2,'93d8225a2011143ff085cf4c3da8b71e',137,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(70,16,'164 Speelplek: Zorg voor je wijk','./../../Zip/NoMedia/L0164.zip','164 Speelplek: Zorg voor je wijk<br />','SCORM_1.2',100,1,0,0,2,'dcf12ca9bc5d2ac510c45dfe28c29846',139,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(71,16,'165 Soorten huizen','./../../Zip/NoMedia/L0165.zip','165 Soorten huizen<br />','SCORM_1.2',100,1,0,0,2,'f5a74414add637f7bab50f8292b98539',141,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(72,16,'165 Toets Soorten huizen','./../../Zip/NoMedia/L0165T.zip','165 Toets Soorten huizen<br />','SCORM_1.2',100,1,0,0,2,'d2a7f09f6f71efe8d8f37c98acd90fb1',143,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(73,16,'166 Buizen door de wijk','./../../Zip/NoMedia/L0166.zip','166 Buizen door de wijk<br />','SCORM_1.2',100,1,0,0,2,'d4d2ac91f540ae3d150351c05db587ff',145,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(74,16,'166 Toets Buizen door de wijk','./../../Zip/NoMedia/L0166T.zip','166 Toets Buizen door de wijk<br />','SCORM_1.2',100,1,0,0,2,'6f4a0d87acf5b49bb8ddd237ccc40ca8',147,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(75,16,'167 Een huis van vroeger','./../../Zip/NoMedia/L0167.zip','167 Een huis van vroeger','SCORM_1.2',100,1,0,0,2,'a2c9f96442261eee9a22b3e44c8feb42',149,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(76,16,'167 Toets Een huis van vroeger','./../../Zip/NoMedia/L0167T.zip','167 Toets Een huis van vroeger<br />','SCORM_1.2',100,1,0,0,2,'fbf022c857bd9c1d8fdafcaba574f2f2',151,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(77,16,'168 Een groene en schone wijk','./../../Zip/NoMedia/L0168.zip','168 Een groene en schone wijk<br />','SCORM_1.2',100,1,0,0,2,'753e3483f2eb44bb0588c615a39415d1',153,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(78,16,'168 Toets Een groene en schone wijk','./../../Zip/NoMedia/L0168T.zip','168 Toets Een groene en schone wijk<br />','SCORM_1.2',100,1,0,0,2,'6334c9187a9621583b5a59a2f3125748',155,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(79,16,'169 Maak de wijk schoon','./../../Zip/NoMedia/L0169.zip','169 Maak de wijk schoon<br />','SCORM_1.2',100,1,0,0,2,'4e8c306b54e0fc94b7302b7376851901',157,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(80,16,'171 Teken je huis van binnen en buiten','./../../Zip/NoMedia/L0171.zip','171 Teken je huis van binnen en buiten<br />','SCORM_1.2',100,1,0,0,2,'3c27afb1bbf52c5fb38eed34c281e0ed',159,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(81,16,'172 Schilder samen een straat','./../../Zip/NoMedia/L0172.zip','172 Schilder samen een straat<br />','SCORM_1.2',100,1,0,0,2,'194253fc93419ef070fa43b9b64ba1aa',161,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(82,16,'173 Maak samen een speelveld','./../../Zip/NoMedia/L0173.zip','173 Maak samen een speelveld<br />','SCORM_1.2',100,1,0,0,2,'3ad47e2210662e15fb3205e7ab229731',163,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(83,16,'210 Een plattegrond lezen','./../../Zip/NoMedia/L0210.zip','210 Een plattegrond lezen<br />','SCORM_1.2',100,1,0,0,2,'24300e54d2b96323a1b11d5bbbe54c58',165,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(84,16,'210 Toets Een plattegrond lezen','./../../Zip/NoMedia/L0210T.zip','210 Toets Een plattegrond lezen<br />','SCORM_1.2',100,1,0,0,2,'55cd9ad6356983de4d46de72eb891da6',167,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(85,16,'727 Teken het leukste schoolplein','./../../Zip/NoMedia/L0727.zip','727 Teken het leukste schoolplein<br />','SCORM_1.2',100,1,0,0,2,'b62299a92ed8b3c73d9d8ec57fa2b297',169,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332833089),(86,17,'163 Straat: Zorg voor je wijk','./../../Zip/NoMedia/L0163.zip','163 Straat: Zorg voor je wijk<br />','SCORM_1.2',100,1,0,0,2,'93d8225a2011143ff085cf4c3da8b71e',171,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(87,17,'164 Speelplek: Zorg voor je wijk','./../../Zip/NoMedia/L0164.zip','164 Speelplek: Zorg voor je wijk<br />','SCORM_1.2',100,1,0,0,2,'dcf12ca9bc5d2ac510c45dfe28c29846',173,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(88,17,'165 Soorten huizen','./../../Zip/NoMedia/L0165.zip','165 Soorten huizen<br />','SCORM_1.2',100,1,0,0,2,'f5a74414add637f7bab50f8292b98539',175,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(89,17,'165 Toets Soorten huizen','./../../Zip/NoMedia/L0165T.zip','165 Toets Soorten huizen<br />','SCORM_1.2',100,1,0,0,2,'d2a7f09f6f71efe8d8f37c98acd90fb1',177,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(90,17,'166 Buizen door de wijk','./../../Zip/NoMedia/L0166.zip','166 Buizen door de wijk<br />','SCORM_1.2',100,1,0,0,2,'d4d2ac91f540ae3d150351c05db587ff',179,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(91,17,'166 Toets Buizen door de wijk','./../../Zip/NoMedia/L0166T.zip','166 Toets Buizen door de wijk<br />','SCORM_1.2',100,1,0,0,2,'6f4a0d87acf5b49bb8ddd237ccc40ca8',181,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(92,17,'167 Een huis van vroeger','./../../Zip/NoMedia/L0167.zip','167 Een huis van vroeger','SCORM_1.2',100,1,0,0,2,'a2c9f96442261eee9a22b3e44c8feb42',183,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(93,17,'167 Toets Een huis van vroeger','./../../Zip/NoMedia/L0167T.zip','167 Toets Een huis van vroeger<br />','SCORM_1.2',100,1,0,0,2,'fbf022c857bd9c1d8fdafcaba574f2f2',185,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(94,17,'168 Een groene en schone wijk','./../../Zip/NoMedia/L0168.zip','168 Een groene en schone wijk<br />','SCORM_1.2',100,1,0,0,2,'753e3483f2eb44bb0588c615a39415d1',187,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(95,17,'168 Toets Een groene en schone wijk','./../../Zip/NoMedia/L0168T.zip','168 Toets Een groene en schone wijk<br />','SCORM_1.2',100,1,0,0,2,'6334c9187a9621583b5a59a2f3125748',189,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(96,17,'169 Maak de wijk schoon','./../../Zip/NoMedia/L0169.zip','169 Maak de wijk schoon<br />','SCORM_1.2',100,1,0,0,2,'4e8c306b54e0fc94b7302b7376851901',191,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(97,17,'171 Teken je huis van binnen en buiten','./../../Zip/NoMedia/L0171.zip','171 Teken je huis van binnen en buiten<br />','SCORM_1.2',100,1,0,0,2,'3c27afb1bbf52c5fb38eed34c281e0ed',193,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(98,17,'172 Schilder samen een straat','./../../Zip/NoMedia/L0172.zip','172 Schilder samen een straat<br />','SCORM_1.2',100,1,0,0,2,'194253fc93419ef070fa43b9b64ba1aa',195,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(99,17,'173 Maak samen een speelveld','./../../Zip/NoMedia/L0173.zip','173 Maak samen een speelveld<br />','SCORM_1.2',100,1,0,0,2,'3ad47e2210662e15fb3205e7ab229731',197,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(100,17,'210 Een plattegrond lezen','./../../Zip/NoMedia/L0210.zip','210 Een plattegrond lezen<br />','SCORM_1.2',100,1,0,0,2,'24300e54d2b96323a1b11d5bbbe54c58',199,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(101,17,'210 Toets Een plattegrond lezen','./../../Zip/NoMedia/L0210T.zip','210 Toets Een plattegrond lezen<br />','SCORM_1.2',100,1,0,0,2,'55cd9ad6356983de4d46de72eb891da6',201,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939),(102,17,'727 Teken het leukste schoolplein','./../../Zip/NoMedia/L0727.zip','727 Teken het leukste schoolplein<br />','SCORM_1.2',100,1,0,0,2,'b62299a92ed8b3c73d9d8ec57fa2b297',203,2,1,0,0,0,1,'resizable=0,scrollbars=0,directories=0,location=0,menubar=0,toolbar=0,status=0',966,760,1332837939);
/*!40000 ALTER TABLE `mdl_scorm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_scoes`
--

DROP TABLE IF EXISTS `mdl_scorm_scoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_scoes` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scorm` bigint(10) unsigned NOT NULL DEFAULT '0',
  `manifest` varchar(255) NOT NULL DEFAULT '',
  `organization` varchar(255) NOT NULL DEFAULT '',
  `parent` varchar(255) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `launch` varchar(255) NOT NULL DEFAULT '',
  `scormtype` varchar(5) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_scorscoe_sco_ix` (`scorm`)
) ENGINE=MyISAM AUTO_INCREMENT=205 DEFAULT CHARSET=utf8 COMMENT='each SCO part of the SCORM module';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_scoes`
--

LOCK TABLES `mdl_scorm_scoes` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_scoes` DISABLE KEYS */;
INSERT INTO `mdl_scorm_scoes` VALUES (1,1,'L0193_MANIFEST','','/','TOC1','','','193 Wonen in je straat'),(2,1,'L0193_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','193 Wonen in je straat'),(3,2,'L0195_MANIFEST','','/','TOC1','','','195 Woorden: Het huis'),(4,2,'L0195_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','195 Woorden: Het huis'),(5,3,'L0196_MANIFEST','','/','TOC1','','','196 Praatplaat: Soorten huizen'),(6,3,'L0196_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','196 Praatplaat: Soorten huizen'),(7,4,'L0199_MANIFEST','','/','TOC1','','','199 Hoek: Huizen bouwen'),(8,4,'L0199_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','199 Hoek: Huizen bouwen'),(9,5,'L0200_MANIFEST','','/','TOC1','','','200 Maak je slaapkamer'),(10,5,'L0200_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','200 Maak je slaapkamer'),(11,6,'L0201_MANIFEST','','/','TOC1','','','201 Woorden: De straat'),(12,6,'L0201_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','201 Woorden: De straat'),(13,7,'L0202_MANIFEST','','/','TOC1','','','202 Bewegen: Stoeptegelspellen'),(14,7,'L0202_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','202 Bewegen: Stoeptegelspellen'),(15,8,'L0203_MANIFEST','','/','TOC1','','','203 Doeblad: Houd je straat schoon'),(16,8,'L0203_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','203 Doeblad: Houd je straat schoon'),(17,9,'L0205_MANIFEST','','/','TOC1','','','205 Ruim de straat op'),(18,9,'L0205_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','205 Ruim de straat op'),(19,10,'L0206_MANIFEST','','/','TOC1','','','206 Teken je eigen huis'),(20,10,'L0206_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','206 Teken je eigen huis'),(21,11,'L0216_MANIFEST','','/','TOC1','','','216 Onder, boven, voor en achter'),(22,11,'L0216_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','216 Onder, boven, voor en achter'),(23,12,'L0217_MANIFEST','','/','TOC1','','','217 Links en rechts'),(24,12,'L0217_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','217 Links en rechts'),(25,13,'L0727_MANIFEST','','/','TOC1','','','727 Teken het leukste schoolplein'),(26,13,'L0727_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','727 Teken het leukste schoolplein'),(27,14,'L0007_MANIFEST','','/','TOC1','','','7 Voorzieningen voor iedereen'),(28,14,'L0007_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','7 Voorzieningen voor iedereen'),(29,15,'L0007_MANIFEST','','/','TOC1','','','7 Toets Voorzieningen voor iedereen'),(30,15,'L0007_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','7 Toets Voorzieningen voor iedereen'),(31,16,'L0008_MANIFEST','','/','TOC1','','','8 Werken met Google Maps'),(32,16,'L0008_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','8 Werken met Google Maps'),(33,17,'L0009_MANIFEST','','/','TOC1','','','9 Rekenen met schaal'),(34,17,'L0009_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','9 Rekenen met schaal'),(35,18,'L0009_MANIFEST','','/','TOC1','','','9 Toets Rekenen met schaal'),(36,18,'L0009_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','9 Toets Rekenen met schaal'),(37,19,'L0111_MANIFEST','','/','TOC1','','','111 Houd een interview'),(38,19,'L0111_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','111 Houd een interview'),(39,20,'L0170_MANIFEST','','/','TOC1','','','170 Doe historisch onderzoek'),(40,20,'L0170_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','170 Doe historisch onderzoek'),(41,21,'L0176_MANIFEST','','/','TOC1','','','176 Onderdelen van een kaart'),(42,21,'L0176_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','176 Onderdelen van een kaart'),(43,22,'L0176_MANIFEST','','/','TOC1','','','176 Toets Onderdelen van een kaart'),(44,22,'L0176_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','176 Toets Onderdelen van een kaart'),(45,23,'L0177_MANIFEST','','/','TOC1','','','177 Een kaart lezen'),(46,23,'L0177_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','177 Een kaart lezen'),(47,24,'L0177_MANIFEST','','/','TOC1','','','177 Toets Een kaart lezen'),(48,24,'L0177_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','177 Toets Een kaart lezen'),(49,25,'L0178_MANIFEST','','/','TOC1','','','178 Opbouw van een stad'),(50,25,'L0178_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','178 Opbouw van een stad'),(51,26,'L0178_MANIFEST','','/','TOC1','','','178 Toets Opbouw van een stad'),(52,26,'L0178_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','178 Toets Opbouw van een stad'),(53,27,'L0179_MANIFEST','','/','TOC1','','','179 Soorten kaarten'),(54,27,'L0179_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','179 Soorten kaarten'),(55,28,'L0179_MANIFEST','','/','TOC1','','','179 Toets Soorten kaarten'),(56,28,'L0179_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','179 Toets Soorten kaarten'),(57,29,'L0180_MANIFEST','','/','TOC1','','','180 Ontwerp een plein op schaal'),(58,29,'L0180_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','180 Ontwerp een plein op schaal'),(59,30,'L0185_MANIFEST','','/','TOC1','','','185 Taken van de gemeente'),(60,30,'L0185_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','185 Taken van de gemeente'),(61,31,'L0185_MANIFEST','','/','TOC1','','','185 Toets Taken van de gemeente'),(62,31,'L0185_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','185 Toets Taken van de gemeente'),(63,32,'L0186_MANIFEST','','/','TOC1','','','186 Ruimtelijke ordening'),(64,32,'L0186_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','186 Ruimtelijke ordening'),(65,33,'L0186_MANIFEST','','/','TOC1','','','186 Toets Ruimtelijke ordening'),(66,33,'L0186_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','186 Toets Ruimtelijke ordening'),(67,34,'L0187_MANIFEST','','/','TOC1','','','187 Historisch onderzoek: Ontwikkeling van je gemeente'),(68,34,'L0187_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','187 Historisch onderzoek: Ontwikkeling van je gemeente'),(69,35,'L0188_MANIFEST','','/','TOC1','','','188 Pleinontwerp: Ontwikkeling van je gemeente'),(70,35,'L0188_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','188 Pleinontwerp: Ontwikkeling van je gemeente'),(71,36,'L0189_MANIFEST','','/','TOC1','','','189 Verstedelijking van Nederland'),(72,36,'L0189_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','189 Verstedelijking van Nederland'),(73,37,'L0189_MANIFEST','','/','TOC1','','','189 Toets Verstedelijking van Nederland'),(74,37,'L0189_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','189 Toets Verstedelijking van Nederland'),(75,38,'L0191_MANIFEST','','/','TOC1','','','191 Ontstaan van dorpen'),(76,38,'L0191_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','191 Ontstaan van dorpen'),(77,39,'L0191_MANIFEST','','/','TOC1','','','191 Toets Ontstaan van dorpen'),(78,39,'L0191_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','191 Toets Ontstaan van dorpen'),(79,40,'L0192_MANIFEST','','/','TOC1','','','192 Ontstaan van steden'),(80,40,'L0192_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','192 Ontstaan van steden'),(81,41,'L0192_MANIFEST','','/','TOC1','','','192 Toets Ontstaan van steden'),(82,41,'L0192_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','192 Toets Ontstaan van steden'),(83,42,'L0208_MANIFEST','','/','TOC1','','','208 Houd een enquête'),(84,42,'L0208_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','208 Houd een enquête'),(85,43,'L0209_MANIFEST','','/','TOC1','','','209 Ontwikkeling van toerisme'),(86,43,'L0209_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','209 Ontwikkeling van toerisme'),(87,44,'L0209_MANIFEST','','/','TOC1','','','209 Toets Ontwikkeling van toerisme'),(88,44,'L0209_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','209 Toets Ontwikkeling van toerisme'),(89,45,'L0211_MANIFEST','','/','TOC1','','','211 Maak samen een nieuwe wijk'),(90,45,'L0211_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','211 Maak samen een nieuwe wijk'),(91,46,'L0727_MANIFEST','','/','TOC1','','','727 Teken het leukste schoolplein'),(92,46,'L0727_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','727 Teken het leukste schoolplein'),(93,47,'L0008_MANIFEST','','/','TOC1','','','8 Werken met Google Maps'),(94,47,'L0008_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','8 Werken met Google Maps'),(95,48,'L0174_MANIFEST','','/','TOC1','','','174 Rondleiding: Vrije tijd in je buurt'),(96,48,'L0174_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','174 Rondleiding: Vrije tijd in je buurt'),(97,49,'L0175_MANIFEST','','/','TOC1','','','175 Plein: Vrije tijd in je buurt'),(98,49,'L0175_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','175 Plein: Vrije tijd in je buurt'),(99,50,'L0176_MANIFEST','','/','TOC1','','','176 Onderdelen van een kaart'),(100,50,'L0176_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','176 Onderdelen van een kaart'),(101,51,'L0176_MANIFEST','','/','TOC1','','','176 Toets Onderdelen van een kaart'),(102,51,'L0176_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','176 Toets Onderdelen van een kaart'),(103,52,'L0177_MANIFEST','','/','TOC1','','','177 Een kaart lezen'),(104,52,'L0177_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','177 Een kaart lezen'),(105,53,'L0177_MANIFEST','','/','TOC1','','','177 Toets Een kaart lezen'),(106,53,'L0177_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','177 Toets Een kaart lezen'),(107,54,'L0179_MANIFEST','','/','TOC1','','','179 Soorten kaarten'),(108,54,'L0179_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','179 Soorten kaarten'),(109,55,'L0179_MANIFEST','','/','TOC1','','','179 Toets Soorten kaarten'),(110,55,'L0179_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','179 Toets Soorten kaarten'),(111,56,'L0181_MANIFEST','','/','TOC1','','','181 Openbare speelruimtes'),(112,56,'L0181_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','181 Openbare speelruimtes'),(113,57,'L0181_MANIFEST','','/','TOC1','','','181 Toets Openbare speelruimtes'),(114,57,'L0181_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','181 Toets Openbare speelruimtes'),(115,58,'L0182_MANIFEST','','/','TOC1','','','182 Soorten vrijetijdsbestedingen'),(116,58,'L0182_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','182 Soorten vrijetijdsbestedingen'),(117,59,'L0182_MANIFEST','','/','TOC1','','','182 Toets Soorten vrijetijdsbestedingen'),(118,59,'L0182_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','182 Toets Soorten vrijetijdsbestedingen'),(119,60,'L0183_MANIFEST','','/','TOC1','','','183 Maak een rondleiding'),(120,60,'L0183_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','183 Maak een rondleiding'),(121,61,'L0184_MANIFEST','','/','TOC1','','','184 Ontwerp een speelplein'),(122,61,'L0184_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','184 Ontwerp een speelplein'),(123,62,'L0190_MANIFEST','','/','TOC1','','','190 Zoek naar vrijetijdsbestedingen'),(124,62,'L0190_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','190 Zoek naar vrijetijdsbestedingen'),(125,63,'L0207_MANIFEST','','/','TOC1','','','207 Leven in een middeleeuwse stad'),(126,63,'L0207_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','207 Leven in een middeleeuwse stad'),(127,64,'L0207_MANIFEST','','/','TOC1','','','207 Toets Leven in een middeleeuwse stad'),(128,64,'L0207_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','207 Toets Leven in een middeleeuwse stad'),(129,65,'L0211_MANIFEST','','/','TOC1','','','211 Maak samen een nieuwe wijk'),(130,65,'L0211_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','211 Maak samen een nieuwe wijk'),(131,66,'L0218_MANIFEST','','/','TOC1','','','218 Toerisme in Nederland'),(132,66,'L0218_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','218 Toerisme in Nederland'),(133,67,'L0218_MANIFEST','','/','TOC1','','','218 Toets Toerisme in Nederland'),(134,67,'L0218_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','218 Toets Toerisme in Nederland'),(135,68,'L0727_MANIFEST','','/','TOC1','','','727 Teken het leukste schoolplein'),(136,68,'L0727_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','727 Teken het leukste schoolplein'),(137,69,'L0163_MANIFEST','','/','TOC1','','','163 Straat: Zorg voor je wijk'),(138,69,'L0163_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','163 Straat: Zorg voor je wijk'),(139,70,'L0164_MANIFEST','','/','TOC1','','','164 Speelplek: Zorg voor je wijk'),(140,70,'L0164_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','164 Speelplek: Zorg voor je wijk'),(141,71,'L0165_MANIFEST','','/','TOC1','','','165 Soorten huizen'),(142,71,'L0165_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','165 Soorten huizen'),(143,72,'L0165_MANIFEST','','/','TOC1','','','165 Toets Soorten huizen'),(144,72,'L0165_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','165 Toets Soorten huizen'),(145,73,'L0166_MANIFEST','','/','TOC1','','','166 Buizen door de wijk'),(146,73,'L0166_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','166 Buizen door de wijk'),(147,74,'L0166_MANIFEST','','/','TOC1','','','166 Toets Buizen door de wijk'),(148,74,'L0166_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','166 Toets Buizen door de wijk'),(149,75,'L0167_MANIFEST','','/','TOC1','','','167 Een huis van vroeger'),(150,75,'L0167_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','167 Een huis van vroeger'),(151,76,'L0167_MANIFEST','','/','TOC1','','','167 Toets Een huis van vroeger'),(152,76,'L0167_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','167 Toets Een huis van vroeger'),(153,77,'L0168_MANIFEST','','/','TOC1','','','168 Een groene en schone wijk'),(154,77,'L0168_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','168 Een groene en schone wijk'),(155,78,'L0168_MANIFEST','','/','TOC1','','','168 Toets Een groene en schone wijk'),(156,78,'L0168_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','168 Toets Een groene en schone wijk'),(157,79,'L0169_MANIFEST','','/','TOC1','','','169 Maak de wijk schoon'),(158,79,'L0169_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','169 Maak de wijk schoon'),(159,80,'L0171_MANIFEST','','/','TOC1','','','171 Teken je huis van binnen en buiten'),(160,80,'L0171_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','171 Teken je huis van binnen en buiten'),(161,81,'L0172_MANIFEST','','/','TOC1','','','172 Schilder samen een straat'),(162,81,'L0172_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','172 Schilder samen een straat'),(163,82,'L0173_MANIFEST','','/','TOC1','','','173 Maak samen een speelveld'),(164,82,'L0173_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','173 Maak samen een speelveld'),(165,83,'L0210_MANIFEST','','/','TOC1','','','210 Een plattegrond lezen'),(166,83,'L0210_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','210 Een plattegrond lezen'),(167,84,'L0210_MANIFEST','','/','TOC1','','','210 Toets Een plattegrond lezen'),(168,84,'L0210_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','210 Toets Een plattegrond lezen'),(169,85,'L0727_MANIFEST','','/','TOC1','','','727 Teken het leukste schoolplein'),(170,85,'L0727_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','727 Teken het leukste schoolplein'),(171,86,'L0163_MANIFEST','','/','TOC1','','','163 Straat: Zorg voor je wijk'),(172,86,'L0163_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','163 Straat: Zorg voor je wijk'),(173,87,'L0164_MANIFEST','','/','TOC1','','','164 Speelplek: Zorg voor je wijk'),(174,87,'L0164_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','164 Speelplek: Zorg voor je wijk'),(175,88,'L0165_MANIFEST','','/','TOC1','','','165 Soorten huizen'),(176,88,'L0165_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','165 Soorten huizen'),(177,89,'L0165_MANIFEST','','/','TOC1','','','165 Toets Soorten huizen'),(178,89,'L0165_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','165 Toets Soorten huizen'),(179,90,'L0166_MANIFEST','','/','TOC1','','','166 Buizen door de wijk'),(180,90,'L0166_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','166 Buizen door de wijk'),(181,91,'L0166_MANIFEST','','/','TOC1','','','166 Toets Buizen door de wijk'),(182,91,'L0166_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','166 Toets Buizen door de wijk'),(183,92,'L0167_MANIFEST','','/','TOC1','','','167 Een huis van vroeger'),(184,92,'L0167_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','167 Een huis van vroeger'),(185,93,'L0167_MANIFEST','','/','TOC1','','','167 Toets Een huis van vroeger'),(186,93,'L0167_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','167 Toets Een huis van vroeger'),(187,94,'L0168_MANIFEST','','/','TOC1','','','168 Een groene en schone wijk'),(188,94,'L0168_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','168 Een groene en schone wijk'),(189,95,'L0168_MANIFEST','','/','TOC1','','','168 Toets Een groene en schone wijk'),(190,95,'L0168_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','168 Toets Een groene en schone wijk'),(191,96,'L0169_MANIFEST','','/','TOC1','','','169 Maak de wijk schoon'),(192,96,'L0169_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','169 Maak de wijk schoon'),(193,97,'L0171_MANIFEST','','/','TOC1','','','171 Teken je huis van binnen en buiten'),(194,97,'L0171_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','171 Teken je huis van binnen en buiten'),(195,98,'L0172_MANIFEST','','/','TOC1','','','172 Schilder samen een straat'),(196,98,'L0172_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','172 Schilder samen een straat'),(197,99,'L0173_MANIFEST','','/','TOC1','','','173 Maak samen een speelveld'),(198,99,'L0173_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','173 Maak samen een speelveld'),(199,100,'L0210_MANIFEST','','/','TOC1','','','210 Een plattegrond lezen'),(200,100,'L0210_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','210 Een plattegrond lezen'),(201,101,'L0210_MANIFEST','','/','TOC1','','','210 Toets Een plattegrond lezen'),(202,101,'L0210_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','210 Toets Een plattegrond lezen'),(203,102,'L0727_MANIFEST','','/','TOC1','','','727 Teken het leukste schoolplein'),(204,102,'L0727_MANIFEST','TOC1','TOC1','I_SCO0','player.html','sco','727 Teken het leukste schoolplein');
/*!40000 ALTER TABLE `mdl_scorm_scoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_scoes_data`
--

DROP TABLE IF EXISTS `mdl_scorm_scoes_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_scoes_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_scorscoedata_sco_ix` (`scoid`)
) ENGINE=MyISAM AUTO_INCREMENT=205 DEFAULT CHARSET=utf8 COMMENT='Contains variable data get from packages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_scoes_data`
--

LOCK TABLES `mdl_scorm_scoes_data` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_scoes_data` DISABLE KEYS */;
INSERT INTO `mdl_scorm_scoes_data` VALUES (1,2,'isvisible','true'),(2,2,'parameters',''),(3,4,'isvisible','true'),(4,4,'parameters',''),(5,6,'isvisible','true'),(6,6,'parameters',''),(7,8,'isvisible','true'),(8,8,'parameters',''),(9,10,'isvisible','true'),(10,10,'parameters',''),(11,12,'isvisible','true'),(12,12,'parameters',''),(13,14,'isvisible','true'),(14,14,'parameters',''),(15,16,'isvisible','true'),(16,16,'parameters',''),(17,18,'isvisible','true'),(18,18,'parameters',''),(19,20,'isvisible','true'),(20,20,'parameters',''),(21,22,'isvisible','true'),(22,22,'parameters',''),(23,24,'isvisible','true'),(24,24,'parameters',''),(25,26,'isvisible','true'),(26,26,'parameters',''),(27,28,'isvisible','true'),(28,28,'parameters',''),(29,30,'isvisible','true'),(30,30,'parameters',''),(31,32,'isvisible','true'),(32,32,'parameters',''),(33,34,'isvisible','true'),(34,34,'parameters',''),(35,36,'isvisible','true'),(36,36,'parameters',''),(37,38,'isvisible','true'),(38,38,'parameters',''),(39,40,'isvisible','true'),(40,40,'parameters',''),(41,42,'isvisible','true'),(42,42,'parameters',''),(43,44,'isvisible','true'),(44,44,'parameters',''),(45,46,'isvisible','true'),(46,46,'parameters',''),(47,48,'isvisible','true'),(48,48,'parameters',''),(49,50,'isvisible','true'),(50,50,'parameters',''),(51,52,'isvisible','true'),(52,52,'parameters',''),(53,54,'isvisible','true'),(54,54,'parameters',''),(55,56,'isvisible','true'),(56,56,'parameters',''),(57,58,'isvisible','true'),(58,58,'parameters',''),(59,60,'isvisible','true'),(60,60,'parameters',''),(61,62,'isvisible','true'),(62,62,'parameters',''),(63,64,'isvisible','true'),(64,64,'parameters',''),(65,66,'isvisible','true'),(66,66,'parameters',''),(67,68,'isvisible','true'),(68,68,'parameters',''),(69,70,'isvisible','true'),(70,70,'parameters',''),(71,72,'isvisible','true'),(72,72,'parameters',''),(73,74,'isvisible','true'),(74,74,'parameters',''),(75,76,'isvisible','true'),(76,76,'parameters',''),(77,78,'isvisible','true'),(78,78,'parameters',''),(79,80,'isvisible','true'),(80,80,'parameters',''),(81,82,'isvisible','true'),(82,82,'parameters',''),(83,84,'isvisible','true'),(84,84,'parameters',''),(85,86,'isvisible','true'),(86,86,'parameters',''),(87,88,'isvisible','true'),(88,88,'parameters',''),(89,90,'isvisible','true'),(90,90,'parameters',''),(91,92,'isvisible','true'),(92,92,'parameters',''),(93,94,'isvisible','true'),(94,94,'parameters',''),(95,96,'isvisible','true'),(96,96,'parameters',''),(97,98,'isvisible','true'),(98,98,'parameters',''),(99,100,'isvisible','true'),(100,100,'parameters',''),(101,102,'isvisible','true'),(102,102,'parameters',''),(103,104,'isvisible','true'),(104,104,'parameters',''),(105,106,'isvisible','true'),(106,106,'parameters',''),(107,108,'isvisible','true'),(108,108,'parameters',''),(109,110,'isvisible','true'),(110,110,'parameters',''),(111,112,'isvisible','true'),(112,112,'parameters',''),(113,114,'isvisible','true'),(114,114,'parameters',''),(115,116,'isvisible','true'),(116,116,'parameters',''),(117,118,'isvisible','true'),(118,118,'parameters',''),(119,120,'isvisible','true'),(120,120,'parameters',''),(121,122,'isvisible','true'),(122,122,'parameters',''),(123,124,'isvisible','true'),(124,124,'parameters',''),(125,126,'isvisible','true'),(126,126,'parameters',''),(127,128,'isvisible','true'),(128,128,'parameters',''),(129,130,'isvisible','true'),(130,130,'parameters',''),(131,132,'isvisible','true'),(132,132,'parameters',''),(133,134,'isvisible','true'),(134,134,'parameters',''),(135,136,'isvisible','true'),(136,136,'parameters',''),(137,138,'isvisible','true'),(138,138,'parameters',''),(139,140,'isvisible','true'),(140,140,'parameters',''),(141,142,'isvisible','true'),(142,142,'parameters',''),(143,144,'isvisible','true'),(144,144,'parameters',''),(145,146,'isvisible','true'),(146,146,'parameters',''),(147,148,'isvisible','true'),(148,148,'parameters',''),(149,150,'isvisible','true'),(150,150,'parameters',''),(151,152,'isvisible','true'),(152,152,'parameters',''),(153,154,'isvisible','true'),(154,154,'parameters',''),(155,156,'isvisible','true'),(156,156,'parameters',''),(157,158,'isvisible','true'),(158,158,'parameters',''),(159,160,'isvisible','true'),(160,160,'parameters',''),(161,162,'isvisible','true'),(162,162,'parameters',''),(163,164,'isvisible','true'),(164,164,'parameters',''),(165,166,'isvisible','true'),(166,166,'parameters',''),(167,168,'isvisible','true'),(168,168,'parameters',''),(169,170,'isvisible','true'),(170,170,'parameters',''),(171,172,'isvisible','true'),(172,172,'parameters',''),(173,174,'isvisible','true'),(174,174,'parameters',''),(175,176,'isvisible','true'),(176,176,'parameters',''),(177,178,'isvisible','true'),(178,178,'parameters',''),(179,180,'isvisible','true'),(180,180,'parameters',''),(181,182,'isvisible','true'),(182,182,'parameters',''),(183,184,'isvisible','true'),(184,184,'parameters',''),(185,186,'isvisible','true'),(186,186,'parameters',''),(187,188,'isvisible','true'),(188,188,'parameters',''),(189,190,'isvisible','true'),(190,190,'parameters',''),(191,192,'isvisible','true'),(192,192,'parameters',''),(193,194,'isvisible','true'),(194,194,'parameters',''),(195,196,'isvisible','true'),(196,196,'parameters',''),(197,198,'isvisible','true'),(198,198,'parameters',''),(199,200,'isvisible','true'),(200,200,'parameters',''),(201,202,'isvisible','true'),(202,202,'parameters',''),(203,204,'isvisible','true'),(204,204,'parameters','');
/*!40000 ALTER TABLE `mdl_scorm_scoes_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_scoes_track`
--

DROP TABLE IF EXISTS `mdl_scorm_scoes_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_scoes_track` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `scormid` bigint(10) NOT NULL DEFAULT '0',
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `attempt` bigint(10) unsigned NOT NULL DEFAULT '1',
  `element` varchar(255) NOT NULL DEFAULT '',
  `value` longtext NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorscoetrac_usescosco_uix` (`userid`,`scormid`,`scoid`,`attempt`,`element`),
  KEY `mdl_scorscoetrac_use_ix` (`userid`),
  KEY `mdl_scorscoetrac_ele_ix` (`element`),
  KEY `mdl_scorscoetrac_sco_ix` (`scormid`),
  KEY `mdl_scorscoetrac_sco2_ix` (`scoid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to track SCOes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_scoes_track`
--

LOCK TABLES `mdl_scorm_scoes_track` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_scoes_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_scoes_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_seq_mapinfo`
--

DROP TABLE IF EXISTS `mdl_scorm_seq_mapinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_seq_mapinfo` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `objectiveid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `targetobjectiveid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `readsatisfiedstatus` tinyint(1) NOT NULL DEFAULT '1',
  `readnormalizedmeasure` tinyint(1) NOT NULL DEFAULT '1',
  `writesatisfiedstatus` tinyint(1) NOT NULL DEFAULT '0',
  `writenormalizedmeasure` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqmapi_scoidobj_uix` (`scoid`,`id`,`objectiveid`),
  KEY `mdl_scorseqmapi_sco_ix` (`scoid`),
  KEY `mdl_scorseqmapi_obj_ix` (`objectiveid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SCORM2004 objective mapinfo description';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_seq_mapinfo`
--

LOCK TABLES `mdl_scorm_seq_mapinfo` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_seq_mapinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_seq_mapinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_seq_objective`
--

DROP TABLE IF EXISTS `mdl_scorm_seq_objective`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_seq_objective` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `primaryobj` tinyint(1) NOT NULL DEFAULT '0',
  `objectiveid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `satisfiedbymeasure` tinyint(1) NOT NULL DEFAULT '1',
  `minnormalizedmeasure` float(11,4) unsigned NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqobje_scoid_uix` (`scoid`,`id`),
  KEY `mdl_scorseqobje_sco_ix` (`scoid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SCORM2004 objective description';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_seq_objective`
--

LOCK TABLES `mdl_scorm_seq_objective` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_seq_objective` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_seq_objective` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_seq_rolluprule`
--

DROP TABLE IF EXISTS `mdl_scorm_seq_rolluprule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_seq_rolluprule` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `childactivityset` varchar(15) NOT NULL DEFAULT '',
  `minimumcount` bigint(10) unsigned NOT NULL DEFAULT '0',
  `minimumpercent` float(11,4) unsigned NOT NULL DEFAULT '0.0000',
  `conditioncombination` varchar(3) NOT NULL DEFAULT 'all',
  `action` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqroll_scoid_uix` (`scoid`,`id`),
  KEY `mdl_scorseqroll_sco_ix` (`scoid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SCORM2004 sequencing rule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_seq_rolluprule`
--

LOCK TABLES `mdl_scorm_seq_rolluprule` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_seq_rolluprule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_seq_rolluprule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_seq_rolluprulecond`
--

DROP TABLE IF EXISTS `mdl_scorm_seq_rolluprulecond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_seq_rolluprulecond` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rollupruleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `operator` varchar(5) NOT NULL DEFAULT 'noOp',
  `cond` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqroll_scorolid_uix` (`scoid`,`rollupruleid`,`id`),
  KEY `mdl_scorseqroll_sco2_ix` (`scoid`),
  KEY `mdl_scorseqroll_rol_ix` (`rollupruleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SCORM2004 sequencing rule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_seq_rolluprulecond`
--

LOCK TABLES `mdl_scorm_seq_rolluprulecond` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_seq_rolluprulecond` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_seq_rolluprulecond` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_seq_rulecond`
--

DROP TABLE IF EXISTS `mdl_scorm_seq_rulecond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_seq_rulecond` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ruleconditionsid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `refrencedobjective` varchar(255) NOT NULL DEFAULT '',
  `measurethreshold` float(11,4) NOT NULL DEFAULT '0.0000',
  `operator` varchar(5) NOT NULL DEFAULT 'noOp',
  `cond` varchar(30) NOT NULL DEFAULT 'always',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqrule_idscorul_uix` (`id`,`scoid`,`ruleconditionsid`),
  KEY `mdl_scorseqrule_sco2_ix` (`scoid`),
  KEY `mdl_scorseqrule_rul_ix` (`ruleconditionsid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SCORM2004 rule condition';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_seq_rulecond`
--

LOCK TABLES `mdl_scorm_seq_rulecond` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_seq_rulecond` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_seq_rulecond` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_scorm_seq_ruleconds`
--

DROP TABLE IF EXISTS `mdl_scorm_seq_ruleconds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_scorm_seq_ruleconds` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `conditioncombination` varchar(3) NOT NULL DEFAULT 'all',
  `ruletype` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `action` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqrule_scoid_uix` (`scoid`,`id`),
  KEY `mdl_scorseqrule_sco_ix` (`scoid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SCORM2004 rule conditions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_scorm_seq_ruleconds`
--

LOCK TABLES `mdl_scorm_seq_ruleconds` WRITE;
/*!40000 ALTER TABLE `mdl_scorm_seq_ruleconds` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_scorm_seq_ruleconds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_sessions2`
--

DROP TABLE IF EXISTS `mdl_sessions2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_sessions2` (
  `sesskey` varchar(64) NOT NULL DEFAULT '',
  `expiry` datetime NOT NULL,
  `expireref` varchar(250) DEFAULT '',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `sessdata` longtext,
  PRIMARY KEY (`sesskey`),
  KEY `mdl_sess_exp_ix` (`expiry`),
  KEY `mdl_sess_exp2_ix` (`expireref`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Optional database session storage in new format, not used by';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_sessions2`
--

LOCK TABLES `mdl_sessions2` WRITE;
/*!40000 ALTER TABLE `mdl_sessions2` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_sessions2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_soda`
--

DROP TABLE IF EXISTS `mdl_soda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_soda` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_soda_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Instances of mod soda';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_soda`
--

LOCK TABLES `mdl_soda` WRITE;
/*!40000 ALTER TABLE `mdl_soda` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_soda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_stats_daily`
--

DROP TABLE IF EXISTS `mdl_stats_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_stats_daily` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` enum('enrolments','activity','logins') NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stat2` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_statdail_cou_ix` (`courseid`),
  KEY `mdl_statdail_tim_ix` (`timeend`),
  KEY `mdl_statdail_rol_ix` (`roleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='to accumulate daily stats';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_stats_daily`
--

LOCK TABLES `mdl_stats_daily` WRITE;
/*!40000 ALTER TABLE `mdl_stats_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_stats_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_stats_monthly`
--

DROP TABLE IF EXISTS `mdl_stats_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_stats_monthly` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` enum('enrolments','activity','logins') NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stat2` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_statmont_cou_ix` (`courseid`),
  KEY `mdl_statmont_tim_ix` (`timeend`),
  KEY `mdl_statmont_rol_ix` (`roleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To accumulate monthly stats';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_stats_monthly`
--

LOCK TABLES `mdl_stats_monthly` WRITE;
/*!40000 ALTER TABLE `mdl_stats_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_stats_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_stats_user_daily`
--

DROP TABLE IF EXISTS `mdl_stats_user_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_stats_user_daily` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `statsreads` bigint(10) unsigned NOT NULL DEFAULT '0',
  `statswrites` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_statuserdail_cou_ix` (`courseid`),
  KEY `mdl_statuserdail_use_ix` (`userid`),
  KEY `mdl_statuserdail_rol_ix` (`roleid`),
  KEY `mdl_statuserdail_tim_ix` (`timeend`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To accumulate daily stats per course/user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_stats_user_daily`
--

LOCK TABLES `mdl_stats_user_daily` WRITE;
/*!40000 ALTER TABLE `mdl_stats_user_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_stats_user_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_stats_user_monthly`
--

DROP TABLE IF EXISTS `mdl_stats_user_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_stats_user_monthly` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `statsreads` bigint(10) unsigned NOT NULL DEFAULT '0',
  `statswrites` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_statusermont_cou_ix` (`courseid`),
  KEY `mdl_statusermont_use_ix` (`userid`),
  KEY `mdl_statusermont_rol_ix` (`roleid`),
  KEY `mdl_statusermont_tim_ix` (`timeend`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To accumulate monthly stats per course/user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_stats_user_monthly`
--

LOCK TABLES `mdl_stats_user_monthly` WRITE;
/*!40000 ALTER TABLE `mdl_stats_user_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_stats_user_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_stats_user_weekly`
--

DROP TABLE IF EXISTS `mdl_stats_user_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_stats_user_weekly` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `statsreads` bigint(10) unsigned NOT NULL DEFAULT '0',
  `statswrites` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_statuserweek_cou_ix` (`courseid`),
  KEY `mdl_statuserweek_use_ix` (`userid`),
  KEY `mdl_statuserweek_rol_ix` (`roleid`),
  KEY `mdl_statuserweek_tim_ix` (`timeend`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To accumulate weekly stats per course/user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_stats_user_weekly`
--

LOCK TABLES `mdl_stats_user_weekly` WRITE;
/*!40000 ALTER TABLE `mdl_stats_user_weekly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_stats_user_weekly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_stats_weekly`
--

DROP TABLE IF EXISTS `mdl_stats_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_stats_weekly` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` enum('enrolments','activity','logins') NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stat2` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_statweek_cou_ix` (`courseid`),
  KEY `mdl_statweek_tim_ix` (`timeend`),
  KEY `mdl_statweek_rol_ix` (`roleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='To accumulate weekly stats';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_stats_weekly`
--

LOCK TABLES `mdl_stats_weekly` WRITE;
/*!40000 ALTER TABLE `mdl_stats_weekly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_stats_weekly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_survey`
--

DROP TABLE IF EXISTS `mdl_survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_survey` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `template` bigint(10) unsigned NOT NULL DEFAULT '0',
  `days` mediumint(6) NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `questions` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_surv_cou_ix` (`course`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Each record is one SURVEY module with its configuration';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_survey`
--

LOCK TABLES `mdl_survey` WRITE;
/*!40000 ALTER TABLE `mdl_survey` DISABLE KEYS */;
INSERT INTO `mdl_survey` VALUES (1,0,0,0,985017600,985017600,'collesaname','collesaintro','25,26,27,28,29,30,43,44'),(2,0,0,0,985017600,985017600,'collespname','collespintro','31,32,33,34,35,36,43,44'),(3,0,0,0,985017600,985017600,'collesapname','collesapintro','37,38,39,40,41,42,43,44'),(4,0,0,0,985017600,985017600,'attlsname','attlsintro','65,67,68'),(5,0,0,0,985017600,985017600,'ciqname','ciqintro','69,70,71,72,73');
/*!40000 ALTER TABLE `mdl_survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_survey_analysis`
--

DROP TABLE IF EXISTS `mdl_survey_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_survey_analysis` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `survey` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_survanal_use_ix` (`userid`),
  KEY `mdl_survanal_sur_ix` (`survey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='text about each survey submission';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_survey_analysis`
--

LOCK TABLES `mdl_survey_analysis` WRITE;
/*!40000 ALTER TABLE `mdl_survey_analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_survey_analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_survey_answers`
--

DROP TABLE IF EXISTS `mdl_survey_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_survey_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `survey` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer1` text NOT NULL,
  `answer2` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_survansw_use_ix` (`userid`),
  KEY `mdl_survansw_sur_ix` (`survey`),
  KEY `mdl_survansw_que_ix` (`question`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='the answers to each questions filled by the users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_survey_answers`
--

LOCK TABLES `mdl_survey_answers` WRITE;
/*!40000 ALTER TABLE `mdl_survey_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_survey_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_survey_questions`
--

DROP TABLE IF EXISTS `mdl_survey_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_survey_questions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL DEFAULT '',
  `shorttext` varchar(30) NOT NULL DEFAULT '',
  `multi` varchar(100) NOT NULL DEFAULT '',
  `intro` varchar(50) NOT NULL DEFAULT '',
  `type` smallint(3) NOT NULL DEFAULT '0',
  `options` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='the questions conforming one survey';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_survey_questions`
--

LOCK TABLES `mdl_survey_questions` WRITE;
/*!40000 ALTER TABLE `mdl_survey_questions` DISABLE KEYS */;
INSERT INTO `mdl_survey_questions` VALUES (1,'colles1','colles1short','','',1,'scaletimes5'),(2,'colles2','colles2short','','',1,'scaletimes5'),(3,'colles3','colles3short','','',1,'scaletimes5'),(4,'colles4','colles4short','','',1,'scaletimes5'),(5,'colles5','colles5short','','',1,'scaletimes5'),(6,'colles6','colles6short','','',1,'scaletimes5'),(7,'colles7','colles7short','','',1,'scaletimes5'),(8,'colles8','colles8short','','',1,'scaletimes5'),(9,'colles9','colles9short','','',1,'scaletimes5'),(10,'colles10','colles10short','','',1,'scaletimes5'),(11,'colles11','colles11short','','',1,'scaletimes5'),(12,'colles12','colles12short','','',1,'scaletimes5'),(13,'colles13','colles13short','','',1,'scaletimes5'),(14,'colles14','colles14short','','',1,'scaletimes5'),(15,'colles15','colles15short','','',1,'scaletimes5'),(16,'colles16','colles16short','','',1,'scaletimes5'),(17,'colles17','colles17short','','',1,'scaletimes5'),(18,'colles18','colles18short','','',1,'scaletimes5'),(19,'colles19','colles19short','','',1,'scaletimes5'),(20,'colles20','colles20short','','',1,'scaletimes5'),(21,'colles21','colles21short','','',1,'scaletimes5'),(22,'colles22','colles22short','','',1,'scaletimes5'),(23,'colles23','colles23short','','',1,'scaletimes5'),(24,'colles24','colles24short','','',1,'scaletimes5'),(25,'collesm1','collesm1short','1,2,3,4','collesmintro',1,'scaletimes5'),(26,'collesm2','collesm2short','5,6,7,8','collesmintro',1,'scaletimes5'),(27,'collesm3','collesm3short','9,10,11,12','collesmintro',1,'scaletimes5'),(28,'collesm4','collesm4short','13,14,15,16','collesmintro',1,'scaletimes5'),(29,'collesm5','collesm5short','17,18,19,20','collesmintro',1,'scaletimes5'),(30,'collesm6','collesm6short','21,22,23,24','collesmintro',1,'scaletimes5'),(31,'collesm1','collesm1short','1,2,3,4','collesmintro',2,'scaletimes5'),(32,'collesm2','collesm2short','5,6,7,8','collesmintro',2,'scaletimes5'),(33,'collesm3','collesm3short','9,10,11,12','collesmintro',2,'scaletimes5'),(34,'collesm4','collesm4short','13,14,15,16','collesmintro',2,'scaletimes5'),(35,'collesm5','collesm5short','17,18,19,20','collesmintro',2,'scaletimes5'),(36,'collesm6','collesm6short','21,22,23,24','collesmintro',2,'scaletimes5'),(37,'collesm1','collesm1short','1,2,3,4','collesmintro',3,'scaletimes5'),(38,'collesm2','collesm2short','5,6,7,8','collesmintro',3,'scaletimes5'),(39,'collesm3','collesm3short','9,10,11,12','collesmintro',3,'scaletimes5'),(40,'collesm4','collesm4short','13,14,15,16','collesmintro',3,'scaletimes5'),(41,'collesm5','collesm5short','17,18,19,20','collesmintro',3,'scaletimes5'),(42,'collesm6','collesm6short','21,22,23,24','collesmintro',3,'scaletimes5'),(43,'howlong','','','',1,'howlongoptions'),(44,'othercomments','','','',0,NULL),(45,'attls1','attls1short','','',1,'scaleagree5'),(46,'attls2','attls2short','','',1,'scaleagree5'),(47,'attls3','attls3short','','',1,'scaleagree5'),(48,'attls4','attls4short','','',1,'scaleagree5'),(49,'attls5','attls5short','','',1,'scaleagree5'),(50,'attls6','attls6short','','',1,'scaleagree5'),(51,'attls7','attls7short','','',1,'scaleagree5'),(52,'attls8','attls8short','','',1,'scaleagree5'),(53,'attls9','attls9short','','',1,'scaleagree5'),(54,'attls10','attls10short','','',1,'scaleagree5'),(55,'attls11','attls11short','','',1,'scaleagree5'),(56,'attls12','attls12short','','',1,'scaleagree5'),(57,'attls13','attls13short','','',1,'scaleagree5'),(58,'attls14','attls14short','','',1,'scaleagree5'),(59,'attls15','attls15short','','',1,'scaleagree5'),(60,'attls16','attls16short','','',1,'scaleagree5'),(61,'attls17','attls17short','','',1,'scaleagree5'),(62,'attls18','attls18short','','',1,'scaleagree5'),(63,'attls19','attls19short','','',1,'scaleagree5'),(64,'attls20','attls20short','','',1,'scaleagree5'),(65,'attlsm1','attlsm1','45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64','attlsmintro',1,'scaleagree5'),(66,'-','-','-','-',0,'-'),(67,'attlsm2','attlsm2','63,62,59,57,55,49,52,50,48,47','attlsmintro',-1,'scaleagree5'),(68,'attlsm3','attlsm3','46,54,45,51,60,53,56,58,61,64','attlsmintro',-1,'scaleagree5'),(69,'ciq1','ciq1short','','',0,NULL),(70,'ciq2','ciq2short','','',0,NULL),(71,'ciq3','ciq3short','','',0,NULL),(72,'ciq4','ciq4short','','',0,NULL),(73,'ciq5','ciq5short','','',0,NULL);
/*!40000 ALTER TABLE `mdl_survey_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_tag`
--

DROP TABLE IF EXISTS `mdl_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_tag` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `rawname` varchar(255) NOT NULL DEFAULT '',
  `tagtype` varchar(255) DEFAULT NULL,
  `description` text,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `flag` smallint(4) unsigned DEFAULT '0',
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_tag_nam_uix` (`name`),
  KEY `mdl_tag_use_ix` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Tag table - this generic table will replace the old "tags" t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_tag`
--

LOCK TABLES `mdl_tag` WRITE;
/*!40000 ALTER TABLE `mdl_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_tag_correlation`
--

DROP TABLE IF EXISTS `mdl_tag_correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_tag_correlation` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` bigint(10) unsigned NOT NULL,
  `correlatedtags` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_tagcorr_tag_ix` (`tagid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='The rationale for the ''tag_correlation'' table is performance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_tag_correlation`
--

LOCK TABLES `mdl_tag_correlation` WRITE;
/*!40000 ALTER TABLE `mdl_tag_correlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_tag_correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_tag_instance`
--

DROP TABLE IF EXISTS `mdl_tag_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_tag_instance` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` bigint(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `ordering` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_taginst_iteitetag_uix` (`itemtype`,`itemid`,`tagid`),
  KEY `mdl_taginst_tag_ix` (`tagid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='tag_instance table holds the information of associations bet';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_tag_instance`
--

LOCK TABLES `mdl_tag_instance` WRITE;
/*!40000 ALTER TABLE `mdl_tag_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_tag_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_timezone`
--

DROP TABLE IF EXISTS `mdl_timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_timezone` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `year` bigint(11) NOT NULL DEFAULT '0',
  `tzrule` varchar(20) NOT NULL DEFAULT '',
  `gmtoff` bigint(11) NOT NULL DEFAULT '0',
  `dstoff` bigint(11) NOT NULL DEFAULT '0',
  `dst_month` tinyint(2) NOT NULL DEFAULT '0',
  `dst_startday` smallint(3) NOT NULL DEFAULT '0',
  `dst_weekday` smallint(3) NOT NULL DEFAULT '0',
  `dst_skipweeks` smallint(3) NOT NULL DEFAULT '0',
  `dst_time` varchar(6) NOT NULL DEFAULT '00:00',
  `std_month` tinyint(2) NOT NULL DEFAULT '0',
  `std_startday` smallint(3) NOT NULL DEFAULT '0',
  `std_weekday` smallint(3) NOT NULL DEFAULT '0',
  `std_skipweeks` smallint(3) NOT NULL DEFAULT '0',
  `std_time` varchar(6) NOT NULL DEFAULT '00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Rules for calculating local wall clock time for users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_timezone`
--

LOCK TABLES `mdl_timezone` WRITE;
/*!40000 ALTER TABLE `mdl_timezone` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_timezone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user`
--

DROP TABLE IF EXISTS `mdl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `auth` varchar(20) NOT NULL DEFAULT 'manual',
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `policyagreed` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `mnethostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `idnumber` varchar(255) NOT NULL DEFAULT '',
  `firstname` varchar(100) NOT NULL DEFAULT '',
  `lastname` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `emailstop` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `icq` varchar(15) NOT NULL DEFAULT '',
  `skype` varchar(50) NOT NULL DEFAULT '',
  `yahoo` varchar(50) NOT NULL DEFAULT '',
  `aim` varchar(50) NOT NULL DEFAULT '',
  `msn` varchar(50) NOT NULL DEFAULT '',
  `phone1` varchar(20) NOT NULL DEFAULT '',
  `phone2` varchar(20) NOT NULL DEFAULT '',
  `institution` varchar(40) NOT NULL DEFAULT '',
  `department` varchar(30) NOT NULL DEFAULT '',
  `address` varchar(70) NOT NULL DEFAULT '',
  `city` varchar(20) NOT NULL DEFAULT '',
  `country` varchar(2) NOT NULL DEFAULT '',
  `lang` varchar(30) NOT NULL DEFAULT 'en_utf8',
  `theme` varchar(50) NOT NULL DEFAULT '',
  `timezone` varchar(100) NOT NULL DEFAULT '99',
  `firstaccess` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastaccess` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastlogin` bigint(10) unsigned NOT NULL DEFAULT '0',
  `currentlogin` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(15) NOT NULL DEFAULT '',
  `secret` varchar(15) NOT NULL DEFAULT '',
  `picture` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `mailformat` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `maildigest` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maildisplay` tinyint(2) unsigned NOT NULL DEFAULT '2',
  `htmleditor` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ajax` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `autosubscribe` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `trackforums` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `trustbitmask` bigint(10) unsigned NOT NULL DEFAULT '0',
  `imagealt` varchar(255) DEFAULT NULL,
  `screenreader` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_user_mneuse_uix` (`mnethostid`,`username`),
  KEY `mdl_user_del_ix` (`deleted`),
  KEY `mdl_user_con_ix` (`confirmed`),
  KEY `mdl_user_fir_ix` (`firstname`),
  KEY `mdl_user_las_ix` (`lastname`),
  KEY `mdl_user_cit_ix` (`city`),
  KEY `mdl_user_cou_ix` (`country`),
  KEY `mdl_user_las2_ix` (`lastaccess`),
  KEY `mdl_user_ema_ix` (`email`),
  KEY `mdl_user_aut_ix` (`auth`),
  KEY `mdl_user_idn_ix` (`idnumber`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='One record for each person';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user`
--

LOCK TABLES `mdl_user` WRITE;
/*!40000 ALTER TABLE `mdl_user` DISABLE KEYS */;
INSERT INTO `mdl_user` VALUES (1,'manual',1,0,0,1,'guest','084e0343a0486ff05530df6c705c8bb4','','Guest User',' ','root@localhost',0,'','','','','','','','','','','','','en_utf8','','99',0,0,0,0,'','',0,'','This user is a special user that allows read-only access to some courses.',1,0,2,1,1,1,0,1323876931,0,NULL,0),(2,'manual',1,0,0,1,'admin','098f6bcd4621d373cade4e832627b4f6','','Admin','User','m.deridder@solin.nl',0,'','','','','','','','','','','Breda','NL','en_utf8','','99',1323877094,1332847482,1332845320,1332845444,'127.0.0.1','',0,'','',1,0,1,1,1,1,0,1323877094,0,'',0);
/*!40000 ALTER TABLE `mdl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user_info_category`
--

DROP TABLE IF EXISTS `mdl_user_info_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user_info_category` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Customisable fields categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user_info_category`
--

LOCK TABLES `mdl_user_info_category` WRITE;
/*!40000 ALTER TABLE `mdl_user_info_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_user_info_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user_info_data`
--

DROP TABLE IF EXISTS `mdl_user_info_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user_info_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `fieldid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_userinfodata_usefie_ix` (`userid`,`fieldid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Data for the customisable user fields';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user_info_data`
--

LOCK TABLES `mdl_user_info_data` WRITE;
/*!40000 ALTER TABLE `mdl_user_info_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_user_info_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user_info_field`
--

DROP TABLE IF EXISTS `mdl_user_info_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user_info_field` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `shortname` varchar(255) NOT NULL DEFAULT 'shortname',
  `name` longtext NOT NULL,
  `datatype` varchar(255) NOT NULL DEFAULT '',
  `description` longtext,
  `categoryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `required` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `visible` smallint(4) unsigned NOT NULL DEFAULT '0',
  `forceunique` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `signup` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `defaultdata` longtext,
  `param1` longtext,
  `param2` longtext,
  `param3` longtext,
  `param4` longtext,
  `param5` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Customisable user profile fields';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user_info_field`
--

LOCK TABLES `mdl_user_info_field` WRITE;
/*!40000 ALTER TABLE `mdl_user_info_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_user_info_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user_lastaccess`
--

DROP TABLE IF EXISTS `mdl_user_lastaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user_lastaccess` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeaccess` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_userlast_usecou_uix` (`userid`,`courseid`),
  KEY `mdl_userlast_use_ix` (`userid`),
  KEY `mdl_userlast_cou_ix` (`courseid`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='To keep track of course page access times, used in online pa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user_lastaccess`
--

LOCK TABLES `mdl_user_lastaccess` WRITE;
/*!40000 ALTER TABLE `mdl_user_lastaccess` DISABLE KEYS */;
INSERT INTO `mdl_user_lastaccess` VALUES (1,2,2,1332832848),(2,2,3,1326976868),(3,2,4,1331653643),(4,2,5,1331204965),(5,2,6,1332832835),(6,2,7,1331205195),(7,2,8,1325682236),(8,2,9,1325682227),(9,2,10,1329403410),(10,2,13,1332833191),(11,2,15,1332833223),(12,2,16,1332834871),(13,2,14,1332833212);
/*!40000 ALTER TABLE `mdl_user_lastaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user_preferences`
--

DROP TABLE IF EXISTS `mdl_user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user_preferences` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_userpref_usenam_uix` (`userid`,`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Allows modules to store arbitrary user preferences';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user_preferences`
--

LOCK TABLES `mdl_user_preferences` WRITE;
/*!40000 ALTER TABLE `mdl_user_preferences` DISABLE KEYS */;
INSERT INTO `mdl_user_preferences` VALUES (1,2,'auth_forcepasswordchange','0'),(2,2,'email_bounce_count','1'),(3,2,'email_send_count','1');
/*!40000 ALTER TABLE `mdl_user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_user_private_key`
--

DROP TABLE IF EXISTS `mdl_user_private_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_user_private_key` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `script` varchar(128) NOT NULL DEFAULT '',
  `value` varchar(128) NOT NULL DEFAULT '',
  `userid` bigint(10) unsigned NOT NULL,
  `instance` bigint(10) unsigned DEFAULT NULL,
  `iprestriction` varchar(255) DEFAULT NULL,
  `validuntil` bigint(10) unsigned DEFAULT NULL,
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_userprivkey_scrval_ix` (`script`,`value`),
  KEY `mdl_userprivkey_use_ix` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='access keys used in cookieless scripts - rss, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_user_private_key`
--

LOCK TABLES `mdl_user_private_key` WRITE;
/*!40000 ALTER TABLE `mdl_user_private_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_user_private_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_webdav_locks`
--

DROP TABLE IF EXISTS `mdl_webdav_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_webdav_locks` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `expiry` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `recursive` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `exclusivelock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_webdlock_tok_uix` (`token`),
  KEY `mdl_webdlock_pat_ix` (`path`),
  KEY `mdl_webdlock_exp_ix` (`expiry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Resource locks for WebDAV users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_webdav_locks`
--

LOCK TABLES `mdl_webdav_locks` WRITE;
/*!40000 ALTER TABLE `mdl_webdav_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_webdav_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_wiki`
--

DROP TABLE IF EXISTS `mdl_wiki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_wiki` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `summary` text NOT NULL,
  `pagename` varchar(255) NOT NULL DEFAULT '',
  `wtype` enum('teacher','group','student') NOT NULL DEFAULT 'group',
  `ewikiprinttitle` smallint(4) unsigned NOT NULL DEFAULT '1',
  `htmlmode` smallint(4) unsigned NOT NULL DEFAULT '0',
  `ewikiacceptbinary` smallint(4) unsigned NOT NULL DEFAULT '0',
  `disablecamelcase` smallint(4) unsigned NOT NULL DEFAULT '0',
  `setpageflags` smallint(4) unsigned NOT NULL DEFAULT '1',
  `strippages` smallint(4) unsigned NOT NULL DEFAULT '1',
  `removepages` smallint(4) unsigned NOT NULL DEFAULT '1',
  `revertchanges` smallint(4) unsigned NOT NULL DEFAULT '1',
  `initialcontent` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_wiki_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Main wik table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_wiki`
--

LOCK TABLES `mdl_wiki` WRITE;
/*!40000 ALTER TABLE `mdl_wiki` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_wiki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_wiki_entries`
--

DROP TABLE IF EXISTS `mdl_wiki_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_wiki_entries` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `wikiid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pagename` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_wikientr_cou_ix` (`course`),
  KEY `mdl_wikientr_gro_ix` (`groupid`),
  KEY `mdl_wikientr_use_ix` (`userid`),
  KEY `mdl_wikientr_pag_ix` (`pagename`),
  KEY `mdl_wikientr_wik_ix` (`wikiid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds entries for each wiki start instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_wiki_entries`
--

LOCK TABLES `mdl_wiki_entries` WRITE;
/*!40000 ALTER TABLE `mdl_wiki_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_wiki_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_wiki_locks`
--

DROP TABLE IF EXISTS `mdl_wiki_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_wiki_locks` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `wikiid` bigint(10) unsigned NOT NULL,
  `pagename` varchar(160) NOT NULL DEFAULT '',
  `lockedby` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lockedsince` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lockedseen` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_wikilock_wikpag_uix` (`wikiid`,`pagename`),
  KEY `mdl_wikilock_loc_ix` (`lockedseen`),
  KEY `mdl_wikilock_wik_ix` (`wikiid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores editing locks on Wiki pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_wiki_locks`
--

LOCK TABLES `mdl_wiki_locks` WRITE;
/*!40000 ALTER TABLE `mdl_wiki_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_wiki_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_wiki_pages`
--

DROP TABLE IF EXISTS `mdl_wiki_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_wiki_pages` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `pagename` varchar(160) NOT NULL DEFAULT '',
  `version` bigint(10) unsigned NOT NULL DEFAULT '0',
  `flags` bigint(10) unsigned DEFAULT '0',
  `content` mediumtext,
  `author` varchar(100) DEFAULT 'ewiki',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned DEFAULT '0',
  `lastmodified` bigint(10) unsigned DEFAULT '0',
  `refs` mediumtext,
  `meta` mediumtext,
  `hits` bigint(10) unsigned DEFAULT '0',
  `wiki` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_wikipage_pagverwik_uix` (`pagename`,`version`,`wiki`),
  KEY `mdl_wikipage_wik_ix` (`wiki`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds the Wiki-Pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_wiki_pages`
--

LOCK TABLES `mdl_wiki_pages` WRITE;
/*!40000 ALTER TABLE `mdl_wiki_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_wiki_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop`
--

DROP TABLE IF EXISTS `mdl_workshop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `wtype` smallint(3) unsigned NOT NULL DEFAULT '0',
  `nelements` smallint(3) unsigned NOT NULL DEFAULT '1',
  `nattachments` smallint(3) unsigned NOT NULL DEFAULT '0',
  `phase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `format` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `gradingstrategy` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `resubmit` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `agreeassessments` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `hidegrades` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `anonymous` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `includeself` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `maxbytes` bigint(10) unsigned NOT NULL DEFAULT '100000',
  `submissionstart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assessmentstart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `submissionend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assessmentend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `releasegrades` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` smallint(3) NOT NULL DEFAULT '0',
  `gradinggrade` smallint(3) NOT NULL DEFAULT '0',
  `ntassessments` smallint(3) unsigned NOT NULL DEFAULT '0',
  `assessmentcomps` smallint(3) unsigned NOT NULL DEFAULT '2',
  `nsassessments` smallint(3) unsigned NOT NULL DEFAULT '0',
  `overallocation` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `teacherweight` smallint(3) unsigned NOT NULL DEFAULT '1',
  `showleaguetable` smallint(3) unsigned NOT NULL DEFAULT '0',
  `usepassword` smallint(3) unsigned NOT NULL DEFAULT '0',
  `password` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_work_cou_ix` (`course`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines workshop';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop`
--

LOCK TABLES `mdl_workshop` WRITE;
/*!40000 ALTER TABLE `mdl_workshop` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_assessments`
--

DROP TABLE IF EXISTS `mdl_workshop_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_assessments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `submissionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timegraded` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeagreed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` double NOT NULL DEFAULT '0',
  `gradinggrade` smallint(3) NOT NULL DEFAULT '0',
  `teachergraded` smallint(3) unsigned NOT NULL DEFAULT '0',
  `mailed` smallint(3) unsigned NOT NULL DEFAULT '0',
  `resubmission` smallint(3) unsigned NOT NULL DEFAULT '0',
  `donotuse` smallint(3) unsigned NOT NULL DEFAULT '0',
  `generalcomment` text,
  `teachercomment` text,
  PRIMARY KEY (`id`),
  KEY `mdl_workasse_use_ix` (`userid`),
  KEY `mdl_workasse_mai_ix` (`mailed`),
  KEY `mdl_workasse_wor_ix` (`workshopid`),
  KEY `mdl_workasse_sub_ix` (`submissionid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about assessments by teacher and students';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_assessments`
--

LOCK TABLES `mdl_workshop_assessments` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_assessments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_assessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_comments`
--

DROP TABLE IF EXISTS `mdl_workshop_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_comments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assessmentid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workcomm_use_ix` (`userid`),
  KEY `mdl_workcomm_mai_ix` (`mailed`),
  KEY `mdl_workcomm_wor_ix` (`workshopid`),
  KEY `mdl_workcomm_ass_ix` (`assessmentid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Defines comments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_comments`
--

LOCK TABLES `mdl_workshop_comments` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_elements`
--

DROP TABLE IF EXISTS `mdl_workshop_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_elements` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` smallint(3) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `scale` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxscore` smallint(3) unsigned NOT NULL DEFAULT '1',
  `weight` smallint(3) unsigned NOT NULL DEFAULT '11',
  `stddev` double NOT NULL DEFAULT '0',
  `totalassessments` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_workelem_wor_ix` (`workshopid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about marking scheme of assignment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_elements`
--

LOCK TABLES `mdl_workshop_elements` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_elements` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_grades`
--

DROP TABLE IF EXISTS `mdl_workshop_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assessmentid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedback` text NOT NULL,
  `grade` smallint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_workgrad_wor_ix` (`workshopid`),
  KEY `mdl_workgrad_ass_ix` (`assessmentid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about individual grades given to each element';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_grades`
--

LOCK TABLES `mdl_workshop_grades` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_rubrics`
--

DROP TABLE IF EXISTS `mdl_workshop_rubrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_rubrics` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rubricno` smallint(3) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workrubr_wor_ix` (`workshopid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about the rubrics marking scheme';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_rubrics`
--

LOCK TABLES `mdl_workshop_rubrics` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_rubrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_rubrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_stockcomments`
--

DROP TABLE IF EXISTS `mdl_workshop_stockcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_stockcomments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` bigint(10) unsigned NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workstoc_wor_ix` (`workshopid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about the teacher comment bank';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_stockcomments`
--

LOCK TABLES `mdl_workshop_stockcomments` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_stockcomments` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_stockcomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdl_workshop_submissions`
--

DROP TABLE IF EXISTS `mdl_workshop_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdl_workshop_submissions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `gradinggrade` smallint(3) unsigned NOT NULL DEFAULT '0',
  `finalgrade` smallint(3) unsigned NOT NULL DEFAULT '0',
  `late` smallint(3) unsigned NOT NULL DEFAULT '0',
  `nassessments` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_worksubm_use_ix` (`userid`),
  KEY `mdl_worksubm_mai_ix` (`mailed`),
  KEY `mdl_worksubm_wor_ix` (`workshopid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Info about submitted work from teacher and students';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdl_workshop_submissions`
--

LOCK TABLES `mdl_workshop_submissions` WRITE;
/*!40000 ALTER TABLE `mdl_workshop_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdl_workshop_submissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-27 14:19:17
