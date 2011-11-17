-- phpMyAdmin SQL Dump
-- version 3.3.7deb5build0.10.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 02, 2011 at 04:55 PM
-- Server version: 5.1.49
-- PHP Version: 5.3.3-1ubuntu9.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `moodle21`
--

-- --------------------------------------------------------

--
-- Table structure for table `mdl_assignment`
--

CREATE TABLE IF NOT EXISTS `mdl_assignment` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines assignments' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_assignment`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_assignment_submissions`
--

CREATE TABLE IF NOT EXISTS `mdl_assignment_submissions` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about submitted assignments' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_assignment_submissions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_controllers`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_controllers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backupid` varchar(32) NOT NULL DEFAULT '',
  `operation` varchar(20) NOT NULL DEFAULT 'backup',
  `type` varchar(10) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `format` varchar(20) NOT NULL DEFAULT '',
  `interactive` smallint(4) unsigned NOT NULL,
  `purpose` smallint(4) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `status` smallint(4) unsigned NOT NULL,
  `execution` smallint(4) unsigned NOT NULL,
  `executiontime` bigint(10) unsigned NOT NULL,
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  `controller` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backcont_bac_uix` (`backupid`),
  KEY `mdl_backcont_typite_ix` (`type`,`itemid`),
  KEY `mdl_backcont_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store the backup_controllers as they are used' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_controllers`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_courses`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_courses` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `laststarttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastendtime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `laststatus` varchar(1) NOT NULL DEFAULT '0',
  `nextstarttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backcour_cou_uix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store every course backup status' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_courses`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_files`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_files` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backup_code` bigint(10) unsigned NOT NULL DEFAULT '0',
  `file_type` varchar(10) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `old_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `new_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backfile_bacfilpat_uix` (`backup_code`,`file_type`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store and recode ids to user and course files' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_files`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_files_template`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_files_template` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backupid` varchar(32) NOT NULL DEFAULT '',
  `contextid` bigint(10) unsigned NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `filearea` varchar(50) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `info` mediumtext,
  PRIMARY KEY (`id`),
  KEY `mdl_backfiletemp_bacconcomf_ix` (`backupid`,`contextid`,`component`,`filearea`,`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store files along the backup process. Note this table isn' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_files_template`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_ids`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_ids` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backup_code` bigint(12) unsigned NOT NULL DEFAULT '0',
  `table_name` varchar(30) NOT NULL DEFAULT '',
  `old_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `new_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `info` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backids_bactabold_uix` (`backup_code`,`table_name`,`old_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store and convert ids in backup/restore' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_ids`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_ids_template`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_ids_template` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backupid` varchar(32) NOT NULL DEFAULT '',
  `itemname` varchar(160) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `newitemid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `parentitemid` bigint(10) unsigned DEFAULT NULL,
  `info` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backidstemp_baciteite_uix` (`backupid`,`itemname`,`itemid`),
  KEY `mdl_backidstemp_bacitepar_ix` (`backupid`,`itemname`,`parentitemid`),
  KEY `mdl_backidstemp_bacitenew_ix` (`backupid`,`itemname`,`newitemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store all sort of ids along the backup process. Note this' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_ids_template`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_log`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `laststarttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(255) NOT NULL DEFAULT '',
  `backuptype` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_backlog_cou_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store every course backup log info' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_backup_logs`
--

CREATE TABLE IF NOT EXISTS `mdl_backup_logs` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `backupid` varchar(32) NOT NULL DEFAULT '',
  `loglevel` smallint(4) unsigned NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_backlogs_bacid_uix` (`backupid`,`id`),
  KEY `mdl_backlogs_bac_ix` (`backupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store all the logs from backup and restore operations (by' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_backup_logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_block`
--

CREATE TABLE IF NOT EXISTS `mdl_block` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT '',
  `version` bigint(10) unsigned NOT NULL DEFAULT '0',
  `cron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastcron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_bloc_nam_uix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='contains all installed blocks' AUTO_INCREMENT=40 ;

--
-- Dumping data for table `mdl_block`
--

INSERT INTO `mdl_block` (`id`, `name`, `version`, `cron`, `lastcron`, `visible`) VALUES
(1, 'activity_modules', 2007101509, 0, 0, 1),
(2, 'admin_bookmarks', 2007101509, 0, 0, 1),
(3, 'blog_menu', 2009071700, 0, 0, 1),
(4, 'blog_recent', 2009070900, 0, 0, 1),
(5, 'blog_tags', 2007101509, 0, 0, 1),
(6, 'calendar_month', 2007101509, 0, 0, 1),
(7, 'calendar_upcoming', 2007101509, 0, 0, 1),
(8, 'comments', 2009072000, 0, 0, 1),
(9, 'community', 2010042701, 0, 0, 1),
(10, 'completionstatus', 2009072800, 0, 0, 1),
(11, 'course_list', 2007101509, 0, 0, 1),
(12, 'course_overview', 2010021100, 0, 0, 1),
(13, 'course_summary', 2007101509, 0, 0, 1),
(14, 'feedback', 2010050200, 0, 0, 0),
(15, 'glossary_random', 2007101509, 0, 0, 1),
(16, 'html', 2010071900, 0, 0, 1),
(17, 'login', 2007101509, 0, 0, 1),
(18, 'mentees', 2007101509, 0, 0, 1),
(19, 'messages', 2007101509, 0, 0, 1),
(20, 'mnet_hosts', 2010112900, 0, 0, 1),
(21, 'myprofile', 2009123100, 0, 0, 1),
(22, 'navigation', 2010091400, 0, 0, 1),
(23, 'news_items', 2007101509, 0, 0, 1),
(24, 'online_users', 2007101510, 0, 0, 1),
(25, 'participants', 2007101509, 0, 0, 1),
(26, 'private_files', 2010030100, 0, 0, 1),
(27, 'quiz_results', 2011100300, 0, 0, 1),
(28, 'recent_activity', 2007101509, 0, 0, 1),
(29, 'rss_client', 2009072901, 300, 0, 1),
(30, 'search', 2010111100, 1, 0, 0),
(31, 'search_forums', 2007101509, 0, 0, 1),
(32, 'section_links', 2007101511, 0, 0, 1),
(33, 'selfcompletion', 2009072800, 0, 0, 1),
(34, 'settings', 2010091400, 0, 0, 1),
(35, 'site_main_menu', 2007101509, 0, 0, 1),
(36, 'social_activities', 2007101509, 0, 0, 1),
(37, 'tag_flickr', 2007101509, 0, 0, 1),
(38, 'tag_youtube', 2007101509, 0, 0, 1),
(39, 'tags', 2010090502, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_community`
--

CREATE TABLE IF NOT EXISTS `mdl_block_community` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL,
  `coursename` varchar(255) NOT NULL DEFAULT '',
  `coursedescription` longtext,
  `courseurl` varchar(255) NOT NULL DEFAULT '',
  `imageurl` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Community block' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_block_community`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_instances`
--

CREATE TABLE IF NOT EXISTS `mdl_block_instances` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `blockname` varchar(40) NOT NULL DEFAULT '',
  `parentcontextid` bigint(10) unsigned NOT NULL,
  `showinsubcontexts` smallint(4) NOT NULL,
  `pagetypepattern` varchar(64) NOT NULL DEFAULT '',
  `subpagepattern` varchar(16) DEFAULT NULL,
  `defaultregion` varchar(16) NOT NULL DEFAULT '',
  `defaultweight` bigint(10) NOT NULL,
  `configdata` text,
  PRIMARY KEY (`id`),
  KEY `mdl_blocinst_parshopagsub_ix` (`parentcontextid`,`showinsubcontexts`,`pagetypepattern`,`subpagepattern`),
  KEY `mdl_blocinst_par_ix` (`parentcontextid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table stores block instances. The type of block this is' AUTO_INCREMENT=10 ;

--
-- Dumping data for table `mdl_block_instances`
--

INSERT INTO `mdl_block_instances` (`id`, `blockname`, `parentcontextid`, `showinsubcontexts`, `pagetypepattern`, `subpagepattern`, `defaultregion`, `defaultweight`, `configdata`) VALUES
(1, 'site_main_menu', 2, 0, 'site-index', NULL, 'side-pre', 0, ''),
(2, 'course_summary', 2, 0, 'site-index', NULL, 'side-post', 0, ''),
(3, 'calendar_month', 2, 0, 'site-index', NULL, 'side-post', 1, ''),
(4, 'navigation', 1, 1, '*', NULL, 'side-pre', 0, ''),
(5, 'settings', 1, 1, '*', NULL, 'side-pre', 1, ''),
(6, 'admin_bookmarks', 1, 0, 'admin-*', NULL, 'side-pre', 0, ''),
(7, 'private_files', 1, 0, 'my-index', '2', 'side-post', 0, ''),
(8, 'online_users', 1, 0, 'my-index', '2', 'side-post', 1, ''),
(9, 'course_overview', 1, 0, 'my-index', '2', 'content', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_instance_old`
--

CREATE TABLE IF NOT EXISTS `mdl_block_instance_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `oldid` bigint(10) unsigned NOT NULL,
  `blockid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pagetype` varchar(20) NOT NULL DEFAULT '',
  `position` varchar(10) NOT NULL DEFAULT '',
  `weight` smallint(3) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `configdata` text,
  PRIMARY KEY (`id`),
  KEY `mdl_blocinstold_pag_ix` (`pageid`),
  KEY `mdl_blocinstold_pag2_ix` (`pagetype`),
  KEY `mdl_blocinstold_blo_ix` (`blockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='backup of 1.9 block instances - to be deleted' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_block_instance_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_pinned_old`
--

CREATE TABLE IF NOT EXISTS `mdl_block_pinned_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `blockid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pagetype` varchar(20) NOT NULL DEFAULT '',
  `position` varchar(10) NOT NULL DEFAULT '',
  `weight` smallint(3) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `configdata` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_blocpinnold_pag_ix` (`pagetype`),
  KEY `mdl_blocpinnold_blo_ix` (`blockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='backup of 1.9 pinned blocks - to be deleted' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_block_pinned_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_positions`
--

CREATE TABLE IF NOT EXISTS `mdl_block_positions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `blockinstanceid` bigint(10) unsigned NOT NULL,
  `contextid` bigint(10) unsigned NOT NULL,
  `pagetype` varchar(64) NOT NULL DEFAULT '',
  `subpage` varchar(16) NOT NULL DEFAULT '',
  `visible` smallint(4) NOT NULL,
  `region` varchar(16) NOT NULL DEFAULT '',
  `weight` bigint(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_blocposi_bloconpagsub_uix` (`blockinstanceid`,`contextid`,`pagetype`,`subpage`),
  KEY `mdl_blocposi_blo_ix` (`blockinstanceid`),
  KEY `mdl_blocposi_con_ix` (`contextid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the position of a sticky block_instance on a another ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_block_positions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_rss_client`
--

CREATE TABLE IF NOT EXISTS `mdl_block_rss_client` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `title` text NOT NULL,
  `preferredtitle` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `shared` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Remote news feed information. Contains the news feed id, the' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_block_rss_client`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_block_search_documents`
--

CREATE TABLE IF NOT EXISTS `mdl_block_search_documents` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table to store search index backups' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_block_search_documents`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_blog_association`
--

CREATE TABLE IF NOT EXISTS `mdl_blog_association` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `blogid` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_blogasso_con_ix` (`contextid`),
  KEY `mdl_blogasso_blo_ix` (`blogid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Associations of blog entries with courses and module instanc' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_blog_association`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_blog_external`
--

CREATE TABLE IF NOT EXISTS `mdl_blog_external` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `url` text NOT NULL,
  `filtertags` varchar(255) DEFAULT NULL,
  `failedlastsync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `timefetched` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_blogexte_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='External blog links used for RSS copying of blog entries to ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_blog_external`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_cache_filters`
--

CREATE TABLE IF NOT EXISTS `mdl_cache_filters` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `version` bigint(10) unsigned NOT NULL DEFAULT '0',
  `md5key` varchar(32) NOT NULL DEFAULT '',
  `rawtext` text NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_cachfilt_filmd5_ix` (`filter`,`md5key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For keeping information about cached data' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_cache_filters`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_cache_flags`
--

CREATE TABLE IF NOT EXISTS `mdl_cache_flags` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `flagtype` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `value` mediumtext NOT NULL,
  `expiry` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_cachflag_fla_ix` (`flagtype`),
  KEY `mdl_cachflag_nam_ix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Cache of time-sensitive flags' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `mdl_cache_flags`
--

INSERT INTO `mdl_cache_flags` (`id`, `flagtype`, `name`, `timemodified`, `value`, `expiry`) VALUES
(1, 'userpreferenceschanged', '2', 1320248923, '1', 1320256123);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_cache_text`
--

CREATE TABLE IF NOT EXISTS `mdl_cache_text` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `md5key` varchar(32) NOT NULL DEFAULT '',
  `formattedtext` longtext NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_cachtext_md5_ix` (`md5key`),
  KEY `mdl_cachtext_tim_ix` (`timemodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For storing temporary copies of processed texts' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_cache_text`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_capabilities`
--

CREATE TABLE IF NOT EXISTS `mdl_capabilities` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `captype` varchar(50) NOT NULL DEFAULT '',
  `contextlevel` bigint(10) unsigned NOT NULL DEFAULT '0',
  `component` varchar(100) NOT NULL DEFAULT '',
  `riskbitmask` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_capa_nam_uix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='this defines all capabilities' AUTO_INCREMENT=368 ;

--
-- Dumping data for table `mdl_capabilities`
--

INSERT INTO `mdl_capabilities` (`id`, `name`, `captype`, `contextlevel`, `component`, `riskbitmask`) VALUES
(1, 'moodle/site:config', 'write', 10, 'moodle', 62),
(2, 'moodle/site:readallmessages', 'read', 10, 'moodle', 8),
(3, 'moodle/site:sendmessage', 'write', 10, 'moodle', 16),
(4, 'moodle/site:approvecourse', 'write', 10, 'moodle', 4),
(5, 'moodle/backup:backupcourse', 'write', 50, 'moodle', 28),
(6, 'moodle/backup:backupsection', 'write', 50, 'moodle', 28),
(7, 'moodle/backup:backupactivity', 'write', 70, 'moodle', 28),
(8, 'moodle/backup:backuptargethub', 'write', 50, 'moodle', 28),
(9, 'moodle/backup:backuptargetimport', 'write', 50, 'moodle', 28),
(10, 'moodle/backup:downloadfile', 'write', 50, 'moodle', 28),
(11, 'moodle/backup:configure', 'write', 50, 'moodle', 28),
(12, 'moodle/backup:userinfo', 'read', 50, 'moodle', 8),
(13, 'moodle/backup:anonymise', 'read', 50, 'moodle', 8),
(14, 'moodle/restore:restorecourse', 'write', 50, 'moodle', 28),
(15, 'moodle/restore:restoresection', 'write', 50, 'moodle', 28),
(16, 'moodle/restore:restoreactivity', 'write', 50, 'moodle', 28),
(17, 'moodle/restore:viewautomatedfilearea', 'write', 50, 'moodle', 28),
(18, 'moodle/restore:restoretargethub', 'write', 50, 'moodle', 28),
(19, 'moodle/restore:restoretargetimport', 'write', 50, 'moodle', 28),
(20, 'moodle/restore:uploadfile', 'write', 50, 'moodle', 28),
(21, 'moodle/restore:configure', 'write', 50, 'moodle', 28),
(22, 'moodle/restore:rolldates', 'write', 50, 'moodle', 0),
(23, 'moodle/restore:userinfo', 'write', 50, 'moodle', 30),
(24, 'moodle/restore:createuser', 'write', 10, 'moodle', 24),
(25, 'moodle/site:manageblocks', 'write', 80, 'moodle', 20),
(26, 'moodle/site:accessallgroups', 'read', 50, 'moodle', 0),
(27, 'moodle/site:viewfullnames', 'read', 50, 'moodle', 0),
(28, 'moodle/site:viewreports', 'read', 50, 'moodle', 8),
(29, 'moodle/site:trustcontent', 'write', 50, 'moodle', 4),
(30, 'moodle/site:uploadusers', 'write', 10, 'moodle', 24),
(31, 'moodle/filter:manage', 'write', 50, 'moodle', 0),
(32, 'moodle/user:create', 'write', 10, 'moodle', 24),
(33, 'moodle/user:delete', 'write', 10, 'moodle', 8),
(34, 'moodle/user:update', 'write', 10, 'moodle', 24),
(35, 'moodle/user:viewdetails', 'read', 50, 'moodle', 0),
(36, 'moodle/user:viewalldetails', 'read', 30, 'moodle', 8),
(37, 'moodle/user:viewhiddendetails', 'read', 50, 'moodle', 8),
(38, 'moodle/user:loginas', 'write', 50, 'moodle', 30),
(39, 'moodle/user:managesyspages', 'write', 10, 'moodle', 0),
(40, 'moodle/user:manageblocks', 'write', 30, 'moodle', 0),
(41, 'moodle/user:manageownblocks', 'write', 10, 'moodle', 0),
(42, 'moodle/user:manageownfiles', 'write', 10, 'moodle', 0),
(43, 'moodle/my:configsyspages', 'write', 10, 'moodle', 0),
(44, 'moodle/role:assign', 'write', 50, 'moodle', 28),
(45, 'moodle/role:review', 'read', 50, 'moodle', 8),
(46, 'moodle/role:override', 'write', 50, 'moodle', 28),
(47, 'moodle/role:safeoverride', 'write', 50, 'moodle', 16),
(48, 'moodle/role:manage', 'write', 10, 'moodle', 28),
(49, 'moodle/role:switchroles', 'read', 50, 'moodle', 12),
(50, 'moodle/category:manage', 'write', 40, 'moodle', 4),
(51, 'moodle/category:viewhiddencategories', 'read', 40, 'moodle', 0),
(52, 'moodle/cohort:manage', 'write', 40, 'moodle', 0),
(53, 'moodle/cohort:assign', 'write', 40, 'moodle', 0),
(54, 'moodle/cohort:view', 'read', 50, 'moodle', 0),
(55, 'moodle/course:create', 'write', 40, 'moodle', 4),
(56, 'moodle/course:request', 'write', 10, 'moodle', 0),
(57, 'moodle/course:delete', 'write', 50, 'moodle', 32),
(58, 'moodle/course:update', 'write', 50, 'moodle', 4),
(59, 'moodle/course:view', 'read', 50, 'moodle', 0),
(60, 'moodle/course:enrolreview', 'read', 50, 'moodle', 8),
(61, 'moodle/course:enrolconfig', 'write', 50, 'moodle', 8),
(62, 'moodle/course:bulkmessaging', 'write', 50, 'moodle', 16),
(63, 'moodle/course:viewhiddenuserfields', 'read', 50, 'moodle', 8),
(64, 'moodle/course:viewhiddencourses', 'read', 50, 'moodle', 0),
(65, 'moodle/course:visibility', 'write', 50, 'moodle', 0),
(66, 'moodle/course:managefiles', 'write', 50, 'moodle', 4),
(67, 'moodle/course:manageactivities', 'write', 50, 'moodle', 4),
(68, 'moodle/course:activityvisibility', 'write', 50, 'moodle', 0),
(69, 'moodle/course:viewhiddenactivities', 'write', 50, 'moodle', 0),
(70, 'moodle/course:viewparticipants', 'read', 50, 'moodle', 0),
(71, 'moodle/course:changefullname', 'write', 50, 'moodle', 4),
(72, 'moodle/course:changeshortname', 'write', 50, 'moodle', 4),
(73, 'moodle/course:changeidnumber', 'write', 50, 'moodle', 4),
(74, 'moodle/course:changecategory', 'write', 50, 'moodle', 4),
(75, 'moodle/course:changesummary', 'write', 50, 'moodle', 4),
(76, 'moodle/site:viewparticipants', 'read', 10, 'moodle', 0),
(77, 'moodle/course:viewscales', 'read', 50, 'moodle', 0),
(78, 'moodle/course:managescales', 'write', 50, 'moodle', 0),
(79, 'moodle/course:managegroups', 'write', 50, 'moodle', 0),
(80, 'moodle/course:reset', 'write', 50, 'moodle', 32),
(81, 'moodle/blog:view', 'read', 10, 'moodle', 0),
(82, 'moodle/blog:search', 'read', 10, 'moodle', 0),
(83, 'moodle/blog:viewdrafts', 'read', 10, 'moodle', 8),
(84, 'moodle/blog:create', 'write', 10, 'moodle', 16),
(85, 'moodle/blog:manageentries', 'write', 10, 'moodle', 16),
(86, 'moodle/blog:manageexternal', 'write', 10, 'moodle', 16),
(87, 'moodle/blog:associatecourse', 'write', 50, 'moodle', 0),
(88, 'moodle/blog:associatemodule', 'write', 70, 'moodle', 0),
(89, 'moodle/calendar:manageownentries', 'write', 50, 'moodle', 16),
(90, 'moodle/calendar:managegroupentries', 'write', 50, 'moodle', 16),
(91, 'moodle/calendar:manageentries', 'write', 50, 'moodle', 16),
(92, 'moodle/user:editprofile', 'write', 30, 'moodle', 24),
(93, 'moodle/user:editownprofile', 'write', 10, 'moodle', 16),
(94, 'moodle/user:changeownpassword', 'write', 10, 'moodle', 0),
(95, 'moodle/user:readuserposts', 'read', 30, 'moodle', 0),
(96, 'moodle/user:readuserblogs', 'read', 30, 'moodle', 0),
(97, 'moodle/user:viewuseractivitiesreport', 'read', 30, 'moodle', 8),
(98, 'moodle/user:editmessageprofile', 'write', 30, 'moodle', 16),
(99, 'moodle/user:editownmessageprofile', 'write', 10, 'moodle', 0),
(100, 'moodle/question:managecategory', 'write', 50, 'moodle', 20),
(101, 'moodle/question:add', 'write', 50, 'moodle', 20),
(102, 'moodle/question:editmine', 'write', 50, 'moodle', 20),
(103, 'moodle/question:editall', 'write', 50, 'moodle', 20),
(104, 'moodle/question:viewmine', 'read', 50, 'moodle', 0),
(105, 'moodle/question:viewall', 'read', 50, 'moodle', 0),
(106, 'moodle/question:usemine', 'read', 50, 'moodle', 0),
(107, 'moodle/question:useall', 'read', 50, 'moodle', 0),
(108, 'moodle/question:movemine', 'write', 50, 'moodle', 0),
(109, 'moodle/question:moveall', 'write', 50, 'moodle', 0),
(110, 'moodle/question:config', 'write', 10, 'moodle', 2),
(111, 'moodle/question:flag', 'write', 50, 'moodle', 0),
(112, 'moodle/site:doclinks', 'read', 10, 'moodle', 0),
(113, 'moodle/course:sectionvisibility', 'write', 50, 'moodle', 0),
(114, 'moodle/course:useremail', 'write', 50, 'moodle', 0),
(115, 'moodle/course:viewhiddensections', 'write', 50, 'moodle', 0),
(116, 'moodle/course:setcurrentsection', 'write', 50, 'moodle', 0),
(117, 'moodle/site:mnetlogintoremote', 'read', 10, 'moodle', 0),
(118, 'moodle/grade:viewall', 'read', 50, 'moodle', 8),
(119, 'moodle/grade:view', 'read', 50, 'moodle', 0),
(120, 'moodle/grade:viewhidden', 'read', 50, 'moodle', 8),
(121, 'moodle/grade:import', 'write', 50, 'moodle', 12),
(122, 'moodle/grade:export', 'read', 50, 'moodle', 8),
(123, 'moodle/grade:manage', 'write', 50, 'moodle', 12),
(124, 'moodle/grade:edit', 'write', 50, 'moodle', 12),
(125, 'moodle/grade:manageoutcomes', 'write', 50, 'moodle', 0),
(126, 'moodle/grade:manageletters', 'write', 50, 'moodle', 0),
(127, 'moodle/grade:hide', 'write', 50, 'moodle', 0),
(128, 'moodle/grade:lock', 'write', 50, 'moodle', 0),
(129, 'moodle/grade:unlock', 'write', 50, 'moodle', 0),
(130, 'moodle/my:manageblocks', 'write', 10, 'moodle', 0),
(131, 'moodle/notes:view', 'read', 50, 'moodle', 0),
(132, 'moodle/notes:manage', 'write', 50, 'moodle', 16),
(133, 'moodle/tag:manage', 'write', 10, 'moodle', 16),
(134, 'moodle/tag:create', 'write', 10, 'moodle', 16),
(135, 'moodle/tag:edit', 'write', 10, 'moodle', 16),
(136, 'moodle/tag:editblocks', 'write', 10, 'moodle', 0),
(137, 'moodle/block:view', 'read', 80, 'moodle', 0),
(138, 'moodle/block:edit', 'write', 80, 'moodle', 20),
(139, 'moodle/portfolio:export', 'read', 10, 'moodle', 0),
(140, 'moodle/comment:view', 'read', 50, 'moodle', 0),
(141, 'moodle/comment:post', 'write', 50, 'moodle', 24),
(142, 'moodle/comment:delete', 'write', 50, 'moodle', 32),
(143, 'moodle/webservice:createtoken', 'write', 10, 'moodle', 62),
(144, 'moodle/webservice:createmobiletoken', 'write', 10, 'moodle', 24),
(145, 'moodle/rating:view', 'read', 50, 'moodle', 0),
(146, 'moodle/rating:viewany', 'read', 50, 'moodle', 8),
(147, 'moodle/rating:viewall', 'read', 50, 'moodle', 8),
(148, 'moodle/rating:rate', 'write', 50, 'moodle', 0),
(149, 'moodle/course:publish', 'write', 10, 'moodle', 24),
(150, 'moodle/course:markcomplete', 'write', 50, 'moodle', 0),
(151, 'moodle/community:add', 'write', 10, 'moodle', 0),
(152, 'moodle/community:download', 'write', 10, 'moodle', 0),
(153, 'mod/assignment:view', 'read', 70, 'mod_assignment', 0),
(154, 'mod/assignment:submit', 'write', 70, 'mod_assignment', 0),
(155, 'mod/assignment:grade', 'write', 70, 'mod_assignment', 4),
(156, 'mod/assignment:exportownsubmission', 'read', 70, 'mod_assignment', 0),
(157, 'mod/chat:chat', 'write', 70, 'mod_chat', 16),
(158, 'mod/chat:readlog', 'read', 70, 'mod_chat', 0),
(159, 'mod/chat:deletelog', 'write', 70, 'mod_chat', 0),
(160, 'mod/chat:exportparticipatedsession', 'read', 70, 'mod_chat', 8),
(161, 'mod/chat:exportsession', 'read', 70, 'mod_chat', 8),
(162, 'mod/choice:choose', 'write', 70, 'mod_choice', 0),
(163, 'mod/choice:readresponses', 'read', 70, 'mod_choice', 0),
(164, 'mod/choice:deleteresponses', 'write', 70, 'mod_choice', 0),
(165, 'mod/choice:downloadresponses', 'read', 70, 'mod_choice', 0),
(166, 'mod/data:viewentry', 'read', 70, 'mod_data', 0),
(167, 'mod/data:writeentry', 'write', 70, 'mod_data', 16),
(168, 'mod/data:comment', 'write', 70, 'mod_data', 16),
(169, 'mod/data:rate', 'write', 70, 'mod_data', 0),
(170, 'mod/data:viewrating', 'read', 70, 'mod_data', 0),
(171, 'mod/data:viewanyrating', 'read', 70, 'mod_data', 8),
(172, 'mod/data:viewallratings', 'read', 70, 'mod_data', 8),
(173, 'mod/data:approve', 'write', 70, 'mod_data', 16),
(174, 'mod/data:manageentries', 'write', 70, 'mod_data', 16),
(175, 'mod/data:managecomments', 'write', 70, 'mod_data', 16),
(176, 'mod/data:managetemplates', 'write', 70, 'mod_data', 20),
(177, 'mod/data:viewalluserpresets', 'read', 70, 'mod_data', 0),
(178, 'mod/data:manageuserpresets', 'write', 70, 'mod_data', 20),
(179, 'mod/data:exportentry', 'read', 70, 'mod_data', 8),
(180, 'mod/data:exportownentry', 'read', 70, 'mod_data', 0),
(181, 'mod/data:exportallentries', 'read', 70, 'mod_data', 8),
(182, 'mod/feedback:view', 'read', 70, 'mod_feedback', 0),
(183, 'mod/feedback:complete', 'write', 70, 'mod_feedback', 16),
(184, 'mod/feedback:viewanalysepage', 'read', 70, 'mod_feedback', 8),
(185, 'mod/feedback:deletesubmissions', 'write', 70, 'mod_feedback', 0),
(186, 'mod/feedback:mapcourse', 'write', 70, 'mod_feedback', 0),
(187, 'mod/feedback:edititems', 'write', 70, 'mod_feedback', 20),
(188, 'mod/feedback:createprivatetemplate', 'write', 70, 'mod_feedback', 16),
(189, 'mod/feedback:createpublictemplate', 'write', 70, 'mod_feedback', 16),
(190, 'mod/feedback:deletetemplate', 'write', 70, 'mod_feedback', 0),
(191, 'mod/feedback:viewreports', 'read', 70, 'mod_feedback', 8),
(192, 'mod/feedback:receivemail', 'read', 70, 'mod_feedback', 8),
(193, 'mod/folder:view', 'read', 70, 'mod_folder', 0),
(194, 'mod/folder:managefiles', 'write', 70, 'mod_folder', 16),
(195, 'mod/forum:viewdiscussion', 'read', 70, 'mod_forum', 0),
(196, 'mod/forum:viewhiddentimedposts', 'read', 70, 'mod_forum', 0),
(197, 'mod/forum:startdiscussion', 'write', 70, 'mod_forum', 16),
(198, 'mod/forum:replypost', 'write', 70, 'mod_forum', 16),
(199, 'mod/forum:addnews', 'write', 70, 'mod_forum', 16),
(200, 'mod/forum:replynews', 'write', 70, 'mod_forum', 16),
(201, 'mod/forum:viewrating', 'read', 70, 'mod_forum', 0),
(202, 'mod/forum:viewanyrating', 'read', 70, 'mod_forum', 8),
(203, 'mod/forum:viewallratings', 'read', 70, 'mod_forum', 8),
(204, 'mod/forum:rate', 'write', 70, 'mod_forum', 0),
(205, 'mod/forum:createattachment', 'write', 70, 'mod_forum', 16),
(206, 'mod/forum:deleteownpost', 'read', 70, 'mod_forum', 0),
(207, 'mod/forum:deleteanypost', 'read', 70, 'mod_forum', 0),
(208, 'mod/forum:splitdiscussions', 'read', 70, 'mod_forum', 0),
(209, 'mod/forum:movediscussions', 'read', 70, 'mod_forum', 0),
(210, 'mod/forum:editanypost', 'write', 70, 'mod_forum', 16),
(211, 'mod/forum:viewqandawithoutposting', 'read', 70, 'mod_forum', 0),
(212, 'mod/forum:viewsubscribers', 'read', 70, 'mod_forum', 0),
(213, 'mod/forum:managesubscriptions', 'read', 70, 'mod_forum', 16),
(214, 'mod/forum:initialsubscriptions', 'read', 70, 'mod_forum', 0),
(215, 'mod/forum:postwithoutthrottling', 'write', 70, 'mod_forum', 16),
(216, 'mod/forum:exportdiscussion', 'read', 70, 'mod_forum', 8),
(217, 'mod/forum:exportpost', 'read', 70, 'mod_forum', 8),
(218, 'mod/forum:exportownpost', 'read', 70, 'mod_forum', 8),
(219, 'mod/glossary:write', 'write', 70, 'mod_glossary', 16),
(220, 'mod/glossary:manageentries', 'write', 70, 'mod_glossary', 16),
(221, 'mod/glossary:managecategories', 'write', 70, 'mod_glossary', 16),
(222, 'mod/glossary:comment', 'write', 70, 'mod_glossary', 16),
(223, 'mod/glossary:managecomments', 'write', 70, 'mod_glossary', 16),
(224, 'mod/glossary:import', 'write', 70, 'mod_glossary', 16),
(225, 'mod/glossary:export', 'read', 70, 'mod_glossary', 0),
(226, 'mod/glossary:approve', 'write', 70, 'mod_glossary', 16),
(227, 'mod/glossary:rate', 'write', 70, 'mod_glossary', 0),
(228, 'mod/glossary:viewrating', 'read', 70, 'mod_glossary', 0),
(229, 'mod/glossary:viewanyrating', 'read', 70, 'mod_glossary', 8),
(230, 'mod/glossary:viewallratings', 'read', 70, 'mod_glossary', 8),
(231, 'mod/glossary:exportentry', 'read', 70, 'mod_glossary', 8),
(232, 'mod/glossary:exportownentry', 'read', 70, 'mod_glossary', 0),
(233, 'mod/imscp:view', 'read', 70, 'mod_imscp', 0),
(234, 'mod/lesson:edit', 'write', 70, 'mod_lesson', 4),
(235, 'mod/lesson:manage', 'write', 70, 'mod_lesson', 0),
(236, 'mod/page:view', 'read', 70, 'mod_page', 0),
(237, 'mod/quiz:view', 'read', 70, 'mod_quiz', 0),
(238, 'mod/quiz:attempt', 'write', 70, 'mod_quiz', 16),
(239, 'mod/quiz:reviewmyattempts', 'read', 70, 'mod_quiz', 0),
(240, 'mod/quiz:manage', 'write', 70, 'mod_quiz', 16),
(241, 'mod/quiz:manageoverrides', 'write', 70, 'mod_quiz', 0),
(242, 'mod/quiz:preview', 'write', 70, 'mod_quiz', 0),
(243, 'mod/quiz:grade', 'write', 70, 'mod_quiz', 16),
(244, 'mod/quiz:regrade', 'write', 70, 'mod_quiz', 16),
(245, 'mod/quiz:viewreports', 'read', 70, 'mod_quiz', 8),
(246, 'mod/quiz:deleteattempts', 'write', 70, 'mod_quiz', 32),
(247, 'mod/quiz:ignoretimelimits', 'read', 70, 'mod_quiz', 0),
(248, 'mod/quiz:emailconfirmsubmission', 'read', 70, 'mod_quiz', 0),
(249, 'mod/quiz:emailnotifysubmission', 'read', 70, 'mod_quiz', 0),
(250, 'mod/resource:view', 'read', 70, 'mod_resource', 0),
(251, 'mod/scorm:viewreport', 'read', 70, 'mod_scorm', 0),
(252, 'mod/scorm:skipview', 'write', 70, 'mod_scorm', 0),
(253, 'mod/scorm:savetrack', 'write', 70, 'mod_scorm', 0),
(254, 'mod/scorm:viewscores', 'read', 70, 'mod_scorm', 0),
(255, 'mod/scorm:deleteresponses', 'read', 70, 'mod_scorm', 0),
(256, 'mod/survey:participate', 'read', 70, 'mod_survey', 0),
(257, 'mod/survey:readresponses', 'read', 70, 'mod_survey', 0),
(258, 'mod/survey:download', 'read', 70, 'mod_survey', 0),
(259, 'mod/url:view', 'read', 70, 'mod_url', 0),
(260, 'mod/wiki:viewpage', 'read', 70, 'mod_wiki', 0),
(261, 'mod/wiki:editpage', 'write', 70, 'mod_wiki', 16),
(262, 'mod/wiki:createpage', 'write', 70, 'mod_wiki', 16),
(263, 'mod/wiki:viewcomment', 'read', 70, 'mod_wiki', 0),
(264, 'mod/wiki:editcomment', 'write', 70, 'mod_wiki', 16),
(265, 'mod/wiki:managecomment', 'write', 70, 'mod_wiki', 0),
(266, 'mod/wiki:managefiles', 'write', 70, 'mod_wiki', 0),
(267, 'mod/wiki:overridelock', 'write', 70, 'mod_wiki', 0),
(268, 'mod/wiki:managewiki', 'write', 70, 'mod_wiki', 0),
(269, 'mod/workshop:view', 'read', 70, 'mod_workshop', 0),
(270, 'mod/workshop:switchphase', 'write', 70, 'mod_workshop', 0),
(271, 'mod/workshop:editdimensions', 'write', 70, 'mod_workshop', 4),
(272, 'mod/workshop:submit', 'write', 70, 'mod_workshop', 0),
(273, 'mod/workshop:peerassess', 'write', 70, 'mod_workshop', 0),
(274, 'mod/workshop:manageexamples', 'write', 70, 'mod_workshop', 0),
(275, 'mod/workshop:allocate', 'write', 70, 'mod_workshop', 0),
(276, 'mod/workshop:publishsubmissions', 'write', 70, 'mod_workshop', 0),
(277, 'mod/workshop:viewauthornames', 'read', 70, 'mod_workshop', 0),
(278, 'mod/workshop:viewreviewernames', 'read', 70, 'mod_workshop', 0),
(279, 'mod/workshop:viewallsubmissions', 'read', 70, 'mod_workshop', 0),
(280, 'mod/workshop:viewpublishedsubmissions', 'read', 70, 'mod_workshop', 0),
(281, 'mod/workshop:viewauthorpublished', 'read', 70, 'mod_workshop', 0),
(282, 'mod/workshop:viewallassessments', 'read', 70, 'mod_workshop', 0),
(283, 'mod/workshop:overridegrades', 'write', 70, 'mod_workshop', 0),
(284, 'mod/workshop:ignoredeadlines', 'write', 70, 'mod_workshop', 0),
(285, 'enrol/authorize:config', 'write', 50, 'enrol_authorize', 0),
(286, 'enrol/authorize:manage', 'write', 50, 'enrol_authorize', 0),
(287, 'enrol/authorize:unenrol', 'write', 50, 'enrol_authorize', 0),
(288, 'enrol/authorize:unenrolself', 'write', 50, 'enrol_authorize', 0),
(289, 'enrol/authorize:managepayments', 'write', 10, 'enrol_authorize', 8),
(290, 'enrol/authorize:uploadcsv', 'write', 10, 'enrol_authorize', 4),
(291, 'enrol/category:synchronised', 'write', 10, 'enrol_category', 0),
(292, 'enrol/cohort:config', 'write', 50, 'enrol_cohort', 0),
(293, 'enrol/guest:config', 'write', 50, 'enrol_guest', 0),
(294, 'enrol/ldap:manage', 'write', 50, 'enrol_ldap', 0),
(295, 'enrol/manual:config', 'write', 50, 'enrol_manual', 0),
(296, 'enrol/manual:enrol', 'write', 50, 'enrol_manual', 0),
(297, 'enrol/manual:manage', 'write', 50, 'enrol_manual', 0),
(298, 'enrol/manual:unenrol', 'write', 50, 'enrol_manual', 0),
(299, 'enrol/manual:unenrolself', 'write', 50, 'enrol_manual', 0),
(300, 'enrol/meta:config', 'write', 50, 'enrol_meta', 0),
(301, 'enrol/meta:selectaslinked', 'read', 50, 'enrol_meta', 0),
(302, 'enrol/paypal:config', 'write', 50, 'enrol_paypal', 0),
(303, 'enrol/paypal:manage', 'write', 50, 'enrol_paypal', 0),
(304, 'enrol/paypal:unenrol', 'write', 50, 'enrol_paypal', 0),
(305, 'enrol/paypal:unenrolself', 'write', 50, 'enrol_paypal', 0),
(306, 'enrol/self:config', 'write', 50, 'enrol_self', 0),
(307, 'enrol/self:manage', 'write', 50, 'enrol_self', 0),
(308, 'enrol/self:unenrolself', 'write', 50, 'enrol_self', 0),
(309, 'enrol/self:unenrol', 'write', 50, 'enrol_self', 0),
(310, 'block/online_users:viewlist', 'read', 80, 'block_online_users', 0),
(311, 'block/rss_client:manageownfeeds', 'write', 80, 'block_rss_client', 0),
(312, 'block/rss_client:manageanyfeeds', 'write', 80, 'block_rss_client', 16),
(313, 'report/courseoverview:view', 'read', 10, 'report_courseoverview', 8),
(314, 'report/customlang:view', 'read', 10, 'report_customlang', 2),
(315, 'report/customlang:edit', 'write', 10, 'report_customlang', 6),
(316, 'report/questioninstances:view', 'read', 10, 'report_questioninstances', 0),
(317, 'report/security:view', 'read', 10, 'report_security', 2),
(318, 'report/unittest:view', 'read', 10, 'report_unittest', 32),
(319, 'coursereport/completion:view', 'read', 50, 'coursereport_completion', 8),
(320, 'coursereport/log:view', 'read', 50, 'coursereport_log', 8),
(321, 'coursereport/log:viewlive', 'read', 50, 'coursereport_log', 8),
(322, 'coursereport/log:viewtoday', 'read', 50, 'coursereport_log', 8),
(323, 'coursereport/outline:view', 'read', 50, 'coursereport_outline', 8),
(324, 'coursereport/participation:view', 'read', 50, 'coursereport_participation', 8),
(325, 'coursereport/progress:view', 'read', 50, 'coursereport_progress', 8),
(326, 'coursereport/stats:view', 'read', 50, 'coursereport_stats', 8),
(327, 'gradeexport/ods:view', 'read', 50, 'gradeexport_ods', 8),
(328, 'gradeexport/ods:publish', 'read', 50, 'gradeexport_ods', 8),
(329, 'gradeexport/txt:view', 'read', 50, 'gradeexport_txt', 8),
(330, 'gradeexport/txt:publish', 'read', 50, 'gradeexport_txt', 8),
(331, 'gradeexport/xls:view', 'read', 50, 'gradeexport_xls', 8),
(332, 'gradeexport/xls:publish', 'read', 50, 'gradeexport_xls', 8),
(333, 'gradeexport/xml:view', 'read', 50, 'gradeexport_xml', 8),
(334, 'gradeexport/xml:publish', 'read', 50, 'gradeexport_xml', 8),
(335, 'gradeimport/csv:view', 'write', 50, 'gradeimport_csv', 0),
(336, 'gradeimport/xml:view', 'write', 50, 'gradeimport_xml', 0),
(337, 'gradeimport/xml:publish', 'write', 50, 'gradeimport_xml', 0),
(338, 'gradereport/grader:view', 'read', 50, 'gradereport_grader', 8),
(339, 'gradereport/outcomes:view', 'read', 50, 'gradereport_outcomes', 8),
(340, 'gradereport/overview:view', 'read', 50, 'gradereport_overview', 8),
(341, 'gradereport/user:view', 'read', 50, 'gradereport_user', 8),
(342, 'webservice/amf:use', 'read', 50, 'webservice_amf', 62),
(343, 'webservice/rest:use', 'read', 50, 'webservice_rest', 62),
(344, 'webservice/soap:use', 'read', 50, 'webservice_soap', 62),
(345, 'webservice/xmlrpc:use', 'read', 50, 'webservice_xmlrpc', 62),
(346, 'repository/alfresco:view', 'read', 70, 'repository_alfresco', 0),
(347, 'repository/boxnet:view', 'read', 70, 'repository_boxnet', 0),
(348, 'repository/coursefiles:view', 'read', 70, 'repository_coursefiles', 0),
(349, 'repository/dropbox:view', 'read', 70, 'repository_dropbox', 0),
(350, 'repository/filesystem:view', 'read', 70, 'repository_filesystem', 0),
(351, 'repository/flickr:view', 'read', 70, 'repository_flickr', 0),
(352, 'repository/flickr_public:view', 'read', 70, 'repository_flickr_public', 0),
(353, 'repository/googledocs:view', 'read', 70, 'repository_googledocs', 0),
(354, 'repository/local:view', 'read', 70, 'repository_local', 0),
(355, 'repository/merlot:view', 'read', 70, 'repository_merlot', 0),
(356, 'repository/picasa:view', 'read', 70, 'repository_picasa', 0),
(357, 'repository/recent:view', 'read', 70, 'repository_recent', 0),
(358, 'repository/s3:view', 'read', 70, 'repository_s3', 0),
(359, 'repository/upload:view', 'read', 70, 'repository_upload', 0),
(360, 'repository/url:view', 'read', 70, 'repository_url', 0),
(361, 'repository/user:view', 'read', 70, 'repository_user', 0),
(362, 'repository/webdav:view', 'read', 70, 'repository_webdav', 0),
(363, 'repository/wikimedia:view', 'read', 70, 'repository_wikimedia', 0),
(364, 'repository/youtube:view', 'read', 70, 'repository_youtube', 0),
(365, 'quiz/grading:viewstudentnames', 'read', 70, 'quiz_grading', 0),
(366, 'quiz/grading:viewidnumber', 'read', 70, 'quiz_grading', 0),
(367, 'quiz/statistics:view', 'read', 70, 'quiz_statistics', 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_chat`
--

CREATE TABLE IF NOT EXISTS `mdl_chat` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `keepdays` bigint(11) NOT NULL DEFAULT '0',
  `studentlogs` smallint(4) NOT NULL DEFAULT '0',
  `chattime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `schedule` smallint(4) NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_chat_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each of these is a chat room' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_chat`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_chat_messages`
--

CREATE TABLE IF NOT EXISTS `mdl_chat_messages` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all the actual chat messages' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_chat_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_chat_messages_current`
--

CREATE TABLE IF NOT EXISTS `mdl_chat_messages_current` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `chatid` bigint(10) NOT NULL DEFAULT '0',
  `userid` bigint(10) NOT NULL DEFAULT '0',
  `groupid` bigint(10) NOT NULL DEFAULT '0',
  `system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `timestamp` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_chatmesscurr_use_ix` (`userid`),
  KEY `mdl_chatmesscurr_gro_ix` (`groupid`),
  KEY `mdl_chatmesscurr_timcha_ix` (`timestamp`,`chatid`),
  KEY `mdl_chatmesscurr_cha_ix` (`chatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores current session' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_chat_messages_current`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_chat_users`
--

CREATE TABLE IF NOT EXISTS `mdl_chat_users` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `chatid` bigint(11) NOT NULL DEFAULT '0',
  `userid` bigint(11) NOT NULL DEFAULT '0',
  `groupid` bigint(11) NOT NULL DEFAULT '0',
  `version` varchar(16) NOT NULL DEFAULT '',
  `ip` varchar(45) NOT NULL DEFAULT '',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of which users are in which chat rooms' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_chat_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_choice`
--

CREATE TABLE IF NOT EXISTS `mdl_choice` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `publish` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `showresults` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `display` smallint(4) unsigned NOT NULL DEFAULT '0',
  `allowupdate` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `showunanswered` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `limitanswers` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `completionsubmit` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_choi_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Available choices are stored here' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_choice`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_choice_answers`
--

CREATE TABLE IF NOT EXISTS `mdl_choice_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `choiceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `optionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_choiansw_use_ix` (`userid`),
  KEY `mdl_choiansw_cho_ix` (`choiceid`),
  KEY `mdl_choiansw_opt_ix` (`optionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='choices performed by users' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_choice_answers`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_choice_options`
--

CREATE TABLE IF NOT EXISTS `mdl_choice_options` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `choiceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `text` text,
  `maxanswers` bigint(10) unsigned DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_choiopti_cho_ix` (`choiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='available options to choice' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_choice_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_cohort`
--

CREATE TABLE IF NOT EXISTS `mdl_cohort` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `name` varchar(254) NOT NULL DEFAULT '',
  `idnumber` varchar(100) DEFAULT NULL,
  `description` text,
  `descriptionformat` tinyint(2) unsigned NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_coho_con_ix` (`contextid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record represents one cohort (aka site-wide group).' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_cohort`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_cohort_members`
--

CREATE TABLE IF NOT EXISTS `mdl_cohort_members` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `cohortid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeadded` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_cohomemb_cohuse_uix` (`cohortid`,`userid`),
  KEY `mdl_cohomemb_coh_ix` (`cohortid`),
  KEY `mdl_cohomemb_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a user to a cohort.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_cohort_members`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_comments`
--

CREATE TABLE IF NOT EXISTS `mdl_comments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `commentarea` varchar(255) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `content` text NOT NULL,
  `format` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='moodle comments module' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_config`
--

CREATE TABLE IF NOT EXISTS `mdl_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_conf_nam_uix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Moodle configuration variables' AUTO_INCREMENT=396 ;

--
-- Dumping data for table `mdl_config`
--

INSERT INTO `mdl_config` (`id`, `name`, `value`) VALUES
(2, 'rolesactive', '1'),
(3, 'auth', 'email'),
(4, 'auth_pop3mailbox', 'INBOX'),
(5, 'enrol_plugins_enabled', 'manual,guest,self,cohort'),
(6, 'theme', 'standard'),
(7, 'filter_multilang_converted', '1'),
(8, 'siteidentifier', 'NZRYADq6cdpIg7X3v2Zwew5SzfLEihVClocalhost'),
(9, 'backup_version', '2008111700'),
(10, 'backup_release', '2.0 dev'),
(11, 'mnet_dispatcher_mode', 'off'),
(12, 'sessiontimeout', '7200'),
(13, 'stringfilters', ''),
(14, 'filterall', '0'),
(15, 'texteditors', 'tinymce,textarea'),
(16, 'mnet_localhost_id', '1'),
(17, 'mnet_all_hosts_id', '2'),
(18, 'siteguest', '1'),
(19, 'siteadmins', '2'),
(20, 'themerev', '171'),
(21, 'licenses', 'unknown,allrightsreserved,public,cc,cc-nd,cc-nc-nd,cc-nc,cc-nc-sa,cc-sa'),
(22, 'version', '2011070102.05'),
(23, 'enableoutcomes', '0'),
(24, 'usecomments', '1'),
(25, 'usetags', '1'),
(26, 'enablenotes', '1'),
(27, 'enableportfolios', '0'),
(28, 'enablewebservices', '0'),
(29, 'messaging', '1'),
(30, 'messaginghidereadnotifications', '0'),
(31, 'messagingdeletereadnotificationsdelay', '604800'),
(32, 'enablestats', '0'),
(33, 'enablerssfeeds', '0'),
(34, 'bloglevel', '4'),
(35, 'enablecompletion', '0'),
(36, 'enableavailability', '0'),
(37, 'enableplagiarism', '0'),
(38, 'autologinguests', '0'),
(39, 'hiddenuserfields', ''),
(40, 'extrauserselectorfields', 'email'),
(41, 'enablecourserequests', '0'),
(42, 'defaultrequestcategory', '1'),
(43, 'courserequestnotify', ''),
(44, 'grade_profilereport', 'user'),
(45, 'grade_aggregationposition', '1'),
(46, 'grade_includescalesinaggregation', '1'),
(47, 'grade_hiddenasdate', '0'),
(48, 'gradepublishing', '0'),
(49, 'grade_export_displaytype', '1'),
(50, 'grade_export_decimalpoints', '2'),
(51, 'grade_navmethod', '0'),
(52, 'gradeexport', ''),
(53, 'unlimitedgrades', '0'),
(54, 'grade_hideforcedsettings', '1'),
(55, 'grade_aggregation', '11'),
(56, 'grade_aggregation_flag', '0'),
(57, 'grade_aggregations_visible', '0,10,11,12,2,4,6,8,13'),
(58, 'grade_aggregateonlygraded', '1'),
(59, 'grade_aggregateonlygraded_flag', '2'),
(60, 'grade_aggregateoutcomes', '0'),
(61, 'grade_aggregateoutcomes_flag', '2'),
(62, 'grade_aggregatesubcats', '0'),
(63, 'grade_aggregatesubcats_flag', '2'),
(64, 'grade_keephigh', '0'),
(65, 'grade_keephigh_flag', '3'),
(66, 'grade_droplow', '0'),
(67, 'grade_droplow_flag', '2'),
(68, 'grade_displaytype', '1'),
(69, 'grade_decimalpoints', '2'),
(70, 'grade_item_advanced', 'iteminfo,idnumber,gradepass,plusfactor,multfactor,display,decimals,hiddenuntil,locktime'),
(71, 'grade_report_studentsperpage', '100'),
(72, 'grade_report_quickgrading', '1'),
(73, 'grade_report_showquickfeedback', '0'),
(74, 'grade_report_fixedstudents', '0'),
(75, 'grade_report_meanselection', '1'),
(76, 'grade_report_enableajax', '0'),
(77, 'grade_report_showcalculations', '0'),
(78, 'grade_report_showeyecons', '0'),
(79, 'grade_report_showaverages', '1'),
(80, 'grade_report_showlocks', '0'),
(81, 'grade_report_showranges', '0'),
(82, 'grade_report_showuserimage', '1'),
(83, 'grade_report_showuseridnumber', '0'),
(84, 'grade_report_showactivityicons', '1'),
(85, 'grade_report_shownumberofgrades', '0'),
(86, 'grade_report_averagesdisplaytype', 'inherit'),
(87, 'grade_report_rangesdisplaytype', 'inherit'),
(88, 'grade_report_averagesdecimalpoints', 'inherit'),
(89, 'grade_report_rangesdecimalpoints', 'inherit'),
(90, 'grade_report_overview_showrank', '0'),
(91, 'grade_report_overview_showtotalsifcontainhidden', '0'),
(92, 'grade_report_user_showrank', '0'),
(93, 'grade_report_user_showpercentage', '1'),
(94, 'grade_report_user_showgrade', '1'),
(95, 'grade_report_user_showfeedback', '1'),
(96, 'grade_report_user_showrange', '1'),
(97, 'grade_report_user_showweight', '0'),
(98, 'grade_report_user_showaverage', '0'),
(99, 'grade_report_user_showlettergrade', '0'),
(100, 'grade_report_user_rangedecimals', '0'),
(101, 'grade_report_user_showhiddenitems', '1'),
(102, 'grade_report_user_showtotalsifcontainhidden', '0'),
(103, 'timezone', '99'),
(104, 'forcetimezone', '99'),
(105, 'country', '0'),
(106, 'defaultcity', ''),
(107, 'geoipfile', '/home/menno/php_projects/moodle_21_fresh/moodledata/geoip/GeoLiteCity.dat'),
(108, 'googlemapkey', ''),
(109, 'allcountrycodes', ''),
(110, 'autolang', '1'),
(111, 'lang', 'en'),
(112, 'langmenu', '1'),
(113, 'langlist', ''),
(114, 'langcache', '1'),
(115, 'langstringcache', '1'),
(116, 'locale', ''),
(117, 'latinexcelexport', '0'),
(119, 'authpreventaccountcreation', '0'),
(120, 'loginpageautofocus', '0'),
(121, 'guestloginbutton', '1'),
(122, 'alternateloginurl', ''),
(123, 'forgottenpasswordurl', ''),
(124, 'auth_instructions', ''),
(125, 'allowemailaddresses', ''),
(126, 'denyemailaddresses', ''),
(127, 'verifychangedemail', '1'),
(128, 'recaptchapublickey', ''),
(129, 'recaptchaprivatekey', ''),
(130, 'sitedefaultlicense', 'allrightsreserved'),
(131, 'cachetext', '60'),
(132, 'filteruploadedfiles', '0'),
(133, 'filtermatchoneperpage', '0'),
(134, 'filtermatchonepertext', '0'),
(135, 'filter_multilang_force_old', '0'),
(136, 'filter_mediaplugin_enable_youtube', '1'),
(137, 'filter_mediaplugin_enable_vimeo', '0'),
(138, 'filter_mediaplugin_enable_mp3', '1'),
(139, 'filter_mediaplugin_enable_flv', '1'),
(140, 'filter_mediaplugin_enable_swf', '1'),
(141, 'filter_mediaplugin_enable_html5audio', '0'),
(142, 'filter_mediaplugin_enable_html5video', '0'),
(143, 'filter_mediaplugin_enable_qt', '1'),
(144, 'filter_mediaplugin_enable_wmp', '1'),
(145, 'filter_mediaplugin_enable_rm', '1'),
(146, 'filter_tex_latexpreamble', '\\usepackage[latin1]{inputenc}\n\\usepackage{amsmath}\n\\usepackage{amsfonts}\n\\RequirePackage{amsmath,amssymb,latexsym}\n'),
(147, 'filter_tex_latexbackground', '#FFFFFF'),
(148, 'filter_tex_density', '120'),
(149, 'filter_tex_pathlatex', '/usr/bin/latex'),
(150, 'filter_tex_pathdvips', '/usr/bin/dvips'),
(151, 'filter_tex_pathconvert', '/usr/bin/convert'),
(152, 'filter_tex_convertformat', 'gif'),
(153, 'filter_censor_badwords', ''),
(154, 'portfolio_moderate_filesize_threshold', '1048576'),
(155, 'portfolio_high_filesize_threshold', '5242880'),
(156, 'portfolio_moderate_db_threshold', '20'),
(157, 'portfolio_high_db_threshold', '50'),
(158, 'repositorycacheexpire', '120'),
(159, 'repositoryallowexternallinks', '1'),
(160, 'legacyfilesinnewcourses', '0'),
(161, 'enablewsdocumentation', '0'),
(162, 'allowbeforeblock', '0'),
(163, 'allowedip', ''),
(164, 'blockedip', ''),
(165, 'protectusernames', '1'),
(166, 'forcelogin', '0'),
(167, 'forceloginforprofiles', '1'),
(168, 'opentogoogle', '0'),
(169, 'maxbytes', '0'),
(170, 'userquota', '104857600'),
(171, 'enablehtmlpurifier', '1'),
(172, 'allowobjectembed', '0'),
(173, 'enabletrusttext', '0'),
(174, 'maxeditingtime', '1800'),
(175, 'fullnamedisplay', 'language'),
(176, 'extendedusernamechars', '0'),
(177, 'sitepolicy', ''),
(178, 'sitepolicyguest', ''),
(179, 'keeptagnamecase', '1'),
(180, 'profilesforenrolledusersonly', '1'),
(181, 'cronclionly', '0'),
(182, 'cronremotepassword', ''),
(183, 'passwordpolicy', '1'),
(184, 'minpasswordlength', '8'),
(185, 'minpassworddigits', '1'),
(186, 'minpasswordlower', '1'),
(187, 'minpasswordupper', '1'),
(188, 'minpasswordnonalphanum', '1'),
(189, 'maxconsecutiveidentchars', '0'),
(190, 'groupenrolmentkeypolicy', '1'),
(191, 'disableuserimages', '0'),
(192, 'emailchangeconfirmation', '1'),
(193, 'strictformsrequired', '0'),
(194, 'loginhttps', '0'),
(195, 'cookiesecure', '0'),
(196, 'cookiehttponly', '0'),
(197, 'excludeoldflashclients', '10.0.12'),
(198, 'restrictmodulesfor', 'none'),
(199, 'restrictbydefault', '0'),
(200, 'displayloginfailures', ''),
(201, 'notifyloginfailures', ''),
(202, 'notifyloginthreshold', '10'),
(203, 'runclamonupload', '0'),
(204, 'pathtoclam', ''),
(205, 'quarantinedir', ''),
(206, 'clamfailureonupload', 'donothing'),
(207, 'themelist', ''),
(208, 'themedesignermode', '0'),
(209, 'allowuserthemes', '0'),
(210, 'allowcoursethemes', '0'),
(211, 'allowcategorythemes', '0'),
(212, 'allowthemechangeonurl', '0'),
(213, 'allowuserblockhiding', '1'),
(214, 'allowblockstodock', '1'),
(215, 'custommenuitems', ''),
(216, 'enabledevicedetection', '1'),
(217, 'devicedetectregex', '[]'),
(218, 'calendar_adminseesall', '0'),
(219, 'calendar_site_timeformat', '0'),
(220, 'calendar_startwday', '0'),
(221, 'calendar_weekend', '65'),
(222, 'calendar_lookahead', '21'),
(223, 'calendar_maxevents', '10'),
(224, 'enablecalendarexport', '1'),
(225, 'calendar_exportsalt', 'ls3pLs7RJOMPUW9q4nZW5V75nhPlOO4SYyq9Qb6DHopO7zyupvh1xHHnooRz'),
(226, 'useblogassociations', '1'),
(227, 'useexternalblogs', '1'),
(228, 'externalblogcrontime', '86400'),
(229, 'maxexternalblogsperuser', '1'),
(230, 'blogusecomments', '1'),
(231, 'blogshowcommentscount', '1'),
(232, 'defaulthomepage', '0'),
(233, 'navshowcategories', '1'),
(234, 'navshowallcourses', '0'),
(235, 'navcourselimit', '20'),
(236, 'formatstringstriptags', '1'),
(237, 'emoticons', '[{"text":":-)","imagename":"s\\/smiley","imagecomponent":"core","altidentifier":"smiley","altcomponent":"core_pix"},{"text":":)","imagename":"s\\/smiley","imagecomponent":"core","altidentifier":"smiley","altcomponent":"core_pix"},{"text":":-D","imagename":"s\\/biggrin","imagecomponent":"core","altidentifier":"biggrin","altcomponent":"core_pix"},{"text":";-)","imagename":"s\\/wink","imagecomponent":"core","altidentifier":"wink","altcomponent":"core_pix"},{"text":":-\\/","imagename":"s\\/mixed","imagecomponent":"core","altidentifier":"mixed","altcomponent":"core_pix"},{"text":"V-.","imagename":"s\\/thoughtful","imagecomponent":"core","altidentifier":"thoughtful","altcomponent":"core_pix"},{"text":":-P","imagename":"s\\/tongueout","imagecomponent":"core","altidentifier":"tongueout","altcomponent":"core_pix"},{"text":":-p","imagename":"s\\/tongueout","imagecomponent":"core","altidentifier":"tongueout","altcomponent":"core_pix"},{"text":"B-)","imagename":"s\\/cool","imagecomponent":"core","altidentifier":"cool","altcomponent":"core_pix"},{"text":"^-)","imagename":"s\\/approve","imagecomponent":"core","altidentifier":"approve","altcomponent":"core_pix"},{"text":"8-)","imagename":"s\\/wideeyes","imagecomponent":"core","altidentifier":"wideeyes","altcomponent":"core_pix"},{"text":":o)","imagename":"s\\/clown","imagecomponent":"core","altidentifier":"clown","altcomponent":"core_pix"},{"text":":-(","imagename":"s\\/sad","imagecomponent":"core","altidentifier":"sad","altcomponent":"core_pix"},{"text":":(","imagename":"s\\/sad","imagecomponent":"core","altidentifier":"sad","altcomponent":"core_pix"},{"text":"8-.","imagename":"s\\/shy","imagecomponent":"core","altidentifier":"shy","altcomponent":"core_pix"},{"text":":-I","imagename":"s\\/blush","imagecomponent":"core","altidentifier":"blush","altcomponent":"core_pix"},{"text":":-X","imagename":"s\\/kiss","imagecomponent":"core","altidentifier":"kiss","altcomponent":"core_pix"},{"text":"8-o","imagename":"s\\/surprise","imagecomponent":"core","altidentifier":"surprise","altcomponent":"core_pix"},{"text":"P-|","imagename":"s\\/blackeye","imagecomponent":"core","altidentifier":"blackeye","altcomponent":"core_pix"},{"text":"8-[","imagename":"s\\/angry","imagecomponent":"core","altidentifier":"angry","altcomponent":"core_pix"},{"text":"(grr)","imagename":"s\\/angry","imagecomponent":"core","altidentifier":"angry","altcomponent":"core_pix"},{"text":"xx-P","imagename":"s\\/dead","imagecomponent":"core","altidentifier":"dead","altcomponent":"core_pix"},{"text":"|-.","imagename":"s\\/sleepy","imagecomponent":"core","altidentifier":"sleepy","altcomponent":"core_pix"},{"text":"}-]","imagename":"s\\/evil","imagecomponent":"core","altidentifier":"evil","altcomponent":"core_pix"},{"text":"(h)","imagename":"s\\/heart","imagecomponent":"core","altidentifier":"heart","altcomponent":"core_pix"},{"text":"(heart)","imagename":"s\\/heart","imagecomponent":"core","altidentifier":"heart","altcomponent":"core_pix"},{"text":"(y)","imagename":"s\\/yes","imagecomponent":"core","altidentifier":"yes","altcomponent":"core"},{"text":"(n)","imagename":"s\\/no","imagecomponent":"core","altidentifier":"no","altcomponent":"core"},{"text":"(martin)","imagename":"s\\/martin","imagecomponent":"core","altidentifier":"martin","altcomponent":"core_pix"},{"text":"( )","imagename":"s\\/egg","imagecomponent":"core","altidentifier":"egg","altcomponent":"core_pix"}]'),
(238, 'docroot', 'http://docs.moodle.org'),
(239, 'doctonewwindow', '0'),
(240, 'enableajax', '1'),
(241, 'useexternalyui', '0'),
(242, 'yuicomboloading', '1'),
(243, 'cachejs', '1'),
(244, 'enablecourseajax', '1'),
(245, 'additionalhtmlhead', ''),
(246, 'additionalhtmltopofbody', ''),
(247, 'additionalhtmlfooter', ''),
(248, 'gdversion', '2'),
(249, 'pathtodu', ''),
(250, 'aspellpath', ''),
(251, 'pathtodot', ''),
(252, 'supportpage', ''),
(253, 'dbsessions', '1'),
(254, 'sessioncookie', ''),
(255, 'sessioncookiepath', '/'),
(256, 'sessioncookiedomain', ''),
(257, 'statsfirstrun', 'none'),
(258, 'statsmaxruntime', '0'),
(259, 'statsruntimedays', '31'),
(260, 'statsruntimestarthour', '0'),
(261, 'statsruntimestartminute', '0'),
(262, 'statsuserthreshold', '0'),
(263, 'framename', '_top'),
(264, 'slasharguments', '1'),
(265, 'getremoteaddrconf', '0'),
(266, 'proxyhost', ''),
(267, 'proxyport', '0'),
(268, 'proxytype', 'HTTP'),
(269, 'proxyuser', ''),
(270, 'proxypassword', ''),
(271, 'proxybypass', 'localhost, 127.0.0.1'),
(272, 'maintenance_enabled', '0'),
(273, 'maintenance_message', ''),
(274, 'deleteunconfirmed', '168'),
(275, 'deleteincompleteusers', '0'),
(276, 'logguests', '1'),
(277, 'loglifetime', '0'),
(278, 'disablegradehistory', '0'),
(279, 'gradehistorylifetime', '0'),
(280, 'numcoursesincombo', '500'),
(281, 'extramemorylimit', '512M'),
(282, 'curlcache', '120'),
(283, 'curltimeoutkbitrate', '56'),
(284, 'enableglobalsearch', '0'),
(285, 'enablesafebrowserintegration', '0'),
(286, 'enablegroupmembersonly', '0'),
(287, 'debug', '0'),
(288, 'debugdisplay', '0'),
(289, 'xmlstrictheaders', '0'),
(290, 'debugsmtp', '0'),
(291, 'perfdebug', '7'),
(292, 'debugstringids', '0'),
(293, 'debugvalidators', '0'),
(294, 'debugpageinfo', '0'),
(295, 'release', '2.1.2+ (Build: 20111027)'),
(296, 'jsrev', '170'),
(298, 'notloggedinroleid', '6'),
(299, 'guestroleid', '6'),
(300, 'defaultuserroleid', '7'),
(301, 'creatornewroleid', '3'),
(302, 'gradebookroles', '5'),
(303, 'assignment_maxbytes', '1048576'),
(304, 'assignment_itemstocount', '1'),
(305, 'assignment_showrecentsubmissions', '1'),
(306, 'chat_method', 'ajax'),
(307, 'chat_refresh_userlist', '10'),
(308, 'chat_old_ping', '35'),
(309, 'chat_refresh_room', '5'),
(310, 'chat_normal_updatemode', 'jsupdate'),
(311, 'chat_serverhost', 'localhost'),
(312, 'chat_serverip', '127.0.0.1'),
(313, 'chat_serverport', '9111'),
(314, 'chat_servermax', '100'),
(315, 'data_enablerssfeeds', '0'),
(316, 'feedback_allowfullanonymous', '0'),
(317, 'forum_displaymode', '3'),
(318, 'forum_replytouser', '1'),
(319, 'forum_shortpost', '300'),
(320, 'forum_longpost', '600'),
(321, 'forum_manydiscussions', '100'),
(322, 'forum_maxbytes', '512000'),
(323, 'forum_maxattachments', '9'),
(324, 'forum_trackreadposts', '1'),
(325, 'forum_oldpostdays', '14'),
(326, 'forum_usermarksread', '0'),
(327, 'forum_cleanreadtime', '2'),
(328, 'digestmailtime', '17'),
(329, 'forum_enablerssfeeds', '0'),
(330, 'forum_enabletimedposts', '0'),
(331, 'glossary_entbypage', '10'),
(332, 'glossary_dupentries', '0'),
(333, 'glossary_allowcomments', '0'),
(334, 'glossary_linkbydefault', '1'),
(335, 'glossary_defaultapproval', '1'),
(336, 'glossary_enablerssfeeds', '0'),
(337, 'glossary_linkentries', '0'),
(338, 'glossary_casesensitive', '0'),
(339, 'glossary_fullmatch', '0'),
(340, 'lesson_slideshowwidth', '640'),
(341, 'lesson_slideshowheight', '480'),
(342, 'lesson_slideshowbgcolor', '#FFFFFF'),
(343, 'lesson_mediawidth', '640'),
(344, 'lesson_mediaheight', '480'),
(345, 'lesson_mediaclose', '0'),
(346, 'lesson_maxhighscores', '10'),
(347, 'lesson_maxanswers', '4'),
(348, 'lesson_defaultnextpage', '0'),
(349, 'block_course_list_adminview', 'all'),
(350, 'block_course_list_hideallcourseslink', '0'),
(351, 'block_online_users_timetosee', '5'),
(352, 'block_rss_client_num_entries', '5'),
(353, 'block_rss_client_timeout', '30'),
(354, 'block_search_enable_file_indexing', '0'),
(355, 'block_search_filetypes', 'PDF,TXT,HTML,PPT,XML,DOC,HTM'),
(356, 'block_search_usemoodleroot', '1'),
(357, 'block_search_limit_index_body', '0'),
(358, 'block_search_pdf_to_text_cmd', 'lib/xpdf/linux/pdftotext -enc UTF-8 -eol unix -q'),
(359, 'block_search_word_to_text_cmd', 'lib/antiword/linux/usr/bin/antiword'),
(360, 'block_search_word_to_text_env', 'ANTIWORDHOME=/home/menno/php_projects/moodle_21_fresh/public_html/lib/antiword/linux/usr/share/antiword'),
(361, 'search_in_assignment', '1'),
(362, 'search_in_chat', '1'),
(363, 'search_in_data', '1'),
(364, 'search_in_forum', '1'),
(365, 'search_in_glossary', '1'),
(366, 'search_in_label', '1'),
(367, 'search_in_lesson', '1'),
(368, 'search_in_resource', '1'),
(369, 'search_in_wiki', '1'),
(370, 'block_tags_showcoursetags', '0'),
(371, 'jabberhost', ''),
(372, 'jabberserver', ''),
(373, 'jabberusername', ''),
(374, 'jabberpassword', ''),
(375, 'jabberport', '5222'),
(376, 'smtphosts', ''),
(377, 'smtpuser', ''),
(378, 'smtppass', ''),
(379, 'smtpmaxbulk', '1'),
(380, 'noreplyaddress', 'noreply@localhost'),
(381, 'sitemailcharset', '0'),
(382, 'allowusermailcharset', '0'),
(383, 'mailnewline', 'LF'),
(384, 'profileroles', '5,4,3'),
(385, 'defaultallowedmodules', ''),
(386, 'coursecontact', '3'),
(387, 'frontpage', '1'),
(388, 'frontpageloggedin', '1'),
(389, 'maxcategorydepth', '0'),
(390, 'commentsperpage', '15'),
(391, 'coursesperpage', '20'),
(392, 'defaultfrontpageroleid', '8'),
(393, 'supportname', 'Admin User'),
(394, 'supportemail', 'm.deridder@solin.nl'),
(395, 'registerauth', '');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_config_log`
--

CREATE TABLE IF NOT EXISTS `mdl_config_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  `plugin` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` text,
  `oldvalue` text,
  PRIMARY KEY (`id`),
  KEY `mdl_conflog_tim_ix` (`timemodified`),
  KEY `mdl_conflog_use_ix` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Changes done in server configuration through admin UI' AUTO_INCREMENT=710 ;

--
-- Dumping data for table `mdl_config_log`
--

INSERT INTO `mdl_config_log` (`id`, `userid`, `timemodified`, `plugin`, `name`, `value`, `oldvalue`) VALUES
(1, 0, 1320247920, NULL, 'enableoutcomes', '0', NULL),
(2, 0, 1320247920, NULL, 'usecomments', '1', NULL),
(3, 0, 1320247920, NULL, 'usetags', '1', NULL),
(4, 0, 1320247920, NULL, 'enablenotes', '1', NULL),
(5, 0, 1320247921, NULL, 'enableportfolios', '0', NULL),
(6, 0, 1320247921, NULL, 'enablewebservices', '0', NULL),
(7, 0, 1320247921, NULL, 'messaging', '1', NULL),
(8, 0, 1320247921, NULL, 'messaginghidereadnotifications', '0', NULL),
(9, 0, 1320247921, NULL, 'messagingdeletereadnotificationsdelay', '604800', NULL),
(10, 0, 1320247921, NULL, 'enablestats', '0', NULL),
(11, 0, 1320247921, NULL, 'enablerssfeeds', '0', NULL),
(12, 0, 1320247921, NULL, 'bloglevel', '4', NULL),
(13, 0, 1320247922, NULL, 'enablecompletion', '0', NULL),
(14, 0, 1320247922, NULL, 'enableavailability', '0', NULL),
(15, 0, 1320247922, NULL, 'enableplagiarism', '0', NULL),
(16, 0, 1320247922, NULL, 'autologinguests', '0', NULL),
(17, 0, 1320247922, NULL, 'hiddenuserfields', '', NULL),
(18, 0, 1320247922, NULL, 'extrauserselectorfields', 'email', NULL),
(19, 0, 1320247922, 'moodlecourse', 'format', 'weeks', NULL),
(20, 0, 1320247922, 'moodlecourse', 'maxsections', '52', NULL),
(21, 0, 1320247923, 'moodlecourse', 'numsections', '10', NULL),
(22, 0, 1320247923, 'moodlecourse', 'hiddensections', '0', NULL),
(23, 0, 1320247923, 'moodlecourse', 'newsitems', '5', NULL),
(24, 0, 1320247923, 'moodlecourse', 'showgrades', '1', NULL),
(25, 0, 1320247923, 'moodlecourse', 'showreports', '0', NULL),
(26, 0, 1320247923, 'moodlecourse', 'maxbytes', '2097152', NULL),
(27, 0, 1320247924, 'moodlecourse', 'groupmode', '0', NULL),
(28, 0, 1320247924, 'moodlecourse', 'groupmodeforce', '0', NULL),
(29, 0, 1320247924, 'moodlecourse', 'visible', '1', NULL),
(30, 0, 1320247924, 'moodlecourse', 'lang', '', NULL),
(31, 0, 1320247924, 'moodlecourse', 'enablecompletion', '0', NULL),
(32, 0, 1320247924, 'moodlecourse', 'completionstartonenrol', '0', NULL),
(33, 0, 1320247924, NULL, 'enablecourserequests', '0', NULL),
(34, 0, 1320247924, NULL, 'defaultrequestcategory', '1', NULL),
(35, 0, 1320247925, NULL, 'courserequestnotify', '', NULL),
(36, 0, 1320247925, 'backup', 'backup_general_users', '1', NULL),
(37, 0, 1320247925, 'backup', 'backup_general_users_locked', '0', NULL),
(38, 0, 1320247925, 'backup', 'backup_general_anonymize', '0', NULL),
(39, 0, 1320247925, 'backup', 'backup_general_anonymize_locked', '0', NULL),
(40, 0, 1320247925, 'backup', 'backup_general_role_assignments', '1', NULL),
(41, 0, 1320247925, 'backup', 'backup_general_role_assignments_locked', '0', NULL),
(42, 0, 1320247925, 'backup', 'backup_general_user_files', '1', NULL),
(43, 0, 1320247926, 'backup', 'backup_general_user_files_locked', '0', NULL),
(44, 0, 1320247926, 'backup', 'backup_general_activities', '1', NULL),
(45, 0, 1320247926, 'backup', 'backup_general_activities_locked', '0', NULL),
(46, 0, 1320247926, 'backup', 'backup_general_blocks', '1', NULL),
(47, 0, 1320247926, 'backup', 'backup_general_blocks_locked', '0', NULL),
(48, 0, 1320247926, 'backup', 'backup_general_filters', '1', NULL),
(49, 0, 1320247926, 'backup', 'backup_general_filters_locked', '0', NULL),
(50, 0, 1320247926, 'backup', 'backup_general_comments', '1', NULL),
(51, 0, 1320247927, 'backup', 'backup_general_comments_locked', '0', NULL),
(52, 0, 1320247927, 'backup', 'backup_general_userscompletion', '1', NULL),
(53, 0, 1320247927, 'backup', 'backup_general_userscompletion_locked', '0', NULL),
(54, 0, 1320247927, 'backup', 'backup_general_logs', '0', NULL),
(55, 0, 1320247927, 'backup', 'backup_general_logs_locked', '0', NULL),
(56, 0, 1320247927, 'backup', 'backup_general_histories', '0', NULL),
(57, 0, 1320247927, 'backup', 'backup_general_histories_locked', '0', NULL),
(58, 0, 1320247928, 'backup', 'backup_auto_active', '0', NULL),
(59, 0, 1320247928, 'backup', 'backup_auto_weekdays', '0000000', NULL),
(60, 0, 1320247928, 'backup', 'backup_auto_hour', '0', NULL),
(61, 0, 1320247928, 'backup', 'backup_auto_minute', '0', NULL),
(62, 0, 1320247928, 'backup', 'backup_auto_storage', '0', NULL),
(63, 0, 1320247928, 'backup', 'backup_auto_destination', '', NULL),
(64, 0, 1320247928, 'backup', 'backup_auto_keep', '1', NULL),
(65, 0, 1320247928, 'backup', 'backup_auto_users', '1', NULL),
(66, 0, 1320247929, 'backup', 'backup_auto_role_assignments', '1', NULL),
(67, 0, 1320247929, 'backup', 'backup_auto_user_files', '1', NULL),
(68, 0, 1320247929, 'backup', 'backup_auto_activities', '1', NULL),
(69, 0, 1320247929, 'backup', 'backup_auto_blocks', '1', NULL),
(70, 0, 1320247929, 'backup', 'backup_auto_filters', '1', NULL),
(71, 0, 1320247930, 'backup', 'backup_auto_comments', '1', NULL),
(72, 0, 1320247930, 'backup', 'backup_auto_userscompletion', '1', NULL),
(73, 0, 1320247930, 'backup', 'backup_auto_logs', '0', NULL),
(74, 0, 1320247930, 'backup', 'backup_auto_histories', '0', NULL),
(75, 0, 1320247930, NULL, 'grade_profilereport', 'user', NULL),
(76, 0, 1320247930, NULL, 'grade_aggregationposition', '1', NULL),
(77, 0, 1320247931, NULL, 'grade_includescalesinaggregation', '1', NULL),
(78, 0, 1320247931, NULL, 'grade_hiddenasdate', '0', NULL),
(79, 0, 1320247931, NULL, 'gradepublishing', '0', NULL),
(80, 0, 1320247931, NULL, 'grade_export_displaytype', '1', NULL),
(81, 0, 1320247931, NULL, 'grade_export_decimalpoints', '2', NULL),
(82, 0, 1320247931, NULL, 'grade_navmethod', '0', NULL),
(83, 0, 1320247931, NULL, 'gradeexport', '', NULL),
(84, 0, 1320247931, NULL, 'unlimitedgrades', '0', NULL),
(85, 0, 1320247932, NULL, 'grade_hideforcedsettings', '1', NULL),
(86, 0, 1320247932, NULL, 'grade_aggregation', '11', NULL),
(87, 0, 1320247932, NULL, 'grade_aggregation_flag', '0', NULL),
(88, 0, 1320247932, NULL, 'grade_aggregations_visible', '0,10,11,12,2,4,6,8,13', NULL),
(89, 0, 1320247932, NULL, 'grade_aggregateonlygraded', '1', NULL),
(90, 0, 1320247932, NULL, 'grade_aggregateonlygraded_flag', '2', NULL),
(91, 0, 1320247933, NULL, 'grade_aggregateoutcomes', '0', NULL),
(92, 0, 1320247933, NULL, 'grade_aggregateoutcomes_flag', '2', NULL),
(93, 0, 1320247933, NULL, 'grade_aggregatesubcats', '0', NULL),
(94, 0, 1320247933, NULL, 'grade_aggregatesubcats_flag', '2', NULL),
(95, 0, 1320247933, NULL, 'grade_keephigh', '0', NULL),
(96, 0, 1320247933, NULL, 'grade_keephigh_flag', '3', NULL),
(97, 0, 1320247933, NULL, 'grade_droplow', '0', NULL),
(98, 0, 1320247933, NULL, 'grade_droplow_flag', '2', NULL),
(99, 0, 1320247933, NULL, 'grade_displaytype', '1', NULL),
(100, 0, 1320247934, NULL, 'grade_decimalpoints', '2', NULL),
(101, 0, 1320247934, NULL, 'grade_item_advanced', 'iteminfo,idnumber,gradepass,plusfactor,multfactor,display,decimals,hiddenuntil,locktime', NULL),
(102, 0, 1320247934, NULL, 'grade_report_studentsperpage', '100', NULL),
(103, 0, 1320247934, NULL, 'grade_report_quickgrading', '1', NULL),
(104, 0, 1320247934, NULL, 'grade_report_showquickfeedback', '0', NULL),
(105, 0, 1320247934, NULL, 'grade_report_fixedstudents', '0', NULL),
(106, 0, 1320247934, NULL, 'grade_report_meanselection', '1', NULL),
(107, 0, 1320247935, NULL, 'grade_report_enableajax', '0', NULL),
(108, 0, 1320247935, NULL, 'grade_report_showcalculations', '0', NULL),
(109, 0, 1320247935, NULL, 'grade_report_showeyecons', '0', NULL),
(110, 0, 1320247935, NULL, 'grade_report_showaverages', '1', NULL),
(111, 0, 1320247935, NULL, 'grade_report_showlocks', '0', NULL),
(112, 0, 1320247935, NULL, 'grade_report_showranges', '0', NULL),
(113, 0, 1320247935, NULL, 'grade_report_showuserimage', '1', NULL),
(114, 0, 1320247935, NULL, 'grade_report_showuseridnumber', '0', NULL),
(115, 0, 1320247936, NULL, 'grade_report_showactivityicons', '1', NULL),
(116, 0, 1320247936, NULL, 'grade_report_shownumberofgrades', '0', NULL),
(117, 0, 1320247936, NULL, 'grade_report_averagesdisplaytype', 'inherit', NULL),
(118, 0, 1320247936, NULL, 'grade_report_rangesdisplaytype', 'inherit', NULL),
(119, 0, 1320247936, NULL, 'grade_report_averagesdecimalpoints', 'inherit', NULL),
(120, 0, 1320247936, NULL, 'grade_report_rangesdecimalpoints', 'inherit', NULL),
(121, 0, 1320247936, NULL, 'grade_report_overview_showrank', '0', NULL),
(122, 0, 1320247936, NULL, 'grade_report_overview_showtotalsifcontainhidden', '0', NULL),
(123, 0, 1320247937, NULL, 'grade_report_user_showrank', '0', NULL),
(124, 0, 1320247937, NULL, 'grade_report_user_showpercentage', '1', NULL),
(125, 0, 1320247937, NULL, 'grade_report_user_showgrade', '1', NULL),
(126, 0, 1320247937, NULL, 'grade_report_user_showfeedback', '1', NULL),
(127, 0, 1320247937, NULL, 'grade_report_user_showrange', '1', NULL),
(128, 0, 1320247937, NULL, 'grade_report_user_showweight', '0', NULL),
(129, 0, 1320247937, NULL, 'grade_report_user_showaverage', '0', NULL),
(130, 0, 1320247938, NULL, 'grade_report_user_showlettergrade', '0', NULL),
(131, 0, 1320247938, NULL, 'grade_report_user_rangedecimals', '0', NULL),
(132, 0, 1320247938, NULL, 'grade_report_user_showhiddenitems', '1', NULL),
(133, 0, 1320247938, NULL, 'grade_report_user_showtotalsifcontainhidden', '0', NULL),
(134, 0, 1320247938, NULL, 'timezone', '99', NULL),
(135, 0, 1320247938, NULL, 'forcetimezone', '99', NULL),
(136, 0, 1320247938, NULL, 'country', '0', NULL),
(137, 0, 1320247939, NULL, 'defaultcity', '', NULL),
(138, 0, 1320247939, NULL, 'geoipfile', '/home/menno/php_projects/moodle_21_fresh/moodledata/geoip/GeoLiteCity.dat', NULL),
(139, 0, 1320247939, NULL, 'googlemapkey', '', NULL),
(140, 0, 1320247939, NULL, 'allcountrycodes', '', NULL),
(141, 0, 1320247939, NULL, 'autolang', '1', NULL),
(142, 0, 1320247939, NULL, 'lang', 'en', NULL),
(143, 0, 1320247939, NULL, 'langmenu', '1', NULL),
(144, 0, 1320247940, NULL, 'langlist', '', NULL),
(145, 0, 1320247940, NULL, 'langcache', '1', NULL),
(146, 0, 1320247940, NULL, 'langstringcache', '1', NULL),
(147, 0, 1320247940, NULL, 'locale', '', NULL),
(148, 0, 1320247940, NULL, 'latinexcelexport', '0', NULL),
(149, 0, 1320247940, NULL, 'registerauth', '', NULL),
(150, 0, 1320247941, NULL, 'authpreventaccountcreation', '0', NULL),
(151, 0, 1320247941, NULL, 'loginpageautofocus', '0', NULL),
(152, 0, 1320247941, NULL, 'guestloginbutton', '1', NULL),
(153, 0, 1320247941, NULL, 'alternateloginurl', '', NULL),
(154, 0, 1320247941, NULL, 'forgottenpasswordurl', '', NULL),
(155, 0, 1320247941, NULL, 'auth_instructions', '', NULL),
(156, 0, 1320247942, NULL, 'allowemailaddresses', '', NULL),
(157, 0, 1320247942, NULL, 'denyemailaddresses', '', NULL),
(158, 0, 1320247942, NULL, 'verifychangedemail', '1', NULL),
(159, 0, 1320247942, NULL, 'recaptchapublickey', '', NULL),
(160, 0, 1320247942, NULL, 'recaptchaprivatekey', '', NULL),
(161, 0, 1320247942, 'enrol_database', 'dbtype', '', NULL),
(162, 0, 1320247942, 'enrol_database', 'dbhost', 'localhost', NULL),
(163, 0, 1320247943, 'enrol_database', 'dbuser', '', NULL),
(164, 0, 1320247943, 'enrol_database', 'dbpass', '', NULL),
(165, 0, 1320247943, 'enrol_database', 'dbname', '', NULL),
(166, 0, 1320247943, 'enrol_database', 'dbencoding', 'utf-8', NULL),
(167, 0, 1320247943, 'enrol_database', 'dbsetupsql', '', NULL),
(168, 0, 1320247943, 'enrol_database', 'dbsybasequoting', '0', NULL),
(169, 0, 1320247943, 'enrol_database', 'debugdb', '0', NULL),
(170, 0, 1320247943, 'enrol_database', 'localcoursefield', 'idnumber', NULL),
(171, 0, 1320247944, 'enrol_database', 'localuserfield', 'idnumber', NULL),
(172, 0, 1320247944, 'enrol_database', 'localrolefield', 'shortname', NULL),
(173, 0, 1320247944, 'enrol_database', 'remoteenroltable', '', NULL),
(174, 0, 1320247944, 'enrol_database', 'remotecoursefield', '', NULL),
(175, 0, 1320247944, 'enrol_database', 'remoteuserfield', '', NULL),
(176, 0, 1320247944, 'enrol_database', 'remoterolefield', '', NULL),
(177, 0, 1320247944, 'enrol_database', 'ignorehiddencourses', '0', NULL),
(178, 0, 1320247944, 'enrol_database', 'unenrolaction', '0', NULL),
(179, 0, 1320247944, 'enrol_database', 'newcoursetable', '', NULL),
(180, 0, 1320247945, 'enrol_database', 'newcoursefullname', 'fullname', NULL),
(181, 0, 1320247945, 'enrol_database', 'newcourseshortname', 'shortname', NULL),
(182, 0, 1320247945, 'enrol_database', 'newcourseidnumber', 'idnumber', NULL),
(183, 0, 1320247945, 'enrol_database', 'newcoursecategory', '', NULL),
(184, 0, 1320247945, 'enrol_database', 'templatecourse', '', NULL),
(185, 0, 1320247945, 'enrol_flatfile', 'location', '', NULL),
(186, 0, 1320247945, 'enrol_flatfile', 'mailstudents', '0', NULL),
(187, 0, 1320247945, 'enrol_flatfile', 'mailteachers', '0', NULL),
(188, 0, 1320247946, 'enrol_flatfile', 'mailadmins', '0', NULL),
(189, 0, 1320247946, 'enrol_guest', 'requirepassword', '0', NULL),
(190, 0, 1320247946, 'enrol_guest', 'usepasswordpolicy', '0', NULL),
(191, 0, 1320247946, 'enrol_guest', 'showhint', '0', NULL),
(192, 0, 1320247946, 'enrol_guest', 'defaultenrol', '1', NULL),
(193, 0, 1320247946, 'enrol_guest', 'status', '1', NULL),
(194, 0, 1320247946, 'enrol_guest', 'status_adv', '0', NULL),
(195, 0, 1320247947, 'enrol_imsenterprise', 'imsfilelocation', '', NULL),
(196, 0, 1320247947, 'enrol_imsenterprise', 'logtolocation', '', NULL),
(197, 0, 1320247947, 'enrol_imsenterprise', 'mailadmins', '0', NULL),
(198, 0, 1320247947, 'enrol_imsenterprise', 'createnewusers', '0', NULL),
(199, 0, 1320247947, 'enrol_imsenterprise', 'imsdeleteusers', '0', NULL),
(200, 0, 1320247947, 'enrol_imsenterprise', 'fixcaseusernames', '0', NULL),
(201, 0, 1320247947, 'enrol_imsenterprise', 'fixcasepersonalnames', '0', NULL),
(202, 0, 1320247947, 'enrol_imsenterprise', 'imssourcedidfallback', '0', NULL),
(203, 0, 1320247948, 'enrol_imsenterprise', 'truncatecoursecodes', '0', NULL),
(204, 0, 1320247948, 'enrol_imsenterprise', 'createnewcourses', '0', NULL),
(205, 0, 1320247948, 'enrol_imsenterprise', 'createnewcategories', '0', NULL),
(206, 0, 1320247948, 'enrol_imsenterprise', 'imsunenrol', '0', NULL),
(207, 0, 1320247948, 'enrol_imsenterprise', 'imsrestricttarget', '', NULL),
(208, 0, 1320247948, 'enrol_imsenterprise', 'imscapitafix', '0', NULL),
(209, 0, 1320247948, 'enrol_manual', 'defaultenrol', '1', NULL),
(210, 0, 1320247948, 'enrol_manual', 'status', '0', NULL),
(211, 0, 1320247949, 'enrol_manual', 'enrolperiod', '0', NULL),
(212, 0, 1320247949, 'enrol_paypal', 'paypalbusiness', '', NULL),
(213, 0, 1320247949, 'enrol_paypal', 'mailstudents', '0', NULL),
(214, 0, 1320247949, 'enrol_paypal', 'mailteachers', '0', NULL),
(215, 0, 1320247949, 'enrol_paypal', 'mailadmins', '0', NULL),
(216, 0, 1320247949, 'enrol_paypal', 'status', '1', NULL),
(217, 0, 1320247949, 'enrol_paypal', 'cost', '0', NULL),
(218, 0, 1320247949, 'enrol_paypal', 'currency', 'USD', NULL),
(219, 0, 1320247950, 'enrol_paypal', 'enrolperiod', '0', NULL),
(220, 0, 1320247950, 'enrol_self', 'requirepassword', '0', NULL),
(221, 0, 1320247950, 'enrol_self', 'usepasswordpolicy', '0', NULL),
(222, 0, 1320247950, 'enrol_self', 'showhint', '0', NULL),
(223, 0, 1320247950, 'enrol_self', 'defaultenrol', '1', NULL),
(224, 0, 1320247950, 'enrol_self', 'status', '1', NULL),
(225, 0, 1320247950, 'enrol_self', 'groupkey', '0', NULL),
(226, 0, 1320247950, 'enrol_self', 'enrolperiod', '0', NULL),
(227, 0, 1320247951, 'enrol_self', 'longtimenosee', '0', NULL),
(228, 0, 1320247951, 'enrol_self', 'maxenrolled', '0', NULL),
(229, 0, 1320247951, 'enrol_self', 'sendcoursewelcomemessage', '1', NULL),
(230, 0, 1320247951, 'editor_tinymce', 'spellengine', 'GoogleSpell', NULL),
(231, 0, 1320247951, NULL, 'sitedefaultlicense', 'allrightsreserved', NULL),
(232, 0, 1320247951, NULL, 'cachetext', '60', NULL),
(233, 0, 1320247951, NULL, 'filteruploadedfiles', '0', NULL),
(234, 0, 1320247952, NULL, 'filtermatchoneperpage', '0', NULL),
(235, 0, 1320247952, NULL, 'filtermatchonepertext', '0', NULL),
(236, 0, 1320247952, 'filter_urltolink', 'formats', '0', NULL),
(237, 0, 1320247952, 'filter_urltolink', 'embedimages', '1', NULL),
(238, 0, 1320247952, 'filter_emoticon', 'formats', '1,4,0', NULL),
(239, 0, 1320247952, NULL, 'filter_multilang_force_old', '0', NULL),
(240, 0, 1320247953, NULL, 'filter_mediaplugin_enable_youtube', '1', NULL),
(241, 0, 1320247953, NULL, 'filter_mediaplugin_enable_vimeo', '0', NULL),
(242, 0, 1320247953, NULL, 'filter_mediaplugin_enable_mp3', '1', NULL),
(243, 0, 1320247953, NULL, 'filter_mediaplugin_enable_flv', '1', NULL),
(244, 0, 1320247953, NULL, 'filter_mediaplugin_enable_swf', '1', NULL),
(245, 0, 1320247953, NULL, 'filter_mediaplugin_enable_html5audio', '0', NULL),
(246, 0, 1320247953, NULL, 'filter_mediaplugin_enable_html5video', '0', NULL),
(247, 0, 1320247953, NULL, 'filter_mediaplugin_enable_qt', '1', NULL),
(248, 0, 1320247954, NULL, 'filter_mediaplugin_enable_wmp', '1', NULL),
(249, 0, 1320247954, NULL, 'filter_mediaplugin_enable_rm', '1', NULL),
(250, 0, 1320247954, NULL, 'filter_tex_latexpreamble', '\\usepackage[latin1]{inputenc}\n\\usepackage{amsmath}\n\\usepackage{amsfonts}\n\\RequirePackage{amsmath,amssymb,latexsym}\n', NULL),
(251, 0, 1320247954, NULL, 'filter_tex_latexbackground', '#FFFFFF', NULL),
(252, 0, 1320247954, NULL, 'filter_tex_density', '120', NULL),
(253, 0, 1320247954, NULL, 'filter_tex_pathlatex', '/usr/bin/latex', NULL),
(254, 0, 1320247954, NULL, 'filter_tex_pathdvips', '/usr/bin/dvips', NULL),
(255, 0, 1320247954, NULL, 'filter_tex_pathconvert', '/usr/bin/convert', NULL),
(256, 0, 1320247955, NULL, 'filter_tex_convertformat', 'gif', NULL),
(257, 0, 1320247955, NULL, 'filter_censor_badwords', '', NULL),
(258, 0, 1320247955, NULL, 'portfolio_moderate_filesize_threshold', '1048576', NULL),
(259, 0, 1320247955, NULL, 'portfolio_high_filesize_threshold', '5242880', NULL),
(260, 0, 1320247955, NULL, 'portfolio_moderate_db_threshold', '20', NULL),
(261, 0, 1320247955, NULL, 'portfolio_high_db_threshold', '50', NULL),
(262, 0, 1320247955, NULL, 'repositorycacheexpire', '120', NULL),
(263, 0, 1320247955, NULL, 'repositoryallowexternallinks', '1', NULL),
(264, 0, 1320247956, NULL, 'legacyfilesinnewcourses', '0', NULL),
(265, 0, 1320247956, NULL, 'enablewsdocumentation', '0', NULL),
(266, 0, 1320247956, NULL, 'allowbeforeblock', '0', NULL),
(267, 0, 1320247956, NULL, 'allowedip', '', NULL),
(268, 0, 1320247956, NULL, 'blockedip', '', NULL),
(269, 0, 1320247956, NULL, 'protectusernames', '1', NULL),
(270, 0, 1320247956, NULL, 'forcelogin', '0', NULL),
(271, 0, 1320247956, NULL, 'forceloginforprofiles', '1', NULL),
(272, 0, 1320247957, NULL, 'opentogoogle', '0', NULL),
(273, 0, 1320247957, NULL, 'maxbytes', '0', NULL),
(274, 0, 1320247957, NULL, 'userquota', '104857600', NULL),
(275, 0, 1320247957, NULL, 'enablehtmlpurifier', '1', NULL),
(276, 0, 1320247957, NULL, 'allowobjectembed', '0', NULL),
(277, 0, 1320247957, NULL, 'enabletrusttext', '0', NULL),
(278, 0, 1320247957, NULL, 'maxeditingtime', '1800', NULL),
(279, 0, 1320247957, NULL, 'fullnamedisplay', 'language', NULL),
(280, 0, 1320247958, NULL, 'extendedusernamechars', '0', NULL),
(281, 0, 1320247958, NULL, 'sitepolicy', '', NULL),
(282, 0, 1320247958, NULL, 'sitepolicyguest', '', NULL),
(283, 0, 1320247958, NULL, 'keeptagnamecase', '1', NULL),
(284, 0, 1320247958, NULL, 'profilesforenrolledusersonly', '1', NULL),
(285, 0, 1320247958, NULL, 'cronclionly', '0', NULL),
(286, 0, 1320247958, NULL, 'cronremotepassword', '', NULL),
(287, 0, 1320247958, NULL, 'passwordpolicy', '1', NULL),
(288, 0, 1320247958, NULL, 'minpasswordlength', '8', NULL),
(289, 0, 1320247959, NULL, 'minpassworddigits', '1', NULL),
(290, 0, 1320247959, NULL, 'minpasswordlower', '1', NULL),
(291, 0, 1320247959, NULL, 'minpasswordupper', '1', NULL),
(292, 0, 1320247959, NULL, 'minpasswordnonalphanum', '1', NULL),
(293, 0, 1320247959, NULL, 'maxconsecutiveidentchars', '0', NULL),
(294, 0, 1320247959, NULL, 'groupenrolmentkeypolicy', '1', NULL),
(295, 0, 1320247959, NULL, 'disableuserimages', '0', NULL),
(296, 0, 1320247959, NULL, 'emailchangeconfirmation', '1', NULL),
(297, 0, 1320247960, NULL, 'strictformsrequired', '0', NULL),
(298, 0, 1320247960, NULL, 'loginhttps', '0', NULL),
(299, 0, 1320247960, NULL, 'cookiesecure', '0', NULL),
(300, 0, 1320247960, NULL, 'cookiehttponly', '0', NULL),
(301, 0, 1320247960, NULL, 'excludeoldflashclients', '10.0.12', NULL),
(302, 0, 1320247960, NULL, 'restrictmodulesfor', 'none', NULL),
(303, 0, 1320247960, NULL, 'restrictbydefault', '0', NULL),
(304, 0, 1320247961, NULL, 'displayloginfailures', '', NULL),
(305, 0, 1320247961, NULL, 'notifyloginfailures', '', NULL),
(306, 0, 1320247961, NULL, 'notifyloginthreshold', '10', NULL),
(307, 0, 1320247961, NULL, 'runclamonupload', '0', NULL),
(308, 0, 1320247961, NULL, 'pathtoclam', '', NULL),
(309, 0, 1320247961, NULL, 'quarantinedir', '', NULL),
(310, 0, 1320247961, NULL, 'clamfailureonupload', 'donothing', NULL),
(311, 0, 1320247961, NULL, 'themelist', '', NULL),
(312, 0, 1320247962, NULL, 'themedesignermode', '0', NULL),
(313, 0, 1320247962, NULL, 'allowuserthemes', '0', NULL),
(314, 0, 1320247962, NULL, 'allowcoursethemes', '0', NULL),
(315, 0, 1320247962, NULL, 'allowcategorythemes', '0', NULL),
(316, 0, 1320247962, NULL, 'allowthemechangeonurl', '0', NULL),
(317, 0, 1320247962, NULL, 'allowuserblockhiding', '1', NULL),
(318, 0, 1320247962, NULL, 'allowblockstodock', '1', NULL),
(319, 0, 1320247963, NULL, 'custommenuitems', '', NULL),
(320, 0, 1320247963, NULL, 'enabledevicedetection', '1', NULL),
(321, 0, 1320247963, NULL, 'devicedetectregex', '[]', NULL),
(322, 0, 1320247963, 'theme_arialist', 'logo', '', NULL),
(323, 0, 1320247963, 'theme_arialist', 'tagline', '', NULL),
(324, 0, 1320247963, 'theme_arialist', 'linkcolor', '#f25f0f', NULL),
(325, 0, 1320247964, 'theme_arialist', 'regionwidth', '250', NULL),
(326, 0, 1320247964, 'theme_arialist', 'customcss', '', NULL),
(327, 0, 1320247964, 'theme_brick', 'logo', '', NULL),
(328, 0, 1320247964, 'theme_brick', 'linkcolor', '#06365b', NULL),
(329, 0, 1320247965, 'theme_brick', 'linkhover', '#5487ad', NULL),
(330, 0, 1320247965, 'theme_brick', 'maincolor', '#8e2800', NULL),
(331, 0, 1320247965, 'theme_brick', 'maincolorlink', '#fff0a5', NULL),
(332, 0, 1320247965, 'theme_brick', 'headingcolor', '#5c3500', NULL),
(333, 0, 1320247965, 'theme_formal_white', 'fontsizereference', '13', NULL),
(334, 0, 1320247965, 'theme_formal_white', 'noframe', '0', NULL),
(335, 0, 1320247965, 'theme_formal_white', 'displaylogo', '1', NULL),
(336, 0, 1320247965, 'theme_formal_white', 'logo', '', NULL),
(337, 0, 1320247966, 'theme_formal_white', 'headerbgc', '#E3DFD4', NULL),
(338, 0, 1320247966, 'theme_formal_white', 'blockcontentbgc', '#F6F6F6', NULL),
(339, 0, 1320247966, 'theme_formal_white', 'lblockcolumnbgc', '#E3DFD4', NULL),
(340, 0, 1320247966, 'theme_formal_white', 'rblockcolumnbgc', '', NULL),
(341, 0, 1320247966, 'theme_formal_white', 'blockcolumnwidth', '200', NULL),
(342, 0, 1320247966, 'theme_formal_white', 'footnote', '', NULL),
(343, 0, 1320247966, 'theme_formal_white', 'customcss', '', NULL),
(344, 0, 1320247966, 'theme_fusion', 'linkcolor', '#2d83d5', NULL),
(345, 0, 1320247967, 'theme_fusion', 'tagline', '', NULL),
(346, 0, 1320247967, 'theme_fusion', 'footertext', '', NULL),
(347, 0, 1320247967, 'theme_fusion', 'customcss', '', NULL),
(348, 0, 1320247967, 'theme_magazine', 'background', '', NULL),
(349, 0, 1320247967, 'theme_magazine', 'logo', '', NULL),
(350, 0, 1320247967, 'theme_magazine', 'linkcolor', '#32529a', NULL),
(351, 0, 1320247967, 'theme_magazine', 'linkhover', '#4e2300', NULL),
(352, 0, 1320247967, 'theme_magazine', 'maincolor', '#002f2f', NULL),
(353, 0, 1320247968, 'theme_magazine', 'maincoloraccent', '#092323', NULL),
(354, 0, 1320247968, 'theme_magazine', 'headingcolor', '#4e0000', NULL),
(355, 0, 1320247968, 'theme_magazine', 'blockcolor', '#002f2f', NULL),
(356, 0, 1320247968, 'theme_magazine', 'forumback', '#e6e2af', NULL),
(357, 0, 1320247968, 'theme_nimble', 'tagline', '', NULL),
(358, 0, 1320247968, 'theme_nimble', 'footerline', '', NULL),
(359, 0, 1320247969, 'theme_nimble', 'backgroundcolor', '#454545', NULL),
(360, 0, 1320247969, 'theme_nimble', 'linkcolor', '#2a65b1', NULL),
(361, 0, 1320247969, 'theme_nimble', 'linkhover', '#222222', NULL),
(362, 0, 1320247969, 'theme_nonzero', 'regionprewidth', '200', NULL),
(363, 0, 1320247969, 'theme_nonzero', 'regionpostwidth', '200', NULL),
(364, 0, 1320247969, 'theme_nonzero', 'customcss', '', NULL),
(365, 0, 1320247969, 'theme_overlay', 'linkcolor', '#428ab5', NULL),
(366, 0, 1320247969, 'theme_overlay', 'headercolor', '#2a4c7b', NULL),
(367, 0, 1320247970, 'theme_overlay', 'footertext', '', NULL),
(368, 0, 1320247970, 'theme_overlay', 'customcss', '', NULL),
(369, 0, 1320247970, 'theme_sky_high', 'logo', '', NULL),
(370, 0, 1320247970, 'theme_sky_high', 'regionwidth', '240', NULL),
(371, 0, 1320247970, 'theme_sky_high', 'footnote', '', NULL),
(372, 0, 1320247970, 'theme_sky_high', 'customcss', '', NULL),
(373, 0, 1320247970, 'theme_splash', 'logo', '', NULL),
(374, 0, 1320247970, 'theme_splash', 'tagline', 'Virtual learning center', NULL),
(375, 0, 1320247971, 'theme_splash', 'hide_tagline', '0', NULL),
(376, 0, 1320247971, 'theme_splash', 'footnote', '', NULL),
(377, 0, 1320247971, 'theme_splash', 'customcss', '', NULL),
(378, 0, 1320247971, NULL, 'calendar_adminseesall', '0', NULL),
(379, 0, 1320247971, NULL, 'calendar_site_timeformat', '0', NULL),
(380, 0, 1320247971, NULL, 'calendar_startwday', '0', NULL),
(381, 0, 1320247971, NULL, 'calendar_weekend', '65', NULL),
(382, 0, 1320247972, NULL, 'calendar_lookahead', '21', NULL),
(383, 0, 1320247972, NULL, 'calendar_maxevents', '10', NULL),
(384, 0, 1320247972, NULL, 'enablecalendarexport', '1', NULL),
(385, 0, 1320247972, NULL, 'calendar_exportsalt', 'ls3pLs7RJOMPUW9q4nZW5V75nhPlOO4SYyq9Qb6DHopO7zyupvh1xHHnooRz', NULL),
(386, 0, 1320247972, NULL, 'useblogassociations', '1', NULL),
(387, 0, 1320247972, NULL, 'useexternalblogs', '1', NULL),
(388, 0, 1320247972, NULL, 'externalblogcrontime', '86400', NULL),
(389, 0, 1320247972, NULL, 'maxexternalblogsperuser', '1', NULL),
(390, 0, 1320247973, NULL, 'blogusecomments', '1', NULL),
(391, 0, 1320247973, NULL, 'blogshowcommentscount', '1', NULL),
(392, 0, 1320247973, NULL, 'defaulthomepage', '0', NULL),
(393, 0, 1320247973, NULL, 'navshowcategories', '1', NULL),
(394, 0, 1320247973, NULL, 'navshowallcourses', '0', NULL),
(395, 0, 1320247973, NULL, 'navcourselimit', '20', NULL),
(396, 0, 1320247973, NULL, 'formatstringstriptags', '1', NULL),
(397, 0, 1320247974, NULL, 'emoticons', '[{"text":":-)","imagename":"s\\/smiley","imagecomponent":"core","altidentifier":"smiley","altcomponent":"core_pix"},{"text":":)","imagename":"s\\/smiley","imagecomponent":"core","altidentifier":"smiley","altcomponent":"core_pix"},{"text":":-D","imagename":"s\\/biggrin","imagecomponent":"core","altidentifier":"biggrin","altcomponent":"core_pix"},{"text":";-)","imagename":"s\\/wink","imagecomponent":"core","altidentifier":"wink","altcomponent":"core_pix"},{"text":":-\\/","imagename":"s\\/mixed","imagecomponent":"core","altidentifier":"mixed","altcomponent":"core_pix"},{"text":"V-.","imagename":"s\\/thoughtful","imagecomponent":"core","altidentifier":"thoughtful","altcomponent":"core_pix"},{"text":":-P","imagename":"s\\/tongueout","imagecomponent":"core","altidentifier":"tongueout","altcomponent":"core_pix"},{"text":":-p","imagename":"s\\/tongueout","imagecomponent":"core","altidentifier":"tongueout","altcomponent":"core_pix"},{"text":"B-)","imagename":"s\\/cool","imagecomponent":"core","altidentifier":"cool","altcomponent":"core_pix"},{"text":"^-)","imagename":"s\\/approve","imagecomponent":"core","altidentifier":"approve","altcomponent":"core_pix"},{"text":"8-)","imagename":"s\\/wideeyes","imagecomponent":"core","altidentifier":"wideeyes","altcomponent":"core_pix"},{"text":":o)","imagename":"s\\/clown","imagecomponent":"core","altidentifier":"clown","altcomponent":"core_pix"},{"text":":-(","imagename":"s\\/sad","imagecomponent":"core","altidentifier":"sad","altcomponent":"core_pix"},{"text":":(","imagename":"s\\/sad","imagecomponent":"core","altidentifier":"sad","altcomponent":"core_pix"},{"text":"8-.","imagename":"s\\/shy","imagecomponent":"core","altidentifier":"shy","altcomponent":"core_pix"},{"text":":-I","imagename":"s\\/blush","imagecomponent":"core","altidentifier":"blush","altcomponent":"core_pix"},{"text":":-X","imagename":"s\\/kiss","imagecomponent":"core","altidentifier":"kiss","altcomponent":"core_pix"},{"text":"8-o","imagename":"s\\/surprise","imagecomponent":"core","altidentifier":"surprise","altcomponent":"core_pix"},{"text":"P-|","imagename":"s\\/blackeye","imagecomponent":"core","altidentifier":"blackeye","altcomponent":"core_pix"},{"text":"8-[","imagename":"s\\/angry","imagecomponent":"core","altidentifier":"angry","altcomponent":"core_pix"},{"text":"(grr)","imagename":"s\\/angry","imagecomponent":"core","altidentifier":"angry","altcomponent":"core_pix"},{"text":"xx-P","imagename":"s\\/dead","imagecomponent":"core","altidentifier":"dead","altcomponent":"core_pix"},{"text":"|-.","imagename":"s\\/sleepy","imagecomponent":"core","altidentifier":"sleepy","altcomponent":"core_pix"},{"text":"}-]","imagename":"s\\/evil","imagecomponent":"core","altidentifier":"evil","altcomponent":"core_pix"},{"text":"(h)","imagename":"s\\/heart","imagecomponent":"core","altidentifier":"heart","altcomponent":"core_pix"},{"text":"(heart)","imagename":"s\\/heart","imagecomponent":"core","altidentifier":"heart","altcomponent":"core_pix"},{"text":"(y)","imagename":"s\\/yes","imagecomponent":"core","altidentifier":"yes","altcomponent":"core"},{"text":"(n)","imagename":"s\\/no","imagecomponent":"core","altidentifier":"no","altcomponent":"core"},{"text":"(martin)","imagename":"s\\/martin","imagecomponent":"core","altidentifier":"martin","altcomponent":"core_pix"},{"text":"( )","imagename":"s\\/egg","imagecomponent":"core","altidentifier":"egg","altcomponent":"core_pix"}]', NULL),
(398, 0, 1320247974, NULL, 'docroot', 'http://docs.moodle.org', NULL),
(399, 0, 1320247974, NULL, 'doctonewwindow', '0', NULL),
(400, 0, 1320247974, NULL, 'enableajax', '1', NULL),
(401, 0, 1320247974, NULL, 'useexternalyui', '0', NULL),
(402, 0, 1320247974, NULL, 'yuicomboloading', '1', NULL),
(403, 0, 1320247974, NULL, 'cachejs', '1', NULL),
(404, 0, 1320247974, NULL, 'enablecourseajax', '1', NULL),
(405, 0, 1320247975, NULL, 'additionalhtmlhead', '', NULL),
(406, 0, 1320247975, NULL, 'additionalhtmltopofbody', '', NULL),
(407, 0, 1320247975, NULL, 'additionalhtmlfooter', '', NULL),
(408, 0, 1320247975, NULL, 'gdversion', '2', NULL),
(409, 0, 1320247975, NULL, 'pathtodu', '', NULL),
(410, 0, 1320247975, NULL, 'aspellpath', '', NULL),
(411, 0, 1320247975, NULL, 'pathtodot', '', NULL),
(412, 0, 1320247975, NULL, 'supportpage', '', NULL),
(413, 0, 1320247975, NULL, 'dbsessions', '1', NULL),
(414, 0, 1320247976, NULL, 'sessioncookie', '', NULL),
(415, 0, 1320247976, NULL, 'sessioncookiepath', '/', NULL),
(416, 0, 1320247976, NULL, 'sessioncookiedomain', '', NULL),
(417, 0, 1320247976, NULL, 'statsfirstrun', 'none', NULL),
(418, 0, 1320247976, NULL, 'statsmaxruntime', '0', NULL),
(419, 0, 1320247976, NULL, 'statsruntimedays', '31', NULL),
(420, 0, 1320247977, NULL, 'statsruntimestarthour', '0', NULL),
(421, 0, 1320247977, NULL, 'statsruntimestartminute', '0', NULL),
(422, 0, 1320247977, NULL, 'statsuserthreshold', '0', NULL),
(423, 0, 1320247977, NULL, 'framename', '_top', NULL),
(424, 0, 1320247977, NULL, 'slasharguments', '1', NULL),
(425, 0, 1320247977, NULL, 'getremoteaddrconf', '0', NULL),
(426, 0, 1320247978, NULL, 'proxyhost', '', NULL),
(427, 0, 1320247978, NULL, 'proxyport', '0', NULL),
(428, 0, 1320247978, NULL, 'proxytype', 'HTTP', NULL),
(429, 0, 1320247978, NULL, 'proxyuser', '', NULL),
(430, 0, 1320247978, NULL, 'proxypassword', '', NULL),
(431, 0, 1320247978, NULL, 'proxybypass', 'localhost, 127.0.0.1', NULL),
(432, 0, 1320247978, NULL, 'maintenance_enabled', '0', NULL),
(433, 0, 1320247979, NULL, 'maintenance_message', '', NULL),
(434, 0, 1320247979, NULL, 'deleteunconfirmed', '168', NULL),
(435, 0, 1320247979, NULL, 'deleteincompleteusers', '0', NULL),
(436, 0, 1320247979, NULL, 'logguests', '1', NULL),
(437, 0, 1320247979, NULL, 'loglifetime', '0', NULL),
(438, 0, 1320247979, NULL, 'disablegradehistory', '0', NULL),
(439, 0, 1320247979, NULL, 'gradehistorylifetime', '0', NULL),
(440, 0, 1320247979, NULL, 'numcoursesincombo', '500', NULL),
(441, 0, 1320247979, NULL, 'extramemorylimit', '512M', NULL),
(442, 0, 1320247980, NULL, 'curlcache', '120', NULL),
(443, 0, 1320247980, NULL, 'curltimeoutkbitrate', '56', NULL),
(444, 0, 1320247980, NULL, 'enableglobalsearch', '0', NULL),
(445, 0, 1320247980, NULL, 'enablesafebrowserintegration', '0', NULL),
(446, 0, 1320247980, NULL, 'enablegroupmembersonly', '0', NULL),
(447, 0, 1320247980, NULL, 'debug', '0', NULL),
(448, 0, 1320247980, NULL, 'debugdisplay', '0', NULL),
(449, 0, 1320247980, NULL, 'xmlstrictheaders', '0', NULL),
(450, 0, 1320247981, NULL, 'debugsmtp', '0', NULL),
(451, 0, 1320247981, NULL, 'perfdebug', '7', NULL),
(452, 0, 1320247981, NULL, 'debugstringids', '0', NULL),
(453, 0, 1320247981, NULL, 'debugvalidators', '0', NULL),
(454, 0, 1320247981, NULL, 'debugpageinfo', '0', NULL),
(455, 2, 1320248924, NULL, 'notloggedinroleid', '6', NULL),
(456, 2, 1320248924, NULL, 'guestroleid', '6', NULL),
(457, 2, 1320248924, NULL, 'defaultuserroleid', '7', NULL),
(458, 2, 1320248924, NULL, 'creatornewroleid', '3', NULL),
(459, 2, 1320248924, NULL, 'gradebookroles', '5', NULL),
(460, 2, 1320248924, NULL, 'assignment_maxbytes', '1048576', NULL),
(461, 2, 1320248924, NULL, 'assignment_itemstocount', '1', NULL),
(462, 2, 1320248924, NULL, 'assignment_showrecentsubmissions', '1', NULL),
(463, 2, 1320248925, NULL, 'chat_method', 'ajax', NULL),
(464, 2, 1320248925, NULL, 'chat_refresh_userlist', '10', NULL),
(465, 2, 1320248925, NULL, 'chat_old_ping', '35', NULL),
(466, 2, 1320248925, NULL, 'chat_refresh_room', '5', NULL),
(467, 2, 1320248925, NULL, 'chat_normal_updatemode', 'jsupdate', NULL),
(468, 2, 1320248925, NULL, 'chat_serverhost', 'localhost', NULL),
(469, 2, 1320248925, NULL, 'chat_serverip', '127.0.0.1', NULL),
(470, 2, 1320248925, NULL, 'chat_serverport', '9111', NULL),
(471, 2, 1320248925, NULL, 'chat_servermax', '100', NULL),
(472, 2, 1320248926, NULL, 'data_enablerssfeeds', '0', NULL),
(473, 2, 1320248926, NULL, 'feedback_allowfullanonymous', '0', NULL),
(474, 2, 1320248926, 'folder', 'requiremodintro', '1', NULL),
(475, 2, 1320248926, NULL, 'forum_displaymode', '3', NULL),
(476, 2, 1320248926, NULL, 'forum_replytouser', '1', NULL),
(477, 2, 1320248926, NULL, 'forum_shortpost', '300', NULL),
(478, 2, 1320248926, NULL, 'forum_longpost', '600', NULL),
(479, 2, 1320248926, NULL, 'forum_manydiscussions', '100', NULL),
(480, 2, 1320248927, NULL, 'forum_maxbytes', '512000', NULL),
(481, 2, 1320248927, NULL, 'forum_maxattachments', '9', NULL),
(482, 2, 1320248927, NULL, 'forum_trackreadposts', '1', NULL),
(483, 2, 1320248927, NULL, 'forum_oldpostdays', '14', NULL),
(484, 2, 1320248927, NULL, 'forum_usermarksread', '0', NULL),
(485, 2, 1320248927, NULL, 'forum_cleanreadtime', '2', NULL),
(486, 2, 1320248927, NULL, 'digestmailtime', '17', NULL),
(487, 2, 1320248927, NULL, 'forum_enablerssfeeds', '0', NULL),
(488, 2, 1320248928, NULL, 'forum_enabletimedposts', '0', NULL),
(489, 2, 1320248928, NULL, 'glossary_entbypage', '10', NULL),
(490, 2, 1320248928, NULL, 'glossary_dupentries', '0', NULL),
(491, 2, 1320248928, NULL, 'glossary_allowcomments', '0', NULL),
(492, 2, 1320248928, NULL, 'glossary_linkbydefault', '1', NULL),
(493, 2, 1320248928, NULL, 'glossary_defaultapproval', '1', NULL),
(494, 2, 1320248928, NULL, 'glossary_enablerssfeeds', '0', NULL),
(495, 2, 1320248928, NULL, 'glossary_linkentries', '0', NULL),
(496, 2, 1320248929, NULL, 'glossary_casesensitive', '0', NULL),
(497, 2, 1320248929, NULL, 'glossary_fullmatch', '0', NULL),
(498, 2, 1320248929, 'imscp', 'requiremodintro', '1', NULL),
(499, 2, 1320248929, 'imscp', 'keepold', '1', NULL),
(500, 2, 1320248929, 'imscp', 'keepold_adv', '0', NULL),
(501, 2, 1320248930, NULL, 'lesson_slideshowwidth', '640', NULL),
(502, 2, 1320248930, NULL, 'lesson_slideshowheight', '480', NULL),
(503, 2, 1320248930, NULL, 'lesson_slideshowbgcolor', '#FFFFFF', NULL),
(504, 2, 1320248930, NULL, 'lesson_mediawidth', '640', NULL),
(505, 2, 1320248930, NULL, 'lesson_mediaheight', '480', NULL),
(506, 2, 1320248930, NULL, 'lesson_mediaclose', '0', NULL),
(507, 2, 1320248930, NULL, 'lesson_maxhighscores', '10', NULL),
(508, 2, 1320248930, NULL, 'lesson_maxanswers', '4', NULL),
(509, 2, 1320248931, NULL, 'lesson_defaultnextpage', '0', NULL),
(510, 2, 1320248931, 'page', 'requiremodintro', '1', NULL),
(511, 2, 1320248931, 'page', 'displayoptions', '5', NULL),
(512, 2, 1320248931, 'page', 'printheading', '1', NULL),
(513, 2, 1320248931, 'page', 'printheading_adv', '0', NULL),
(514, 2, 1320248931, 'page', 'printintro', '0', NULL),
(515, 2, 1320248931, 'page', 'printintro_adv', '0', NULL),
(516, 2, 1320248931, 'page', 'display', '5', NULL),
(517, 2, 1320248932, 'page', 'display_adv', '1', NULL),
(518, 2, 1320248932, 'page', 'popupwidth', '620', NULL),
(519, 2, 1320248932, 'page', 'popupwidth_adv', '1', NULL),
(520, 2, 1320248932, 'page', 'popupheight', '450', NULL),
(521, 2, 1320248932, 'page', 'popupheight_adv', '1', NULL),
(522, 2, 1320248932, 'quiz', 'timelimit', '0', NULL),
(523, 2, 1320248932, 'quiz', 'timelimit_adv', '0', NULL),
(524, 2, 1320248933, 'quiz', 'attempts', '0', NULL),
(525, 2, 1320248933, 'quiz', 'attempts_adv', '0', NULL),
(526, 2, 1320248933, 'quiz', 'grademethod', '1', NULL),
(527, 2, 1320248933, 'quiz', 'grademethod_adv', '0', NULL),
(528, 2, 1320248934, 'quiz', 'maximumgrade', '10', NULL),
(529, 2, 1320248934, 'quiz', 'shufflequestions', '0', NULL),
(530, 2, 1320248934, 'quiz', 'shufflequestions_adv', '0', NULL),
(531, 2, 1320248934, 'quiz', 'questionsperpage', '1', NULL),
(532, 2, 1320248934, 'quiz', 'questionsperpage_adv', '0', NULL),
(533, 2, 1320248934, 'quiz', 'shuffleanswers', '1', NULL),
(534, 2, 1320248934, 'quiz', 'shuffleanswers_adv', '0', NULL),
(535, 2, 1320248934, 'quiz', 'preferredbehaviour', 'deferredfeedback', NULL),
(536, 2, 1320248935, 'quiz', 'attemptonlast', '0', NULL),
(537, 2, 1320248935, 'quiz', 'attemptonlast_adv', '1', NULL),
(538, 2, 1320248935, 'quiz', 'reviewattempt', '69904', NULL),
(539, 2, 1320248935, 'quiz', 'reviewcorrectness', '69904', NULL),
(540, 2, 1320248935, 'quiz', 'reviewmarks', '69904', NULL),
(541, 2, 1320248935, 'quiz', 'reviewspecificfeedback', '69904', NULL),
(542, 2, 1320248936, 'quiz', 'reviewgeneralfeedback', '69904', NULL),
(543, 2, 1320248936, 'quiz', 'reviewrightanswer', '69904', NULL),
(544, 2, 1320248936, 'quiz', 'reviewoverallfeedback', '4368', NULL),
(545, 2, 1320248936, 'quiz', 'showuserpicture', '0', NULL),
(546, 2, 1320248936, 'quiz', 'showuserpicture_adv', '0', NULL),
(547, 2, 1320248936, 'quiz', 'decimalpoints', '2', NULL),
(548, 2, 1320248936, 'quiz', 'decimalpoints_adv', '0', NULL),
(549, 2, 1320248936, 'quiz', 'questiondecimalpoints', '-1', NULL),
(550, 2, 1320248936, 'quiz', 'questiondecimalpoints_adv', '0', NULL),
(551, 2, 1320248937, 'quiz', 'showblocks', '0', NULL),
(552, 2, 1320248937, 'quiz', 'showblocks_adv', '1', NULL),
(553, 2, 1320248937, 'quiz', 'password', '', NULL),
(554, 2, 1320248937, 'quiz', 'password_adv', '0', NULL),
(555, 2, 1320248937, 'quiz', 'subnet', '', NULL),
(556, 2, 1320248937, 'quiz', 'subnet_adv', '0', NULL),
(557, 2, 1320248937, 'quiz', 'delay1', '0', NULL),
(558, 2, 1320248937, 'quiz', 'delay1_adv', '0', NULL),
(559, 2, 1320248938, 'quiz', 'delay2', '0', NULL),
(560, 2, 1320248938, 'quiz', 'delay2_adv', '0', NULL),
(561, 2, 1320248938, 'quiz', 'popup', '0', NULL),
(562, 2, 1320248938, 'quiz', 'popup_adv', '1', NULL),
(563, 2, 1320248938, 'resource', 'framesize', '130', NULL),
(564, 2, 1320248938, 'resource', 'requiremodintro', '1', NULL),
(565, 2, 1320248939, 'resource', 'displayoptions', '0,1,4,5,6', NULL),
(566, 2, 1320248939, 'resource', 'printheading', '0', NULL),
(567, 2, 1320248939, 'resource', 'printheading_adv', '0', NULL),
(568, 2, 1320248939, 'resource', 'printintro', '1', NULL),
(569, 2, 1320248939, 'resource', 'printintro_adv', '0', NULL),
(570, 2, 1320248939, 'resource', 'display', '0', NULL),
(571, 2, 1320248939, 'resource', 'display_adv', '0', NULL),
(572, 2, 1320248940, 'resource', 'popupwidth', '620', NULL),
(573, 2, 1320248940, 'resource', 'popupwidth_adv', '1', NULL),
(574, 2, 1320248940, 'resource', 'popupheight', '450', NULL),
(575, 2, 1320248940, 'resource', 'popupheight_adv', '1', NULL),
(576, 2, 1320248940, 'resource', 'filterfiles', '0', NULL),
(577, 2, 1320248941, 'resource', 'filterfiles_adv', '1', NULL),
(578, 2, 1320248941, 'scorm', 'grademethod', '1', NULL),
(579, 2, 1320248941, 'scorm', 'maxgrade', '100', NULL),
(580, 2, 1320248941, 'scorm', 'maxattempts', '0', NULL),
(581, 2, 1320248941, 'scorm', 'displayattemptstatus', '0', NULL),
(582, 2, 1320248941, 'scorm', 'displaycoursestructure', '0', NULL),
(583, 2, 1320248941, 'scorm', 'forcecompleted', '0', NULL),
(584, 2, 1320248942, 'scorm', 'forcenewattempt', '0', NULL),
(585, 2, 1320248942, 'scorm', 'lastattemptlock', '0', NULL),
(586, 2, 1320248942, 'scorm', 'whatgrade', '0', NULL),
(587, 2, 1320248942, 'scorm', 'framewidth', '100', NULL),
(588, 2, 1320248942, 'scorm', 'frameheight', '500', NULL),
(589, 2, 1320248942, 'scorm', 'popup', '0', NULL),
(590, 2, 1320248942, 'scorm', 'resizable', '0', NULL),
(591, 2, 1320248942, 'scorm', 'scrollbars', '0', NULL),
(592, 2, 1320248943, 'scorm', 'directories', '0', NULL),
(593, 2, 1320248943, 'scorm', 'location', '0', NULL),
(594, 2, 1320248943, 'scorm', 'menubar', '0', NULL),
(595, 2, 1320248943, 'scorm', 'toolbar', '0', NULL),
(596, 2, 1320248943, 'scorm', 'status', '0', NULL),
(597, 2, 1320248943, 'scorm', 'skipview', '0', NULL),
(598, 2, 1320248943, 'scorm', 'hidebrowse', '0', NULL),
(599, 2, 1320248943, 'scorm', 'hidetoc', '0', NULL),
(600, 2, 1320248944, 'scorm', 'hidenav', '0', NULL),
(601, 2, 1320248944, 'scorm', 'auto', '0', NULL),
(602, 2, 1320248944, 'scorm', 'updatefreq', '0', NULL),
(603, 2, 1320248944, 'scorm', 'allowtypeexternal', '0', NULL),
(604, 2, 1320248944, 'scorm', 'allowtypelocalsync', '0', NULL),
(605, 2, 1320248944, 'scorm', 'allowtypeimsrepository', '0', NULL),
(606, 2, 1320248945, 'scorm', 'forcejavascript', '1', NULL),
(607, 2, 1320248945, 'scorm', 'allowapidebug', '0', NULL),
(608, 2, 1320248945, 'scorm', 'apidebugmask', '.*', NULL),
(609, 2, 1320248945, 'url', 'framesize', '130', NULL),
(610, 2, 1320248945, 'url', 'requiremodintro', '1', NULL),
(611, 2, 1320248945, 'url', 'secretphrase', '', NULL),
(612, 2, 1320248945, 'url', 'rolesinparams', '0', NULL),
(613, 2, 1320248945, 'url', 'displayoptions', '0,1,5,6', NULL),
(614, 2, 1320248946, 'url', 'printheading', '0', NULL),
(615, 2, 1320248946, 'url', 'printheading_adv', '0', NULL),
(616, 2, 1320248946, 'url', 'printintro', '1', NULL),
(617, 2, 1320248946, 'url', 'printintro_adv', '0', NULL),
(618, 2, 1320248946, 'url', 'display', '0', NULL),
(619, 2, 1320248946, 'url', 'display_adv', '0', NULL),
(620, 2, 1320248946, 'url', 'popupwidth', '620', NULL),
(621, 2, 1320248947, 'url', 'popupwidth_adv', '1', NULL),
(622, 2, 1320248947, 'url', 'popupheight', '450', NULL),
(623, 2, 1320248947, 'url', 'popupheight_adv', '1', NULL),
(624, 2, 1320248947, 'workshop', 'grade', '80', NULL),
(625, 2, 1320248947, 'workshop', 'gradinggrade', '20', NULL),
(626, 2, 1320248947, 'workshop', 'gradedecimals', '0', NULL),
(627, 2, 1320248947, 'workshop', 'maxbytes', '0', NULL),
(628, 2, 1320248947, 'workshop', 'strategy', 'accumulative', NULL),
(629, 2, 1320248948, 'workshop', 'examplesmode', '0', NULL),
(630, 2, 1320248948, 'workshopallocation_random', 'numofreviews', '5', NULL),
(631, 2, 1320248948, 'workshopform_numerrors', 'grade0', 'No', NULL),
(632, 2, 1320248948, 'workshopform_numerrors', 'grade1', 'Yes', NULL),
(633, 2, 1320248948, 'workshopeval_best', 'comparison', '5', NULL),
(634, 2, 1320248948, NULL, 'block_course_list_adminview', 'all', NULL),
(635, 2, 1320248948, NULL, 'block_course_list_hideallcourseslink', '0', NULL),
(636, 2, 1320248948, NULL, 'block_online_users_timetosee', '5', NULL),
(637, 2, 1320248949, NULL, 'block_rss_client_num_entries', '5', NULL),
(638, 2, 1320248949, NULL, 'block_rss_client_timeout', '30', NULL),
(639, 2, 1320248949, NULL, 'block_search_enable_file_indexing', '0', NULL),
(640, 2, 1320248949, NULL, 'block_search_filetypes', 'PDF,TXT,HTML,PPT,XML,DOC,HTM', NULL),
(641, 2, 1320248949, NULL, 'block_search_usemoodleroot', '1', NULL),
(642, 2, 1320248949, NULL, 'block_search_limit_index_body', '0', NULL),
(643, 2, 1320248949, NULL, 'block_search_pdf_to_text_cmd', 'lib/xpdf/linux/pdftotext -enc UTF-8 -eol unix -q', NULL),
(644, 2, 1320248950, NULL, 'block_search_word_to_text_cmd', 'lib/antiword/linux/usr/bin/antiword', NULL),
(645, 2, 1320248950, NULL, 'block_search_word_to_text_env', 'ANTIWORDHOME=/home/menno/php_projects/moodle_21_fresh/public_html/lib/antiword/linux/usr/share/antiword', NULL),
(646, 2, 1320248950, NULL, 'search_in_assignment', '1', NULL),
(647, 2, 1320248950, NULL, 'search_in_chat', '1', NULL),
(648, 2, 1320248950, NULL, 'search_in_data', '1', NULL),
(649, 2, 1320248950, NULL, 'search_in_forum', '1', NULL),
(650, 2, 1320248950, NULL, 'search_in_glossary', '1', NULL),
(651, 2, 1320248951, NULL, 'search_in_label', '1', NULL),
(652, 2, 1320248951, NULL, 'search_in_lesson', '1', NULL),
(653, 2, 1320248951, NULL, 'search_in_resource', '1', NULL),
(654, 2, 1320248951, NULL, 'search_in_wiki', '1', NULL),
(655, 2, 1320248951, 'blocks/section_links', 'numsections1', '22', NULL),
(656, 2, 1320248951, 'blocks/section_links', 'incby1', '2', NULL),
(657, 2, 1320248951, 'blocks/section_links', 'numsections2', '40', NULL),
(658, 2, 1320248951, 'blocks/section_links', 'incby2', '5', NULL),
(659, 2, 1320248952, NULL, 'block_tags_showcoursetags', '0', NULL),
(660, 2, 1320248952, NULL, 'jabberhost', '', NULL),
(661, 2, 1320248952, NULL, 'jabberserver', '', NULL),
(662, 2, 1320248952, NULL, 'jabberusername', '', NULL),
(663, 2, 1320248952, NULL, 'jabberpassword', '', NULL),
(664, 2, 1320248952, NULL, 'jabberport', '5222', NULL),
(665, 2, 1320248952, NULL, 'smtphosts', '', NULL),
(666, 2, 1320248952, NULL, 'smtpuser', '', NULL),
(667, 2, 1320248953, NULL, 'smtppass', '', NULL),
(668, 2, 1320248953, NULL, 'smtpmaxbulk', '1', NULL),
(669, 2, 1320248953, NULL, 'noreplyaddress', 'noreply@localhost', NULL),
(670, 2, 1320248953, NULL, 'sitemailcharset', '0', NULL),
(671, 2, 1320248953, NULL, 'allowusermailcharset', '0', NULL),
(672, 2, 1320248953, NULL, 'mailnewline', 'LF', NULL),
(673, 2, 1320248953, 'enrol_cohort', 'roleid', '5', NULL),
(674, 2, 1320248953, 'enrol_database', 'defaultrole', '5', NULL),
(675, 2, 1320248953, 'enrol_database', 'defaultcategory', '1', NULL),
(676, 2, 1320248954, 'enrol_flatfile', 'map_1', 'manager', NULL),
(677, 2, 1320248954, 'enrol_flatfile', 'map_2', 'coursecreator', NULL),
(678, 2, 1320248954, 'enrol_flatfile', 'map_3', 'editingteacher', NULL),
(679, 2, 1320248954, 'enrol_flatfile', 'map_4', 'teacher', NULL),
(680, 2, 1320248954, 'enrol_flatfile', 'map_5', 'student', NULL),
(681, 2, 1320248954, 'enrol_flatfile', 'map_6', 'guest', NULL),
(682, 2, 1320248954, 'enrol_flatfile', 'map_7', 'user', NULL),
(683, 2, 1320248954, 'enrol_flatfile', 'map_8', 'frontpage', NULL),
(684, 2, 1320248955, 'enrol_imsenterprise', 'imsrolemap01', '5', NULL),
(685, 2, 1320248955, 'enrol_imsenterprise', 'imsrolemap02', '3', NULL),
(686, 2, 1320248955, 'enrol_imsenterprise', 'imsrolemap03', '3', NULL),
(687, 2, 1320248955, 'enrol_imsenterprise', 'imsrolemap04', '5', NULL),
(688, 2, 1320248955, 'enrol_imsenterprise', 'imsrolemap05', '0', NULL),
(689, 2, 1320248956, 'enrol_imsenterprise', 'imsrolemap06', '4', NULL),
(690, 2, 1320248956, 'enrol_imsenterprise', 'imsrolemap07', '0', NULL),
(691, 2, 1320248956, 'enrol_imsenterprise', 'imsrolemap08', '4', NULL),
(692, 2, 1320248956, 'enrol_manual', 'roleid', '5', NULL),
(693, 2, 1320248956, 'enrol_meta', 'nosyncroleids', '', NULL),
(694, 2, 1320248956, 'enrol_mnet', 'roleid', '5', NULL),
(695, 2, 1320248956, 'enrol_mnet', 'roleid_adv', '1', NULL),
(696, 2, 1320248956, 'enrol_paypal', 'roleid', '5', NULL),
(697, 2, 1320248956, 'enrol_self', 'roleid', '5', NULL),
(698, 2, 1320248957, NULL, 'profileroles', '5,4,3', NULL),
(699, 2, 1320248957, NULL, 'defaultallowedmodules', '', NULL),
(700, 2, 1320248957, NULL, 'coursecontact', '3', NULL),
(701, 2, 1320248957, NULL, 'frontpage', '1', NULL),
(702, 2, 1320248957, NULL, 'frontpageloggedin', '1', NULL),
(703, 2, 1320248957, NULL, 'maxcategorydepth', '0', NULL),
(704, 2, 1320248957, NULL, 'commentsperpage', '15', NULL),
(705, 2, 1320248958, NULL, 'coursesperpage', '20', NULL),
(706, 2, 1320248958, NULL, 'defaultfrontpageroleid', '8', NULL),
(707, 2, 1320248958, NULL, 'supportname', 'Admin User', NULL),
(708, 2, 1320248958, NULL, 'supportemail', 'm.deridder@solin.nl', NULL),
(709, 2, 1320249143, NULL, 'registerauth', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_config_plugins`
--

CREATE TABLE IF NOT EXISTS `mdl_config_plugins` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin` varchar(100) NOT NULL DEFAULT 'core',
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_confplug_plunam_uix` (`plugin`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Moodle modules and plugins configuration variables' AUTO_INCREMENT=573 ;

--
-- Dumping data for table `mdl_config_plugins`
--

INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES
(1, 'moodlecourse', 'format', 'weeks'),
(2, 'moodlecourse', 'maxsections', '52'),
(3, 'moodlecourse', 'numsections', '10'),
(4, 'moodlecourse', 'hiddensections', '0'),
(5, 'moodlecourse', 'newsitems', '5'),
(6, 'moodlecourse', 'showgrades', '1'),
(7, 'moodlecourse', 'showreports', '0'),
(8, 'moodlecourse', 'maxbytes', '2097152'),
(9, 'moodlecourse', 'groupmode', '0'),
(10, 'moodlecourse', 'groupmodeforce', '0'),
(11, 'moodlecourse', 'visible', '1'),
(12, 'moodlecourse', 'lang', ''),
(13, 'moodlecourse', 'enablecompletion', '0'),
(14, 'moodlecourse', 'completionstartonenrol', '0'),
(15, 'backup', 'backup_general_users', '1'),
(16, 'backup', 'backup_general_users_locked', '0'),
(17, 'backup', 'backup_general_anonymize', '0'),
(18, 'backup', 'backup_general_anonymize_locked', '0'),
(19, 'backup', 'backup_general_role_assignments', '1'),
(20, 'backup', 'backup_general_role_assignments_locked', '0'),
(21, 'backup', 'backup_general_user_files', '1'),
(22, 'backup', 'backup_general_user_files_locked', '0'),
(23, 'backup', 'backup_general_activities', '1'),
(24, 'backup', 'backup_general_activities_locked', '0'),
(25, 'backup', 'backup_general_blocks', '1'),
(26, 'backup', 'backup_general_blocks_locked', '0'),
(27, 'backup', 'backup_general_filters', '1'),
(28, 'backup', 'backup_general_filters_locked', '0'),
(29, 'backup', 'backup_general_comments', '1'),
(30, 'backup', 'backup_general_comments_locked', '0'),
(31, 'backup', 'backup_general_userscompletion', '1'),
(32, 'backup', 'backup_general_userscompletion_locked', '0'),
(33, 'backup', 'backup_general_logs', '0'),
(34, 'backup', 'backup_general_logs_locked', '0'),
(35, 'backup', 'backup_general_histories', '0'),
(36, 'backup', 'backup_general_histories_locked', '0'),
(37, 'backup', 'backup_auto_active', '0'),
(38, 'backup', 'backup_auto_weekdays', '0000000'),
(39, 'backup', 'backup_auto_hour', '0'),
(40, 'backup', 'backup_auto_minute', '0'),
(41, 'backup', 'backup_auto_storage', '0'),
(42, 'backup', 'backup_auto_destination', ''),
(43, 'backup', 'backup_auto_keep', '1'),
(44, 'backup', 'backup_auto_users', '1'),
(45, 'backup', 'backup_auto_role_assignments', '1'),
(46, 'backup', 'backup_auto_user_files', '1'),
(47, 'backup', 'backup_auto_activities', '1'),
(48, 'backup', 'backup_auto_blocks', '1'),
(49, 'backup', 'backup_auto_filters', '1'),
(50, 'backup', 'backup_auto_comments', '1'),
(51, 'backup', 'backup_auto_userscompletion', '1'),
(52, 'backup', 'backup_auto_logs', '0'),
(53, 'backup', 'backup_auto_histories', '0'),
(54, 'enrol_database', 'dbtype', ''),
(55, 'enrol_database', 'dbhost', 'localhost'),
(56, 'enrol_database', 'dbuser', ''),
(57, 'enrol_database', 'dbpass', ''),
(58, 'enrol_database', 'dbname', ''),
(59, 'enrol_database', 'dbencoding', 'utf-8'),
(60, 'enrol_database', 'dbsetupsql', ''),
(61, 'enrol_database', 'dbsybasequoting', '0'),
(62, 'enrol_database', 'debugdb', '0'),
(63, 'enrol_database', 'localcoursefield', 'idnumber'),
(64, 'enrol_database', 'localuserfield', 'idnumber'),
(65, 'enrol_database', 'localrolefield', 'shortname'),
(66, 'enrol_database', 'remoteenroltable', ''),
(67, 'enrol_database', 'remotecoursefield', ''),
(68, 'enrol_database', 'remoteuserfield', ''),
(69, 'enrol_database', 'remoterolefield', ''),
(70, 'enrol_database', 'ignorehiddencourses', '0'),
(71, 'enrol_database', 'unenrolaction', '0'),
(72, 'enrol_database', 'newcoursetable', ''),
(73, 'enrol_database', 'newcoursefullname', 'fullname'),
(74, 'enrol_database', 'newcourseshortname', 'shortname'),
(75, 'enrol_database', 'newcourseidnumber', 'idnumber'),
(76, 'enrol_database', 'newcoursecategory', ''),
(77, 'enrol_database', 'templatecourse', ''),
(78, 'enrol_flatfile', 'location', ''),
(79, 'enrol_flatfile', 'mailstudents', '0'),
(80, 'enrol_flatfile', 'mailteachers', '0'),
(81, 'enrol_flatfile', 'mailadmins', '0'),
(82, 'enrol_guest', 'requirepassword', '0'),
(83, 'enrol_guest', 'usepasswordpolicy', '0'),
(84, 'enrol_guest', 'showhint', '0'),
(85, 'enrol_guest', 'defaultenrol', '1'),
(86, 'enrol_guest', 'status', '1'),
(87, 'enrol_guest', 'status_adv', '0'),
(88, 'enrol_imsenterprise', 'imsfilelocation', ''),
(89, 'enrol_imsenterprise', 'logtolocation', ''),
(90, 'enrol_imsenterprise', 'mailadmins', '0'),
(91, 'enrol_imsenterprise', 'createnewusers', '0'),
(92, 'enrol_imsenterprise', 'imsdeleteusers', '0'),
(93, 'enrol_imsenterprise', 'fixcaseusernames', '0'),
(94, 'enrol_imsenterprise', 'fixcasepersonalnames', '0'),
(95, 'enrol_imsenterprise', 'imssourcedidfallback', '0'),
(96, 'enrol_imsenterprise', 'truncatecoursecodes', '0'),
(97, 'enrol_imsenterprise', 'createnewcourses', '0'),
(98, 'enrol_imsenterprise', 'createnewcategories', '0'),
(99, 'enrol_imsenterprise', 'imsunenrol', '0'),
(100, 'enrol_imsenterprise', 'imsrestricttarget', ''),
(101, 'enrol_imsenterprise', 'imscapitafix', '0'),
(102, 'enrol_manual', 'defaultenrol', '1'),
(103, 'enrol_manual', 'status', '0'),
(104, 'enrol_manual', 'enrolperiod', '0'),
(105, 'enrol_paypal', 'paypalbusiness', ''),
(106, 'enrol_paypal', 'mailstudents', '0'),
(107, 'enrol_paypal', 'mailteachers', '0'),
(108, 'enrol_paypal', 'mailadmins', '0'),
(109, 'enrol_paypal', 'status', '1'),
(110, 'enrol_paypal', 'cost', '0'),
(111, 'enrol_paypal', 'currency', 'USD'),
(112, 'enrol_paypal', 'enrolperiod', '0'),
(113, 'enrol_self', 'requirepassword', '0'),
(114, 'enrol_self', 'usepasswordpolicy', '0'),
(115, 'enrol_self', 'showhint', '0'),
(116, 'enrol_self', 'defaultenrol', '1'),
(117, 'enrol_self', 'status', '1'),
(118, 'enrol_self', 'groupkey', '0'),
(119, 'enrol_self', 'enrolperiod', '0'),
(120, 'enrol_self', 'longtimenosee', '0'),
(121, 'enrol_self', 'maxenrolled', '0'),
(122, 'enrol_self', 'sendcoursewelcomemessage', '1'),
(123, 'editor_tinymce', 'spellengine', 'GoogleSpell'),
(124, 'filter_urltolink', 'formats', '0'),
(125, 'filter_urltolink', 'embedimages', '1'),
(126, 'filter_emoticon', 'formats', '1,4,0'),
(127, 'theme_arialist', 'logo', ''),
(128, 'theme_arialist', 'tagline', ''),
(129, 'theme_arialist', 'linkcolor', '#f25f0f'),
(130, 'theme_arialist', 'regionwidth', '250'),
(131, 'theme_arialist', 'customcss', ''),
(132, 'theme_brick', 'logo', ''),
(133, 'theme_brick', 'linkcolor', '#06365b'),
(134, 'theme_brick', 'linkhover', '#5487ad'),
(135, 'theme_brick', 'maincolor', '#8e2800'),
(136, 'theme_brick', 'maincolorlink', '#fff0a5'),
(137, 'theme_brick', 'headingcolor', '#5c3500'),
(138, 'theme_formal_white', 'fontsizereference', '13'),
(139, 'theme_formal_white', 'noframe', '0'),
(140, 'theme_formal_white', 'displaylogo', '1'),
(141, 'theme_formal_white', 'logo', ''),
(142, 'theme_formal_white', 'headerbgc', '#E3DFD4'),
(143, 'theme_formal_white', 'blockcontentbgc', '#F6F6F6'),
(144, 'theme_formal_white', 'lblockcolumnbgc', '#E3DFD4'),
(145, 'theme_formal_white', 'rblockcolumnbgc', ''),
(146, 'theme_formal_white', 'blockcolumnwidth', '200'),
(147, 'theme_formal_white', 'footnote', ''),
(148, 'theme_formal_white', 'customcss', ''),
(149, 'theme_fusion', 'linkcolor', '#2d83d5'),
(150, 'theme_fusion', 'tagline', ''),
(151, 'theme_fusion', 'footertext', ''),
(152, 'theme_fusion', 'customcss', ''),
(153, 'theme_magazine', 'background', ''),
(154, 'theme_magazine', 'logo', ''),
(155, 'theme_magazine', 'linkcolor', '#32529a'),
(156, 'theme_magazine', 'linkhover', '#4e2300'),
(157, 'theme_magazine', 'maincolor', '#002f2f'),
(158, 'theme_magazine', 'maincoloraccent', '#092323'),
(159, 'theme_magazine', 'headingcolor', '#4e0000'),
(160, 'theme_magazine', 'blockcolor', '#002f2f'),
(161, 'theme_magazine', 'forumback', '#e6e2af'),
(162, 'theme_nimble', 'tagline', ''),
(163, 'theme_nimble', 'footerline', ''),
(164, 'theme_nimble', 'backgroundcolor', '#454545'),
(165, 'theme_nimble', 'linkcolor', '#2a65b1'),
(166, 'theme_nimble', 'linkhover', '#222222'),
(167, 'theme_nonzero', 'regionprewidth', '200'),
(168, 'theme_nonzero', 'regionpostwidth', '200'),
(169, 'theme_nonzero', 'customcss', ''),
(170, 'theme_overlay', 'linkcolor', '#428ab5'),
(171, 'theme_overlay', 'headercolor', '#2a4c7b'),
(172, 'theme_overlay', 'footertext', ''),
(173, 'theme_overlay', 'customcss', ''),
(174, 'theme_sky_high', 'logo', ''),
(175, 'theme_sky_high', 'regionwidth', '240'),
(176, 'theme_sky_high', 'footnote', ''),
(177, 'theme_sky_high', 'customcss', ''),
(178, 'theme_splash', 'logo', ''),
(179, 'theme_splash', 'tagline', 'Virtual learning center'),
(180, 'theme_splash', 'hide_tagline', '0'),
(181, 'theme_splash', 'footnote', ''),
(182, 'theme_splash', 'customcss', ''),
(183, 'qtype_calculated', 'version', '2011051900'),
(184, 'qtype_calculatedmulti', 'version', '2011051900'),
(185, 'qtype_calculatedsimple', 'version', '2011051900'),
(186, 'qtype_description', 'version', '2011051200'),
(187, 'qtype_essay', 'version', '2011060300'),
(188, 'qtype_match', 'version', '2011051200'),
(189, 'qtype_missingtype', 'version', '2011051200'),
(190, 'qtype_multianswer', 'version', '2011051200'),
(191, 'qtype_multichoice', 'version', '2011051200'),
(192, 'qtype_numerical', 'version', '2011051200'),
(193, 'qtype_random', 'version', '2011051200'),
(194, 'qtype_randomsamatch', 'version', '2010090501'),
(195, 'qtype_shortanswer', 'version', '2011051200'),
(196, 'qtype_truefalse', 'version', '2011051200'),
(205, 'auth_cas', 'version', '2010072600'),
(207, 'auth_db', 'version', '2009112400'),
(209, 'auth_fc', 'version', '2009112400'),
(211, 'auth_imap', 'version', '2009112400'),
(213, 'auth_ldap', 'version', '2010072600'),
(215, 'auth_manual', 'version', '2011022700'),
(216, 'auth_mnet', 'version', '2010071300'),
(218, 'auth_nntp', 'version', '2009112400'),
(220, 'auth_pam', 'version', '2009112400'),
(222, 'auth_pop3', 'version', '2009112400'),
(224, 'auth_radius', 'version', '2009112400'),
(226, 'auth_shibboleth', 'version', '2009112400'),
(228, 'enrol_authorize', 'version', '2010081203'),
(229, 'enrol_category', 'version', '2010061500'),
(231, 'enrol_cohort', 'version', '2010073100'),
(232, 'enrol_database', 'version', '2010073101'),
(234, 'enrol_flatfile', 'version', '2010091400'),
(235, 'enrol_guest', 'version', '2010081800'),
(236, 'enrol_imsenterprise', 'version', '2011013000'),
(238, 'enrol_ldap', 'version', '2010071100'),
(240, 'enrol_manual', 'version', '2010071201'),
(242, 'enrol_meta', 'version', '2010073100'),
(244, 'enrol_mnet', 'version', '2010071701'),
(245, 'enrol_paypal', 'version', '2010073100'),
(246, 'enrol_self', 'version', '2010090501'),
(248, 'message_email', 'version', '2010090501'),
(250, 'message', 'email_provider_mod_assignment_assignment_updates_permitted', 'permitted'),
(251, 'message', 'message_provider_mod_assignment_assignment_updates_loggedin', 'email'),
(252, 'message', 'message_provider_mod_assignment_assignment_updates_loggedoff', 'email'),
(253, 'message', 'email_provider_mod_feedback_submission_permitted', 'permitted'),
(254, 'message', 'message_provider_mod_feedback_submission_loggedin', 'email'),
(255, 'message', 'message_provider_mod_feedback_submission_loggedoff', 'email'),
(256, 'message', 'email_provider_mod_feedback_message_permitted', 'permitted'),
(257, 'message', 'message_provider_mod_feedback_message_loggedin', 'email'),
(258, 'message', 'message_provider_mod_feedback_message_loggedoff', 'email'),
(259, 'message', 'email_provider_mod_forum_posts_permitted', 'permitted'),
(260, 'message', 'message_provider_mod_forum_posts_loggedin', 'email'),
(261, 'message', 'message_provider_mod_forum_posts_loggedoff', 'email'),
(262, 'message', 'email_provider_mod_lesson_graded_essay_permitted', 'permitted'),
(263, 'message', 'message_provider_mod_lesson_graded_essay_loggedin', 'email'),
(264, 'message', 'message_provider_mod_lesson_graded_essay_loggedoff', 'email'),
(265, 'message', 'email_provider_mod_quiz_submission_permitted', 'permitted'),
(266, 'message', 'message_provider_mod_quiz_submission_loggedin', 'email'),
(267, 'message', 'message_provider_mod_quiz_submission_loggedoff', 'email'),
(268, 'message', 'email_provider_mod_quiz_confirmation_permitted', 'permitted'),
(269, 'message', 'message_provider_mod_quiz_confirmation_loggedin', 'email'),
(270, 'message', 'message_provider_mod_quiz_confirmation_loggedoff', 'email'),
(271, 'message', 'email_provider_moodle_notices_permitted', 'permitted'),
(272, 'message', 'message_provider_moodle_notices_loggedin', 'email'),
(273, 'message', 'message_provider_moodle_notices_loggedoff', 'email'),
(274, 'message', 'email_provider_moodle_errors_permitted', 'permitted'),
(275, 'message', 'message_provider_moodle_errors_loggedin', 'email'),
(276, 'message', 'message_provider_moodle_errors_loggedoff', 'email'),
(277, 'message', 'email_provider_moodle_instantmessage_permitted', 'permitted'),
(278, 'message', 'message_provider_moodle_instantmessage_loggedoff', 'popup,email'),
(279, 'message', 'email_provider_moodle_backup_permitted', 'permitted'),
(280, 'message', 'message_provider_moodle_backup_loggedin', 'email'),
(281, 'message', 'message_provider_moodle_backup_loggedoff', 'email'),
(282, 'message', 'email_provider_moodle_courserequested_permitted', 'permitted'),
(283, 'message', 'message_provider_moodle_courserequested_loggedin', 'email'),
(284, 'message', 'message_provider_moodle_courserequested_loggedoff', 'email'),
(285, 'message', 'email_provider_moodle_courserequestapproved_permitted', 'permitted'),
(286, 'message', 'message_provider_moodle_courserequestapproved_loggedin', 'email'),
(287, 'message', 'message_provider_moodle_courserequestapproved_loggedoff', 'email'),
(288, 'message', 'email_provider_moodle_courserequestrejected_permitted', 'permitted'),
(289, 'message', 'message_provider_moodle_courserequestrejected_loggedin', 'email'),
(290, 'message', 'message_provider_moodle_courserequestrejected_loggedoff', 'email'),
(291, 'message_jabber', 'version', '2010090501'),
(293, 'message', 'jabber_provider_mod_assignment_assignment_updates_permitted', 'permitted'),
(294, 'message', 'jabber_provider_mod_feedback_submission_permitted', 'permitted'),
(295, 'message', 'jabber_provider_mod_feedback_message_permitted', 'permitted'),
(296, 'message', 'jabber_provider_mod_forum_posts_permitted', 'permitted'),
(297, 'message', 'jabber_provider_mod_lesson_graded_essay_permitted', 'permitted'),
(298, 'message', 'jabber_provider_mod_quiz_submission_permitted', 'permitted'),
(299, 'message', 'jabber_provider_mod_quiz_confirmation_permitted', 'permitted'),
(300, 'message', 'jabber_provider_moodle_notices_permitted', 'permitted'),
(301, 'message', 'jabber_provider_moodle_errors_permitted', 'permitted'),
(302, 'message', 'jabber_provider_moodle_instantmessage_permitted', 'permitted'),
(303, 'message', 'jabber_provider_moodle_backup_permitted', 'permitted'),
(304, 'message', 'jabber_provider_moodle_courserequested_permitted', 'permitted'),
(305, 'message', 'jabber_provider_moodle_courserequestapproved_permitted', 'permitted'),
(306, 'message', 'jabber_provider_moodle_courserequestrejected_permitted', 'permitted'),
(307, 'message_popup', 'version', '2010090501'),
(309, 'message', 'popup_provider_mod_assignment_assignment_updates_permitted', 'permitted'),
(310, 'message', 'popup_provider_mod_feedback_submission_permitted', 'permitted'),
(311, 'message', 'popup_provider_mod_feedback_message_permitted', 'permitted'),
(312, 'message', 'popup_provider_mod_forum_posts_permitted', 'permitted'),
(313, 'message', 'popup_provider_mod_lesson_graded_essay_permitted', 'permitted'),
(314, 'message', 'popup_provider_mod_quiz_submission_permitted', 'permitted'),
(315, 'message', 'popup_provider_mod_quiz_confirmation_permitted', 'permitted'),
(316, 'message', 'popup_provider_moodle_notices_permitted', 'permitted'),
(317, 'message', 'popup_provider_moodle_errors_permitted', 'permitted'),
(318, 'message', 'popup_provider_moodle_instantmessage_permitted', 'permitted'),
(319, 'message', 'message_provider_moodle_instantmessage_loggedin', 'popup'),
(320, 'message', 'popup_provider_moodle_backup_permitted', 'permitted'),
(321, 'message', 'popup_provider_moodle_courserequested_permitted', 'permitted'),
(322, 'message', 'popup_provider_moodle_courserequestapproved_permitted', 'permitted'),
(323, 'message', 'popup_provider_moodle_courserequestrejected_permitted', 'permitted'),
(326, 'filter_emoticon', 'version', '2010102300'),
(327, 'filter_mediaplugin', 'version', '2011030900'),
(329, 'filter_tex', 'version', '2011031301'),
(331, 'filter_urltolink', 'version', '2010100500'),
(332, 'editor_textarea', 'version', '2010090501'),
(333, 'editor_tinymce', 'version', '2010093000'),
(334, 'report_courseoverview', 'version', '2010090501'),
(335, 'report_customlang', 'version', '2011041900'),
(336, 'report_questioninstances', 'version', '2010090501'),
(337, 'report_security', 'version', '2010090501'),
(338, 'report_unittest', 'version', '2010090501'),
(339, 'report_unsuproles', 'version', '2010071800'),
(340, 'coursereport_completion', 'version', '2010090501'),
(341, 'coursereport_log', 'version', '2010090501'),
(342, 'coursereport_outline', 'version', '2010090501'),
(343, 'coursereport_participation', 'version', '2010090501'),
(344, 'coursereport_progress', 'version', '2010090501'),
(345, 'coursereport_stats', 'version', '2010090501'),
(346, 'gradeexport_ods', 'version', '2010090501'),
(347, 'gradeexport_txt', 'version', '2010090501'),
(348, 'gradeexport_xls', 'version', '2010090501'),
(349, 'gradeexport_xml', 'version', '2010090501'),
(350, 'gradeimport_csv', 'version', '2010090501'),
(351, 'gradeimport_xml', 'version', '2010090501'),
(352, 'gradereport_grader', 'version', '2010090501'),
(353, 'gradereport_outcomes', 'version', '2010090501'),
(354, 'gradereport_overview', 'version', '2010090501'),
(355, 'gradereport_user', 'version', '2010090501'),
(356, 'mnetservice_enrol', 'version', '2010071700'),
(357, 'webservice_amf', 'version', '2009101900'),
(358, 'webservice_rest', 'version', '2009100800'),
(359, 'webservice_soap', 'version', '2009101900'),
(360, 'webservice_xmlrpc', 'version', '2009101900'),
(361, 'repository_alfresco', 'version', '2010050700'),
(362, 'repository_boxnet', 'version', '2009080105'),
(363, 'repository_coursefiles', 'version', '2010083100'),
(364, 'repository_dropbox', 'version', '2010051400'),
(365, 'repository_filesystem', 'version', '2009080102'),
(366, 'repository_flickr', 'version', '2009080102'),
(367, 'repository_flickr_public', 'version', '2009080102'),
(368, 'repository_googledocs', 'version', '2009080102'),
(369, 'repository_local', 'version', '2009080102'),
(371, 'local', 'enablecourseinstances', '0'),
(372, 'local', 'enableuserinstances', '0'),
(373, 'repository_merlot', 'version', '2009111301'),
(374, 'repository_picasa', 'version', '2009080102'),
(375, 'repository_recent', 'version', '2010042202'),
(377, 'recent', 'enablecourseinstances', '0'),
(378, 'recent', 'enableuserinstances', '0'),
(379, 'repository_s3', 'version', '2009080102'),
(380, 'repository_upload', 'version', '2009080102'),
(382, 'upload', 'enablecourseinstances', '0'),
(383, 'upload', 'enableuserinstances', '0'),
(384, 'repository_url', 'version', '2009080102'),
(385, 'repository_user', 'version', '2010052700'),
(387, 'user', 'enablecourseinstances', '0'),
(388, 'user', 'enableuserinstances', '0'),
(389, 'repository_webdav', 'version', '2009080102'),
(390, 'repository_wikimedia', 'version', '2009080102'),
(391, 'repository_youtube', 'version', '2009080102'),
(392, 'portfolio_boxnet', 'version', '2010090501'),
(393, 'portfolio_download', 'version', '2010090501'),
(394, 'portfolio_flickr', 'version', '2010090501'),
(395, 'portfolio_googledocs', 'version', '2010090501'),
(396, 'portfolio_mahara', 'version', '2010090501'),
(397, 'portfolio_picasa', 'version', '2010090501'),
(398, 'theme_formal_white', 'version', '2011061301'),
(400, 'assignment_online', 'version', '2010090501'),
(401, 'quiz_grading', 'version', '2011051200'),
(402, 'quiz_overview', 'version', '2011051200'),
(403, 'quiz_responses', 'version', '2011051200'),
(404, 'quiz_statistics', 'version', '2011062600'),
(406, 'workshopform_accumulative', 'version', '2010091700'),
(408, 'workshopform_comments', 'version', '2010091700'),
(410, 'workshopform_numerrors', 'version', '2010091700'),
(412, 'workshopform_rubric', 'version', '2010091700'),
(414, 'workshopeval_best', 'version', '2010090501'),
(415, 'local_qeupgradehelper', 'version', '2011040400'),
(416, 'folder', 'requiremodintro', '1'),
(417, 'imscp', 'requiremodintro', '1'),
(418, 'imscp', 'keepold', '1'),
(419, 'imscp', 'keepold_adv', '0'),
(420, 'page', 'requiremodintro', '1'),
(421, 'page', 'displayoptions', '5'),
(422, 'page', 'printheading', '1'),
(423, 'page', 'printheading_adv', '0'),
(424, 'page', 'printintro', '0'),
(425, 'page', 'printintro_adv', '0'),
(426, 'page', 'display', '5'),
(427, 'page', 'display_adv', '1'),
(428, 'page', 'popupwidth', '620'),
(429, 'page', 'popupwidth_adv', '1'),
(430, 'page', 'popupheight', '450'),
(431, 'page', 'popupheight_adv', '1'),
(432, 'quiz', 'timelimit', '0'),
(433, 'quiz', 'timelimit_adv', '0'),
(434, 'quiz', 'attempts', '0'),
(435, 'quiz', 'attempts_adv', '0'),
(436, 'quiz', 'grademethod', '1'),
(437, 'quiz', 'grademethod_adv', '0'),
(438, 'quiz', 'maximumgrade', '10'),
(439, 'quiz', 'shufflequestions', '0'),
(440, 'quiz', 'shufflequestions_adv', '0'),
(441, 'quiz', 'questionsperpage', '1'),
(442, 'quiz', 'questionsperpage_adv', '0'),
(443, 'quiz', 'shuffleanswers', '1'),
(444, 'quiz', 'shuffleanswers_adv', '0'),
(445, 'quiz', 'preferredbehaviour', 'deferredfeedback'),
(446, 'quiz', 'attemptonlast', '0'),
(447, 'quiz', 'attemptonlast_adv', '1'),
(448, 'quiz', 'reviewattempt', '69904'),
(449, 'quiz', 'reviewcorrectness', '69904'),
(450, 'quiz', 'reviewmarks', '69904'),
(451, 'quiz', 'reviewspecificfeedback', '69904'),
(452, 'quiz', 'reviewgeneralfeedback', '69904'),
(453, 'quiz', 'reviewrightanswer', '69904'),
(454, 'quiz', 'reviewoverallfeedback', '4368'),
(455, 'quiz', 'showuserpicture', '0'),
(456, 'quiz', 'showuserpicture_adv', '0'),
(457, 'quiz', 'decimalpoints', '2'),
(458, 'quiz', 'decimalpoints_adv', '0'),
(459, 'quiz', 'questiondecimalpoints', '-1'),
(460, 'quiz', 'questiondecimalpoints_adv', '0'),
(461, 'quiz', 'showblocks', '0'),
(462, 'quiz', 'showblocks_adv', '1'),
(463, 'quiz', 'password', ''),
(464, 'quiz', 'password_adv', '0'),
(465, 'quiz', 'subnet', ''),
(466, 'quiz', 'subnet_adv', '0'),
(467, 'quiz', 'delay1', '0'),
(468, 'quiz', 'delay1_adv', '0'),
(469, 'quiz', 'delay2', '0'),
(470, 'quiz', 'delay2_adv', '0'),
(471, 'quiz', 'popup', '0'),
(472, 'quiz', 'popup_adv', '1'),
(473, 'resource', 'framesize', '130'),
(474, 'resource', 'requiremodintro', '1'),
(475, 'resource', 'displayoptions', '0,1,4,5,6'),
(476, 'resource', 'printheading', '0'),
(477, 'resource', 'printheading_adv', '0'),
(478, 'resource', 'printintro', '1'),
(479, 'resource', 'printintro_adv', '0'),
(480, 'resource', 'display', '0'),
(481, 'resource', 'display_adv', '0'),
(482, 'resource', 'popupwidth', '620'),
(483, 'resource', 'popupwidth_adv', '1'),
(484, 'resource', 'popupheight', '450'),
(485, 'resource', 'popupheight_adv', '1'),
(486, 'resource', 'filterfiles', '0'),
(487, 'resource', 'filterfiles_adv', '1'),
(488, 'scorm', 'grademethod', '1'),
(489, 'scorm', 'maxgrade', '100'),
(490, 'scorm', 'maxattempts', '0'),
(491, 'scorm', 'displayattemptstatus', '0'),
(492, 'scorm', 'displaycoursestructure', '0'),
(493, 'scorm', 'forcecompleted', '0'),
(494, 'scorm', 'forcenewattempt', '0'),
(495, 'scorm', 'lastattemptlock', '0'),
(496, 'scorm', 'whatgrade', '0'),
(497, 'scorm', 'framewidth', '100'),
(498, 'scorm', 'frameheight', '500'),
(499, 'scorm', 'popup', '0'),
(500, 'scorm', 'resizable', '0'),
(501, 'scorm', 'scrollbars', '0'),
(502, 'scorm', 'directories', '0'),
(503, 'scorm', 'location', '0'),
(504, 'scorm', 'menubar', '0'),
(505, 'scorm', 'toolbar', '0'),
(506, 'scorm', 'status', '0'),
(507, 'scorm', 'skipview', '0'),
(508, 'scorm', 'hidebrowse', '0'),
(509, 'scorm', 'hidetoc', '0'),
(510, 'scorm', 'hidenav', '0'),
(511, 'scorm', 'auto', '0'),
(512, 'scorm', 'updatefreq', '0'),
(513, 'scorm', 'allowtypeexternal', '0'),
(514, 'scorm', 'allowtypelocalsync', '0'),
(515, 'scorm', 'allowtypeimsrepository', '0'),
(516, 'scorm', 'forcejavascript', '1'),
(517, 'scorm', 'allowapidebug', '0'),
(518, 'scorm', 'apidebugmask', '.*'),
(519, 'url', 'framesize', '130'),
(520, 'url', 'requiremodintro', '1'),
(521, 'url', 'secretphrase', ''),
(522, 'url', 'rolesinparams', '0'),
(523, 'url', 'displayoptions', '0,1,5,6'),
(524, 'url', 'printheading', '0'),
(525, 'url', 'printheading_adv', '0'),
(526, 'url', 'printintro', '1'),
(527, 'url', 'printintro_adv', '0'),
(528, 'url', 'display', '0'),
(529, 'url', 'display_adv', '0'),
(530, 'url', 'popupwidth', '620'),
(531, 'url', 'popupwidth_adv', '1'),
(532, 'url', 'popupheight', '450'),
(533, 'url', 'popupheight_adv', '1'),
(534, 'workshop', 'grade', '80'),
(535, 'workshop', 'gradinggrade', '20'),
(536, 'workshop', 'gradedecimals', '0'),
(537, 'workshop', 'maxbytes', '0'),
(538, 'workshop', 'strategy', 'accumulative'),
(539, 'workshop', 'examplesmode', '0'),
(540, 'workshopallocation_random', 'numofreviews', '5'),
(541, 'workshopform_numerrors', 'grade0', 'No'),
(542, 'workshopform_numerrors', 'grade1', 'Yes'),
(543, 'workshopeval_best', 'comparison', '5'),
(544, 'blocks/section_links', 'numsections1', '22'),
(545, 'blocks/section_links', 'incby1', '2'),
(546, 'blocks/section_links', 'numsections2', '40'),
(547, 'blocks/section_links', 'incby2', '5'),
(548, 'enrol_cohort', 'roleid', '5'),
(549, 'enrol_database', 'defaultrole', '5'),
(550, 'enrol_database', 'defaultcategory', '1'),
(551, 'enrol_flatfile', 'map_1', 'manager'),
(552, 'enrol_flatfile', 'map_2', 'coursecreator'),
(553, 'enrol_flatfile', 'map_3', 'editingteacher'),
(554, 'enrol_flatfile', 'map_4', 'teacher'),
(555, 'enrol_flatfile', 'map_5', 'student'),
(556, 'enrol_flatfile', 'map_6', 'guest'),
(557, 'enrol_flatfile', 'map_7', 'user'),
(558, 'enrol_flatfile', 'map_8', 'frontpage'),
(559, 'enrol_imsenterprise', 'imsrolemap01', '5'),
(560, 'enrol_imsenterprise', 'imsrolemap02', '3'),
(561, 'enrol_imsenterprise', 'imsrolemap03', '3'),
(562, 'enrol_imsenterprise', 'imsrolemap04', '5'),
(563, 'enrol_imsenterprise', 'imsrolemap05', '0'),
(564, 'enrol_imsenterprise', 'imsrolemap06', '4'),
(565, 'enrol_imsenterprise', 'imsrolemap07', '0'),
(566, 'enrol_imsenterprise', 'imsrolemap08', '4'),
(567, 'enrol_manual', 'roleid', '5'),
(568, 'enrol_meta', 'nosyncroleids', ''),
(569, 'enrol_mnet', 'roleid', '5'),
(570, 'enrol_mnet', 'roleid_adv', '1'),
(571, 'enrol_paypal', 'roleid', '5'),
(572, 'enrol_self', 'roleid', '5');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_context`
--

CREATE TABLE IF NOT EXISTS `mdl_context` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextlevel` bigint(10) unsigned NOT NULL DEFAULT '0',
  `instanceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  `depth` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_cont_conins_uix` (`contextlevel`,`instanceid`),
  KEY `mdl_cont_ins_ix` (`instanceid`),
  KEY `mdl_cont_pat_ix` (`path`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='one of these must be set' AUTO_INCREMENT=14 ;

--
-- Dumping data for table `mdl_context`
--

INSERT INTO `mdl_context` (`id`, `contextlevel`, `instanceid`, `path`, `depth`) VALUES
(1, 10, 0, '/1', 1),
(2, 50, 1, '/1/2', 2),
(3, 40, 1, '/1/3', 2),
(4, 80, 1, '/1/2/4', 3),
(5, 80, 2, '/1/2/5', 3),
(6, 80, 3, '/1/2/6', 3),
(7, 80, 4, '/1/7', 2),
(8, 80, 5, '/1/8', 2),
(9, 80, 6, '/1/9', 2),
(10, 80, 7, '/1/10', 2),
(11, 80, 8, '/1/11', 2),
(12, 80, 9, '/1/12', 2),
(13, 30, 2, '/1/13', 2);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_context_temp`
--

CREATE TABLE IF NOT EXISTS `mdl_context_temp` (
  `id` bigint(10) unsigned NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '',
  `depth` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used by build_context_path() in upgrade and cron to keep con';

--
-- Dumping data for table `mdl_context_temp`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course`
--

CREATE TABLE IF NOT EXISTS `mdl_course` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `summary` text,
  `summaryformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `format` varchar(10) NOT NULL DEFAULT 'topics',
  `showgrades` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `modinfo` longtext,
  `newsitems` mediumint(5) unsigned NOT NULL DEFAULT '1',
  `startdate` bigint(10) unsigned NOT NULL DEFAULT '0',
  `numsections` mediumint(5) unsigned NOT NULL DEFAULT '1',
  `marker` bigint(10) unsigned NOT NULL DEFAULT '0',
  `maxbytes` bigint(10) unsigned NOT NULL DEFAULT '0',
  `legacyfiles` smallint(4) unsigned NOT NULL DEFAULT '0',
  `showreports` smallint(4) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `visibleold` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `hiddensections` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `groupmode` smallint(4) unsigned NOT NULL DEFAULT '0',
  `groupmodeforce` smallint(4) unsigned NOT NULL DEFAULT '0',
  `defaultgroupingid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(30) NOT NULL DEFAULT '',
  `theme` varchar(50) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `requested` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `restrictmodules` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `enablecompletion` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completionstartonenrol` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completionnotify` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_cour_cat_ix` (`category`),
  KEY `mdl_cour_idn_ix` (`idnumber`),
  KEY `mdl_cour_sho_ix` (`shortname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Central course table' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `mdl_course`
--

INSERT INTO `mdl_course` (`id`, `category`, `sortorder`, `fullname`, `shortname`, `idnumber`, `summary`, `summaryformat`, `format`, `showgrades`, `modinfo`, `newsitems`, `startdate`, `numsections`, `marker`, `maxbytes`, `legacyfiles`, `showreports`, `visible`, `visibleold`, `hiddensections`, `groupmode`, `groupmodeforce`, `defaultgroupingid`, `lang`, `theme`, `timecreated`, `timemodified`, `requested`, `restrictmodules`, `enablecompletion`, `completionstartonenrol`, `completionnotify`) VALUES
(1, 0, 1, 'Moodle 2.1 Fresh', 'moodle21_fresh', '', '', 0, 'site', 1, 'a:0:{}', 3, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, '', '', 1320247875, 1320249143, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_allowed_modules`
--

CREATE TABLE IF NOT EXISTS `mdl_course_allowed_modules` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `module` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courallomodu_cou_ix` (`course`),
  KEY `mdl_courallomodu_mod_ix` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='allowed modules foreach course' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_allowed_modules`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_categories`
--

CREATE TABLE IF NOT EXISTS `mdl_course_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `coursecount` bigint(10) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `visibleold` tinyint(1) NOT NULL DEFAULT '1',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `depth` bigint(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `theme` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courcate_par_ix` (`parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Course categories' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `mdl_course_categories`
--

INSERT INTO `mdl_course_categories` (`id`, `name`, `description`, `descriptionformat`, `parent`, `sortorder`, `coursecount`, `visible`, `visibleold`, `timemodified`, `depth`, `path`, `theme`) VALUES
(1, 'Miscellaneous', NULL, 0, 0, 10000, 0, 1, 1, 1320247876, 1, '/1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_completions`
--

CREATE TABLE IF NOT EXISTS `mdl_course_completions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(1) unsigned DEFAULT NULL,
  `timenotified` bigint(10) unsigned DEFAULT NULL,
  `timeenrolled` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timestarted` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecompleted` bigint(10) unsigned DEFAULT NULL,
  `reaggregate` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courcomp_use_ix` (`userid`),
  KEY `mdl_courcomp_cou_ix` (`course`),
  KEY `mdl_courcomp_tim_ix` (`timecompleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion records' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_completions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_completion_aggr_methd`
--

CREATE TABLE IF NOT EXISTS `mdl_course_completion_aggr_methd` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `criteriatype` bigint(20) unsigned DEFAULT NULL,
  `method` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `value` decimal(10,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courcompaggrmeth_cou_ix` (`course`),
  KEY `mdl_courcompaggrmeth_cri_ix` (`criteriatype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion aggregation methods for criteria' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_completion_aggr_methd`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_completion_criteria`
--

CREATE TABLE IF NOT EXISTS `mdl_course_completion_criteria` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `criteriatype` bigint(20) unsigned NOT NULL DEFAULT '0',
  `module` varchar(100) DEFAULT NULL,
  `moduleinstance` bigint(10) unsigned DEFAULT NULL,
  `courseinstance` bigint(10) unsigned DEFAULT NULL,
  `enrolperiod` bigint(10) unsigned DEFAULT NULL,
  `timeend` bigint(10) unsigned DEFAULT NULL,
  `gradepass` decimal(10,5) DEFAULT NULL,
  `role` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courcompcrit_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion criteria' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_completion_criteria`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_completion_crit_compl`
--

CREATE TABLE IF NOT EXISTS `mdl_course_completion_crit_compl` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `criteriaid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `gradefinal` decimal(10,5) DEFAULT NULL,
  `unenroled` bigint(10) unsigned DEFAULT NULL,
  `deleted` tinyint(1) unsigned DEFAULT NULL,
  `timecompleted` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courcompcritcomp_use_ix` (`userid`),
  KEY `mdl_courcompcritcomp_cou_ix` (`course`),
  KEY `mdl_courcompcritcomp_cri_ix` (`criteriaid`),
  KEY `mdl_courcompcritcomp_tim_ix` (`timecompleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion user records' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_completion_crit_compl`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_completion_notify`
--

CREATE TABLE IF NOT EXISTS `mdl_course_completion_notify` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `role` bigint(10) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `timesent` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courcompnoti_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion notification emails' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_completion_notify`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_display`
--

CREATE TABLE IF NOT EXISTS `mdl_course_display` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `display` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courdisp_couuse_ix` (`course`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores info about how to display the course' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_display`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_modules`
--

CREATE TABLE IF NOT EXISTS `mdl_course_modules` (
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
  `completion` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completiongradeitemnumber` bigint(10) unsigned DEFAULT NULL,
  `completionview` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completionexpected` bigint(10) unsigned NOT NULL DEFAULT '0',
  `availablefrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `availableuntil` bigint(10) unsigned NOT NULL DEFAULT '0',
  `showavailability` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_courmodu_vis_ix` (`visible`),
  KEY `mdl_courmodu_cou_ix` (`course`),
  KEY `mdl_courmodu_mod_ix` (`module`),
  KEY `mdl_courmodu_ins_ix` (`instance`),
  KEY `mdl_courmodu_idncou_ix` (`idnumber`,`course`),
  KEY `mdl_courmodu_gro_ix` (`groupingid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='course_modules table retrofitted from MySQL' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_modules`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_modules_availability`
--

CREATE TABLE IF NOT EXISTS `mdl_course_modules_availability` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `coursemoduleid` bigint(10) unsigned NOT NULL,
  `sourcecmid` bigint(10) unsigned DEFAULT NULL,
  `requiredcompletion` tinyint(1) unsigned DEFAULT NULL,
  `gradeitemid` bigint(10) unsigned DEFAULT NULL,
  `grademin` decimal(10,5) DEFAULT NULL,
  `grademax` decimal(10,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courmoduavai_cou_ix` (`coursemoduleid`),
  KEY `mdl_courmoduavai_sou_ix` (`sourcecmid`),
  KEY `mdl_courmoduavai_gra_ix` (`gradeitemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table stores conditions that affect whether a module/activit' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_modules_availability`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_modules_completion`
--

CREATE TABLE IF NOT EXISTS `mdl_course_modules_completion` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `coursemoduleid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `completionstate` tinyint(1) unsigned NOT NULL,
  `viewed` tinyint(1) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_courmoducomp_usecou_uix` (`userid`,`coursemoduleid`),
  KEY `mdl_courmoducomp_cou_ix` (`coursemoduleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the completion state (completed or not completed, etc' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_modules_completion`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_published`
--

CREATE TABLE IF NOT EXISTS `mdl_course_published` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `huburl` varchar(255) DEFAULT NULL,
  `courseid` bigint(10) unsigned NOT NULL,
  `timepublished` bigint(10) unsigned NOT NULL,
  `enrollable` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `hubcourseid` bigint(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned DEFAULT '0',
  `timechecked` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about how and when an local courses were publish' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_published`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_request`
--

CREATE TABLE IF NOT EXISTS `mdl_course_request` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `summary` text NOT NULL,
  `summaryformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `reason` text NOT NULL,
  `requester` bigint(10) unsigned NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_courrequ_sho_ix` (`shortname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='course requests' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_request`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_course_sections`
--

CREATE TABLE IF NOT EXISTS `mdl_course_sections` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `section` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `summary` text,
  `summaryformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sequence` text,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_coursect_cousec_ix` (`course`,`section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='to define the sections for each course' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_course_sections`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_data`
--

CREATE TABLE IF NOT EXISTS `mdl_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
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
  `assesstimestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `defaultsort` bigint(10) unsigned NOT NULL DEFAULT '0',
  `defaultsortdir` smallint(4) unsigned NOT NULL DEFAULT '0',
  `editany` smallint(4) unsigned NOT NULL DEFAULT '0',
  `notification` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_data_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all database activities' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_data_content`
--

CREATE TABLE IF NOT EXISTS `mdl_data_content` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='the content introduced in each record/fields' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_data_content`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_data_fields`
--

CREATE TABLE IF NOT EXISTS `mdl_data_fields` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='every field available' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_data_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_data_records`
--

CREATE TABLE IF NOT EXISTS `mdl_data_records` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `dataid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `approved` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_datareco_dat_ix` (`dataid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='every record introduced' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_data_records`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_enrol`
--

CREATE TABLE IF NOT EXISTS `mdl_enrol` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `enrol` varchar(20) NOT NULL DEFAULT '',
  `status` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL,
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `enrolperiod` bigint(10) unsigned DEFAULT '0',
  `enrolstartdate` bigint(10) unsigned DEFAULT '0',
  `enrolenddate` bigint(10) unsigned DEFAULT '0',
  `expirynotify` tinyint(1) unsigned DEFAULT '0',
  `expirythreshold` bigint(10) unsigned DEFAULT '0',
  `notifyall` tinyint(1) unsigned DEFAULT '0',
  `password` varchar(50) DEFAULT NULL,
  `cost` varchar(20) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `roleid` bigint(10) unsigned DEFAULT '0',
  `customint1` bigint(10) DEFAULT NULL,
  `customint2` bigint(10) DEFAULT NULL,
  `customint3` bigint(10) DEFAULT NULL,
  `customint4` bigint(10) DEFAULT NULL,
  `customchar1` varchar(255) DEFAULT NULL,
  `customchar2` varchar(255) DEFAULT NULL,
  `customdec1` decimal(12,7) DEFAULT NULL,
  `customdec2` decimal(12,7) DEFAULT NULL,
  `customtext1` longtext,
  `customtext2` longtext,
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_enro_enr_ix` (`enrol`),
  KEY `mdl_enro_cou_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of enrolment plugins used in courses, fields marke' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_enrol`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_enrol_authorize`
--

CREATE TABLE IF NOT EXISTS `mdl_enrol_authorize` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `paymentmethod` varchar(6) NOT NULL DEFAULT 'cc',
  `refundinfo` smallint(4) unsigned NOT NULL DEFAULT '0',
  `ccname` varchar(255) NOT NULL DEFAULT '',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `instanceid` bigint(10) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds all known information about authorize.net transactions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_enrol_authorize`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_enrol_authorize_refunds`
--

CREATE TABLE IF NOT EXISTS `mdl_enrol_authorize_refunds` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `amount` varchar(10) NOT NULL DEFAULT '',
  `transid` bigint(20) unsigned DEFAULT '0',
  `settletime` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_enroauthrefu_tra_ix` (`transid`),
  KEY `mdl_enroauthrefu_ord_ix` (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Authorize.net refunds' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_enrol_authorize_refunds`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_enrol_flatfile`
--

CREATE TABLE IF NOT EXISTS `mdl_enrol_flatfile` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(30) NOT NULL DEFAULT '',
  `roleid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `courseid` bigint(10) unsigned NOT NULL,
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_enroflat_cou_ix` (`courseid`),
  KEY `mdl_enroflat_use_ix` (`userid`),
  KEY `mdl_enroflat_rol_ix` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='enrol_flatfile table retrofitted from MySQL' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_enrol_flatfile`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_enrol_paypal`
--

CREATE TABLE IF NOT EXISTS `mdl_enrol_paypal` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `business` varchar(255) NOT NULL DEFAULT '',
  `receiver_email` varchar(255) NOT NULL DEFAULT '',
  `receiver_id` varchar(255) NOT NULL DEFAULT '',
  `item_name` varchar(255) NOT NULL DEFAULT '',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `instanceid` bigint(10) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds all known information about PayPal transactions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_enrol_paypal`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_event`
--

CREATE TABLE IF NOT EXISTS `mdl_event` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For everything with a time associated to it' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_event`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_events_handlers`
--

CREATE TABLE IF NOT EXISTS `mdl_events_handlers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventname` varchar(166) NOT NULL DEFAULT '',
  `component` varchar(166) NOT NULL DEFAULT '',
  `handlerfile` varchar(255) NOT NULL DEFAULT '',
  `handlerfunction` mediumtext,
  `schedule` varchar(255) DEFAULT NULL,
  `status` bigint(10) unsigned NOT NULL DEFAULT '0',
  `internal` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_evenhand_evecom_uix` (`eventname`,`component`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table is for storing which components requests what typ' AUTO_INCREMENT=18 ;

--
-- Dumping data for table `mdl_events_handlers`
--

INSERT INTO `mdl_events_handlers` (`id`, `eventname`, `component`, `handlerfile`, `handlerfunction`, `schedule`, `status`, `internal`) VALUES
(1, 'portfolio_send', 'moodle', '/lib/portfolio.php', 's:22:"portfolio_handle_event";', 'cron', 0, 0),
(2, 'user_logout', 'mod_chat', '/mod/chat/lib.php', 's:16:"chat_user_logout";', 'instant', 0, 1),
(3, 'user_enrolled', 'mod_forum', '/mod/forum/lib.php', 's:19:"forum_user_enrolled";', 'instant', 0, 1),
(4, 'user_unenrolled', 'mod_forum', '/mod/forum/lib.php', 's:21:"forum_user_unenrolled";', 'instant', 0, 1),
(5, 'quiz_attempt_submitted', 'mod_quiz', '/mod/quiz/locallib.php', 's:30:"quiz_attempt_submitted_handler";', 'cron', 0, 1),
(6, 'role_assigned', 'enrol_category', '/enrol/category/locallib.php', 'a:2:{i:0;s:22:"enrol_category_handler";i:1;s:13:"role_assigned";}', 'instant', 0, 1),
(7, 'role_unassigned', 'enrol_category', '/enrol/category/locallib.php', 'a:2:{i:0;s:22:"enrol_category_handler";i:1;s:15:"role_unassigned";}', 'instant', 0, 1),
(8, 'cohort_member_added', 'enrol_cohort', '/enrol/cohort/locallib.php', 'a:2:{i:0;s:20:"enrol_cohort_handler";i:1;s:12:"member_added";}', 'instant', 0, 1),
(9, 'cohort_member_removed', 'enrol_cohort', '/enrol/cohort/locallib.php', 'a:2:{i:0;s:20:"enrol_cohort_handler";i:1;s:14:"member_removed";}', 'instant', 0, 1),
(10, 'cohort_deleted', 'enrol_cohort', '/enrol/cohort/locallib.php', 'a:2:{i:0;s:20:"enrol_cohort_handler";i:1;s:7:"deleted";}', 'instant', 0, 1),
(11, 'role_assigned', 'enrol_meta', '/enrol/meta/locallib.php', 'a:2:{i:0;s:18:"enrol_meta_handler";i:1;s:13:"role_assigned";}', 'instant', 0, 1),
(12, 'role_unassigned', 'enrol_meta', '/enrol/meta/locallib.php', 'a:2:{i:0;s:18:"enrol_meta_handler";i:1;s:15:"role_unassigned";}', 'instant', 0, 1),
(13, 'user_enrolled', 'enrol_meta', '/enrol/meta/locallib.php', 'a:2:{i:0;s:18:"enrol_meta_handler";i:1;s:13:"user_enrolled";}', 'instant', 0, 1),
(14, 'user_unenrolled', 'enrol_meta', '/enrol/meta/locallib.php', 'a:2:{i:0;s:18:"enrol_meta_handler";i:1;s:15:"user_unenrolled";}', 'instant', 0, 1),
(15, 'course_deleted', 'enrol_meta', '/enrol/meta/locallib.php', 'a:2:{i:0;s:18:"enrol_meta_handler";i:1;s:14:"course_deleted";}', 'instant', 0, 1),
(16, 'user_deleted', 'portfolio_googledocs', '/portfolio/googledocs/lib.php', 's:33:"portfolio_googledocs_user_deleted";', 'cron', 0, 0),
(17, 'user_deleted', 'portfolio_picasa', '/portfolio/picasa/lib.php', 's:29:"portfolio_picasa_user_deleted";', 'cron', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_events_queue`
--

CREATE TABLE IF NOT EXISTS `mdl_events_queue` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventdata` longtext NOT NULL,
  `stackdump` mediumtext,
  `userid` bigint(10) unsigned DEFAULT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_evenqueu_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is for storing queued events. It stores only one ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_events_queue`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_events_queue_handlers`
--

CREATE TABLE IF NOT EXISTS `mdl_events_queue_handlers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `queuedeventid` bigint(10) unsigned NOT NULL,
  `handlerid` bigint(10) unsigned NOT NULL,
  `status` bigint(10) DEFAULT NULL,
  `errormessage` mediumtext,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_evenqueuhand_que_ix` (`queuedeventid`),
  KEY `mdl_evenqueuhand_han_ix` (`handlerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This is the list of queued handlers for processing. The even' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_events_queue_handlers`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_external_functions`
--

CREATE TABLE IF NOT EXISTS `mdl_external_functions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `classname` varchar(100) NOT NULL DEFAULT '',
  `methodname` varchar(100) NOT NULL DEFAULT '',
  `classpath` varchar(255) DEFAULT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `capabilities` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_extefunc_nam_uix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='list of all external functions' AUTO_INCREMENT=26 ;

--
-- Dumping data for table `mdl_external_functions`
--

INSERT INTO `mdl_external_functions` (`id`, `name`, `classname`, `methodname`, `classpath`, `component`, `capabilities`) VALUES
(1, 'moodle_group_create_groups', 'moodle_group_external', 'create_groups', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(2, 'moodle_group_get_groups', 'moodle_group_external', 'get_groups', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(3, 'moodle_group_get_course_groups', 'moodle_group_external', 'get_course_groups', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(4, 'moodle_group_delete_groups', 'moodle_group_external', 'delete_groups', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(5, 'moodle_group_get_groupmembers', 'moodle_group_external', 'get_groupmembers', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(6, 'moodle_group_add_groupmembers', 'moodle_group_external', 'add_groupmembers', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(7, 'moodle_group_delete_groupmembers', 'moodle_group_external', 'delete_groupmembers', 'group/externallib.php', 'moodle', 'moodle/course:managegroups'),
(8, 'moodle_file_get_files', 'moodle_file_external', 'get_files', 'files/externallib.php', 'moodle', ''),
(9, 'moodle_file_upload', 'moodle_file_external', 'upload', 'files/externallib.php', 'moodle', ''),
(10, 'moodle_user_create_users', 'moodle_user_external', 'create_users', 'user/externallib.php', 'moodle', 'moodle/user:create'),
(11, 'moodle_user_get_users_by_id', 'moodle_user_external', 'get_users_by_id', 'user/externallib.php', 'moodle', 'moodle/user:viewdetails, moodle/user:viewhiddendetails, moodle/course:useremail, moodle/user:update'),
(12, 'moodle_user_get_users_by_courseid', 'moodle_user_external', 'get_users_by_courseid', 'user/externallib.php', 'moodle', 'moodle/user:viewdetails, moodle/user:viewhiddendetails, moodle/course:useremail, moodle/user:update, moodle/site:accessallgroups'),
(13, 'moodle_user_get_course_participants_by_id', 'moodle_user_external', 'get_course_participants_by_id', 'user/externallib.php', 'moodle', 'moodle/user:viewdetails, moodle/user:viewhiddendetails, moodle/course:useremail, moodle/user:update, moodle/site:accessallgroups'),
(14, 'moodle_user_delete_users', 'moodle_user_external', 'delete_users', 'user/externallib.php', 'moodle', 'moodle/user:delete'),
(15, 'moodle_user_update_users', 'moodle_user_external', 'update_users', 'user/externallib.php', 'moodle', 'moodle/user:update'),
(16, 'moodle_enrol_get_enrolled_users', 'moodle_enrol_external', 'get_enrolled_users', 'enrol/externallib.php', 'moodle', 'moodle/site:viewparticipants, moodle/course:viewparticipants,\n            moodle/role:review, moodle/site:accessallgroups, moodle/course:enrolreview'),
(17, 'moodle_enrol_get_users_courses', 'moodle_enrol_external', 'get_users_courses', 'enrol/externallib.php', 'moodle', 'moodle/course:viewparticipants'),
(18, 'moodle_role_assign', 'moodle_enrol_external', 'role_assign', 'enrol/externallib.php', 'moodle', 'moodle/role:assign'),
(19, 'moodle_role_unassign', 'moodle_enrol_external', 'role_unassign', 'enrol/externallib.php', 'moodle', 'moodle/role:assign'),
(20, 'moodle_course_get_courses', 'moodle_course_external', 'get_courses', 'course/externallib.php', 'moodle', 'moodle/course:view,moodle/course:update,moodle/course:viewhiddencourses'),
(21, 'moodle_course_create_courses', 'moodle_course_external', 'create_courses', 'course/externallib.php', 'moodle', 'moodle/course:create,moodle/course:visibility'),
(22, 'moodle_message_send_instantmessages', 'moodle_message_external', 'send_instantmessages', 'message/externallib.php', 'moodle', 'moodle/site:sendmessage'),
(23, 'moodle_notes_create_notes', 'moodle_notes_external', 'create_notes', 'notes/externallib.php', 'moodle', 'moodle/notes:manage'),
(24, 'moodle_webservice_get_siteinfo', 'moodle_webservice_external', 'get_siteinfo', 'webservice/externallib.php', 'moodle', ''),
(25, 'moodle_enrol_manual_enrol_users', 'moodle_enrol_manual_external', 'manual_enrol_users', 'enrol/manual/externallib.php', 'enrol_manual', 'enrol/manual:enrol');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_external_services`
--

CREATE TABLE IF NOT EXISTS `mdl_external_services` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL,
  `requiredcapability` varchar(150) DEFAULT NULL,
  `restrictedusers` tinyint(1) unsigned NOT NULL,
  `component` varchar(100) DEFAULT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `shortname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_exteserv_nam_uix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='built in and custom external services' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `mdl_external_services`
--

INSERT INTO `mdl_external_services` (`id`, `name`, `enabled`, `requiredcapability`, `restrictedusers`, `component`, `timecreated`, `timemodified`, `shortname`) VALUES
(1, 'Moodle mobile web service', 0, NULL, 0, 'moodle', 1320247918, NULL, 'moodle_mobile_app');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_external_services_functions`
--

CREATE TABLE IF NOT EXISTS `mdl_external_services_functions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `externalserviceid` bigint(10) unsigned NOT NULL,
  `functionname` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_exteservfunc_ext_ix` (`externalserviceid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='lists functions available in each service group' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `mdl_external_services_functions`
--

INSERT INTO `mdl_external_services_functions` (`id`, `externalserviceid`, `functionname`) VALUES
(1, 1, 'moodle_enrol_get_users_courses'),
(2, 1, 'moodle_enrol_get_enrolled_users'),
(3, 1, 'moodle_user_get_users_by_id'),
(4, 1, 'moodle_webservice_get_siteinfo'),
(5, 1, 'moodle_notes_create_notes'),
(6, 1, 'moodle_user_get_course_participants_by_id'),
(7, 1, 'moodle_user_get_users_by_courseid'),
(8, 1, 'moodle_message_send_instantmessages');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_external_services_users`
--

CREATE TABLE IF NOT EXISTS `mdl_external_services_users` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `externalserviceid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `iprestriction` varchar(255) DEFAULT NULL,
  `validuntil` bigint(10) unsigned DEFAULT NULL,
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_exteservuser_ext_ix` (`externalserviceid`),
  KEY `mdl_exteservuser_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='users allowed to use services with restricted users flag' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_external_services_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_external_tokens`
--

CREATE TABLE IF NOT EXISTS `mdl_external_tokens` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL DEFAULT '',
  `tokentype` smallint(4) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `externalserviceid` bigint(10) unsigned NOT NULL,
  `sid` varchar(128) DEFAULT NULL,
  `contextid` bigint(10) unsigned NOT NULL,
  `creatorid` bigint(20) unsigned NOT NULL DEFAULT '1',
  `iprestriction` varchar(255) DEFAULT NULL,
  `validuntil` bigint(10) unsigned DEFAULT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  `lastaccess` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_extetoke_use_ix` (`userid`),
  KEY `mdl_extetoke_ext_ix` (`externalserviceid`),
  KEY `mdl_extetoke_con_ix` (`contextid`),
  KEY `mdl_extetoke_cre_ix` (`creatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Security tokens for accessing of external services' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_external_tokens`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `anonymous` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `email_notification` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `multiple_submit` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `autonumbering` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `site_after_submit` varchar(255) NOT NULL DEFAULT '',
  `page_after_submit` text NOT NULL,
  `page_after_submitformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `publish_stats` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `completionsubmit` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_feed_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all feedbacks' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_completed`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_completed` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `feedback` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `random_response` bigint(10) unsigned NOT NULL DEFAULT '0',
  `anonymous_response` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_feedcomp_use_ix` (`userid`),
  KEY `mdl_feedcomp_fee_ix` (`feedback`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='filled out feedback' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_completed`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_completedtmp`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_completedtmp` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `feedback` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `guestid` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `random_response` bigint(10) unsigned NOT NULL DEFAULT '0',
  `anonymous_response` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_feedcomp_use2_ix` (`userid`),
  KEY `mdl_feedcomp_fee2_ix` (`feedback`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='filled out feedback' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_completedtmp`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_item`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_item` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `feedback` bigint(10) unsigned NOT NULL DEFAULT '0',
  `template` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) NOT NULL DEFAULT '',
  `presentation` text NOT NULL,
  `typ` varchar(255) NOT NULL DEFAULT '',
  `hasvalue` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `position` smallint(3) unsigned NOT NULL DEFAULT '0',
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dependitem` bigint(10) unsigned NOT NULL DEFAULT '0',
  `dependvalue` varchar(255) NOT NULL DEFAULT '',
  `options` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_feeditem_fee_ix` (`feedback`),
  KEY `mdl_feeditem_tem_ix` (`template`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='feedback_items' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_item`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_sitecourse_map`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_sitecourse_map` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `feedbackid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_feedsitemap_cou_ix` (`courseid`),
  KEY `mdl_feedsitemap_fee_ix` (`feedbackid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='feedback sitecourse map' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_sitecourse_map`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_template`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_template` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_feedtemp_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='templates of feedbackstructures' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_template`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_tracking`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_tracking` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedback` bigint(10) unsigned NOT NULL DEFAULT '0',
  `completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tmp_completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_feedtrac_use_ix` (`userid`),
  KEY `mdl_feedtrac_fee_ix` (`feedback`),
  KEY `mdl_feedtrac_com_ix` (`completed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='feedback trackingdata' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_tracking`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_value`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_value` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `item` bigint(10) unsigned NOT NULL DEFAULT '0',
  `completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tmp_completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_feedvalu_cou_ix` (`course_id`),
  KEY `mdl_feedvalu_ite_ix` (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='values of the completeds' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_value`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_feedback_valuetmp`
--

CREATE TABLE IF NOT EXISTS `mdl_feedback_valuetmp` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `item` bigint(10) unsigned NOT NULL DEFAULT '0',
  `completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tmp_completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_feedvalu_cou2_ix` (`course_id`),
  KEY `mdl_feedvalu_ite2_ix` (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='values of the completedstmp' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_feedback_valuetmp`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_files`
--

CREATE TABLE IF NOT EXISTS `mdl_files` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contenthash` varchar(40) NOT NULL DEFAULT '',
  `pathnamehash` varchar(40) NOT NULL DEFAULT '',
  `contextid` bigint(10) unsigned NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `filearea` varchar(50) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `filepath` varchar(255) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `userid` bigint(10) unsigned DEFAULT NULL,
  `filesize` bigint(10) unsigned NOT NULL,
  `mimetype` varchar(100) DEFAULT NULL,
  `status` bigint(10) unsigned NOT NULL DEFAULT '0',
  `source` text,
  `author` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_file_pat_uix` (`pathnamehash`),
  KEY `mdl_file_comfilconite_ix` (`component`,`filearea`,`contextid`,`itemid`),
  KEY `mdl_file_con_ix` (`contenthash`),
  KEY `mdl_file_con2_ix` (`contextid`),
  KEY `mdl_file_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='description of files, content is stored in sha1 file pool' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_files`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_filter_active`
--

CREATE TABLE IF NOT EXISTS `mdl_filter_active` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `contextid` bigint(10) unsigned NOT NULL,
  `active` smallint(4) NOT NULL,
  `sortorder` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_filtacti_confil_uix` (`contextid`,`filter`),
  KEY `mdl_filtacti_con_ix` (`contextid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about which filters are active in which c' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_filter_active`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_filter_config`
--

CREATE TABLE IF NOT EXISTS `mdl_filter_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `contextid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_filtconf_confilnam_uix` (`contextid`,`filter`,`name`),
  KEY `mdl_filtconf_con_ix` (`contextid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores per-context configuration settings for filters which ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_filter_config`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_folder`
--

CREATE TABLE IF NOT EXISTS `mdl_folder` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `revision` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_fold_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each record is one folder resource' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_folder`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum`
--

CREATE TABLE IF NOT EXISTS `mdl_forum` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(20) NOT NULL DEFAULT 'general',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `assessed` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assesstimefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `scale` bigint(10) NOT NULL DEFAULT '0',
  `maxbytes` bigint(10) unsigned NOT NULL DEFAULT '0',
  `maxattachments` bigint(10) unsigned NOT NULL DEFAULT '1',
  `forcesubscribe` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `trackingtype` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rsstype` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rssarticles` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `warnafter` bigint(10) unsigned NOT NULL DEFAULT '0',
  `blockafter` bigint(10) unsigned NOT NULL DEFAULT '0',
  `blockperiod` bigint(10) unsigned NOT NULL DEFAULT '0',
  `completiondiscussions` int(9) unsigned NOT NULL DEFAULT '0',
  `completionreplies` int(9) unsigned NOT NULL DEFAULT '0',
  `completionposts` int(9) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_foru_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forums contain and structure discussion' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum_discussions`
--

CREATE TABLE IF NOT EXISTS `mdl_forum_discussions` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forums are composed of discussions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum_discussions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum_posts`
--

CREATE TABLE IF NOT EXISTS `mdl_forum_posts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `discussion` bigint(10) unsigned NOT NULL DEFAULT '0',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `messageformat` tinyint(2) NOT NULL DEFAULT '0',
  `messagetrust` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `totalscore` smallint(4) NOT NULL DEFAULT '0',
  `mailnow` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forupost_use_ix` (`userid`),
  KEY `mdl_forupost_cre_ix` (`created`),
  KEY `mdl_forupost_mai_ix` (`mailed`),
  KEY `mdl_forupost_dis_ix` (`discussion`),
  KEY `mdl_forupost_par_ix` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All posts are stored in this table' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum_posts`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum_queue`
--

CREATE TABLE IF NOT EXISTS `mdl_forum_queue` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `discussionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `postid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_foruqueu_use_ix` (`userid`),
  KEY `mdl_foruqueu_dis_ix` (`discussionid`),
  KEY `mdl_foruqueu_pos_ix` (`postid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For keeping track of posts that will be mailed in digest for' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum_queue`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum_read`
--

CREATE TABLE IF NOT EXISTS `mdl_forum_read` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tracks each users read posts' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum_read`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum_subscriptions`
--

CREATE TABLE IF NOT EXISTS `mdl_forum_subscriptions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forum` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forusubs_use_ix` (`userid`),
  KEY `mdl_forusubs_for_ix` (`forum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of who is subscribed to what forum' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum_subscriptions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_forum_track_prefs`
--

CREATE TABLE IF NOT EXISTS `mdl_forum_track_prefs` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `forumid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_forutracpref_usefor_ix` (`userid`,`forumid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tracks each users untracked forums' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_forum_track_prefs`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_glossary`
--

CREATE TABLE IF NOT EXISTS `mdl_glossary` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
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
  `completionentries` int(9) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_glos_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all glossaries' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_glossary`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_glossary_alias`
--

CREATE TABLE IF NOT EXISTS `mdl_glossary_alias` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `entryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `alias` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_glosalia_ent_ix` (`entryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='entries alias' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_glossary_alias`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_glossary_categories`
--

CREATE TABLE IF NOT EXISTS `mdl_glossary_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `glossaryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `usedynalink` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_gloscate_glo_ix` (`glossaryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all categories for glossary entries' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_glossary_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_glossary_entries`
--

CREATE TABLE IF NOT EXISTS `mdl_glossary_entries` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `glossaryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `concept` varchar(255) NOT NULL DEFAULT '',
  `definition` text NOT NULL,
  `definitionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `definitiontrust` tinyint(2) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all glossary entries' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_glossary_entries`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_glossary_entries_categories`
--

CREATE TABLE IF NOT EXISTS `mdl_glossary_entries_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `categoryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `entryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_glosentrcate_cat_ix` (`categoryid`),
  KEY `mdl_glosentrcate_ent_ix` (`entryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='categories of each glossary entry' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_glossary_entries_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_glossary_formats`
--

CREATE TABLE IF NOT EXISTS `mdl_glossary_formats` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Setting of the display formats' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `mdl_glossary_formats`
--

INSERT INTO `mdl_glossary_formats` (`id`, `name`, `popupformatname`, `visible`, `showgroup`, `defaultmode`, `defaulthook`, `sortkey`, `sortorder`) VALUES
(1, 'continuous', 'continuous', 1, 1, '', '', '', ''),
(2, 'dictionary', 'dictionary', 1, 1, '', '', '', ''),
(3, 'encyclopedia', 'encyclopedia', 1, 1, '', '', '', ''),
(4, 'entrylist', 'entrylist', 1, 1, '', '', '', ''),
(5, 'faq', 'faq', 1, 1, '', '', '', ''),
(6, 'fullwithauthor', 'fullwithauthor', 1, 1, '', '', '', ''),
(7, 'fullwithoutauthor', 'fullwithoutauthor', 1, 1, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_categories`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_categories` (
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
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_gradcate_cou_ix` (`courseid`),
  KEY `mdl_gradcate_par_ix` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about categories, used for grou' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_categories_history`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_categories_history` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History of grade_categories' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_categories_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_grades`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_grades` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='grade_grades  This table keeps individual grades for each us' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_grades`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_grades_history`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_grades_history` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History table' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_grades_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_import_newitem`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_import_newitem` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemname` varchar(255) NOT NULL DEFAULT '',
  `importcode` bigint(10) unsigned NOT NULL,
  `importer` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_gradimponewi_imp_ix` (`importer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='temporary table for storing new grade_item names from grade ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_import_newitem`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_import_values`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_import_values` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Temporary table for importing grades' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_import_values`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_items`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_items` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about gradeable items (ie colum' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_items`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_items_history`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_items_history` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History of grade_items' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_items_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_letters`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_letters` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `lowerboundary` decimal(10,5) NOT NULL,
  `letter` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradlett_conlowlet_uix` (`contextid`,`lowerboundary`,`letter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Repository for grade letters, for courses and other moodle e' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_letters`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_outcomes`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_outcomes` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned DEFAULT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `fullname` text NOT NULL,
  `scaleid` bigint(10) unsigned DEFAULT NULL,
  `description` text,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `usermodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradoutc_cousho_uix` (`courseid`,`shortname`),
  KEY `mdl_gradoutc_cou_ix` (`courseid`),
  KEY `mdl_gradoutc_sca_ix` (`scaleid`),
  KEY `mdl_gradoutc_use_ix` (`usermodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table describes the outcomes used in the system. An out' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_outcomes`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_outcomes_courses`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_outcomes_courses` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `outcomeid` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradoutccour_couout_uix` (`courseid`,`outcomeid`),
  KEY `mdl_gradoutccour_cou_ix` (`courseid`),
  KEY `mdl_gradoutccour_out_ix` (`outcomeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores what outcomes are used in what courses.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_outcomes_courses`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_outcomes_history`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_outcomes_history` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History table' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_outcomes_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_grade_settings`
--

CREATE TABLE IF NOT EXISTS `mdl_grade_settings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_gradsett_counam_uix` (`courseid`,`name`),
  KEY `mdl_gradsett_cou_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='gradebook settings' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_grade_settings`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_groupings`
--

CREATE TABLE IF NOT EXISTS `mdl_groupings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `configdata` text,
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_grou_cou2_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A grouping is a collection of groups. WAS: groups_groupings' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_groupings`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_groupings_groups`
--

CREATE TABLE IF NOT EXISTS `mdl_groupings_groups` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupingid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeadded` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_grougrou_gro_ix` (`groupingid`),
  KEY `mdl_grougrou_gro2_ix` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a grouping to a group (note, groups can be in multiple ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_groupings_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_groups`
--

CREATE TABLE IF NOT EXISTS `mdl_groups` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL,
  `name` varchar(254) NOT NULL DEFAULT '',
  `description` text,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `enrolmentkey` varchar(50) DEFAULT NULL,
  `picture` bigint(10) unsigned NOT NULL DEFAULT '0',
  `hidepicture` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_grou_cou_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record represents a group.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_groups_members`
--

CREATE TABLE IF NOT EXISTS `mdl_groups_members` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeadded` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_groumemb_gro_ix` (`groupid`),
  KEY `mdl_groumemb_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a user to a group.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_groups_members`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_imscp`
--

CREATE TABLE IF NOT EXISTS `mdl_imscp` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `revision` bigint(10) unsigned NOT NULL DEFAULT '0',
  `keepold` bigint(10) NOT NULL DEFAULT '-1',
  `structure` mediumtext,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_imsc_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each record is one imscp resource' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_imscp`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_label`
--

CREATE TABLE IF NOT EXISTS `mdl_label` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_labe_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines labels' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_label`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_answers`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `jumpto` bigint(11) NOT NULL DEFAULT '0',
  `grade` smallint(4) NOT NULL DEFAULT '0',
  `score` bigint(10) NOT NULL DEFAULT '0',
  `flags` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` text,
  `answerformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `response` text,
  `responseformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lessansw_les_ix` (`lessonid`),
  KEY `mdl_lessansw_pag_ix` (`pageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_answers' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_answers`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_attempts`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_attempts` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_attempts' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_attempts`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_branch`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_branch` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='branches for each lesson/user' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_branch`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_grades`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` double unsigned NOT NULL DEFAULT '0',
  `late` smallint(3) unsigned NOT NULL DEFAULT '0',
  `completed` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lessgrad_use_ix` (`userid`),
  KEY `mdl_lessgrad_les_ix` (`lessonid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_grades' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_grades`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_high_scores`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_high_scores` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `gradeid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(5) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_lesshighscor_use_ix` (`userid`),
  KEY `mdl_lesshighscor_les_ix` (`lessonid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='high scores for each lesson' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_high_scores`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_pages`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_pages` (
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
  `contentsformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lesspage_les_ix` (`lessonid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_pages' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_lesson_timer`
--

CREATE TABLE IF NOT EXISTS `mdl_lesson_timer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `starttime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lessontime` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_lesstime_use_ix` (`userid`),
  KEY `mdl_lesstime_les_ix` (`lessonid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lesson timer for each lesson' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_lesson_timer`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_license`
--

CREATE TABLE IF NOT EXISTS `mdl_license` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `shortname` varchar(255) DEFAULT NULL,
  `fullname` text,
  `source` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `version` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='store licenses used by moodle' AUTO_INCREMENT=10 ;

--
-- Dumping data for table `mdl_license`
--

INSERT INTO `mdl_license` (`id`, `shortname`, `fullname`, `source`, `enabled`, `version`) VALUES
(1, 'unknown', 'Unknown license', '', 1, 2010033100),
(2, 'allrightsreserved', 'All rights reserved', 'http://en.wikipedia.org/wiki/All_rights_reserved', 1, 2010033100),
(3, 'public', 'Public Domain', 'http://creativecommons.org/licenses/publicdomain/', 1, 2010033100),
(4, 'cc', 'Creative Commons', 'http://creativecommons.org/licenses/by/3.0/', 1, 2010033100),
(5, 'cc-nd', 'Creative Commons - NoDerivs', 'http://creativecommons.org/licenses/by-nd/3.0/', 1, 2010033100),
(6, 'cc-nc-nd', 'Creative Commons - No Commercial NoDerivs', 'http://creativecommons.org/licenses/by-nc-nd/3.0/', 1, 2010033100),
(7, 'cc-nc', 'Creative Commons - No Commercial', 'http://creativecommons.org/licenses/by-nd/3.0/', 1, 2010033100),
(8, 'cc-nc-sa', 'Creative Commons - No Commercial ShareAlike', 'http://creativecommons.org/licenses/by-nc-sa/3.0/', 1, 2010033100),
(9, 'cc-sa', 'Creative Commons - ShareAlike', 'http://creativecommons.org/licenses/by-sa/3.0/', 1, 2010033100);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_log`
--

CREATE TABLE IF NOT EXISTS `mdl_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(45) NOT NULL DEFAULT '',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Every action is logged as far as possible' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mdl_log`
--

INSERT INTO `mdl_log` (`id`, `time`, `userid`, `ip`, `course`, `module`, `cmid`, `action`, `url`, `info`) VALUES
(1, 1320248922, 2, '0:0:0:0:0:0:0:1', 1, 'user', 0, 'update', 'view.php?id=2&course=1', ''),
(2, 1320249144, 2, '0:0:0:0:0:0:0:1', 1, 'course', 0, 'view', 'view.php?id=1', '1');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_log_display`
--

CREATE TABLE IF NOT EXISTS `mdl_log_display` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(20) NOT NULL DEFAULT '',
  `action` varchar(40) NOT NULL DEFAULT '',
  `mtable` varchar(30) NOT NULL DEFAULT '',
  `field` varchar(200) NOT NULL DEFAULT '',
  `component` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_logdisp_modact_uix` (`module`,`action`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='For a particular module/action, specifies a moodle table/fie' AUTO_INCREMENT=141 ;

--
-- Dumping data for table `mdl_log_display`
--

INSERT INTO `mdl_log_display` (`id`, `module`, `action`, `mtable`, `field`, `component`) VALUES
(1, 'user', 'view', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(2, 'course', 'user report', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(3, 'course', 'view', 'course', 'fullname', 'moodle'),
(4, 'course', 'update', 'course', 'fullname', 'moodle'),
(5, 'course', 'enrol', 'course', 'fullname', 'moodle'),
(6, 'course', 'unenrol', 'course', 'fullname', 'moodle'),
(7, 'course', 'report log', 'course', 'fullname', 'moodle'),
(8, 'course', 'report live', 'course', 'fullname', 'moodle'),
(9, 'course', 'report outline', 'course', 'fullname', 'moodle'),
(10, 'course', 'report participation', 'course', 'fullname', 'moodle'),
(11, 'course', 'report stats', 'course', 'fullname', 'moodle'),
(12, 'message', 'write', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(13, 'message', 'read', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(14, 'message', 'add contact', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(15, 'message', 'remove contact', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(16, 'message', 'block contact', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(17, 'message', 'unblock contact', 'user', 'CONCAT(firstname, '' '', lastname)', 'moodle'),
(18, 'group', 'view', 'groups', 'name', 'moodle'),
(19, 'tag', 'update', 'tag', 'name', 'moodle'),
(20, 'assignment', 'view', 'assignment', 'name', 'mod_assignment'),
(21, 'assignment', 'add', 'assignment', 'name', 'mod_assignment'),
(22, 'assignment', 'update', 'assignment', 'name', 'mod_assignment'),
(23, 'assignment', 'view submission', 'assignment', 'name', 'mod_assignment'),
(24, 'assignment', 'upload', 'assignment', 'name', 'mod_assignment'),
(25, 'chat', 'view', 'chat', 'name', 'mod_chat'),
(26, 'chat', 'add', 'chat', 'name', 'mod_chat'),
(27, 'chat', 'update', 'chat', 'name', 'mod_chat'),
(28, 'chat', 'report', 'chat', 'name', 'mod_chat'),
(29, 'chat', 'talk', 'chat', 'name', 'mod_chat'),
(30, 'choice', 'view', 'choice', 'name', 'mod_choice'),
(31, 'choice', 'update', 'choice', 'name', 'mod_choice'),
(32, 'choice', 'add', 'choice', 'name', 'mod_choice'),
(33, 'choice', 'report', 'choice', 'name', 'mod_choice'),
(34, 'choice', 'choose', 'choice', 'name', 'mod_choice'),
(35, 'choice', 'choose again', 'choice', 'name', 'mod_choice'),
(36, 'data', 'view', 'data', 'name', 'mod_data'),
(37, 'data', 'add', 'data', 'name', 'mod_data'),
(38, 'data', 'update', 'data', 'name', 'mod_data'),
(39, 'data', 'record delete', 'data', 'name', 'mod_data'),
(40, 'data', 'fields add', 'data_fields', 'name', 'mod_data'),
(41, 'data', 'fields update', 'data_fields', 'name', 'mod_data'),
(42, 'data', 'templates saved', 'data', 'name', 'mod_data'),
(43, 'data', 'templates def', 'data', 'name', 'mod_data'),
(44, 'feedback', 'startcomplete', 'feedback', 'name', 'mod_feedback'),
(45, 'feedback', 'submit', 'feedback', 'name', 'mod_feedback'),
(46, 'feedback', 'delete', 'feedback', 'name', 'mod_feedback'),
(47, 'feedback', 'view', 'feedback', 'name', 'mod_feedback'),
(48, 'feedback', 'view all', 'course', 'shortname', 'mod_feedback'),
(49, 'folder', 'view', 'folder', 'name', 'mod_folder'),
(50, 'folder', 'view all', 'folder', 'name', 'mod_folder'),
(51, 'folder', 'update', 'folder', 'name', 'mod_folder'),
(52, 'folder', 'add', 'folder', 'name', 'mod_folder'),
(53, 'forum', 'add', 'forum', 'name', 'mod_forum'),
(54, 'forum', 'update', 'forum', 'name', 'mod_forum'),
(55, 'forum', 'add discussion', 'forum_discussions', 'name', 'mod_forum'),
(56, 'forum', 'add post', 'forum_posts', 'subject', 'mod_forum'),
(57, 'forum', 'update post', 'forum_posts', 'subject', 'mod_forum'),
(58, 'forum', 'user report', 'user', 'CONCAT(firstname, '' '', lastname)', 'mod_forum'),
(59, 'forum', 'move discussion', 'forum_discussions', 'name', 'mod_forum'),
(60, 'forum', 'view subscribers', 'forum', 'name', 'mod_forum'),
(61, 'forum', 'view discussion', 'forum_discussions', 'name', 'mod_forum'),
(62, 'forum', 'view forum', 'forum', 'name', 'mod_forum'),
(63, 'forum', 'subscribe', 'forum', 'name', 'mod_forum'),
(64, 'forum', 'unsubscribe', 'forum', 'name', 'mod_forum'),
(65, 'glossary', 'add', 'glossary', 'name', 'mod_glossary'),
(66, 'glossary', 'update', 'glossary', 'name', 'mod_glossary'),
(67, 'glossary', 'view', 'glossary', 'name', 'mod_glossary'),
(68, 'glossary', 'view all', 'glossary', 'name', 'mod_glossary'),
(69, 'glossary', 'add entry', 'glossary', 'name', 'mod_glossary'),
(70, 'glossary', 'update entry', 'glossary', 'name', 'mod_glossary'),
(71, 'glossary', 'add category', 'glossary', 'name', 'mod_glossary'),
(72, 'glossary', 'update category', 'glossary', 'name', 'mod_glossary'),
(73, 'glossary', 'delete category', 'glossary', 'name', 'mod_glossary'),
(74, 'glossary', 'approve entry', 'glossary', 'name', 'mod_glossary'),
(75, 'glossary', 'view entry', 'glossary_entries', 'concept', 'mod_glossary'),
(76, 'imscp', 'view', 'imscp', 'name', 'mod_imscp'),
(77, 'imscp', 'view all', 'imscp', 'name', 'mod_imscp'),
(78, 'imscp', 'update', 'imscp', 'name', 'mod_imscp'),
(79, 'imscp', 'add', 'imscp', 'name', 'mod_imscp'),
(80, 'label', 'add', 'label', 'name', 'mod_label'),
(81, 'label', 'update', 'label', 'name', 'mod_label'),
(82, 'lesson', 'start', 'lesson', 'name', 'mod_lesson'),
(83, 'lesson', 'end', 'lesson', 'name', 'mod_lesson'),
(84, 'lesson', 'view', 'lesson_pages', 'title', 'mod_lesson'),
(85, 'page', 'view', 'page', 'name', 'mod_page'),
(86, 'page', 'view all', 'page', 'name', 'mod_page'),
(87, 'page', 'update', 'page', 'name', 'mod_page'),
(88, 'page', 'add', 'page', 'name', 'mod_page'),
(89, 'quiz', 'add', 'quiz', 'name', 'mod_quiz'),
(90, 'quiz', 'update', 'quiz', 'name', 'mod_quiz'),
(91, 'quiz', 'view', 'quiz', 'name', 'mod_quiz'),
(92, 'quiz', 'report', 'quiz', 'name', 'mod_quiz'),
(93, 'quiz', 'attempt', 'quiz', 'name', 'mod_quiz'),
(94, 'quiz', 'submit', 'quiz', 'name', 'mod_quiz'),
(95, 'quiz', 'review', 'quiz', 'name', 'mod_quiz'),
(96, 'quiz', 'editquestions', 'quiz', 'name', 'mod_quiz'),
(97, 'quiz', 'preview', 'quiz', 'name', 'mod_quiz'),
(98, 'quiz', 'start attempt', 'quiz', 'name', 'mod_quiz'),
(99, 'quiz', 'close attempt', 'quiz', 'name', 'mod_quiz'),
(100, 'quiz', 'continue attempt', 'quiz', 'name', 'mod_quiz'),
(101, 'quiz', 'edit override', 'quiz', 'name', 'mod_quiz'),
(102, 'quiz', 'delete override', 'quiz', 'name', 'mod_quiz'),
(103, 'resource', 'view', 'resource', 'name', 'mod_resource'),
(104, 'resource', 'view all', 'resource', 'name', 'mod_resource'),
(105, 'resource', 'update', 'resource', 'name', 'mod_resource'),
(106, 'resource', 'add', 'resource', 'name', 'mod_resource'),
(107, 'scorm', 'view', 'scorm', 'name', 'mod_scorm'),
(108, 'scorm', 'review', 'scorm', 'name', 'mod_scorm'),
(109, 'scorm', 'update', 'scorm', 'name', 'mod_scorm'),
(110, 'scorm', 'add', 'scorm', 'name', 'mod_scorm'),
(111, 'survey', 'add', 'survey', 'name', 'mod_survey'),
(112, 'survey', 'update', 'survey', 'name', 'mod_survey'),
(113, 'survey', 'download', 'survey', 'name', 'mod_survey'),
(114, 'survey', 'view form', 'survey', 'name', 'mod_survey'),
(115, 'survey', 'view graph', 'survey', 'name', 'mod_survey'),
(116, 'survey', 'view report', 'survey', 'name', 'mod_survey'),
(117, 'survey', 'submit', 'survey', 'name', 'mod_survey'),
(118, 'url', 'view', 'url', 'name', 'mod_url'),
(119, 'url', 'view all', 'url', 'name', 'mod_url'),
(120, 'url', 'update', 'url', 'name', 'mod_url'),
(121, 'url', 'add', 'url', 'name', 'mod_url'),
(122, 'workshop', 'add', 'workshop', 'name', 'mod_workshop'),
(123, 'workshop', 'update', 'workshop', 'name', 'mod_workshop'),
(124, 'workshop', 'view', 'workshop', 'name', 'mod_workshop'),
(125, 'workshop', 'view all', 'workshop', 'name', 'mod_workshop'),
(126, 'workshop', 'add submission', 'workshop_submissions', 'title', 'mod_workshop'),
(127, 'workshop', 'update submission', 'workshop_submissions', 'title', 'mod_workshop'),
(128, 'workshop', 'view submission', 'workshop_submissions', 'title', 'mod_workshop'),
(129, 'workshop', 'add assessment', 'workshop_submissions', 'title', 'mod_workshop'),
(130, 'workshop', 'update assessment', 'workshop_submissions', 'title', 'mod_workshop'),
(131, 'workshop', 'add example', 'workshop_submissions', 'title', 'mod_workshop'),
(132, 'workshop', 'update example', 'workshop_submissions', 'title', 'mod_workshop'),
(133, 'workshop', 'view example', 'workshop_submissions', 'title', 'mod_workshop'),
(134, 'workshop', 'add reference assessment', 'workshop_submissions', 'title', 'mod_workshop'),
(135, 'workshop', 'update reference assessment', 'workshop_submissions', 'title', 'mod_workshop'),
(136, 'workshop', 'add example assessment', 'workshop_submissions', 'title', 'mod_workshop'),
(137, 'workshop', 'update example assessment', 'workshop_submissions', 'title', 'mod_workshop'),
(138, 'workshop', 'update aggregate grades', 'workshop', 'name', 'mod_workshop'),
(139, 'workshop', 'update clear aggregated grades', 'workshop', 'name', 'mod_workshop'),
(140, 'workshop', 'update clear assessments', 'workshop', 'name', 'mod_workshop');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_log_queries`
--

CREATE TABLE IF NOT EXISTS `mdl_log_queries` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `qtype` mediumint(5) unsigned NOT NULL,
  `sqltext` mediumtext NOT NULL,
  `sqlparams` longtext,
  `error` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `info` text,
  `backtrace` text,
  `exectime` decimal(10,5) NOT NULL,
  `timelogged` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Logged database queries.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_log_queries`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_message`
--

CREATE TABLE IF NOT EXISTS `mdl_message` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `useridfrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `useridto` bigint(10) unsigned NOT NULL DEFAULT '0',
  `subject` text,
  `fullmessage` text,
  `fullmessageformat` smallint(4) unsigned DEFAULT '0',
  `fullmessagehtml` mediumtext,
  `smallmessage` text,
  `notification` tinyint(1) unsigned DEFAULT '0',
  `contexturl` text,
  `contexturlname` text,
  `timecreated` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_mess_use_ix` (`useridfrom`),
  KEY `mdl_mess_use2_ix` (`useridto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all unread messages' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_message`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_message_contacts`
--

CREATE TABLE IF NOT EXISTS `mdl_message_contacts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contactid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `blocked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_messcont_usecon_uix` (`userid`,`contactid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains lists of relationships between users' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_message_contacts`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_message_processors`
--

CREATE TABLE IF NOT EXISTS `mdl_message_processors` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(166) NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='List of message output plugins' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `mdl_message_processors`
--

INSERT INTO `mdl_message_processors` (`id`, `name`, `enabled`) VALUES
(1, 'email', 1),
(2, 'jabber', 1),
(3, 'popup', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_message_providers`
--

CREATE TABLE IF NOT EXISTS `mdl_message_providers` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `component` varchar(200) NOT NULL DEFAULT '',
  `capability` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_messprov_comnam_uix` (`component`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table stores the message providers (modules and core sy' AUTO_INCREMENT=15 ;

--
-- Dumping data for table `mdl_message_providers`
--

INSERT INTO `mdl_message_providers` (`id`, `name`, `component`, `capability`) VALUES
(1, 'notices', 'moodle', 'moodle/site:config'),
(2, 'errors', 'moodle', 'moodle/site:config'),
(3, 'instantmessage', 'moodle', NULL),
(4, 'backup', 'moodle', 'moodle/site:config'),
(5, 'courserequested', 'moodle', 'moodle/site:approvecourse'),
(6, 'courserequestapproved', 'moodle', 'moodle/course:request'),
(7, 'courserequestrejected', 'moodle', 'moodle/course:request'),
(8, 'assignment_updates', 'mod_assignment', NULL),
(9, 'submission', 'mod_feedback', NULL),
(10, 'message', 'mod_feedback', NULL),
(11, 'posts', 'mod_forum', NULL),
(12, 'graded_essay', 'mod_lesson', NULL),
(13, 'submission', 'mod_quiz', 'mod/quiz:emailnotifysubmission'),
(14, 'confirmation', 'mod_quiz', 'mod/quiz:emailconfirmsubmission');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_message_read`
--

CREATE TABLE IF NOT EXISTS `mdl_message_read` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `useridfrom` bigint(10) unsigned NOT NULL DEFAULT '0',
  `useridto` bigint(10) unsigned NOT NULL DEFAULT '0',
  `subject` text,
  `fullmessage` text,
  `fullmessageformat` smallint(4) unsigned DEFAULT '0',
  `fullmessagehtml` mediumtext,
  `smallmessage` text,
  `notification` tinyint(1) unsigned DEFAULT '0',
  `contexturl` text,
  `contexturlname` text,
  `timecreated` bigint(10) NOT NULL DEFAULT '0',
  `timeread` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_messread_use_ix` (`useridfrom`),
  KEY `mdl_messread_use2_ix` (`useridto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all messages that have been read' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_message_read`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_message_working`
--

CREATE TABLE IF NOT EXISTS `mdl_message_working` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `unreadmessageid` bigint(10) unsigned NOT NULL,
  `processorid` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Lists all the messages and processors that need to be proces' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_message_working`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnetservice_enrol_courses`
--

CREATE TABLE IF NOT EXISTS `mdl_mnetservice_enrol_courses` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL,
  `remoteid` bigint(10) unsigned NOT NULL,
  `categoryid` bigint(10) unsigned NOT NULL,
  `categoryname` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `summary` mediumtext NOT NULL,
  `summaryformat` smallint(3) unsigned DEFAULT '0',
  `startdate` bigint(10) unsigned NOT NULL,
  `roleid` bigint(10) unsigned NOT NULL,
  `rolename` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetenrocour_hosrem_uix` (`hostid`,`remoteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches the information fetched via XML-RPC about courses on ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_mnetservice_enrol_courses`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnetservice_enrol_enrolments`
--

CREATE TABLE IF NOT EXISTS `mdl_mnetservice_enrol_enrolments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `remotecourseid` bigint(10) unsigned NOT NULL,
  `rolename` varchar(255) NOT NULL DEFAULT '',
  `enroltime` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enroltype` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_mnetenroenro_use_ix` (`userid`),
  KEY `mdl_mnetenroenro_hos_ix` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches the information about enrolments of our local users i' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_mnetservice_enrol_enrolments`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_application`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_application` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `display_name` varchar(50) NOT NULL DEFAULT '',
  `xmlrpc_server_url` varchar(255) NOT NULL DEFAULT '',
  `sso_land_url` varchar(255) NOT NULL DEFAULT '',
  `sso_jump_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Information about applications on remote hosts' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mdl_mnet_application`
--

INSERT INTO `mdl_mnet_application` (`id`, `name`, `display_name`, `xmlrpc_server_url`, `sso_land_url`, `sso_jump_url`) VALUES
(1, 'moodle', 'Moodle', '/mnet/xmlrpc/server.php', '/auth/mnet/land.php', '/auth/mnet/jump.php'),
(2, 'mahara', 'Mahara', '/api/xmlrpc/server.php', '/auth/xmlrpc/land.php', '/auth/xmlrpc/jump.php');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_host`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_host` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `wwwroot` varchar(255) NOT NULL DEFAULT '',
  `ip_address` varchar(45) NOT NULL DEFAULT '',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Information about the local and remote hosts for RPC' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mdl_mnet_host`
--

INSERT INTO `mdl_mnet_host` (`id`, `deleted`, `wwwroot`, `ip_address`, `name`, `public_key`, `public_key_expires`, `transport`, `portno`, `last_connect_time`, `last_log_id`, `force_theme`, `theme`, `applicationid`) VALUES
(1, 0, 'http://localhost/moodle21', '::1', '', '', 0, 0, 0, 0, 0, 0, NULL, 1),
(2, 0, '', '', 'All Hosts', '', 0, 0, 0, 0, 0, 0, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_host2service`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_host2service` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `serviceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subscribe` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnethost_hosser_uix` (`hostid`,`serviceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about the services for a given host' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_mnet_host2service`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_log`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `remoteid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `time` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(45) NOT NULL DEFAULT '',
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `coursename` varchar(40) NOT NULL DEFAULT '',
  `module` varchar(20) NOT NULL DEFAULT '',
  `cmid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `action` varchar(40) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL DEFAULT '',
  `info` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_mnetlog_hosusecou_ix` (`hostid`,`userid`,`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store session data from users migrating to other sites' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_mnet_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_remote_rpc`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_remote_rpc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `functionname` varchar(40) NOT NULL DEFAULT '',
  `xmlrpcpath` varchar(80) NOT NULL DEFAULT '',
  `plugintype` varchar(20) NOT NULL DEFAULT '',
  `pluginname` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table describes functions that might be called remotely' AUTO_INCREMENT=17 ;

--
-- Dumping data for table `mdl_mnet_remote_rpc`
--

INSERT INTO `mdl_mnet_remote_rpc` (`id`, `functionname`, `xmlrpcpath`, `plugintype`, `pluginname`, `enabled`) VALUES
(1, 'user_authorise', 'auth/mnet/auth.php/user_authorise', 'auth', 'mnet', 1),
(2, 'keepalive_server', 'auth/mnet/auth.php/keepalive_server', 'auth', 'mnet', 1),
(3, 'kill_children', 'auth/mnet/auth.php/kill_children', 'auth', 'mnet', 1),
(4, 'refresh_log', 'auth/mnet/auth.php/refresh_log', 'auth', 'mnet', 1),
(5, 'fetch_user_image', 'auth/mnet/auth.php/fetch_user_image', 'auth', 'mnet', 1),
(6, 'fetch_theme_info', 'auth/mnet/auth.php/fetch_theme_info', 'auth', 'mnet', 1),
(7, 'update_enrolments', 'auth/mnet/auth.php/update_enrolments', 'auth', 'mnet', 1),
(8, 'keepalive_client', 'auth/mnet/auth.php/keepalive_client', 'auth', 'mnet', 1),
(9, 'kill_child', 'auth/mnet/auth.php/kill_child', 'auth', 'mnet', 1),
(10, 'available_courses', 'enrol/mnet/enrol.php/available_courses', 'enrol', 'mnet', 1),
(11, 'user_enrolments', 'enrol/mnet/enrol.php/user_enrolments', 'enrol', 'mnet', 1),
(12, 'enrol_user', 'enrol/mnet/enrol.php/enrol_user', 'enrol', 'mnet', 1),
(13, 'unenrol_user', 'enrol/mnet/enrol.php/unenrol_user', 'enrol', 'mnet', 1),
(14, 'course_enrolments', 'enrol/mnet/enrol.php/course_enrolments', 'enrol', 'mnet', 1),
(15, 'send_content_intent', 'portfolio/mahara/lib.php/send_content_intent', 'portfolio', 'mahara', 1),
(16, 'send_content_ready', 'portfolio/mahara/lib.php/send_content_ready', 'portfolio', 'mahara', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_remote_service2rpc`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_remote_service2rpc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `serviceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rpcid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetremoserv_rpcser_uix` (`rpcid`,`serviceid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Group functions or methods under a service' AUTO_INCREMENT=17 ;

--
-- Dumping data for table `mdl_mnet_remote_service2rpc`
--

INSERT INTO `mdl_mnet_remote_service2rpc` (`id`, `serviceid`, `rpcid`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 2, 8),
(9, 2, 9),
(10, 3, 10),
(11, 3, 11),
(12, 3, 12),
(13, 3, 13),
(14, 3, 14),
(15, 4, 15),
(16, 4, 16);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_rpc`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_rpc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `functionname` varchar(40) NOT NULL DEFAULT '',
  `xmlrpcpath` varchar(80) NOT NULL DEFAULT '',
  `plugintype` varchar(20) NOT NULL DEFAULT '',
  `pluginname` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `help` mediumtext NOT NULL,
  `profile` mediumtext NOT NULL,
  `filename` varchar(100) NOT NULL DEFAULT '',
  `classname` varchar(150) DEFAULT NULL,
  `static` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_mnetrpc_enaxml_ix` (`enabled`,`xmlrpcpath`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Functions or methods that we may publish or subscribe to' AUTO_INCREMENT=16 ;

--
-- Dumping data for table `mdl_mnet_rpc`
--

INSERT INTO `mdl_mnet_rpc` (`id`, `functionname`, `xmlrpcpath`, `plugintype`, `pluginname`, `enabled`, `help`, `profile`, `filename`, `classname`, `static`) VALUES
(1, 'user_authorise', 'auth/mnet/auth.php/user_authorise', 'auth', 'mnet', 1, 'Return user data for the provided token, compare with user_agent string.', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:5:"token";s:4:"type";s:6:"string";s:11:"description";s:37:"The unique ID provided by remotehost.";}i:1;a:3:{s:4:"name";s:9:"useragent";s:4:"type";s:6:"string";s:11:"description";s:0:"";}}s:6:"return";a:2:{s:4:"type";s:5:"array";s:11:"description";s:44:"$userdata Array of user info for remote host";}}', 'auth.php', 'auth_plugin_mnet', 0),
(2, 'keepalive_server', 'auth/mnet/auth.php/keepalive_server', 'auth', 'mnet', 1, 'Receives an array of usernames from a remote machine and prods their\nsessions to keep them alive', 'a:2:{s:10:"parameters";a:1:{i:0;a:3:{s:4:"name";s:5:"array";s:4:"type";s:5:"array";s:11:"description";s:21:"An array of usernames";}}s:6:"return";a:2:{s:4:"type";s:6:"string";s:11:"description";s:28:""All ok" or an error message";}}', 'auth.php', 'auth_plugin_mnet', 0),
(3, 'kill_children', 'auth/mnet/auth.php/kill_children', 'auth', 'mnet', 1, 'The IdP uses this function to kill child sessions on other hosts', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:8:"username";s:4:"type";s:6:"string";s:11:"description";s:28:"Username for session to kill";}i:1;a:3:{s:4:"name";s:9:"useragent";s:4:"type";s:6:"string";s:11:"description";s:0:"";}}s:6:"return";a:2:{s:4:"type";s:6:"string";s:11:"description";s:39:"A plaintext report of what has happened";}}', 'auth.php', 'auth_plugin_mnet', 0),
(4, 'refresh_log', 'auth/mnet/auth.php/refresh_log', 'auth', 'mnet', 1, 'Receives an array of log entries from an SP and adds them to the mnet_log\ntable', 'a:2:{s:10:"parameters";a:1:{i:0;a:3:{s:4:"name";s:5:"array";s:4:"type";s:5:"array";s:11:"description";s:21:"An array of usernames";}}s:6:"return";a:2:{s:4:"type";s:6:"string";s:11:"description";s:28:""All ok" or an error message";}}', 'auth.php', 'auth_plugin_mnet', 0),
(5, 'fetch_user_image', 'auth/mnet/auth.php/fetch_user_image', 'auth', 'mnet', 1, 'Returns the user''s profile image info\nIf the user exists and has a profile picture, the returned array will contain keys:\n f1          - the content of the default 100x100px image\n f1_mimetype - the mimetype of the f1 file\n f2          - the content of the 35x35px variant of the image\n f2_mimetype - the mimetype of the f2 file\nThe mimetype information was added in Moodle 2.0. In Moodle 1.x, images are always jpegs.', 'a:2:{s:10:"parameters";a:1:{i:0;a:3:{s:4:"name";s:8:"username";s:4:"type";s:3:"int";s:11:"description";s:18:"The id of the user";}}s:6:"return";a:2:{s:4:"type";s:5:"array";s:11:"description";s:84:"false if user not found, empty array if no picture exists, array with data otherwise";}}', 'auth.php', 'auth_plugin_mnet', 0),
(6, 'fetch_theme_info', 'auth/mnet/auth.php/fetch_theme_info', 'auth', 'mnet', 1, 'Returns the theme information and logo url as strings.', 'a:2:{s:10:"parameters";a:0:{}s:6:"return";a:2:{s:4:"type";s:6:"string";s:11:"description";s:14:"The theme info";}}', 'auth.php', 'auth_plugin_mnet', 0),
(7, 'update_enrolments', 'auth/mnet/auth.php/update_enrolments', 'auth', 'mnet', 1, 'Invoke this function _on_ the IDP to update it with enrolment info local to\nthe SP right after calling user_authorise()\nNormally called by the SP after calling user_authorise()', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:8:"username";s:4:"type";s:6:"string";s:11:"description";s:12:"The username";}i:1;a:3:{s:4:"name";s:7:"courses";s:4:"type";s:5:"array";s:11:"description";s:0:"";}}s:6:"return";a:2:{s:4:"type";s:4:"bool";s:11:"description";s:0:"";}}', 'auth.php', 'auth_plugin_mnet', 0),
(8, 'keepalive_client', 'auth/mnet/auth.php/keepalive_client', 'auth', 'mnet', 1, 'Poll the IdP server to let it know that a user it has authenticated is still\nonline', 'a:2:{s:10:"parameters";a:0:{}s:6:"return";a:2:{s:4:"type";s:4:"void";s:11:"description";s:0:"";}}', 'auth.php', 'auth_plugin_mnet', 0),
(9, 'kill_child', 'auth/mnet/auth.php/kill_child', 'auth', 'mnet', 1, 'When the IdP requests that child sessions are terminated,\nthis function will be called on each of the child hosts. The machine that\ncalls the function (over xmlrpc) provides us with the mnethostid we need.', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:8:"username";s:4:"type";s:6:"string";s:11:"description";s:28:"Username for session to kill";}i:1;a:3:{s:4:"name";s:9:"useragent";s:4:"type";s:6:"string";s:11:"description";s:0:"";}}s:6:"return";a:2:{s:4:"type";s:4:"bool";s:11:"description";s:15:"True on success";}}', 'auth.php', 'auth_plugin_mnet', 0),
(10, 'available_courses', 'enrol/mnet/enrol.php/available_courses', 'enrol', 'mnet', 1, 'Returns list of courses that we offer to the caller for remote enrolment of their users\nSince Moodle 2.0, courses are made available for MNet peers by creating an instance\nof enrol_mnet plugin for the course. Hidden courses are not returned. If there are two\ninstances - one specific for the host and one for ''All hosts'', the setting of the specific\none is used. The id of the peer is kept in customint1, no other custom fields are used.', 'a:2:{s:10:"parameters";a:0:{}s:6:"return";a:2:{s:4:"type";s:5:"array";s:11:"description";s:0:"";}}', 'enrol.php', 'enrol_mnet_mnetservice_enrol', 0),
(11, 'user_enrolments', 'enrol/mnet/enrol.php/user_enrolments', 'enrol', 'mnet', 1, 'This method has never been implemented in Moodle MNet API', 'a:2:{s:10:"parameters";a:0:{}s:6:"return";a:2:{s:4:"type";s:5:"array";s:11:"description";s:11:"empty array";}}', 'enrol.php', 'enrol_mnet_mnetservice_enrol', 0),
(12, 'enrol_user', 'enrol/mnet/enrol.php/enrol_user', 'enrol', 'mnet', 1, 'Enrol remote user to our course\nIf we do not have local record for the remote user in our database,\nit gets created here.', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:8:"userdata";s:4:"type";s:5:"array";s:11:"description";s:14:"user details {";}i:1;a:3:{s:4:"name";s:8:"courseid";s:4:"type";s:3:"int";s:11:"description";s:19:"our local course id";}}s:6:"return";a:2:{s:4:"type";s:4:"bool";s:11:"description";s:69:"true if the enrolment has been successful, throws exception otherwise";}}', 'enrol.php', 'enrol_mnet_mnetservice_enrol', 0),
(13, 'unenrol_user', 'enrol/mnet/enrol.php/unenrol_user', 'enrol', 'mnet', 1, 'Unenrol remote user from our course\nOnly users enrolled via enrol_mnet plugin can be unenrolled remotely. If the\nremote user is enrolled into the local course via some other enrol plugin\n(enrol_manual for example), the remote host can''t touch such enrolment. Please\ndo not report this behaviour as bug, it is a feature ;-)', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:8:"username";s:4:"type";s:6:"string";s:11:"description";s:18:"of the remote user";}i:1;a:3:{s:4:"name";s:8:"courseid";s:4:"type";s:3:"int";s:11:"description";s:0:"";}}s:6:"return";a:2:{s:4:"type";s:4:"bool";s:11:"description";s:71:"true if the unenrolment has been successful, throws exception otherwise";}}', 'enrol.php', 'enrol_mnet_mnetservice_enrol', 0),
(14, 'course_enrolments', 'enrol/mnet/enrol.php/course_enrolments', 'enrol', 'mnet', 1, 'Returns a list of users from the client server who are enrolled in our course\nSuitable instance of enrol_mnet must be created in the course. This method will not\nreturn any information about the enrolments in courses that are not available for\nremote enrolment, even if their users are enrolled into them via other plugin\n(note the difference from {@link self::user_enrolments()}).\nThis method will return enrolment information for users from hosts regardless\nthe enrolment plugin. It does not matter if the user was enrolled remotely by\ntheir admin or locally. Once the course is available for remote enrolments, we\nwill tell them everything about their users.\nIn Moodle 1.x the returned array used to be indexed by username. The side effect\nof MDL-19219 fix is that we do not need to use such index and therefore we can\nreturn all enrolment records. MNet clients 1.x will only use the last record for\nthe student, if she is enrolled via multiple plugins.', 'a:2:{s:10:"parameters";a:2:{i:0;a:3:{s:4:"name";s:8:"courseid";s:4:"type";s:3:"int";s:11:"description";s:16:"ID of our course";}i:1;a:3:{s:4:"name";s:5:"roles";s:4:"type";s:5:"array";s:11:"description";s:0:"";}}s:6:"return";a:2:{s:4:"type";s:5:"array";s:11:"description";s:0:"";}}', 'enrol.php', 'enrol_mnet_mnetservice_enrol', 0),
(15, 'fetch_file', 'portfolio/mahara/lib.php/fetch_file', 'portfolio', 'mahara', 1, 'xmlrpc (mnet) function to get the file.\nreads in the file and returns it base_64 encoded\nso that it can be enrypted by mnet.', 'a:2:{s:10:"parameters";a:1:{i:0;a:3:{s:4:"name";s:5:"token";s:4:"type";s:6:"string";s:11:"description";s:56:"the token recieved previously during send_content_intent";}}s:6:"return";a:2:{s:4:"type";s:4:"void";s:11:"description";s:0:"";}}', 'lib.php', 'portfolio_plugin_mahara', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_service`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_service` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT '',
  `description` varchar(40) NOT NULL DEFAULT '',
  `apiversion` varchar(10) NOT NULL DEFAULT '',
  `offer` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='A service is a group of functions' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `mdl_mnet_service`
--

INSERT INTO `mdl_mnet_service` (`id`, `name`, `description`, `apiversion`, `offer`) VALUES
(1, 'sso_idp', '', '1', 1),
(2, 'sso_sp', '', '1', 1),
(3, 'mnet_enrol', '', '1', 1),
(4, 'pf', '', '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_service2rpc`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_service2rpc` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `serviceid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rpcid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetserv_rpcser_uix` (`rpcid`,`serviceid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Group functions or methods under a service' AUTO_INCREMENT=16 ;

--
-- Dumping data for table `mdl_mnet_service2rpc`
--

INSERT INTO `mdl_mnet_service2rpc` (`id`, `serviceid`, `rpcid`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 2, 8),
(9, 2, 9),
(10, 3, 10),
(11, 3, 11),
(12, 3, 12),
(13, 3, 13),
(14, 3, 14),
(15, 4, 15);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_session`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_session` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store session data from users migrating to other sites' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_mnet_session`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_mnet_sso_access_control`
--

CREATE TABLE IF NOT EXISTS `mdl_mnet_sso_access_control` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL DEFAULT '',
  `mnet_host_id` bigint(10) unsigned NOT NULL DEFAULT '0',
  `accessctrl` varchar(20) NOT NULL DEFAULT 'allow',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_mnetssoaccecont_mneuse_uix` (`mnet_host_id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users by host permitted (or not) to login from a remote prov' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_mnet_sso_access_control`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_modules`
--

CREATE TABLE IF NOT EXISTS `mdl_modules` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `version` bigint(10) NOT NULL DEFAULT '0',
  `cron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastcron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `search` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_modu_nam_ix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='modules available in the site' AUTO_INCREMENT=20 ;

--
-- Dumping data for table `mdl_modules`
--

INSERT INTO `mdl_modules` (`id`, `name`, `version`, `cron`, `lastcron`, `search`, `visible`) VALUES
(1, 'assignment', 2010102600, 60, 0, '', 1),
(2, 'chat', 2010080302, 300, 0, '', 1),
(3, 'choice', 2010101301, 0, 0, '', 1),
(4, 'data', 2011052300, 60, 0, '', 1),
(5, 'feedback', 2011051600, 0, 0, '', 0),
(6, 'folder', 2010101400, 0, 0, '', 1),
(7, 'forum', 2011052300, 60, 0, '', 1),
(8, 'glossary', 2011052300, 0, 0, '', 1),
(9, 'imscp', 2010101400, 0, 0, '', 1),
(10, 'label', 2010080300, 0, 0, '', 1),
(11, 'lesson', 2010122200, 0, 0, '', 1),
(12, 'page', 2010101400, 0, 0, '', 1),
(13, 'quiz', 2011070100, 0, 0, '', 1),
(14, 'resource', 2011022700, 0, 0, '', 1),
(15, 'scorm', 2011021403, 300, 0, '', 1),
(16, 'survey', 2010080300, 0, 0, '', 1),
(17, 'url', 2010101400, 0, 0, '', 1),
(18, 'wiki', 2011011001, 0, 0, '', 1),
(19, 'workshop', 2011061000, 0, 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_my_pages`
--

CREATE TABLE IF NOT EXISTS `mdl_my_pages` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned DEFAULT '0',
  `name` varchar(200) NOT NULL DEFAULT '',
  `private` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `sortorder` mediumint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_mypage_usepri_ix` (`userid`,`private`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Extra user pages for the My Moodle system' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mdl_my_pages`
--

INSERT INTO `mdl_my_pages` (`id`, `userid`, `name`, `private`, `sortorder`) VALUES
(1, NULL, '__default', 0, 0),
(2, NULL, '__default', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_page`
--

CREATE TABLE IF NOT EXISTS `mdl_page` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `content` mediumtext,
  `contentformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `legacyfiles` smallint(4) unsigned NOT NULL DEFAULT '0',
  `legacyfileslast` bigint(10) unsigned DEFAULT NULL,
  `display` smallint(4) unsigned NOT NULL DEFAULT '0',
  `displayoptions` text,
  `revision` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_page_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is one page and its config data' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_page`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_portfolio_instance`
--

CREATE TABLE IF NOT EXISTS `mdl_portfolio_instance` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='base table (not including config data) for instances of port' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_portfolio_instance`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_portfolio_instance_config`
--

CREATE TABLE IF NOT EXISTS `mdl_portfolio_instance_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext,
  PRIMARY KEY (`id`),
  KEY `mdl_portinstconf_nam_ix` (`name`),
  KEY `mdl_portinstconf_ins_ix` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='config for portfolio plugin instances' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_portfolio_instance_config`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_portfolio_instance_user`
--

CREATE TABLE IF NOT EXISTS `mdl_portfolio_instance_user` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext,
  PRIMARY KEY (`id`),
  KEY `mdl_portinstuser_ins_ix` (`instance`),
  KEY `mdl_portinstuser_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user data for portfolio instances.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_portfolio_instance_user`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_portfolio_log`
--

CREATE TABLE IF NOT EXISTS `mdl_portfolio_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL,
  `time` bigint(10) unsigned NOT NULL,
  `portfolio` bigint(10) unsigned NOT NULL,
  `caller_class` varchar(150) NOT NULL DEFAULT '',
  `caller_file` varchar(255) NOT NULL DEFAULT '',
  `caller_sha1` varchar(255) NOT NULL DEFAULT '',
  `tempdataid` bigint(10) NOT NULL DEFAULT '0',
  `returnurl` varchar(255) NOT NULL DEFAULT '',
  `continueurl` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_portlog_use_ix` (`userid`),
  KEY `mdl_portlog_por_ix` (`portfolio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='log of portfolio transfers (used to later check for duplicat' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_portfolio_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_portfolio_mahara_queue`
--

CREATE TABLE IF NOT EXISTS `mdl_portfolio_mahara_queue` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `transferid` bigint(10) unsigned NOT NULL,
  `token` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_portmahaqueu_tok_ix` (`token`),
  KEY `mdl_portmahaqueu_tra_ix` (`transferid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps mahara tokens to transfer ids' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_portfolio_mahara_queue`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_portfolio_tempdata`
--

CREATE TABLE IF NOT EXISTS `mdl_portfolio_tempdata` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext,
  `expirytime` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `instance` bigint(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_porttemp_use_ix` (`userid`),
  KEY `mdl_porttemp_ins_ix` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores temporary data for portfolio exports. the id of this ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_portfolio_tempdata`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_post`
--

CREATE TABLE IF NOT EXISTS `mdl_post` (
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
  `summaryformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `attachment` varchar(100) DEFAULT NULL,
  `publishstate` varchar(20) NOT NULL DEFAULT 'draft',
  `lastmodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `created` bigint(10) unsigned NOT NULL DEFAULT '0',
  `usermodified` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_post_iduse_uix` (`id`,`userid`),
  KEY `mdl_post_las_ix` (`lastmodified`),
  KEY `mdl_post_mod_ix` (`module`),
  KEY `mdl_post_sub_ix` (`subject`),
  KEY `mdl_post_use_ix` (`usermodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic post table to hold data blog entries etc in differen' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_post`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_profiling`
--

CREATE TABLE IF NOT EXISTS `mdl_profiling` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `runid` varchar(32) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `data` longtext NOT NULL,
  `totalexecutiontime` bigint(10) unsigned NOT NULL,
  `totalcputime` bigint(10) unsigned NOT NULL,
  `totalcalls` bigint(10) unsigned NOT NULL,
  `totalmemory` bigint(10) unsigned NOT NULL,
  `runreference` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `runcomment` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_prof_run_uix` (`runid`),
  KEY `mdl_prof_urlrun_ix` (`url`,`runreference`),
  KEY `mdl_prof_timrun_ix` (`timecreated`,`runreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the results of all the profiling runs' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_profiling`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_qtype_essay_options`
--

CREATE TABLE IF NOT EXISTS `mdl_qtype_essay_options` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionid` bigint(10) unsigned NOT NULL,
  `responseformat` varchar(16) NOT NULL DEFAULT 'editor',
  `responsefieldlines` smallint(4) NOT NULL DEFAULT '15',
  `attachments` smallint(4) NOT NULL DEFAULT '0',
  `graderinfo` text,
  `graderinfoformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_qtypessaopti_que_uix` (`questionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Extra options for essay questions.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_qtype_essay_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question`
--

CREATE TABLE IF NOT EXISTS `mdl_question` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(10) NOT NULL DEFAULT '0',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `questiontext` text NOT NULL,
  `questiontextformat` tinyint(2) NOT NULL DEFAULT '0',
  `generalfeedback` text NOT NULL,
  `generalfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `defaultmark` decimal(12,7) NOT NULL DEFAULT '1.0000000',
  `penalty` decimal(12,7) NOT NULL DEFAULT '0.3333333',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The questions themselves' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_answers`
--

CREATE TABLE IF NOT EXISTS `mdl_question_answers` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` text NOT NULL,
  `answerformat` tinyint(2) NOT NULL DEFAULT '0',
  `fraction` decimal(12,7) NOT NULL DEFAULT '0.0000000',
  `feedback` text NOT NULL,
  `feedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesansw_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Answers, with a fractional grade (0-1) and feedback' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_answers`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_attempts`
--

CREATE TABLE IF NOT EXISTS `mdl_question_attempts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionusageid` bigint(10) unsigned NOT NULL,
  `slot` bigint(10) unsigned NOT NULL,
  `behaviour` varchar(32) NOT NULL DEFAULT '',
  `questionid` bigint(10) unsigned NOT NULL,
  `variant` bigint(10) unsigned NOT NULL DEFAULT '1',
  `maxmark` decimal(12,7) NOT NULL,
  `minfraction` decimal(12,7) NOT NULL,
  `flagged` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `questionsummary` text,
  `rightanswer` text,
  `responsesummary` text,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quesatte_queslo_uix` (`questionusageid`,`slot`),
  KEY `mdl_quesatte_que_ix` (`questionid`),
  KEY `mdl_quesatte_que2_ix` (`questionusageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row here corresponds to an attempt at one question, as ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_attempts`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_attempt_steps`
--

CREATE TABLE IF NOT EXISTS `mdl_question_attempt_steps` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionattemptid` bigint(10) unsigned NOT NULL,
  `sequencenumber` bigint(10) unsigned NOT NULL,
  `state` varchar(13) NOT NULL DEFAULT '',
  `fraction` decimal(12,7) DEFAULT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quesattestep_queseq_uix` (`questionattemptid`,`sequencenumber`),
  KEY `mdl_quesattestep_que_ix` (`questionattemptid`),
  KEY `mdl_quesattestep_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores one step in in a question attempt. As well as the dat' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_attempt_steps`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_attempt_step_data`
--

CREATE TABLE IF NOT EXISTS `mdl_question_attempt_step_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attemptstepid` bigint(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quesattestepdata_attna_uix` (`attemptstepid`,`name`),
  KEY `mdl_quesattestepdata_att_ix` (`attemptstepid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each question_attempt_step has an associative array of the d' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_attempt_step_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_calculated`
--

CREATE TABLE IF NOT EXISTS `mdl_question_calculated` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for questions of type calculated' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_calculated`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_calculated_options`
--

CREATE TABLE IF NOT EXISTS `mdl_question_calculated_options` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `synchronize` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `single` smallint(4) NOT NULL DEFAULT '0',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '0',
  `correctfeedback` text,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `partiallycorrectfeedback` text,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `incorrectfeedback` text,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `answernumbering` varchar(10) NOT NULL DEFAULT 'abc',
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quescalcopti_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for questions of type calculated' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_calculated_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_categories`
--

CREATE TABLE IF NOT EXISTS `mdl_question_categories` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `info` text NOT NULL,
  `infoformat` tinyint(2) NOT NULL DEFAULT '0',
  `stamp` varchar(255) NOT NULL DEFAULT '',
  `parent` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  KEY `mdl_quescate_con_ix` (`contextid`),
  KEY `mdl_quescate_par_ix` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Categories are for grouping questions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_datasets`
--

CREATE TABLE IF NOT EXISTS `mdl_question_datasets` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `datasetdefinition` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesdata_quedat_ix` (`question`,`datasetdefinition`),
  KEY `mdl_quesdata_que_ix` (`question`),
  KEY `mdl_quesdata_dat_ix` (`datasetdefinition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Many-many relation between questions and dataset definitions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_datasets`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_dataset_definitions`
--

CREATE TABLE IF NOT EXISTS `mdl_question_dataset_definitions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` bigint(10) NOT NULL DEFAULT '0',
  `options` varchar(255) NOT NULL DEFAULT '',
  `itemcount` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesdatadefi_cat_ix` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Organises and stores properties for dataset items' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_dataset_definitions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_dataset_items`
--

CREATE TABLE IF NOT EXISTS `mdl_question_dataset_items` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `definition` bigint(10) unsigned NOT NULL DEFAULT '0',
  `itemnumber` bigint(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_quesdataitem_def_ix` (`definition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Individual dataset items' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_dataset_items`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_hints`
--

CREATE TABLE IF NOT EXISTS `mdl_question_hints` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionid` bigint(10) unsigned NOT NULL,
  `hint` text NOT NULL,
  `hintformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `shownumcorrect` tinyint(1) unsigned DEFAULT NULL,
  `clearwrong` tinyint(1) unsigned DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_queshint_que_ix` (`questionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the the part of the question definition that gives di' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_hints`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_match`
--

CREATE TABLE IF NOT EXISTS `mdl_question_match` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `subquestions` varchar(255) NOT NULL DEFAULT '',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '1',
  `correctfeedback` text NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `partiallycorrectfeedback` text NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `incorrectfeedback` text NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesmatc_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines fixed matching questions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_match`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_match_sub`
--

CREATE TABLE IF NOT EXISTS `mdl_question_match_sub` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `questiontext` text NOT NULL,
  `questiontextformat` tinyint(2) NOT NULL DEFAULT '0',
  `answertext` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_quesmatcsub_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines the subquestions that make up a matching question' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_match_sub`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_multianswer`
--

CREATE TABLE IF NOT EXISTS `mdl_question_multianswer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sequence` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_quesmult_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for multianswer questions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_multianswer`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_multichoice`
--

CREATE TABLE IF NOT EXISTS `mdl_question_multichoice` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `layout` smallint(4) NOT NULL DEFAULT '0',
  `answers` varchar(255) NOT NULL DEFAULT '',
  `single` smallint(4) NOT NULL DEFAULT '0',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '1',
  `correctfeedback` text NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `partiallycorrectfeedback` text NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `incorrectfeedback` text NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT '0',
  `answernumbering` varchar(10) NOT NULL DEFAULT 'abc',
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesmult_que2_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for multiple choice questions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_multichoice`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_numerical`
--

CREATE TABLE IF NOT EXISTS `mdl_question_numerical` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answer` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tolerance` varchar(255) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesnume_ans_ix` (`answer`),
  KEY `mdl_quesnume_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for numerical questions.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_numerical`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_numerical_options`
--

CREATE TABLE IF NOT EXISTS `mdl_question_numerical_options` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `showunits` smallint(4) unsigned NOT NULL DEFAULT '0',
  `unitsleft` smallint(4) NOT NULL DEFAULT '0',
  `unitgradingtype` smallint(4) unsigned NOT NULL DEFAULT '0',
  `unitpenalty` decimal(12,7) unsigned NOT NULL DEFAULT '0.1000000',
  PRIMARY KEY (`id`),
  KEY `mdl_quesnumeopti_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for questions of type numerical This table is also u' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_numerical_options`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_numerical_units`
--

CREATE TABLE IF NOT EXISTS `mdl_question_numerical_units` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `multiplier` decimal(40,20) NOT NULL DEFAULT '1.00000000000000000000',
  `unit` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quesnumeunit_queuni_uix` (`question`,`unit`),
  KEY `mdl_quesnumeunit_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Optional unit options for numerical questions. This table is' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_numerical_units`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_randomsamatch`
--

CREATE TABLE IF NOT EXISTS `mdl_question_randomsamatch` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `choose` bigint(10) unsigned NOT NULL DEFAULT '4',
  PRIMARY KEY (`id`),
  KEY `mdl_quesrand_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about a random short-answer matching question' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_randomsamatch`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_sessions`
--

CREATE TABLE IF NOT EXISTS `mdl_question_sessions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attemptid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `questionid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `newest` bigint(10) unsigned NOT NULL DEFAULT '0',
  `newgraded` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sumpenalty` decimal(12,7) NOT NULL DEFAULT '0.0000000',
  `manualcomment` text NOT NULL,
  `manualcommentformat` tinyint(2) NOT NULL DEFAULT '0',
  `flagged` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quessess_attque_uix` (`attemptid`,`questionid`),
  KEY `mdl_quessess_att_ix` (`attemptid`),
  KEY `mdl_quessess_que_ix` (`questionid`),
  KEY `mdl_quessess_new_ix` (`newest`),
  KEY `mdl_quessess_new2_ix` (`newgraded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gives ids of the newest open and newest graded states' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_sessions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_shortanswer`
--

CREATE TABLE IF NOT EXISTS `mdl_question_shortanswer` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `answers` varchar(255) NOT NULL DEFAULT '',
  `usecase` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quesshor_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for short answer questions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_shortanswer`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_states`
--

CREATE TABLE IF NOT EXISTS `mdl_question_states` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `attempt` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `seq_number` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `answer` text NOT NULL,
  `timestamp` bigint(10) unsigned NOT NULL DEFAULT '0',
  `event` smallint(4) unsigned NOT NULL DEFAULT '0',
  `grade` decimal(12,7) NOT NULL DEFAULT '0.0000000',
  `raw_grade` decimal(12,7) NOT NULL DEFAULT '0.0000000',
  `penalty` decimal(12,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`id`),
  KEY `mdl_quesstat_att_ix` (`attempt`),
  KEY `mdl_quesstat_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user responses to an attempt, and percentage grades' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_states`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_truefalse`
--

CREATE TABLE IF NOT EXISTS `mdl_question_truefalse` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `trueanswer` bigint(10) unsigned NOT NULL DEFAULT '0',
  `falseanswer` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_questrue_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for True-False questions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_truefalse`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_question_usages`
--

CREATE TABLE IF NOT EXISTS `mdl_question_usages` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `component` varchar(255) NOT NULL DEFAULT '',
  `preferredbehaviour` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_quesusag_con_ix` (`contextid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table''s main purpose it to assign a unique id to each a' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_question_usages`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `preferredbehaviour` varchar(32) NOT NULL DEFAULT '',
  `attempts` mediumint(6) NOT NULL DEFAULT '0',
  `attemptonlast` smallint(4) NOT NULL DEFAULT '0',
  `grademethod` smallint(4) NOT NULL DEFAULT '1',
  `decimalpoints` smallint(4) NOT NULL DEFAULT '2',
  `questiondecimalpoints` smallint(4) NOT NULL DEFAULT '-2',
  `reviewattempt` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `reviewcorrectness` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `reviewmarks` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `reviewspecificfeedback` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `reviewgeneralfeedback` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `reviewrightanswer` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `reviewoverallfeedback` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `questionsperpage` bigint(10) NOT NULL DEFAULT '0',
  `shufflequestions` smallint(4) NOT NULL DEFAULT '0',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT '0',
  `questions` text NOT NULL,
  `sumgrades` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `grade` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timelimit` bigint(10) unsigned NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `popup` smallint(4) NOT NULL DEFAULT '0',
  `delay1` bigint(10) NOT NULL DEFAULT '0',
  `delay2` bigint(10) NOT NULL DEFAULT '0',
  `showuserpicture` smallint(4) NOT NULL DEFAULT '0',
  `showblocks` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quiz_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Main information about each quiz' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_attempts`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_attempts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `attempt` mediumint(6) NOT NULL DEFAULT '0',
  `sumgrades` decimal(10,5) DEFAULT NULL,
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timefinish` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `layout` text NOT NULL,
  `preview` smallint(3) unsigned NOT NULL DEFAULT '0',
  `needsupgradetonewqe` smallint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quizatte_uni_uix` (`uniqueid`),
  KEY `mdl_quizatte_use_ix` (`userid`),
  KEY `mdl_quizatte_qui_ix` (`quiz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores various attempts on a quiz' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_attempts`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_feedback`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_feedback` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quizid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedbacktext` text NOT NULL,
  `feedbacktextformat` tinyint(2) NOT NULL DEFAULT '0',
  `mingrade` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `maxgrade` decimal(10,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`id`),
  KEY `mdl_quizfeed_qui_ix` (`quizid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Feedback given to students based on which grade band their o' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_feedback`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_grades`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_quizgrad_use_ix` (`userid`),
  KEY `mdl_quizgrad_qui_ix` (`quiz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The overall grade for each user on the quiz, based on their ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_grades`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_overrides`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_overrides` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned DEFAULT NULL,
  `userid` bigint(10) unsigned DEFAULT NULL,
  `timeopen` bigint(10) unsigned DEFAULT NULL,
  `timeclose` bigint(10) unsigned DEFAULT NULL,
  `timelimit` bigint(10) unsigned DEFAULT NULL,
  `attempts` mediumint(6) unsigned DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_quizover_qui_ix` (`quiz`),
  KEY `mdl_quizover_gro_ix` (`groupid`),
  KEY `mdl_quizover_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The overrides to quiz settings on a per-user and per-group b' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_overrides`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_overview_regrades`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_overview_regrades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionusageid` bigint(10) unsigned NOT NULL,
  `slot` bigint(10) unsigned NOT NULL,
  `newfraction` decimal(12,7) DEFAULT NULL,
  `oldfraction` decimal(12,7) DEFAULT NULL,
  `regraded` smallint(4) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table records which question attempts need regrading an' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_overview_regrades`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_question_instances`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_question_instances` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz` bigint(10) unsigned NOT NULL DEFAULT '0',
  `question` bigint(10) unsigned NOT NULL DEFAULT '0',
  `grade` decimal(12,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`id`),
  KEY `mdl_quizquesinst_qui_ix` (`quiz`),
  KEY `mdl_quizquesinst_que_ix` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the maximum possible grade (weight) for each question' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_question_instances`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_question_response_stats`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_question_response_stats` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quizstatisticsid` bigint(10) unsigned NOT NULL,
  `questionid` bigint(10) unsigned NOT NULL,
  `subqid` bigint(10) unsigned NOT NULL,
  `aid` bigint(10) unsigned DEFAULT NULL,
  `response` longtext,
  `rcount` bigint(10) unsigned DEFAULT NULL,
  `credit` decimal(15,5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quiz question responses.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_question_response_stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_question_statistics`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_question_statistics` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quizstatisticsid` bigint(10) unsigned NOT NULL,
  `questionid` bigint(10) unsigned NOT NULL,
  `slot` bigint(10) unsigned DEFAULT NULL,
  `subquestion` smallint(4) unsigned NOT NULL,
  `s` bigint(10) unsigned NOT NULL DEFAULT '0',
  `effectiveweight` decimal(15,5) DEFAULT NULL,
  `negcovar` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `discriminationindex` decimal(15,5) DEFAULT NULL,
  `discriminativeefficiency` decimal(15,5) DEFAULT NULL,
  `sd` decimal(15,10) DEFAULT NULL,
  `facility` decimal(15,10) DEFAULT NULL,
  `subquestions` mediumtext,
  `maxmark` decimal(12,7) DEFAULT NULL,
  `positions` mediumtext,
  `randomguessscore` decimal(12,7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default comment for the table, please edit me' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_question_statistics`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_reports`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_reports` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `displayorder` bigint(10) unsigned NOT NULL,
  `lastcron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `cron` bigint(10) unsigned NOT NULL DEFAULT '0',
  `capability` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_quizrepo_nam_uix` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Lists all the installed quiz reports and their display order' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `mdl_quiz_reports`
--

INSERT INTO `mdl_quiz_reports` (`id`, `name`, `displayorder`, `lastcron`, `cron`, `capability`) VALUES
(1, 'overview', 10000, 0, 0, NULL),
(2, 'responses', 9000, 0, 0, NULL),
(3, 'grading', 6000, 0, 0, NULL),
(4, 'statistics', 8000, 0, 18000, 'quiz/statistics:view');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_quiz_statistics`
--

CREATE TABLE IF NOT EXISTS `mdl_quiz_statistics` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `quizid` bigint(10) unsigned NOT NULL,
  `groupid` bigint(10) unsigned NOT NULL,
  `allattempts` smallint(4) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  `firstattemptscount` bigint(10) unsigned NOT NULL,
  `allattemptscount` bigint(10) unsigned NOT NULL,
  `firstattemptsavg` decimal(15,5) DEFAULT NULL,
  `allattemptsavg` decimal(15,5) DEFAULT NULL,
  `median` decimal(15,5) DEFAULT NULL,
  `standarddeviation` decimal(15,5) DEFAULT NULL,
  `skewness` decimal(15,10) DEFAULT NULL,
  `kurtosis` decimal(15,5) DEFAULT NULL,
  `cic` decimal(15,10) DEFAULT NULL,
  `errorratio` decimal(15,10) DEFAULT NULL,
  `standarderror` decimal(15,10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table to cache results from analysis done in statistics repo' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_quiz_statistics`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_rating`
--

CREATE TABLE IF NOT EXISTS `mdl_rating` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `contextid` bigint(10) unsigned NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `ratingarea` varchar(50) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `scaleid` bigint(10) NOT NULL,
  `rating` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_rati_comratconite_ix` (`component`,`ratingarea`,`contextid`,`itemid`),
  KEY `mdl_rati_con_ix` (`contextid`),
  KEY `mdl_rati_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='moodle ratings' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_rating`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_registration_hubs`
--

CREATE TABLE IF NOT EXISTS `mdl_registration_hubs` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL DEFAULT '',
  `hubname` varchar(255) NOT NULL DEFAULT '',
  `huburl` varchar(255) NOT NULL DEFAULT '',
  `confirmed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `secret` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='hub where the site is registered on with their associated to' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_registration_hubs`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_report_customlang`
--

CREATE TABLE IF NOT EXISTS `mdl_report_customlang` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(20) NOT NULL DEFAULT '',
  `componentid` bigint(10) unsigned NOT NULL,
  `stringid` varchar(255) NOT NULL DEFAULT '',
  `original` longtext NOT NULL,
  `master` longtext,
  `local` longtext,
  `timemodified` bigint(10) unsigned NOT NULL,
  `timecustomized` bigint(10) unsigned DEFAULT NULL,
  `outdated` smallint(3) unsigned DEFAULT '0',
  `modified` smallint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_repocust_lancomstr_uix` (`lang`,`componentid`,`stringid`),
  KEY `mdl_repocust_com_ix` (`componentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the working checkout of all strings and their custo' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_report_customlang`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_report_customlang_components`
--

CREATE TABLE IF NOT EXISTS `mdl_report_customlang_components` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the list of all installed plugins that provide thei' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_report_customlang_components`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_repository`
--

CREATE TABLE IF NOT EXISTS `mdl_repository` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) unsigned DEFAULT '1',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table contains one entry for every configured external ' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `mdl_repository`
--

INSERT INTO `mdl_repository` (`id`, `type`, `visible`, `sortorder`) VALUES
(1, 'local', 1, 1),
(2, 'recent', 1, 2),
(3, 'upload', 1, 3),
(4, 'user', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_repository_instances`
--

CREATE TABLE IF NOT EXISTS `mdl_repository_instances` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `typeid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contextid` bigint(10) unsigned NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `timecreated` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned DEFAULT NULL,
  `readonly` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table contains one entry for every configured external ' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `mdl_repository_instances`
--

INSERT INTO `mdl_repository_instances` (`id`, `name`, `typeid`, `userid`, `contextid`, `username`, `password`, `timecreated`, `timemodified`, `readonly`) VALUES
(1, '', 1, 0, 1, NULL, NULL, 1320248257, 1320248257, 0),
(2, '', 2, 0, 1, NULL, NULL, 1320248260, 1320248260, 0),
(3, '', 3, 0, 1, NULL, NULL, 1320248262, 1320248262, 0),
(4, '', 4, 0, 1, NULL, NULL, 1320248264, 1320248264, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_repository_instance_config`
--

CREATE TABLE IF NOT EXISTS `mdl_repository_instance_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The config for intances' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_repository_instance_config`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_resource`
--

CREATE TABLE IF NOT EXISTS `mdl_resource` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `tobemigrated` smallint(4) unsigned NOT NULL DEFAULT '0',
  `legacyfiles` smallint(4) unsigned NOT NULL DEFAULT '0',
  `legacyfileslast` bigint(10) unsigned DEFAULT NULL,
  `display` smallint(4) unsigned NOT NULL DEFAULT '0',
  `displayoptions` text,
  `filterfiles` smallint(4) unsigned NOT NULL DEFAULT '0',
  `revision` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_reso_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is one resource and its config data' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_resource`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_resource_old`
--

CREATE TABLE IF NOT EXISTS `mdl_resource_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(30) NOT NULL DEFAULT '',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `intro` text,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `alltext` mediumtext NOT NULL,
  `popup` text NOT NULL,
  `options` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `oldid` bigint(10) unsigned NOT NULL,
  `cmid` bigint(10) unsigned DEFAULT NULL,
  `newmodule` varchar(50) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  `migrated` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_resoold_old_uix` (`oldid`),
  KEY `mdl_resoold_cmi_ix` (`cmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='backup of all old resource instances from 1.9' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_resource_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_role`
--

CREATE TABLE IF NOT EXISTS `mdl_role` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `archetype` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_role_sor_uix` (`sortorder`),
  UNIQUE KEY `mdl_role_nam_uix` (`name`),
  UNIQUE KEY `mdl_role_sho_uix` (`shortname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='moodle roles' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `mdl_role`
--

INSERT INTO `mdl_role` (`id`, `name`, `shortname`, `description`, `sortorder`, `archetype`) VALUES
(1, 'Manager', 'manager', 'Managers can access course and modify them, they usually do not participate in courses.', 1, 'manager'),
(2, 'Course creator', 'coursecreator', 'Course creators can create new courses.', 2, 'coursecreator'),
(3, 'Teacher', 'editingteacher', 'Teachers can do anything within a course, including changing the activities and grading students.', 3, 'editingteacher'),
(4, 'Non-editing teacher', 'teacher', 'Non-editing teachers can teach in courses and grade students, but may not alter activities.', 4, 'teacher'),
(5, 'Student', 'student', 'Students generally have fewer privileges within a course.', 5, 'student'),
(6, 'Guest', 'guest', 'Guests have minimal privileges and usually can not enter text anywhere.', 6, 'guest'),
(7, 'Authenticated user', 'user', 'All logged in users.', 7, 'user'),
(8, 'Authenticated user on frontpage', 'frontpage', 'All logged in users in the frontpage course.', 8, 'frontpage');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_allow_assign`
--

CREATE TABLE IF NOT EXISTS `mdl_role_allow_assign` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `allowassign` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolealloassi_rolall_uix` (`roleid`,`allowassign`),
  KEY `mdl_rolealloassi_rol_ix` (`roleid`),
  KEY `mdl_rolealloassi_all_ix` (`allowassign`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='this defines what role can assign what role' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `mdl_role_allow_assign`
--

INSERT INTO `mdl_role_allow_assign` (`id`, `roleid`, `allowassign`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 3, 4),
(7, 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_allow_override`
--

CREATE TABLE IF NOT EXISTS `mdl_role_allow_override` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `allowoverride` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolealloover_rolall_uix` (`roleid`,`allowoverride`),
  KEY `mdl_rolealloover_rol_ix` (`roleid`),
  KEY `mdl_rolealloover_all_ix` (`allowoverride`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='this defines what role can override what role' AUTO_INCREMENT=12 ;

--
-- Dumping data for table `mdl_role_allow_override`
--

INSERT INTO `mdl_role_allow_override` (`id`, `roleid`, `allowoverride`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 3, 4),
(10, 3, 5),
(11, 3, 6);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_allow_switch`
--

CREATE TABLE IF NOT EXISTS `mdl_role_allow_switch` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL,
  `allowswitch` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolealloswit_rolall_uix` (`roleid`,`allowswitch`),
  KEY `mdl_rolealloswit_rol_ix` (`roleid`),
  KEY `mdl_rolealloswit_all_ix` (`allowswitch`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table stores which which other roles a user is allowed ' AUTO_INCREMENT=10 ;

--
-- Dumping data for table `mdl_role_allow_switch`
--

INSERT INTO `mdl_role_allow_switch` (`id`, `roleid`, `allowswitch`) VALUES
(1, 1, 3),
(2, 1, 4),
(3, 1, 5),
(4, 1, 6),
(5, 3, 4),
(6, 3, 5),
(7, 3, 6),
(8, 4, 5),
(9, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_assignments`
--

CREATE TABLE IF NOT EXISTS `mdl_role_assignments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modifierid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `component` varchar(100) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_roleassi_sor_ix` (`sortorder`),
  KEY `mdl_roleassi_rol_ix` (`roleid`),
  KEY `mdl_roleassi_con_ix` (`contextid`),
  KEY `mdl_roleassi_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='assigning roles in different context' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_role_assignments`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_capabilities`
--

CREATE TABLE IF NOT EXISTS `mdl_role_capabilities` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='permission has to be signed, overriding a capability for a p' AUTO_INCREMENT=865 ;

--
-- Dumping data for table `mdl_role_capabilities`
--

INSERT INTO `mdl_role_capabilities` (`id`, `contextid`, `roleid`, `capability`, `permission`, `timemodified`, `modifierid`) VALUES
(1, 1, 1, 'moodle/site:readallmessages', 1, 1320247878, 0),
(2, 1, 3, 'moodle/site:readallmessages', 1, 1320247879, 0),
(3, 1, 1, 'moodle/site:sendmessage', 1, 1320247879, 0),
(4, 1, 7, 'moodle/site:sendmessage', 1, 1320247879, 0),
(5, 1, 1, 'moodle/site:approvecourse', 1, 1320247879, 0),
(6, 1, 3, 'moodle/backup:backupcourse', 1, 1320247879, 0),
(7, 1, 1, 'moodle/backup:backupcourse', 1, 1320247879, 0),
(8, 1, 3, 'moodle/backup:backupsection', 1, 1320247879, 0),
(9, 1, 1, 'moodle/backup:backupsection', 1, 1320247879, 0),
(10, 1, 3, 'moodle/backup:backupactivity', 1, 1320247879, 0),
(11, 1, 1, 'moodle/backup:backupactivity', 1, 1320247879, 0),
(12, 1, 3, 'moodle/backup:backuptargethub', 1, 1320247879, 0),
(13, 1, 1, 'moodle/backup:backuptargethub', 1, 1320247879, 0),
(14, 1, 3, 'moodle/backup:backuptargetimport', 1, 1320247880, 0),
(15, 1, 1, 'moodle/backup:backuptargetimport', 1, 1320247880, 0),
(16, 1, 3, 'moodle/backup:downloadfile', 1, 1320247880, 0),
(17, 1, 1, 'moodle/backup:downloadfile', 1, 1320247880, 0),
(18, 1, 3, 'moodle/backup:configure', 1, 1320247880, 0),
(19, 1, 1, 'moodle/backup:configure', 1, 1320247880, 0),
(20, 1, 1, 'moodle/backup:userinfo', 1, 1320247880, 0),
(21, 1, 1, 'moodle/backup:anonymise', 1, 1320247880, 0),
(22, 1, 3, 'moodle/restore:restorecourse', 1, 1320247881, 0),
(23, 1, 1, 'moodle/restore:restorecourse', 1, 1320247881, 0),
(24, 1, 3, 'moodle/restore:restoresection', 1, 1320247881, 0),
(25, 1, 1, 'moodle/restore:restoresection', 1, 1320247881, 0),
(26, 1, 3, 'moodle/restore:restoreactivity', 1, 1320247881, 0),
(27, 1, 1, 'moodle/restore:restoreactivity', 1, 1320247881, 0),
(28, 1, 3, 'moodle/restore:restoretargethub', 1, 1320247881, 0),
(29, 1, 1, 'moodle/restore:restoretargethub', 1, 1320247881, 0),
(30, 1, 3, 'moodle/restore:restoretargetimport', 1, 1320247881, 0),
(31, 1, 1, 'moodle/restore:restoretargetimport', 1, 1320247881, 0),
(32, 1, 3, 'moodle/restore:uploadfile', 1, 1320247882, 0),
(33, 1, 1, 'moodle/restore:uploadfile', 1, 1320247882, 0),
(34, 1, 3, 'moodle/restore:configure', 1, 1320247882, 0),
(35, 1, 1, 'moodle/restore:configure', 1, 1320247882, 0),
(36, 1, 2, 'moodle/restore:rolldates', 1, 1320247882, 0),
(37, 1, 1, 'moodle/restore:rolldates', 1, 1320247882, 0),
(38, 1, 1, 'moodle/restore:userinfo', 1, 1320247882, 0),
(39, 1, 1, 'moodle/restore:createuser', 1, 1320247882, 0),
(40, 1, 3, 'moodle/site:manageblocks', 1, 1320247883, 0),
(41, 1, 1, 'moodle/site:manageblocks', 1, 1320247883, 0),
(42, 1, 4, 'moodle/site:accessallgroups', 1, 1320247883, 0),
(43, 1, 3, 'moodle/site:accessallgroups', 1, 1320247883, 0),
(44, 1, 1, 'moodle/site:accessallgroups', 1, 1320247883, 0),
(45, 1, 4, 'moodle/site:viewfullnames', 1, 1320247883, 0),
(46, 1, 3, 'moodle/site:viewfullnames', 1, 1320247883, 0),
(47, 1, 1, 'moodle/site:viewfullnames', 1, 1320247883, 0),
(48, 1, 4, 'moodle/site:viewreports', 1, 1320247883, 0),
(49, 1, 3, 'moodle/site:viewreports', 1, 1320247883, 0),
(50, 1, 1, 'moodle/site:viewreports', 1, 1320247883, 0),
(51, 1, 3, 'moodle/site:trustcontent', 1, 1320247883, 0),
(52, 1, 1, 'moodle/site:trustcontent', 1, 1320247884, 0),
(53, 1, 1, 'moodle/site:uploadusers', 1, 1320247884, 0),
(54, 1, 3, 'moodle/filter:manage', 1, 1320247884, 0),
(55, 1, 1, 'moodle/filter:manage', 1, 1320247884, 0),
(56, 1, 1, 'moodle/user:create', 1, 1320247884, 0),
(57, 1, 1, 'moodle/user:delete', 1, 1320247884, 0),
(58, 1, 1, 'moodle/user:update', 1, 1320247884, 0),
(59, 1, 6, 'moodle/user:viewdetails', 1, 1320247884, 0),
(60, 1, 5, 'moodle/user:viewdetails', 1, 1320247884, 0),
(61, 1, 4, 'moodle/user:viewdetails', 1, 1320247885, 0),
(62, 1, 3, 'moodle/user:viewdetails', 1, 1320247885, 0),
(63, 1, 1, 'moodle/user:viewdetails', 1, 1320247885, 0),
(64, 1, 1, 'moodle/user:viewalldetails', 1, 1320247885, 0),
(65, 1, 4, 'moodle/user:viewhiddendetails', 1, 1320247885, 0),
(66, 1, 3, 'moodle/user:viewhiddendetails', 1, 1320247885, 0),
(67, 1, 1, 'moodle/user:viewhiddendetails', 1, 1320247885, 0),
(68, 1, 1, 'moodle/user:loginas', 1, 1320247885, 0),
(69, 1, 1, 'moodle/user:managesyspages', 1, 1320247885, 0),
(70, 1, 7, 'moodle/user:manageownblocks', 1, 1320247885, 0),
(71, 1, 7, 'moodle/user:manageownfiles', 1, 1320247886, 0),
(72, 1, 1, 'moodle/my:configsyspages', 1, 1320247886, 0),
(73, 1, 3, 'moodle/role:assign', 1, 1320247886, 0),
(74, 1, 1, 'moodle/role:assign', 1, 1320247886, 0),
(75, 1, 4, 'moodle/role:review', 1, 1320247886, 0),
(76, 1, 3, 'moodle/role:review', 1, 1320247886, 0),
(77, 1, 1, 'moodle/role:review', 1, 1320247886, 0),
(78, 1, 1, 'moodle/role:override', 1, 1320247887, 0),
(79, 1, 3, 'moodle/role:safeoverride', 1, 1320247887, 0),
(80, 1, 1, 'moodle/role:manage', 1, 1320247887, 0),
(81, 1, 3, 'moodle/role:switchroles', 1, 1320247887, 0),
(82, 1, 1, 'moodle/role:switchroles', 1, 1320247887, 0),
(83, 1, 1, 'moodle/category:manage', 1, 1320247887, 0),
(84, 1, 2, 'moodle/category:viewhiddencategories', 1, 1320247887, 0),
(85, 1, 1, 'moodle/category:viewhiddencategories', 1, 1320247887, 0),
(86, 1, 1, 'moodle/cohort:manage', 1, 1320247887, 0),
(87, 1, 1, 'moodle/cohort:assign', 1, 1320247888, 0),
(88, 1, 3, 'moodle/cohort:view', 1, 1320247888, 0),
(89, 1, 1, 'moodle/cohort:view', 1, 1320247888, 0),
(90, 1, 2, 'moodle/course:create', 1, 1320247888, 0),
(91, 1, 1, 'moodle/course:create', 1, 1320247888, 0),
(92, 1, 7, 'moodle/course:request', 1, 1320247888, 0),
(93, 1, 1, 'moodle/course:delete', 1, 1320247888, 0),
(94, 1, 3, 'moodle/course:update', 1, 1320247888, 0),
(95, 1, 1, 'moodle/course:update', 1, 1320247888, 0),
(96, 1, 1, 'moodle/course:view', 1, 1320247889, 0),
(97, 1, 3, 'moodle/course:enrolreview', 1, 1320247889, 0),
(98, 1, 1, 'moodle/course:enrolreview', 1, 1320247889, 0),
(99, 1, 3, 'moodle/course:enrolconfig', 1, 1320247889, 0),
(100, 1, 1, 'moodle/course:enrolconfig', 1, 1320247889, 0),
(101, 1, 4, 'moodle/course:bulkmessaging', 1, 1320247889, 0),
(102, 1, 3, 'moodle/course:bulkmessaging', 1, 1320247889, 0),
(103, 1, 1, 'moodle/course:bulkmessaging', 1, 1320247889, 0),
(104, 1, 4, 'moodle/course:viewhiddenuserfields', 1, 1320247889, 0),
(105, 1, 3, 'moodle/course:viewhiddenuserfields', 1, 1320247890, 0),
(106, 1, 1, 'moodle/course:viewhiddenuserfields', 1, 1320247890, 0),
(107, 1, 2, 'moodle/course:viewhiddencourses', 1, 1320247890, 0),
(108, 1, 4, 'moodle/course:viewhiddencourses', 1, 1320247890, 0),
(109, 1, 3, 'moodle/course:viewhiddencourses', 1, 1320247890, 0),
(110, 1, 1, 'moodle/course:viewhiddencourses', 1, 1320247890, 0),
(111, 1, 3, 'moodle/course:visibility', 1, 1320247890, 0),
(112, 1, 1, 'moodle/course:visibility', 1, 1320247890, 0),
(113, 1, 3, 'moodle/course:managefiles', 1, 1320247890, 0),
(114, 1, 1, 'moodle/course:managefiles', 1, 1320247890, 0),
(115, 1, 3, 'moodle/course:manageactivities', 1, 1320247890, 0),
(116, 1, 1, 'moodle/course:manageactivities', 1, 1320247890, 0),
(117, 1, 3, 'moodle/course:activityvisibility', 1, 1320247891, 0),
(118, 1, 1, 'moodle/course:activityvisibility', 1, 1320247891, 0),
(119, 1, 4, 'moodle/course:viewhiddenactivities', 1, 1320247891, 0),
(120, 1, 3, 'moodle/course:viewhiddenactivities', 1, 1320247891, 0),
(121, 1, 1, 'moodle/course:viewhiddenactivities', 1, 1320247891, 0),
(122, 1, 5, 'moodle/course:viewparticipants', 1, 1320247891, 0),
(123, 1, 4, 'moodle/course:viewparticipants', 1, 1320247891, 0),
(124, 1, 3, 'moodle/course:viewparticipants', 1, 1320247891, 0),
(125, 1, 1, 'moodle/course:viewparticipants', 1, 1320247891, 0),
(126, 1, 3, 'moodle/course:changefullname', 1, 1320247891, 0),
(127, 1, 1, 'moodle/course:changefullname', 1, 1320247891, 0),
(128, 1, 3, 'moodle/course:changeshortname', 1, 1320247891, 0),
(129, 1, 1, 'moodle/course:changeshortname', 1, 1320247892, 0),
(130, 1, 3, 'moodle/course:changeidnumber', 1, 1320247892, 0),
(131, 1, 1, 'moodle/course:changeidnumber', 1, 1320247892, 0),
(132, 1, 3, 'moodle/course:changecategory', 1, 1320247892, 0),
(133, 1, 1, 'moodle/course:changecategory', 1, 1320247892, 0),
(134, 1, 3, 'moodle/course:changesummary', 1, 1320247892, 0),
(135, 1, 1, 'moodle/course:changesummary', 1, 1320247892, 0),
(136, 1, 1, 'moodle/site:viewparticipants', 1, 1320247892, 0),
(137, 1, 5, 'moodle/course:viewscales', 1, 1320247892, 0),
(138, 1, 4, 'moodle/course:viewscales', 1, 1320247892, 0),
(139, 1, 3, 'moodle/course:viewscales', 1, 1320247892, 0),
(140, 1, 1, 'moodle/course:viewscales', 1, 1320247893, 0),
(141, 1, 3, 'moodle/course:managescales', 1, 1320247893, 0),
(142, 1, 1, 'moodle/course:managescales', 1, 1320247893, 0),
(143, 1, 3, 'moodle/course:managegroups', 1, 1320247893, 0),
(144, 1, 1, 'moodle/course:managegroups', 1, 1320247893, 0),
(145, 1, 3, 'moodle/course:reset', 1, 1320247893, 0),
(146, 1, 1, 'moodle/course:reset', 1, 1320247893, 0),
(147, 1, 6, 'moodle/blog:view', 1, 1320247893, 0),
(148, 1, 7, 'moodle/blog:view', 1, 1320247893, 0),
(149, 1, 5, 'moodle/blog:view', 1, 1320247893, 0),
(150, 1, 4, 'moodle/blog:view', 1, 1320247893, 0),
(151, 1, 3, 'moodle/blog:view', 1, 1320247893, 0),
(152, 1, 1, 'moodle/blog:view', 1, 1320247894, 0),
(153, 1, 6, 'moodle/blog:search', 1, 1320247894, 0),
(154, 1, 7, 'moodle/blog:search', 1, 1320247894, 0),
(155, 1, 5, 'moodle/blog:search', 1, 1320247894, 0),
(156, 1, 4, 'moodle/blog:search', 1, 1320247894, 0),
(157, 1, 3, 'moodle/blog:search', 1, 1320247894, 0),
(158, 1, 1, 'moodle/blog:search', 1, 1320247895, 0),
(159, 1, 1, 'moodle/blog:viewdrafts', 1, 1320247895, 0),
(160, 1, 7, 'moodle/blog:create', 1, 1320247895, 0),
(161, 1, 1, 'moodle/blog:create', 1, 1320247895, 0),
(162, 1, 4, 'moodle/blog:manageentries', 1, 1320247895, 0),
(163, 1, 3, 'moodle/blog:manageentries', 1, 1320247895, 0),
(164, 1, 1, 'moodle/blog:manageentries', 1, 1320247895, 0),
(165, 1, 5, 'moodle/blog:manageexternal', 1, 1320247895, 0),
(166, 1, 7, 'moodle/blog:manageexternal', 1, 1320247895, 0),
(167, 1, 4, 'moodle/blog:manageexternal', 1, 1320247895, 0),
(168, 1, 3, 'moodle/blog:manageexternal', 1, 1320247895, 0),
(169, 1, 1, 'moodle/blog:manageexternal', 1, 1320247896, 0),
(170, 1, 5, 'moodle/blog:associatecourse', 1, 1320247896, 0),
(171, 1, 7, 'moodle/blog:associatecourse', 1, 1320247896, 0),
(172, 1, 4, 'moodle/blog:associatecourse', 1, 1320247896, 0),
(173, 1, 3, 'moodle/blog:associatecourse', 1, 1320247896, 0),
(174, 1, 1, 'moodle/blog:associatecourse', 1, 1320247896, 0),
(175, 1, 5, 'moodle/blog:associatemodule', 1, 1320247896, 0),
(176, 1, 7, 'moodle/blog:associatemodule', 1, 1320247896, 0),
(177, 1, 4, 'moodle/blog:associatemodule', 1, 1320247896, 0),
(178, 1, 3, 'moodle/blog:associatemodule', 1, 1320247896, 0),
(179, 1, 1, 'moodle/blog:associatemodule', 1, 1320247896, 0),
(180, 1, 7, 'moodle/calendar:manageownentries', 1, 1320247897, 0),
(181, 1, 1, 'moodle/calendar:manageownentries', 1, 1320247897, 0),
(182, 1, 4, 'moodle/calendar:managegroupentries', 1, 1320247897, 0),
(183, 1, 3, 'moodle/calendar:managegroupentries', 1, 1320247897, 0),
(184, 1, 1, 'moodle/calendar:managegroupentries', 1, 1320247897, 0),
(185, 1, 4, 'moodle/calendar:manageentries', 1, 1320247898, 0),
(186, 1, 3, 'moodle/calendar:manageentries', 1, 1320247898, 0),
(187, 1, 1, 'moodle/calendar:manageentries', 1, 1320247898, 0),
(188, 1, 1, 'moodle/user:editprofile', 1, 1320247898, 0),
(189, 1, 6, 'moodle/user:editownprofile', -1000, 1320247898, 0),
(190, 1, 7, 'moodle/user:editownprofile', 1, 1320247898, 0),
(191, 1, 1, 'moodle/user:editownprofile', 1, 1320247898, 0),
(192, 1, 6, 'moodle/user:changeownpassword', -1000, 1320247898, 0),
(193, 1, 7, 'moodle/user:changeownpassword', 1, 1320247898, 0),
(194, 1, 1, 'moodle/user:changeownpassword', 1, 1320247898, 0),
(195, 1, 5, 'moodle/user:readuserposts', 1, 1320247898, 0),
(196, 1, 4, 'moodle/user:readuserposts', 1, 1320247898, 0),
(197, 1, 3, 'moodle/user:readuserposts', 1, 1320247899, 0),
(198, 1, 1, 'moodle/user:readuserposts', 1, 1320247899, 0),
(199, 1, 5, 'moodle/user:readuserblogs', 1, 1320247899, 0),
(200, 1, 4, 'moodle/user:readuserblogs', 1, 1320247899, 0),
(201, 1, 3, 'moodle/user:readuserblogs', 1, 1320247899, 0),
(202, 1, 1, 'moodle/user:readuserblogs', 1, 1320247899, 0),
(203, 1, 1, 'moodle/user:editmessageprofile', 1, 1320247899, 0),
(204, 1, 6, 'moodle/user:editownmessageprofile', -1000, 1320247899, 0),
(205, 1, 7, 'moodle/user:editownmessageprofile', 1, 1320247899, 0),
(206, 1, 1, 'moodle/user:editownmessageprofile', 1, 1320247899, 0),
(207, 1, 3, 'moodle/question:managecategory', 1, 1320247899, 0),
(208, 1, 1, 'moodle/question:managecategory', 1, 1320247900, 0),
(209, 1, 3, 'moodle/question:add', 1, 1320247900, 0),
(210, 1, 1, 'moodle/question:add', 1, 1320247900, 0),
(211, 1, 3, 'moodle/question:editmine', 1, 1320247900, 0),
(212, 1, 1, 'moodle/question:editmine', 1, 1320247900, 0),
(213, 1, 3, 'moodle/question:editall', 1, 1320247900, 0),
(214, 1, 1, 'moodle/question:editall', 1, 1320247900, 0),
(215, 1, 3, 'moodle/question:viewmine', 1, 1320247900, 0),
(216, 1, 1, 'moodle/question:viewmine', 1, 1320247900, 0),
(217, 1, 3, 'moodle/question:viewall', 1, 1320247900, 0),
(218, 1, 1, 'moodle/question:viewall', 1, 1320247900, 0),
(219, 1, 3, 'moodle/question:usemine', 1, 1320247901, 0),
(220, 1, 1, 'moodle/question:usemine', 1, 1320247901, 0),
(221, 1, 3, 'moodle/question:useall', 1, 1320247901, 0),
(222, 1, 1, 'moodle/question:useall', 1, 1320247901, 0),
(223, 1, 3, 'moodle/question:movemine', 1, 1320247901, 0),
(224, 1, 1, 'moodle/question:movemine', 1, 1320247901, 0),
(225, 1, 3, 'moodle/question:moveall', 1, 1320247901, 0),
(226, 1, 1, 'moodle/question:moveall', 1, 1320247901, 0),
(227, 1, 1, 'moodle/question:config', 1, 1320247901, 0),
(228, 1, 5, 'moodle/question:flag', 1, 1320247901, 0),
(229, 1, 4, 'moodle/question:flag', 1, 1320247901, 0),
(230, 1, 3, 'moodle/question:flag', 1, 1320247902, 0),
(231, 1, 1, 'moodle/question:flag', 1, 1320247902, 0),
(232, 1, 4, 'moodle/site:doclinks', 1, 1320247902, 0),
(233, 1, 3, 'moodle/site:doclinks', 1, 1320247902, 0),
(234, 1, 1, 'moodle/site:doclinks', 1, 1320247902, 0),
(235, 1, 3, 'moodle/course:sectionvisibility', 1, 1320247902, 0),
(236, 1, 1, 'moodle/course:sectionvisibility', 1, 1320247902, 0),
(237, 1, 3, 'moodle/course:useremail', 1, 1320247902, 0),
(238, 1, 1, 'moodle/course:useremail', 1, 1320247902, 0),
(239, 1, 3, 'moodle/course:viewhiddensections', 1, 1320247902, 0),
(240, 1, 1, 'moodle/course:viewhiddensections', 1, 1320247902, 0),
(241, 1, 3, 'moodle/course:setcurrentsection', 1, 1320247903, 0),
(242, 1, 1, 'moodle/course:setcurrentsection', 1, 1320247903, 0),
(243, 1, 4, 'moodle/grade:viewall', 1, 1320247903, 0),
(244, 1, 3, 'moodle/grade:viewall', 1, 1320247903, 0),
(245, 1, 1, 'moodle/grade:viewall', 1, 1320247903, 0),
(246, 1, 5, 'moodle/grade:view', 1, 1320247903, 0),
(247, 1, 4, 'moodle/grade:viewhidden', 1, 1320247903, 0),
(248, 1, 3, 'moodle/grade:viewhidden', 1, 1320247903, 0),
(249, 1, 1, 'moodle/grade:viewhidden', 1, 1320247903, 0),
(250, 1, 3, 'moodle/grade:import', 1, 1320247903, 0),
(251, 1, 1, 'moodle/grade:import', 1, 1320247903, 0),
(252, 1, 4, 'moodle/grade:export', 1, 1320247904, 0),
(253, 1, 3, 'moodle/grade:export', 1, 1320247904, 0),
(254, 1, 1, 'moodle/grade:export', 1, 1320247904, 0),
(255, 1, 3, 'moodle/grade:manage', 1, 1320247904, 0),
(256, 1, 1, 'moodle/grade:manage', 1, 1320247904, 0),
(257, 1, 3, 'moodle/grade:edit', 1, 1320247904, 0),
(258, 1, 1, 'moodle/grade:edit', 1, 1320247904, 0),
(259, 1, 3, 'moodle/grade:manageoutcomes', 1, 1320247904, 0),
(260, 1, 1, 'moodle/grade:manageoutcomes', 1, 1320247905, 0),
(261, 1, 3, 'moodle/grade:manageletters', 1, 1320247905, 0),
(262, 1, 1, 'moodle/grade:manageletters', 1, 1320247905, 0),
(263, 1, 3, 'moodle/grade:hide', 1, 1320247905, 0),
(264, 1, 1, 'moodle/grade:hide', 1, 1320247905, 0),
(265, 1, 3, 'moodle/grade:lock', 1, 1320247905, 0),
(266, 1, 1, 'moodle/grade:lock', 1, 1320247905, 0),
(267, 1, 3, 'moodle/grade:unlock', 1, 1320247905, 0),
(268, 1, 1, 'moodle/grade:unlock', 1, 1320247905, 0),
(269, 1, 7, 'moodle/my:manageblocks', 1, 1320247905, 0),
(270, 1, 4, 'moodle/notes:view', 1, 1320247905, 0),
(271, 1, 3, 'moodle/notes:view', 1, 1320247906, 0),
(272, 1, 1, 'moodle/notes:view', 1, 1320247906, 0),
(273, 1, 4, 'moodle/notes:manage', 1, 1320247906, 0),
(274, 1, 3, 'moodle/notes:manage', 1, 1320247906, 0),
(275, 1, 1, 'moodle/notes:manage', 1, 1320247906, 0),
(276, 1, 4, 'moodle/tag:manage', 1, 1320247906, 0),
(277, 1, 3, 'moodle/tag:manage', 1, 1320247906, 0),
(278, 1, 1, 'moodle/tag:manage', 1, 1320247906, 0),
(279, 1, 1, 'moodle/tag:create', 1, 1320247906, 0),
(280, 1, 7, 'moodle/tag:create', 1, 1320247906, 0),
(281, 1, 1, 'moodle/tag:edit', 1, 1320247906, 0),
(282, 1, 7, 'moodle/tag:edit', 1, 1320247906, 0),
(283, 1, 4, 'moodle/tag:editblocks', 1, 1320247907, 0),
(284, 1, 3, 'moodle/tag:editblocks', 1, 1320247907, 0),
(285, 1, 1, 'moodle/tag:editblocks', 1, 1320247907, 0),
(286, 1, 6, 'moodle/block:view', 1, 1320247907, 0),
(287, 1, 7, 'moodle/block:view', 1, 1320247907, 0),
(288, 1, 5, 'moodle/block:view', 1, 1320247907, 0),
(289, 1, 4, 'moodle/block:view', 1, 1320247907, 0),
(290, 1, 3, 'moodle/block:view', 1, 1320247907, 0),
(291, 1, 3, 'moodle/block:edit', 1, 1320247907, 0),
(292, 1, 7, 'moodle/portfolio:export', 1, 1320247907, 0),
(293, 1, 5, 'moodle/portfolio:export', 1, 1320247907, 0),
(294, 1, 4, 'moodle/portfolio:export', 1, 1320247907, 0),
(295, 1, 3, 'moodle/portfolio:export', 1, 1320247907, 0),
(296, 1, 8, 'moodle/comment:view', 1, 1320247908, 0),
(297, 1, 6, 'moodle/comment:view', 1, 1320247908, 0),
(298, 1, 7, 'moodle/comment:view', 1, 1320247908, 0),
(299, 1, 5, 'moodle/comment:view', 1, 1320247908, 0),
(300, 1, 4, 'moodle/comment:view', 1, 1320247908, 0),
(301, 1, 3, 'moodle/comment:view', 1, 1320247908, 0),
(302, 1, 1, 'moodle/comment:view', 1, 1320247908, 0),
(303, 1, 7, 'moodle/comment:post', 1, 1320247909, 0),
(304, 1, 5, 'moodle/comment:post', 1, 1320247909, 0),
(305, 1, 4, 'moodle/comment:post', 1, 1320247909, 0),
(306, 1, 3, 'moodle/comment:post', 1, 1320247909, 0),
(307, 1, 1, 'moodle/comment:post', 1, 1320247909, 0),
(308, 1, 3, 'moodle/comment:delete', 1, 1320247909, 0),
(309, 1, 1, 'moodle/comment:delete', 1, 1320247909, 0),
(310, 1, 1, 'moodle/webservice:createtoken', 1, 1320247909, 0),
(311, 1, 7, 'moodle/webservice:createmobiletoken', 1, 1320247909, 0),
(312, 1, 7, 'moodle/rating:view', 1, 1320247910, 0),
(313, 1, 5, 'moodle/rating:view', 1, 1320247910, 0),
(314, 1, 4, 'moodle/rating:view', 1, 1320247910, 0),
(315, 1, 3, 'moodle/rating:view', 1, 1320247910, 0),
(316, 1, 1, 'moodle/rating:view', 1, 1320247910, 0),
(317, 1, 7, 'moodle/rating:viewany', 1, 1320247910, 0),
(318, 1, 5, 'moodle/rating:viewany', 1, 1320247910, 0),
(319, 1, 4, 'moodle/rating:viewany', 1, 1320247910, 0),
(320, 1, 3, 'moodle/rating:viewany', 1, 1320247910, 0),
(321, 1, 1, 'moodle/rating:viewany', 1, 1320247910, 0),
(322, 1, 7, 'moodle/rating:viewall', 1, 1320247910, 0),
(323, 1, 5, 'moodle/rating:viewall', 1, 1320247910, 0),
(324, 1, 4, 'moodle/rating:viewall', 1, 1320247910, 0),
(325, 1, 3, 'moodle/rating:viewall', 1, 1320247911, 0),
(326, 1, 1, 'moodle/rating:viewall', 1, 1320247911, 0),
(327, 1, 7, 'moodle/rating:rate', 1, 1320247911, 0),
(328, 1, 5, 'moodle/rating:rate', 1, 1320247911, 0),
(329, 1, 4, 'moodle/rating:rate', 1, 1320247911, 0),
(330, 1, 3, 'moodle/rating:rate', 1, 1320247911, 0),
(331, 1, 1, 'moodle/rating:rate', 1, 1320247911, 0),
(332, 1, 1, 'moodle/course:publish', 1, 1320247911, 0),
(333, 1, 4, 'moodle/course:markcomplete', 1, 1320247911, 0),
(334, 1, 3, 'moodle/course:markcomplete', 1, 1320247911, 0),
(335, 1, 1, 'moodle/course:markcomplete', 1, 1320247911, 0),
(336, 1, 1, 'moodle/community:add', 1, 1320247912, 0),
(337, 1, 4, 'moodle/community:add', 1, 1320247912, 0),
(338, 1, 3, 'moodle/community:add', 1, 1320247912, 0),
(339, 1, 1, 'moodle/community:download', 1, 1320247912, 0),
(340, 1, 3, 'moodle/community:download', 1, 1320247912, 0),
(341, 1, 6, 'mod/assignment:view', 1, 1320248005, 0),
(342, 1, 5, 'mod/assignment:view', 1, 1320248005, 0),
(343, 1, 4, 'mod/assignment:view', 1, 1320248005, 0),
(344, 1, 3, 'mod/assignment:view', 1, 1320248005, 0),
(345, 1, 1, 'mod/assignment:view', 1, 1320248006, 0),
(346, 1, 5, 'mod/assignment:submit', 1, 1320248006, 0),
(347, 1, 4, 'mod/assignment:grade', 1, 1320248006, 0),
(348, 1, 3, 'mod/assignment:grade', 1, 1320248006, 0),
(349, 1, 1, 'mod/assignment:grade', 1, 1320248006, 0),
(350, 1, 4, 'mod/assignment:exportownsubmission', 1, 1320248006, 0),
(351, 1, 3, 'mod/assignment:exportownsubmission', 1, 1320248006, 0),
(352, 1, 1, 'mod/assignment:exportownsubmission', 1, 1320248007, 0),
(353, 1, 5, 'mod/assignment:exportownsubmission', 1, 1320248007, 0),
(354, 1, 5, 'mod/chat:chat', 1, 1320248014, 0),
(355, 1, 4, 'mod/chat:chat', 1, 1320248014, 0),
(356, 1, 3, 'mod/chat:chat', 1, 1320248014, 0),
(357, 1, 1, 'mod/chat:chat', 1, 1320248014, 0),
(358, 1, 5, 'mod/chat:readlog', 1, 1320248014, 0),
(359, 1, 4, 'mod/chat:readlog', 1, 1320248014, 0),
(360, 1, 3, 'mod/chat:readlog', 1, 1320248014, 0),
(361, 1, 1, 'mod/chat:readlog', 1, 1320248014, 0),
(362, 1, 4, 'mod/chat:deletelog', 1, 1320248014, 0),
(363, 1, 3, 'mod/chat:deletelog', 1, 1320248014, 0),
(364, 1, 1, 'mod/chat:deletelog', 1, 1320248014, 0),
(365, 1, 4, 'mod/chat:exportparticipatedsession', 1, 1320248015, 0),
(366, 1, 3, 'mod/chat:exportparticipatedsession', 1, 1320248015, 0),
(367, 1, 1, 'mod/chat:exportparticipatedsession', 1, 1320248015, 0),
(368, 1, 4, 'mod/chat:exportsession', 1, 1320248015, 0),
(369, 1, 3, 'mod/chat:exportsession', 1, 1320248015, 0),
(370, 1, 1, 'mod/chat:exportsession', 1, 1320248015, 0),
(371, 1, 5, 'mod/choice:choose', 1, 1320248019, 0),
(372, 1, 4, 'mod/choice:choose', 1, 1320248019, 0),
(373, 1, 3, 'mod/choice:choose', 1, 1320248019, 0),
(374, 1, 4, 'mod/choice:readresponses', 1, 1320248019, 0),
(375, 1, 3, 'mod/choice:readresponses', 1, 1320248019, 0),
(376, 1, 1, 'mod/choice:readresponses', 1, 1320248019, 0),
(377, 1, 4, 'mod/choice:deleteresponses', 1, 1320248020, 0),
(378, 1, 3, 'mod/choice:deleteresponses', 1, 1320248020, 0),
(379, 1, 1, 'mod/choice:deleteresponses', 1, 1320248020, 0),
(380, 1, 4, 'mod/choice:downloadresponses', 1, 1320248020, 0),
(381, 1, 3, 'mod/choice:downloadresponses', 1, 1320248020, 0),
(382, 1, 1, 'mod/choice:downloadresponses', 1, 1320248020, 0),
(383, 1, 8, 'mod/data:viewentry', 1, 1320248024, 0),
(384, 1, 6, 'mod/data:viewentry', 1, 1320248024, 0),
(385, 1, 5, 'mod/data:viewentry', 1, 1320248024, 0),
(386, 1, 4, 'mod/data:viewentry', 1, 1320248024, 0),
(387, 1, 3, 'mod/data:viewentry', 1, 1320248024, 0),
(388, 1, 1, 'mod/data:viewentry', 1, 1320248024, 0),
(389, 1, 5, 'mod/data:writeentry', 1, 1320248024, 0),
(390, 1, 4, 'mod/data:writeentry', 1, 1320248024, 0),
(391, 1, 3, 'mod/data:writeentry', 1, 1320248024, 0),
(392, 1, 1, 'mod/data:writeentry', 1, 1320248025, 0),
(393, 1, 5, 'mod/data:comment', 1, 1320248025, 0),
(394, 1, 4, 'mod/data:comment', 1, 1320248025, 0),
(395, 1, 3, 'mod/data:comment', 1, 1320248025, 0),
(396, 1, 1, 'mod/data:comment', 1, 1320248025, 0),
(397, 1, 4, 'mod/data:rate', 1, 1320248025, 0),
(398, 1, 3, 'mod/data:rate', 1, 1320248025, 0),
(399, 1, 1, 'mod/data:rate', 1, 1320248025, 0),
(400, 1, 4, 'mod/data:viewrating', 1, 1320248025, 0),
(401, 1, 3, 'mod/data:viewrating', 1, 1320248025, 0),
(402, 1, 1, 'mod/data:viewrating', 1, 1320248026, 0),
(403, 1, 4, 'mod/data:viewanyrating', 1, 1320248026, 0),
(404, 1, 3, 'mod/data:viewanyrating', 1, 1320248026, 0),
(405, 1, 1, 'mod/data:viewanyrating', 1, 1320248026, 0),
(406, 1, 4, 'mod/data:viewallratings', 1, 1320248026, 0),
(407, 1, 3, 'mod/data:viewallratings', 1, 1320248026, 0),
(408, 1, 1, 'mod/data:viewallratings', 1, 1320248026, 0),
(409, 1, 4, 'mod/data:approve', 1, 1320248026, 0),
(410, 1, 3, 'mod/data:approve', 1, 1320248026, 0),
(411, 1, 1, 'mod/data:approve', 1, 1320248026, 0),
(412, 1, 4, 'mod/data:manageentries', 1, 1320248026, 0),
(413, 1, 3, 'mod/data:manageentries', 1, 1320248027, 0),
(414, 1, 1, 'mod/data:manageentries', 1, 1320248027, 0),
(415, 1, 4, 'mod/data:managecomments', 1, 1320248027, 0),
(416, 1, 3, 'mod/data:managecomments', 1, 1320248027, 0),
(417, 1, 1, 'mod/data:managecomments', 1, 1320248027, 0),
(418, 1, 3, 'mod/data:managetemplates', 1, 1320248027, 0),
(419, 1, 1, 'mod/data:managetemplates', 1, 1320248027, 0),
(420, 1, 4, 'mod/data:viewalluserpresets', 1, 1320248027, 0),
(421, 1, 3, 'mod/data:viewalluserpresets', 1, 1320248027, 0),
(422, 1, 1, 'mod/data:viewalluserpresets', 1, 1320248027, 0),
(423, 1, 1, 'mod/data:manageuserpresets', 1, 1320248028, 0),
(424, 1, 1, 'mod/data:exportentry', 1, 1320248028, 0),
(425, 1, 4, 'mod/data:exportentry', 1, 1320248028, 0),
(426, 1, 3, 'mod/data:exportentry', 1, 1320248028, 0),
(427, 1, 1, 'mod/data:exportownentry', 1, 1320248028, 0),
(428, 1, 4, 'mod/data:exportownentry', 1, 1320248028, 0),
(429, 1, 3, 'mod/data:exportownentry', 1, 1320248028, 0),
(430, 1, 5, 'mod/data:exportownentry', 1, 1320248028, 0),
(431, 1, 1, 'mod/data:exportallentries', 1, 1320248029, 0),
(432, 1, 4, 'mod/data:exportallentries', 1, 1320248029, 0),
(433, 1, 3, 'mod/data:exportallentries', 1, 1320248029, 0),
(434, 1, 6, 'mod/feedback:view', 1, 1320248040, 0),
(435, 1, 5, 'mod/feedback:view', 1, 1320248040, 0),
(436, 1, 4, 'mod/feedback:view', 1, 1320248040, 0),
(437, 1, 3, 'mod/feedback:view', 1, 1320248040, 0),
(438, 1, 1, 'mod/feedback:view', 1, 1320248040, 0),
(439, 1, 5, 'mod/feedback:complete', 1, 1320248040, 0),
(440, 1, 5, 'mod/feedback:viewanalysepage', 1, 1320248040, 0),
(441, 1, 3, 'mod/feedback:viewanalysepage', 1, 1320248040, 0),
(442, 1, 1, 'mod/feedback:viewanalysepage', 1, 1320248040, 0),
(443, 1, 3, 'mod/feedback:deletesubmissions', 1, 1320248040, 0),
(444, 1, 1, 'mod/feedback:deletesubmissions', 1, 1320248040, 0),
(445, 1, 1, 'mod/feedback:mapcourse', 1, 1320248041, 0),
(446, 1, 3, 'mod/feedback:edititems', 1, 1320248041, 0),
(447, 1, 1, 'mod/feedback:edititems', 1, 1320248041, 0),
(448, 1, 3, 'mod/feedback:createprivatetemplate', 1, 1320248042, 0),
(449, 1, 1, 'mod/feedback:createprivatetemplate', 1, 1320248042, 0),
(450, 1, 3, 'mod/feedback:createpublictemplate', 1, 1320248042, 0),
(451, 1, 1, 'mod/feedback:createpublictemplate', 1, 1320248042, 0),
(452, 1, 3, 'mod/feedback:deletetemplate', 1, 1320248042, 0),
(453, 1, 1, 'mod/feedback:deletetemplate', 1, 1320248042, 0),
(454, 1, 4, 'mod/feedback:viewreports', 1, 1320248042, 0),
(455, 1, 3, 'mod/feedback:viewreports', 1, 1320248042, 0),
(456, 1, 1, 'mod/feedback:viewreports', 1, 1320248042, 0),
(457, 1, 4, 'mod/feedback:receivemail', 1, 1320248042, 0),
(458, 1, 3, 'mod/feedback:receivemail', 1, 1320248043, 0),
(459, 1, 6, 'mod/folder:view', 1, 1320248044, 0),
(460, 1, 7, 'mod/folder:view', 1, 1320248044, 0),
(461, 1, 3, 'mod/folder:managefiles', 1, 1320248045, 0),
(462, 1, 8, 'mod/forum:viewdiscussion', 1, 1320248054, 0),
(463, 1, 6, 'mod/forum:viewdiscussion', 1, 1320248054, 0),
(464, 1, 5, 'mod/forum:viewdiscussion', 1, 1320248054, 0),
(465, 1, 4, 'mod/forum:viewdiscussion', 1, 1320248055, 0),
(466, 1, 3, 'mod/forum:viewdiscussion', 1, 1320248055, 0),
(467, 1, 1, 'mod/forum:viewdiscussion', 1, 1320248055, 0),
(468, 1, 4, 'mod/forum:viewhiddentimedposts', 1, 1320248055, 0),
(469, 1, 3, 'mod/forum:viewhiddentimedposts', 1, 1320248055, 0),
(470, 1, 1, 'mod/forum:viewhiddentimedposts', 1, 1320248055, 0),
(471, 1, 5, 'mod/forum:startdiscussion', 1, 1320248055, 0),
(472, 1, 4, 'mod/forum:startdiscussion', 1, 1320248055, 0),
(473, 1, 3, 'mod/forum:startdiscussion', 1, 1320248055, 0),
(474, 1, 1, 'mod/forum:startdiscussion', 1, 1320248055, 0),
(475, 1, 5, 'mod/forum:replypost', 1, 1320248055, 0),
(476, 1, 4, 'mod/forum:replypost', 1, 1320248056, 0),
(477, 1, 3, 'mod/forum:replypost', 1, 1320248056, 0),
(478, 1, 1, 'mod/forum:replypost', 1, 1320248056, 0),
(479, 1, 4, 'mod/forum:addnews', 1, 1320248056, 0),
(480, 1, 3, 'mod/forum:addnews', 1, 1320248056, 0),
(481, 1, 1, 'mod/forum:addnews', 1, 1320248056, 0),
(482, 1, 4, 'mod/forum:replynews', 1, 1320248056, 0),
(483, 1, 3, 'mod/forum:replynews', 1, 1320248056, 0),
(484, 1, 1, 'mod/forum:replynews', 1, 1320248056, 0),
(485, 1, 5, 'mod/forum:viewrating', 1, 1320248056, 0),
(486, 1, 4, 'mod/forum:viewrating', 1, 1320248056, 0),
(487, 1, 3, 'mod/forum:viewrating', 1, 1320248056, 0),
(488, 1, 1, 'mod/forum:viewrating', 1, 1320248057, 0),
(489, 1, 4, 'mod/forum:viewanyrating', 1, 1320248057, 0),
(490, 1, 3, 'mod/forum:viewanyrating', 1, 1320248057, 0),
(491, 1, 1, 'mod/forum:viewanyrating', 1, 1320248057, 0),
(492, 1, 4, 'mod/forum:viewallratings', 1, 1320248057, 0),
(493, 1, 3, 'mod/forum:viewallratings', 1, 1320248057, 0),
(494, 1, 1, 'mod/forum:viewallratings', 1, 1320248057, 0),
(495, 1, 4, 'mod/forum:rate', 1, 1320248057, 0),
(496, 1, 3, 'mod/forum:rate', 1, 1320248057, 0),
(497, 1, 1, 'mod/forum:rate', 1, 1320248057, 0),
(498, 1, 5, 'mod/forum:createattachment', 1, 1320248057, 0),
(499, 1, 4, 'mod/forum:createattachment', 1, 1320248057, 0),
(500, 1, 3, 'mod/forum:createattachment', 1, 1320248058, 0),
(501, 1, 1, 'mod/forum:createattachment', 1, 1320248058, 0),
(502, 1, 5, 'mod/forum:deleteownpost', 1, 1320248058, 0),
(503, 1, 4, 'mod/forum:deleteownpost', 1, 1320248058, 0),
(504, 1, 3, 'mod/forum:deleteownpost', 1, 1320248058, 0),
(505, 1, 1, 'mod/forum:deleteownpost', 1, 1320248058, 0),
(506, 1, 4, 'mod/forum:deleteanypost', 1, 1320248058, 0),
(507, 1, 3, 'mod/forum:deleteanypost', 1, 1320248058, 0),
(508, 1, 1, 'mod/forum:deleteanypost', 1, 1320248058, 0),
(509, 1, 4, 'mod/forum:splitdiscussions', 1, 1320248058, 0),
(510, 1, 3, 'mod/forum:splitdiscussions', 1, 1320248058, 0),
(511, 1, 1, 'mod/forum:splitdiscussions', 1, 1320248058, 0),
(512, 1, 4, 'mod/forum:movediscussions', 1, 1320248058, 0),
(513, 1, 3, 'mod/forum:movediscussions', 1, 1320248059, 0),
(514, 1, 1, 'mod/forum:movediscussions', 1, 1320248059, 0),
(515, 1, 4, 'mod/forum:editanypost', 1, 1320248059, 0),
(516, 1, 3, 'mod/forum:editanypost', 1, 1320248059, 0),
(517, 1, 1, 'mod/forum:editanypost', 1, 1320248059, 0),
(518, 1, 4, 'mod/forum:viewqandawithoutposting', 1, 1320248059, 0),
(519, 1, 3, 'mod/forum:viewqandawithoutposting', 1, 1320248059, 0),
(520, 1, 1, 'mod/forum:viewqandawithoutposting', 1, 1320248059, 0),
(521, 1, 4, 'mod/forum:viewsubscribers', 1, 1320248059, 0),
(522, 1, 3, 'mod/forum:viewsubscribers', 1, 1320248059, 0),
(523, 1, 1, 'mod/forum:viewsubscribers', 1, 1320248059, 0),
(524, 1, 4, 'mod/forum:managesubscriptions', 1, 1320248059, 0),
(525, 1, 3, 'mod/forum:managesubscriptions', 1, 1320248060, 0),
(526, 1, 1, 'mod/forum:managesubscriptions', 1, 1320248060, 0),
(527, 1, 4, 'mod/forum:initialsubscriptions', 1, 1320248060, 0),
(528, 1, 3, 'mod/forum:initialsubscriptions', 1, 1320248060, 0),
(529, 1, 5, 'mod/forum:initialsubscriptions', 1, 1320248060, 0),
(530, 1, 4, 'mod/forum:postwithoutthrottling', 1, 1320248060, 0),
(531, 1, 3, 'mod/forum:postwithoutthrottling', 1, 1320248060, 0),
(532, 1, 1, 'mod/forum:postwithoutthrottling', 1, 1320248060, 0),
(533, 1, 4, 'mod/forum:exportdiscussion', 1, 1320248060, 0),
(534, 1, 3, 'mod/forum:exportdiscussion', 1, 1320248060, 0),
(535, 1, 1, 'mod/forum:exportdiscussion', 1, 1320248060, 0),
(536, 1, 4, 'mod/forum:exportpost', 1, 1320248060, 0),
(537, 1, 3, 'mod/forum:exportpost', 1, 1320248061, 0),
(538, 1, 1, 'mod/forum:exportpost', 1, 1320248061, 0),
(539, 1, 4, 'mod/forum:exportownpost', 1, 1320248061, 0),
(540, 1, 3, 'mod/forum:exportownpost', 1, 1320248061, 0),
(541, 1, 1, 'mod/forum:exportownpost', 1, 1320248061, 0),
(542, 1, 5, 'mod/forum:exportownpost', 1, 1320248061, 0),
(543, 1, 5, 'mod/glossary:write', 1, 1320248068, 0),
(544, 1, 4, 'mod/glossary:write', 1, 1320248069, 0),
(545, 1, 3, 'mod/glossary:write', 1, 1320248069, 0),
(546, 1, 1, 'mod/glossary:write', 1, 1320248069, 0),
(547, 1, 4, 'mod/glossary:manageentries', 1, 1320248069, 0),
(548, 1, 3, 'mod/glossary:manageentries', 1, 1320248069, 0),
(549, 1, 1, 'mod/glossary:manageentries', 1, 1320248069, 0),
(550, 1, 4, 'mod/glossary:managecategories', 1, 1320248069, 0),
(551, 1, 3, 'mod/glossary:managecategories', 1, 1320248069, 0),
(552, 1, 1, 'mod/glossary:managecategories', 1, 1320248069, 0),
(553, 1, 5, 'mod/glossary:comment', 1, 1320248069, 0),
(554, 1, 4, 'mod/glossary:comment', 1, 1320248069, 0),
(555, 1, 3, 'mod/glossary:comment', 1, 1320248069, 0),
(556, 1, 1, 'mod/glossary:comment', 1, 1320248070, 0),
(557, 1, 4, 'mod/glossary:managecomments', 1, 1320248070, 0),
(558, 1, 3, 'mod/glossary:managecomments', 1, 1320248070, 0),
(559, 1, 1, 'mod/glossary:managecomments', 1, 1320248070, 0),
(560, 1, 4, 'mod/glossary:import', 1, 1320248070, 0),
(561, 1, 3, 'mod/glossary:import', 1, 1320248070, 0),
(562, 1, 1, 'mod/glossary:import', 1, 1320248070, 0),
(563, 1, 4, 'mod/glossary:export', 1, 1320248070, 0),
(564, 1, 3, 'mod/glossary:export', 1, 1320248070, 0),
(565, 1, 1, 'mod/glossary:export', 1, 1320248070, 0),
(566, 1, 4, 'mod/glossary:approve', 1, 1320248070, 0),
(567, 1, 3, 'mod/glossary:approve', 1, 1320248070, 0),
(568, 1, 1, 'mod/glossary:approve', 1, 1320248071, 0),
(569, 1, 4, 'mod/glossary:rate', 1, 1320248071, 0),
(570, 1, 3, 'mod/glossary:rate', 1, 1320248071, 0),
(571, 1, 1, 'mod/glossary:rate', 1, 1320248071, 0),
(572, 1, 4, 'mod/glossary:viewrating', 1, 1320248071, 0),
(573, 1, 3, 'mod/glossary:viewrating', 1, 1320248071, 0),
(574, 1, 1, 'mod/glossary:viewrating', 1, 1320248071, 0),
(575, 1, 4, 'mod/glossary:viewanyrating', 1, 1320248071, 0),
(576, 1, 3, 'mod/glossary:viewanyrating', 1, 1320248071, 0),
(577, 1, 1, 'mod/glossary:viewanyrating', 1, 1320248071, 0),
(578, 1, 4, 'mod/glossary:viewallratings', 1, 1320248072, 0),
(579, 1, 3, 'mod/glossary:viewallratings', 1, 1320248072, 0),
(580, 1, 1, 'mod/glossary:viewallratings', 1, 1320248072, 0),
(581, 1, 4, 'mod/glossary:exportentry', 1, 1320248072, 0),
(582, 1, 3, 'mod/glossary:exportentry', 1, 1320248072, 0),
(583, 1, 1, 'mod/glossary:exportentry', 1, 1320248072, 0),
(584, 1, 4, 'mod/glossary:exportownentry', 1, 1320248072, 0),
(585, 1, 3, 'mod/glossary:exportownentry', 1, 1320248072, 0),
(586, 1, 1, 'mod/glossary:exportownentry', 1, 1320248072, 0),
(587, 1, 5, 'mod/glossary:exportownentry', 1, 1320248072, 0),
(588, 1, 6, 'mod/imscp:view', 1, 1320248074, 0),
(589, 1, 7, 'mod/imscp:view', 1, 1320248074, 0),
(590, 1, 3, 'mod/lesson:edit', 1, 1320248086, 0),
(591, 1, 1, 'mod/lesson:edit', 1, 1320248086, 0),
(592, 1, 4, 'mod/lesson:manage', 1, 1320248086, 0),
(593, 1, 3, 'mod/lesson:manage', 1, 1320248086, 0),
(594, 1, 1, 'mod/lesson:manage', 1, 1320248086, 0),
(595, 1, 6, 'mod/page:view', 1, 1320248089, 0),
(596, 1, 7, 'mod/page:view', 1, 1320248089, 0),
(597, 1, 6, 'mod/quiz:view', 1, 1320248095, 0),
(598, 1, 5, 'mod/quiz:view', 1, 1320248096, 0),
(599, 1, 4, 'mod/quiz:view', 1, 1320248096, 0),
(600, 1, 3, 'mod/quiz:view', 1, 1320248096, 0),
(601, 1, 1, 'mod/quiz:view', 1, 1320248096, 0),
(602, 1, 5, 'mod/quiz:attempt', 1, 1320248096, 0),
(603, 1, 5, 'mod/quiz:reviewmyattempts', 1, 1320248096, 0),
(604, 1, 3, 'mod/quiz:manage', 1, 1320248096, 0),
(605, 1, 1, 'mod/quiz:manage', 1, 1320248096, 0),
(606, 1, 3, 'mod/quiz:manageoverrides', 1, 1320248096, 0),
(607, 1, 1, 'mod/quiz:manageoverrides', 1, 1320248096, 0),
(608, 1, 4, 'mod/quiz:preview', 1, 1320248096, 0),
(609, 1, 3, 'mod/quiz:preview', 1, 1320248096, 0),
(610, 1, 1, 'mod/quiz:preview', 1, 1320248097, 0),
(611, 1, 4, 'mod/quiz:grade', 1, 1320248097, 0),
(612, 1, 3, 'mod/quiz:grade', 1, 1320248097, 0),
(613, 1, 1, 'mod/quiz:grade', 1, 1320248097, 0),
(614, 1, 4, 'mod/quiz:regrade', 1, 1320248097, 0),
(615, 1, 3, 'mod/quiz:regrade', 1, 1320248097, 0),
(616, 1, 1, 'mod/quiz:regrade', 1, 1320248097, 0),
(617, 1, 4, 'mod/quiz:viewreports', 1, 1320248097, 0),
(618, 1, 3, 'mod/quiz:viewreports', 1, 1320248097, 0),
(619, 1, 1, 'mod/quiz:viewreports', 1, 1320248097, 0),
(620, 1, 3, 'mod/quiz:deleteattempts', 1, 1320248098, 0),
(621, 1, 1, 'mod/quiz:deleteattempts', 1, 1320248098, 0),
(622, 1, 6, 'mod/resource:view', 1, 1320248102, 0),
(623, 1, 7, 'mod/resource:view', 1, 1320248102, 0),
(624, 1, 4, 'mod/scorm:viewreport', 1, 1320248114, 0),
(625, 1, 3, 'mod/scorm:viewreport', 1, 1320248114, 0),
(626, 1, 1, 'mod/scorm:viewreport', 1, 1320248114, 0),
(627, 1, 5, 'mod/scorm:skipview', 1, 1320248114, 0),
(628, 1, 5, 'mod/scorm:savetrack', 1, 1320248114, 0),
(629, 1, 4, 'mod/scorm:savetrack', 1, 1320248114, 0),
(630, 1, 3, 'mod/scorm:savetrack', 1, 1320248114, 0),
(631, 1, 1, 'mod/scorm:savetrack', 1, 1320248114, 0),
(632, 1, 5, 'mod/scorm:viewscores', 1, 1320248114, 0),
(633, 1, 4, 'mod/scorm:viewscores', 1, 1320248115, 0),
(634, 1, 3, 'mod/scorm:viewscores', 1, 1320248115, 0),
(635, 1, 1, 'mod/scorm:viewscores', 1, 1320248115, 0),
(636, 1, 4, 'mod/scorm:deleteresponses', 1, 1320248115, 0),
(637, 1, 3, 'mod/scorm:deleteresponses', 1, 1320248115, 0),
(638, 1, 1, 'mod/scorm:deleteresponses', 1, 1320248115, 0),
(639, 1, 5, 'mod/survey:participate', 1, 1320248125, 0),
(640, 1, 4, 'mod/survey:participate', 1, 1320248125, 0),
(641, 1, 3, 'mod/survey:participate', 1, 1320248125, 0),
(642, 1, 1, 'mod/survey:participate', 1, 1320248125, 0),
(643, 1, 4, 'mod/survey:readresponses', 1, 1320248125, 0),
(644, 1, 3, 'mod/survey:readresponses', 1, 1320248125, 0),
(645, 1, 1, 'mod/survey:readresponses', 1, 1320248125, 0),
(646, 1, 4, 'mod/survey:download', 1, 1320248125, 0),
(647, 1, 3, 'mod/survey:download', 1, 1320248125, 0),
(648, 1, 1, 'mod/survey:download', 1, 1320248126, 0),
(649, 1, 6, 'mod/url:view', 1, 1320248128, 0),
(650, 1, 7, 'mod/url:view', 1, 1320248128, 0),
(651, 1, 6, 'mod/wiki:viewpage', 1, 1320248134, 0),
(652, 1, 5, 'mod/wiki:viewpage', 1, 1320248134, 0),
(653, 1, 4, 'mod/wiki:viewpage', 1, 1320248134, 0),
(654, 1, 3, 'mod/wiki:viewpage', 1, 1320248134, 0),
(655, 1, 1, 'mod/wiki:viewpage', 1, 1320248135, 0),
(656, 1, 5, 'mod/wiki:editpage', 1, 1320248135, 0),
(657, 1, 4, 'mod/wiki:editpage', 1, 1320248135, 0),
(658, 1, 3, 'mod/wiki:editpage', 1, 1320248135, 0),
(659, 1, 1, 'mod/wiki:editpage', 1, 1320248135, 0),
(660, 1, 5, 'mod/wiki:createpage', 1, 1320248135, 0),
(661, 1, 4, 'mod/wiki:createpage', 1, 1320248135, 0),
(662, 1, 3, 'mod/wiki:createpage', 1, 1320248135, 0),
(663, 1, 1, 'mod/wiki:createpage', 1, 1320248135, 0),
(664, 1, 5, 'mod/wiki:viewcomment', 1, 1320248135, 0),
(665, 1, 4, 'mod/wiki:viewcomment', 1, 1320248135, 0),
(666, 1, 3, 'mod/wiki:viewcomment', 1, 1320248135, 0),
(667, 1, 1, 'mod/wiki:viewcomment', 1, 1320248135, 0),
(668, 1, 5, 'mod/wiki:editcomment', 1, 1320248136, 0),
(669, 1, 4, 'mod/wiki:editcomment', 1, 1320248136, 0),
(670, 1, 3, 'mod/wiki:editcomment', 1, 1320248136, 0),
(671, 1, 1, 'mod/wiki:editcomment', 1, 1320248136, 0),
(672, 1, 4, 'mod/wiki:managecomment', 1, 1320248136, 0),
(673, 1, 3, 'mod/wiki:managecomment', 1, 1320248136, 0),
(674, 1, 1, 'mod/wiki:managecomment', 1, 1320248136, 0),
(675, 1, 4, 'mod/wiki:managefiles', 1, 1320248136, 0),
(676, 1, 3, 'mod/wiki:managefiles', 1, 1320248136, 0),
(677, 1, 1, 'mod/wiki:managefiles', 1, 1320248136, 0),
(678, 1, 4, 'mod/wiki:overridelock', 1, 1320248137, 0),
(679, 1, 3, 'mod/wiki:overridelock', 1, 1320248137, 0),
(680, 1, 1, 'mod/wiki:overridelock', 1, 1320248137, 0),
(681, 1, 4, 'mod/wiki:managewiki', 1, 1320248137, 0),
(682, 1, 3, 'mod/wiki:managewiki', 1, 1320248137, 0),
(683, 1, 1, 'mod/wiki:managewiki', 1, 1320248137, 0),
(684, 1, 6, 'mod/workshop:view', 1, 1320248152, 0),
(685, 1, 5, 'mod/workshop:view', 1, 1320248152, 0),
(686, 1, 4, 'mod/workshop:view', 1, 1320248152, 0),
(687, 1, 3, 'mod/workshop:view', 1, 1320248152, 0),
(688, 1, 1, 'mod/workshop:view', 1, 1320248152, 0),
(689, 1, 4, 'mod/workshop:switchphase', 1, 1320248152, 0),
(690, 1, 3, 'mod/workshop:switchphase', 1, 1320248152, 0),
(691, 1, 1, 'mod/workshop:switchphase', 1, 1320248152, 0),
(692, 1, 3, 'mod/workshop:editdimensions', 1, 1320248152, 0),
(693, 1, 1, 'mod/workshop:editdimensions', 1, 1320248152, 0),
(694, 1, 5, 'mod/workshop:submit', 1, 1320248153, 0),
(695, 1, 5, 'mod/workshop:peerassess', 1, 1320248153, 0),
(696, 1, 4, 'mod/workshop:manageexamples', 1, 1320248153, 0),
(697, 1, 3, 'mod/workshop:manageexamples', 1, 1320248153, 0),
(698, 1, 1, 'mod/workshop:manageexamples', 1, 1320248153, 0),
(699, 1, 4, 'mod/workshop:allocate', 1, 1320248153, 0),
(700, 1, 3, 'mod/workshop:allocate', 1, 1320248153, 0),
(701, 1, 1, 'mod/workshop:allocate', 1, 1320248153, 0),
(702, 1, 4, 'mod/workshop:publishsubmissions', 1, 1320248154, 0),
(703, 1, 3, 'mod/workshop:publishsubmissions', 1, 1320248154, 0),
(704, 1, 1, 'mod/workshop:publishsubmissions', 1, 1320248154, 0),
(705, 1, 5, 'mod/workshop:viewauthornames', 1, 1320248154, 0),
(706, 1, 4, 'mod/workshop:viewauthornames', 1, 1320248154, 0),
(707, 1, 3, 'mod/workshop:viewauthornames', 1, 1320248154, 0),
(708, 1, 1, 'mod/workshop:viewauthornames', 1, 1320248155, 0),
(709, 1, 4, 'mod/workshop:viewreviewernames', 1, 1320248155, 0),
(710, 1, 3, 'mod/workshop:viewreviewernames', 1, 1320248155, 0),
(711, 1, 1, 'mod/workshop:viewreviewernames', 1, 1320248155, 0),
(712, 1, 4, 'mod/workshop:viewallsubmissions', 1, 1320248155, 0),
(713, 1, 3, 'mod/workshop:viewallsubmissions', 1, 1320248155, 0),
(714, 1, 1, 'mod/workshop:viewallsubmissions', 1, 1320248155, 0),
(715, 1, 5, 'mod/workshop:viewpublishedsubmissions', 1, 1320248155, 0),
(716, 1, 4, 'mod/workshop:viewpublishedsubmissions', 1, 1320248155, 0),
(717, 1, 3, 'mod/workshop:viewpublishedsubmissions', 1, 1320248155, 0),
(718, 1, 1, 'mod/workshop:viewpublishedsubmissions', 1, 1320248155, 0),
(719, 1, 5, 'mod/workshop:viewauthorpublished', 1, 1320248155, 0),
(720, 1, 4, 'mod/workshop:viewauthorpublished', 1, 1320248156, 0),
(721, 1, 3, 'mod/workshop:viewauthorpublished', 1, 1320248156, 0),
(722, 1, 1, 'mod/workshop:viewauthorpublished', 1, 1320248156, 0),
(723, 1, 4, 'mod/workshop:viewallassessments', 1, 1320248156, 0),
(724, 1, 3, 'mod/workshop:viewallassessments', 1, 1320248156, 0),
(725, 1, 1, 'mod/workshop:viewallassessments', 1, 1320248156, 0),
(726, 1, 4, 'mod/workshop:overridegrades', 1, 1320248156, 0),
(727, 1, 3, 'mod/workshop:overridegrades', 1, 1320248156, 0),
(728, 1, 1, 'mod/workshop:overridegrades', 1, 1320248156, 0),
(729, 1, 4, 'mod/workshop:ignoredeadlines', 1, 1320248156, 0),
(730, 1, 3, 'mod/workshop:ignoredeadlines', 1, 1320248156, 0),
(731, 1, 1, 'mod/workshop:ignoredeadlines', 1, 1320248157, 0),
(732, 1, 1, 'enrol/authorize:config', 1, 1320248175, 0),
(733, 1, 1, 'enrol/authorize:manage', 1, 1320248175, 0),
(734, 1, 3, 'enrol/authorize:manage', 1, 1320248175, 0),
(735, 1, 1, 'enrol/authorize:unenrol', 1, 1320248175, 0),
(736, 1, 1, 'enrol/authorize:managepayments', 1, 1320248175, 0),
(737, 1, 1, 'enrol/authorize:uploadcsv', 1, 1320248176, 0),
(738, 1, 3, 'enrol/cohort:config', 1, 1320248178, 0),
(739, 1, 1, 'enrol/cohort:config', 1, 1320248178, 0),
(740, 1, 1, 'enrol/guest:config', 1, 1320248181, 0),
(741, 1, 3, 'enrol/guest:config', 1, 1320248181, 0),
(742, 1, 1, 'enrol/ldap:manage', 1, 1320248183, 0),
(743, 1, 1, 'enrol/manual:config', 1, 1320248184, 0),
(744, 1, 1, 'enrol/manual:enrol', 1, 1320248184, 0),
(745, 1, 3, 'enrol/manual:enrol', 1, 1320248184, 0),
(746, 1, 1, 'enrol/manual:manage', 1, 1320248184, 0),
(747, 1, 3, 'enrol/manual:manage', 1, 1320248184, 0),
(748, 1, 1, 'enrol/manual:unenrol', 1, 1320248184, 0),
(749, 1, 3, 'enrol/manual:unenrol', 1, 1320248184, 0),
(750, 1, 1, 'enrol/meta:config', 1, 1320248185, 0),
(751, 1, 3, 'enrol/meta:config', 1, 1320248185, 0),
(752, 1, 1, 'enrol/meta:selectaslinked', 1, 1320248185, 0),
(753, 1, 1, 'enrol/paypal:config', 1, 1320248190, 0),
(754, 1, 1, 'enrol/paypal:manage', 1, 1320248190, 0),
(755, 1, 3, 'enrol/paypal:manage', 1, 1320248190, 0),
(756, 1, 1, 'enrol/paypal:unenrol', 1, 1320248190, 0),
(757, 1, 3, 'enrol/self:config', 1, 1320248191, 0),
(758, 1, 1, 'enrol/self:config', 1, 1320248191, 0),
(759, 1, 3, 'enrol/self:manage', 1, 1320248191, 0),
(760, 1, 1, 'enrol/self:manage', 1, 1320248191, 0),
(761, 1, 5, 'enrol/self:unenrolself', 1, 1320248191, 0),
(762, 1, 3, 'enrol/self:unenrol', 1, 1320248191, 0),
(763, 1, 1, 'enrol/self:unenrol', 1, 1320248191, 0),
(764, 1, 7, 'block/online_users:viewlist', 1, 1320248207, 0),
(765, 1, 6, 'block/online_users:viewlist', 1, 1320248207, 0),
(766, 1, 5, 'block/online_users:viewlist', 1, 1320248207, 0),
(767, 1, 4, 'block/online_users:viewlist', 1, 1320248207, 0),
(768, 1, 3, 'block/online_users:viewlist', 1, 1320248207, 0),
(769, 1, 1, 'block/online_users:viewlist', 1, 1320248207, 0),
(770, 1, 4, 'block/rss_client:manageownfeeds', 1, 1320248211, 0),
(771, 1, 3, 'block/rss_client:manageownfeeds', 1, 1320248211, 0),
(772, 1, 1, 'block/rss_client:manageownfeeds', 1, 1320248211, 0),
(773, 1, 1, 'block/rss_client:manageanyfeeds', 1, 1320248211, 0),
(774, 1, 4, 'report/courseoverview:view', 1, 1320248224, 0),
(775, 1, 3, 'report/courseoverview:view', 1, 1320248224, 0),
(776, 1, 1, 'report/courseoverview:view', 1, 1320248224, 0),
(777, 1, 1, 'report/customlang:view', 1, 1320248226, 0),
(778, 1, 1, 'report/customlang:edit', 1, 1320248226, 0),
(779, 1, 1, 'report/questioninstances:view', 1, 1320248227, 0),
(780, 1, 1, 'report/security:view', 1, 1320248228, 0),
(781, 1, 1, 'report/unittest:view', 1, 1320248229, 0),
(782, 1, 4, 'coursereport/completion:view', 1, 1320248230, 0),
(783, 1, 3, 'coursereport/completion:view', 1, 1320248230, 0),
(784, 1, 1, 'coursereport/completion:view', 1, 1320248230, 0),
(785, 1, 4, 'coursereport/log:view', 1, 1320248231, 0),
(786, 1, 3, 'coursereport/log:view', 1, 1320248231, 0),
(787, 1, 1, 'coursereport/log:view', 1, 1320248231, 0),
(788, 1, 4, 'coursereport/log:viewlive', 1, 1320248231, 0),
(789, 1, 3, 'coursereport/log:viewlive', 1, 1320248231, 0),
(790, 1, 1, 'coursereport/log:viewlive', 1, 1320248231, 0),
(791, 1, 4, 'coursereport/log:viewtoday', 1, 1320248232, 0),
(792, 1, 3, 'coursereport/log:viewtoday', 1, 1320248232, 0),
(793, 1, 1, 'coursereport/log:viewtoday', 1, 1320248232, 0),
(794, 1, 4, 'coursereport/outline:view', 1, 1320248233, 0),
(795, 1, 3, 'coursereport/outline:view', 1, 1320248233, 0),
(796, 1, 1, 'coursereport/outline:view', 1, 1320248233, 0),
(797, 1, 4, 'coursereport/participation:view', 1, 1320248234, 0),
(798, 1, 3, 'coursereport/participation:view', 1, 1320248234, 0),
(799, 1, 1, 'coursereport/participation:view', 1, 1320248234, 0),
(800, 1, 4, 'coursereport/progress:view', 1, 1320248234, 0),
(801, 1, 3, 'coursereport/progress:view', 1, 1320248235, 0),
(802, 1, 1, 'coursereport/progress:view', 1, 1320248235, 0),
(803, 1, 4, 'coursereport/stats:view', 1, 1320248235, 0),
(804, 1, 3, 'coursereport/stats:view', 1, 1320248235, 0),
(805, 1, 1, 'coursereport/stats:view', 1, 1320248235, 0),
(806, 1, 4, 'gradeexport/ods:view', 1, 1320248236, 0),
(807, 1, 3, 'gradeexport/ods:view', 1, 1320248236, 0),
(808, 1, 1, 'gradeexport/ods:view', 1, 1320248236, 0),
(809, 1, 1, 'gradeexport/ods:publish', 1, 1320248236, 0),
(810, 1, 4, 'gradeexport/txt:view', 1, 1320248237, 0),
(811, 1, 3, 'gradeexport/txt:view', 1, 1320248237, 0),
(812, 1, 1, 'gradeexport/txt:view', 1, 1320248237, 0),
(813, 1, 1, 'gradeexport/txt:publish', 1, 1320248237, 0),
(814, 1, 4, 'gradeexport/xls:view', 1, 1320248238, 0),
(815, 1, 3, 'gradeexport/xls:view', 1, 1320248238, 0),
(816, 1, 1, 'gradeexport/xls:view', 1, 1320248238, 0),
(817, 1, 1, 'gradeexport/xls:publish', 1, 1320248238, 0),
(818, 1, 4, 'gradeexport/xml:view', 1, 1320248239, 0),
(819, 1, 3, 'gradeexport/xml:view', 1, 1320248239, 0),
(820, 1, 1, 'gradeexport/xml:view', 1, 1320248239, 0),
(821, 1, 1, 'gradeexport/xml:publish', 1, 1320248239, 0),
(822, 1, 3, 'gradeimport/csv:view', 1, 1320248240, 0),
(823, 1, 1, 'gradeimport/csv:view', 1, 1320248240, 0),
(824, 1, 3, 'gradeimport/xml:view', 1, 1320248241, 0),
(825, 1, 1, 'gradeimport/xml:view', 1, 1320248241, 0),
(826, 1, 1, 'gradeimport/xml:publish', 1, 1320248241, 0),
(827, 1, 4, 'gradereport/grader:view', 1, 1320248242, 0),
(828, 1, 3, 'gradereport/grader:view', 1, 1320248242, 0),
(829, 1, 1, 'gradereport/grader:view', 1, 1320248242, 0),
(830, 1, 4, 'gradereport/outcomes:view', 1, 1320248244, 0),
(831, 1, 3, 'gradereport/outcomes:view', 1, 1320248244, 0),
(832, 1, 1, 'gradereport/outcomes:view', 1, 1320248244, 0),
(833, 1, 5, 'gradereport/overview:view', 1, 1320248245, 0),
(834, 1, 1, 'gradereport/overview:view', 1, 1320248245, 0),
(835, 1, 5, 'gradereport/user:view', 1, 1320248245, 0),
(836, 1, 4, 'gradereport/user:view', 1, 1320248245, 0),
(837, 1, 3, 'gradereport/user:view', 1, 1320248245, 0),
(838, 1, 1, 'gradereport/user:view', 1, 1320248245, 0),
(839, 1, 7, 'repository/alfresco:view', 1, 1320248251, 0),
(840, 1, 7, 'repository/boxnet:view', 1, 1320248252, 0),
(841, 1, 7, 'repository/coursefiles:view', 1, 1320248252, 0),
(842, 1, 7, 'repository/dropbox:view', 1, 1320248253, 0),
(843, 1, 7, 'repository/filesystem:view', 1, 1320248254, 0),
(844, 1, 7, 'repository/flickr:view', 1, 1320248255, 0),
(845, 1, 7, 'repository/flickr_public:view', 1, 1320248256, 0),
(846, 1, 7, 'repository/googledocs:view', 1, 1320248256, 0),
(847, 1, 7, 'repository/local:view', 1, 1320248258, 0),
(848, 1, 7, 'repository/merlot:view', 1, 1320248258, 0),
(849, 1, 7, 'repository/picasa:view', 1, 1320248259, 0),
(850, 1, 7, 'repository/recent:view', 1, 1320248260, 0),
(851, 1, 7, 'repository/s3:view', 1, 1320248261, 0),
(852, 1, 7, 'repository/upload:view', 1, 1320248262, 0),
(853, 1, 7, 'repository/url:view', 1, 1320248263, 0),
(854, 1, 7, 'repository/user:view', 1, 1320248264, 0),
(855, 1, 7, 'repository/webdav:view', 1, 1320248266, 0),
(856, 1, 7, 'repository/wikimedia:view', 1, 1320248266, 0),
(857, 1, 7, 'repository/youtube:view', 1, 1320248267, 0),
(858, 1, 4, 'quiz/grading:viewstudentnames', 1, 1320248275, 0),
(859, 1, 3, 'quiz/grading:viewstudentnames', 1, 1320248275, 0),
(860, 1, 4, 'quiz/grading:viewidnumber', 1, 1320248275, 0),
(861, 1, 3, 'quiz/grading:viewidnumber', 1, 1320248275, 0),
(862, 1, 4, 'quiz/statistics:view', 1, 1320248279, 0),
(863, 1, 3, 'quiz/statistics:view', 1, 1320248279, 0),
(864, 1, 1, 'quiz/statistics:view', 1, 1320248279, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_context_levels`
--

CREATE TABLE IF NOT EXISTS `mdl_role_context_levels` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL,
  `contextlevel` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolecontleve_conrol_uix` (`contextlevel`,`roleid`),
  KEY `mdl_rolecontleve_rol_ix` (`roleid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Lists which roles can be assigned at which context levels. T' AUTO_INCREMENT=12 ;

--
-- Dumping data for table `mdl_role_context_levels`
--

INSERT INTO `mdl_role_context_levels` (`id`, `roleid`, `contextlevel`) VALUES
(1, 1, 10),
(4, 2, 10),
(2, 1, 40),
(5, 2, 40),
(3, 1, 50),
(6, 3, 50),
(8, 4, 50),
(10, 5, 50),
(7, 3, 70),
(9, 4, 70),
(11, 5, 70);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_names`
--

CREATE TABLE IF NOT EXISTS `mdl_role_names` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `contextid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_rolename_rolcon_uix` (`roleid`,`contextid`),
  KEY `mdl_rolename_rol_ix` (`roleid`),
  KEY `mdl_rolename_con_ix` (`contextid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='role names in native strings' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_role_names`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_role_sortorder`
--

CREATE TABLE IF NOT EXISTS `mdl_role_sortorder` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sort order of course managers in a course' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_role_sortorder`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scale`
--

CREATE TABLE IF NOT EXISTS `mdl_scale` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `scale` text NOT NULL,
  `description` text NOT NULL,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_scal_cou_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines grading scales' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scale`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scale_history`
--

CREATE TABLE IF NOT EXISTS `mdl_scale_history` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History table' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scale_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `scormtype` varchar(50) NOT NULL DEFAULT 'local',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `version` varchar(9) NOT NULL DEFAULT '',
  `maxgrade` double NOT NULL DEFAULT '0',
  `grademethod` tinyint(2) NOT NULL DEFAULT '0',
  `whatgrade` bigint(10) NOT NULL DEFAULT '0',
  `maxattempt` bigint(10) NOT NULL DEFAULT '1',
  `forcecompleted` tinyint(1) NOT NULL DEFAULT '1',
  `forcenewattempt` tinyint(1) NOT NULL DEFAULT '0',
  `lastattemptlock` tinyint(1) NOT NULL DEFAULT '0',
  `displayattemptstatus` tinyint(1) NOT NULL DEFAULT '1',
  `displaycoursestructure` tinyint(1) NOT NULL DEFAULT '1',
  `updatefreq` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sha1hash` varchar(40) DEFAULT NULL,
  `md5hash` varchar(32) NOT NULL DEFAULT '',
  `revision` bigint(10) unsigned NOT NULL DEFAULT '0',
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
  `timeopen` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeclose` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_scor_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each table is one SCORM module and its configuration' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_scoes`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_scoes` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scorm` bigint(10) unsigned NOT NULL DEFAULT '0',
  `manifest` varchar(255) NOT NULL DEFAULT '',
  `organization` varchar(255) NOT NULL DEFAULT '',
  `parent` varchar(255) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `launch` text NOT NULL,
  `scormtype` varchar(5) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_scorscoe_sco_ix` (`scorm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each SCO part of the SCORM module' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_scoes`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_scoes_data`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_scoes_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_scorscoedata_sco_ix` (`scoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains variable data get from packages' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_scoes_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_scoes_track`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_scoes_track` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='to track SCOes' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_scoes_track`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_seq_mapinfo`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_seq_mapinfo` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 objective mapinfo description' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_seq_mapinfo`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_seq_objective`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_seq_objective` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `primaryobj` tinyint(1) NOT NULL DEFAULT '0',
  `objectiveid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `satisfiedbymeasure` tinyint(1) NOT NULL DEFAULT '1',
  `minnormalizedmeasure` float(11,4) unsigned NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqobje_scoid_uix` (`scoid`,`id`),
  KEY `mdl_scorseqobje_sco_ix` (`scoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 objective description' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_seq_objective`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_seq_rolluprule`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_seq_rolluprule` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 sequencing rule' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_seq_rolluprule`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_seq_rolluprulecond`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_seq_rolluprulecond` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rollupruleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `operator` varchar(5) NOT NULL DEFAULT 'noOp',
  `cond` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqroll_scorolid_uix` (`scoid`,`rollupruleid`,`id`),
  KEY `mdl_scorseqroll_sco2_ix` (`scoid`),
  KEY `mdl_scorseqroll_rol_ix` (`rollupruleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 sequencing rule' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_seq_rolluprulecond`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_seq_rulecond`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_seq_rulecond` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 rule condition' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_seq_rulecond`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_scorm_seq_ruleconds`
--

CREATE TABLE IF NOT EXISTS `mdl_scorm_seq_ruleconds` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `scoid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `conditioncombination` varchar(3) NOT NULL DEFAULT 'all',
  `ruletype` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `action` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_scorseqrule_scoid_uix` (`scoid`,`id`),
  KEY `mdl_scorseqrule_sco_ix` (`scoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 rule conditions' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_scorm_seq_ruleconds`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_sessions`
--

CREATE TABLE IF NOT EXISTS `mdl_sessions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `state` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sid` varchar(128) NOT NULL DEFAULT '',
  `userid` bigint(10) unsigned NOT NULL,
  `sessdata` longtext,
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  `firstip` varchar(45) DEFAULT NULL,
  `lastip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_sess_sid_uix` (`sid`),
  KEY `mdl_sess_sta_ix` (`state`),
  KEY `mdl_sess_tim_ix` (`timecreated`),
  KEY `mdl_sess_tim2_ix` (`timemodified`),
  KEY `mdl_sess_use_ix` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Database based session storage - now recommended' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mdl_sessions`
--

INSERT INTO `mdl_sessions` (`id`, `state`, `sid`, `userid`, `sessdata`, `timecreated`, `timemodified`, `firstip`, `lastip`) VALUES
(2, 0, '8qut741999ib50lhla52glq3s4', 2, 'U0VTU0lPTnxPOjg6InN0ZENsYXNzIjo3OntzOjEzOiJoYXNfdGltZWRfb3V0IjtiOjE7czoxMjoiZmxhc2h2ZXJzaW9uIjtzOjY6IjExLjAuMSI7czo0OiJsYW5nIjtzOjI6ImVuIjtzOjg6Im5hdmNhY2hlIjtPOjg6InN0ZENsYXNzIjoxOntzOjEwOiJuYXZpZ2F0aW9uIjthOjQ6e3M6MTc6ImNvdXJzZV9zZWN0aW9uc18xIjthOjM6e2k6MDtpOjEzMjAyNDkxNDQ7aToxO3M6MToiMiI7aToyO3M6NjoiYTowOnt9Ijt9czoxODoiY291cnNlX2FjdGl2aXRlc18xIjthOjM6e2k6MDtpOjEzMjAyNDkxNDQ7aToxO3M6MToiMiI7aToyO3M6NjoiYTowOnt9Ijt9czoxNjoidXNlcmJsb2dvcHRpb25zMiI7YTozOntpOjA7aToxMzIwMjQ5MTQ0O2k6MTtzOjE6IjIiO2k6MjtzOjcwMToiYToyOntzOjQ6InZpZXciO2E6Mjp7czo2OiJzdHJpbmciO3M6MjI6IlZpZXcgYWxsIG9mIG15IGVudHJpZXMiO3M6NDoibGluayI7TzoxMDoibW9vZGxlX3VybCI6OTp7czo5OiIAKgBzY2hlbWUiO3M6NDoiaHR0cCI7czo3OiIAKgBob3N0IjtzOjk6ImxvY2FsaG9zdCI7czo3OiIAKgBwb3J0IjtzOjA6IiI7czo3OiIAKgB1c2VyIjtzOjA6IiI7czo3OiIAKgBwYXNzIjtzOjA6IiI7czo3OiIAKgBwYXRoIjtzOjI0OiIvbW9vZGxlMjEvYmxvZy9pbmRleC5waHAiO3M6MTY6IgAqAHNsYXNoYXJndW1lbnQiO3M6MDoiIjtzOjk6IgAqAGFuY2hvciI7TjtzOjk6IgAqAHBhcmFtcyI7YToxOntzOjY6InVzZXJpZCI7czoxOiIyIjt9fX1zOjM6ImFkZCI7YToyOntzOjY6InN0cmluZyI7czoxNToiQWRkIGEgbmV3IGVudHJ5IjtzOjQ6ImxpbmsiO086MTA6Im1vb2RsZV91cmwiOjk6e3M6OToiACoAc2NoZW1lIjtzOjQ6Imh0dHAiO3M6NzoiACoAaG9zdCI7czo5OiJsb2NhbGhvc3QiO3M6NzoiACoAcG9ydCI7czowOiIiO3M6NzoiACoAdXNlciI7czowOiIiO3M6NzoiACoAcGFzcyI7czowOiIiO3M6NzoiACoAcGF0aCI7czoyMzoiL21vb2RsZTIxL2Jsb2cvZWRpdC5waHAiO3M6MTY6IgAqAHNsYXNoYXJndW1lbnQiO3M6MDoiIjtzOjk6IgAqAGFuY2hvciI7TjtzOjk6IgAqAHBhcmFtcyI7YToxOntzOjY6ImFjdGlvbiI7czozOiJhZGQiO319fX0iO31zOjE3OiJjb250ZXh0aGFzcmVwb3MxMyI7YTozOntpOjA7aToxMzIwMjQ5MTQ0O2k6MTtzOjE6IjIiO2k6MjtzOjQ6ImI6MDsiO319fXM6MjI6ImFkbWluX2NyaXRpY2FsX3dhcm5pbmciO2k6MDtzOjIxOiJsb2FkX25hdmlnYXRpb25fYWRtaW4iO2I6MTtzOjIxOiJjYWxlbmRhcnNob3dldmVudHR5cGUiO2k6MTU7fVVTRVJ8Tzo4OiJzdGRDbGFzcyI6NjE6e3M6MjoiaWQiO3M6MToiMiI7czo0OiJhdXRoIjtzOjY6Im1hbnVhbCI7czo5OiJjb25maXJtZWQiO3M6MToiMSI7czoxMjoicG9saWN5YWdyZWVkIjtzOjE6IjAiO3M6NzoiZGVsZXRlZCI7czoxOiIwIjtzOjk6InN1c3BlbmRlZCI7czoxOiIwIjtzOjEwOiJtbmV0aG9zdGlkIjtzOjE6IjEiO3M6ODoidXNlcm5hbWUiO3M6NToiYWRtaW4iO3M6ODoicGFzc3dvcmQiO3M6MzI6IjUxZDczZTAyMzczZjJiODYyZWI5ZjUwYjQwMTg3ZTM1IjtzOjg6ImlkbnVtYmVyIjtzOjA6IiI7czo5OiJmaXJzdG5hbWUiO3M6NToiQWRtaW4iO3M6ODoibGFzdG5hbWUiO3M6NDoiVXNlciI7czo1OiJlbWFpbCI7czoxOToibS5kZXJpZGRlckBzb2xpbi5ubCI7czo5OiJlbWFpbHN0b3AiO3M6MToiMCI7czozOiJpY3EiO3M6MDoiIjtzOjU6InNreXBlIjtzOjA6IiI7czo1OiJ5YWhvbyI7czowOiIiO3M6MzoiYWltIjtzOjA6IiI7czozOiJtc24iO3M6MDoiIjtzOjY6InBob25lMSI7czowOiIiO3M6NjoicGhvbmUyIjtzOjA6IiI7czoxMToiaW5zdGl0dXRpb24iO3M6MDoiIjtzOjEwOiJkZXBhcnRtZW50IjtzOjA6IiI7czo3OiJhZGRyZXNzIjtzOjA6IiI7czo0OiJjaXR5IjtzOjU6IkJyZWRhIjtzOjc6ImNvdW50cnkiO3M6MjoiTkwiO3M6NDoibGFuZyI7czoyOiJlbiI7czo1OiJ0aGVtZSI7czowOiIiO3M6ODoidGltZXpvbmUiO3M6MjoiOTkiO3M6MTE6ImZpcnN0YWNjZXNzIjtzOjE6IjAiO3M6MTA6Imxhc3RhY2Nlc3MiO2k6MTMyMDI0OTE0MjtzOjk6Imxhc3Rsb2dpbiI7czoxOiIwIjtzOjEyOiJjdXJyZW50bG9naW4iO3M6MTA6IjEzMjAyNDg4OTUiO3M6NjoibGFzdGlwIjtzOjE1OiIwOjA6MDowOjA6MDowOjEiO3M6Njoic2VjcmV0IjtzOjA6IiI7czo3OiJwaWN0dXJlIjtzOjE6IjAiO3M6MzoidXJsIjtzOjA6IiI7czoxNzoiZGVzY3JpcHRpb25mb3JtYXQiO3M6MToiMCI7czoxMDoibWFpbGZvcm1hdCI7czoxOiIxIjtzOjEwOiJtYWlsZGlnZXN0IjtzOjE6IjAiO3M6MTE6Im1haWxkaXNwbGF5IjtzOjE6IjEiO3M6MTA6Imh0bWxlZGl0b3IiO3M6MToiMSI7czo0OiJhamF4IjtzOjE6IjEiO3M6MTM6ImF1dG9zdWJzY3JpYmUiO3M6MToiMSI7czoxMToidHJhY2tmb3J1bXMiO3M6MToiMCI7czoxMToidGltZWNyZWF0ZWQiO3M6MToiMCI7czoxMjoidGltZW1vZGlmaWVkIjtzOjEwOiIxMzIwMjQ4OTIyIjtzOjEyOiJ0cnVzdGJpdG1hc2siO3M6MToiMCI7czo4OiJpbWFnZWFsdCI7TjtzOjEyOiJzY3JlZW5yZWFkZXIiO3M6MToiMCI7czoxNjoibGFzdGNvdXJzZWFjY2VzcyI7YTowOnt9czoxOToiY3VycmVudGNvdXJzZWFjY2VzcyI7YTowOnt9czoxMToiZ3JvdXBtZW1iZXIiO2E6MDp7fXM6NzoicHJvZmlsZSI7YTowOnt9czo2OiJhY2Nlc3MiO2E6NDp7czoyOiJyYSI7YTowOnt9czo0OiJyZGVmIjthOjA6e31zOjY6ImxvYWRlZCI7YTowOnt9czo0OiJ0aW1lIjtpOjEzMjAyNDg4OTU7fXM6Nzoic2Vzc2tleSI7czoxMDoiU2QwT3cwYW5ORiI7czoxNzoibWVzc2FnZV9sYXN0cG9wdXAiO2k6MDtzOjEwOiJwcmVmZXJlbmNlIjthOjQ6e3M6MjQ6ImF1dGhfZm9yY2VwYXNzd29yZGNoYW5nZSI7czoxOiIwIjtzOjE4OiJlbWFpbF9ib3VuY2VfY291bnQiO3M6MToiMSI7czoxNjoiZW1haWxfc2VuZF9jb3VudCI7czoxOiIxIjtzOjExOiJfbGFzdGxvYWRlZCI7aToxMzIwMjQ5MTQ0O31zOjExOiJkZXNjcmlwdGlvbiI7czowOiIiO3M6MjU6ImFqYXhfdXBkYXRhYmxlX3VzZXJfcHJlZnMiO2E6Nzp7czoyMzoiZG9ja2VkX2Jsb2NrX2luc3RhbmNlXzEiO3M6MzoiaW50IjtzOjIzOiJkb2NrZWRfYmxvY2tfaW5zdGFuY2VfNCI7czozOiJpbnQiO3M6MjM6ImRvY2tlZF9ibG9ja19pbnN0YW5jZV81IjtzOjM6ImludCI7czoyMzoiZG9ja2VkX2Jsb2NrX2luc3RhbmNlXzMiO3M6MzoiaW50IjtzOjEyOiJibG9jazRoaWRkZW4iO3M6NDoiYm9vbCI7czoxMjoiYmxvY2s1aGlkZGVuIjtzOjQ6ImJvb2wiO3M6MTI6ImJsb2NrM2hpZGRlbiI7czo0OiJib29sIjt9czo3OiJkaXNwbGF5IjthOjE6e2k6MTtpOjA7fX0=', 1320248895, 1320249144, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_stats_daily`
--

CREATE TABLE IF NOT EXISTS `mdl_stats_daily` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` varchar(20) NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stat2` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_statdail_cou_ix` (`courseid`),
  KEY `mdl_statdail_tim_ix` (`timeend`),
  KEY `mdl_statdail_rol_ix` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='to accumulate daily stats' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_stats_daily`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_stats_monthly`
--

CREATE TABLE IF NOT EXISTS `mdl_stats_monthly` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` varchar(20) NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stat2` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_statmont_cou_ix` (`courseid`),
  KEY `mdl_statmont_tim_ix` (`timeend`),
  KEY `mdl_statmont_rol_ix` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate monthly stats' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_stats_monthly`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_stats_user_daily`
--

CREATE TABLE IF NOT EXISTS `mdl_stats_user_daily` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate daily stats per course/user' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_stats_user_daily`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_stats_user_monthly`
--

CREATE TABLE IF NOT EXISTS `mdl_stats_user_monthly` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate monthly stats per course/user' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_stats_user_monthly`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_stats_user_weekly`
--

CREATE TABLE IF NOT EXISTS `mdl_stats_user_weekly` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate weekly stats per course/user' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_stats_user_weekly`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_stats_weekly`
--

CREATE TABLE IF NOT EXISTS `mdl_stats_weekly` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '0',
  `roleid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stattype` varchar(20) NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) unsigned NOT NULL DEFAULT '0',
  `stat2` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_statweek_cou_ix` (`courseid`),
  KEY `mdl_statweek_tim_ix` (`timeend`),
  KEY `mdl_statweek_rol_ix` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate weekly stats' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_stats_weekly`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_survey`
--

CREATE TABLE IF NOT EXISTS `mdl_survey` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `template` bigint(10) unsigned NOT NULL DEFAULT '0',
  `days` mediumint(6) NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text NOT NULL,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `questions` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `mdl_surv_cou_ix` (`course`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Each record is one SURVEY module with its configuration' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `mdl_survey`
--

INSERT INTO `mdl_survey` (`id`, `course`, `template`, `days`, `timecreated`, `timemodified`, `name`, `intro`, `introformat`, `questions`) VALUES
(1, 0, 0, 0, 985017600, 985017600, 'collesaname', 'collesaintro', 0, '25,26,27,28,29,30,43,44'),
(2, 0, 0, 0, 985017600, 985017600, 'collespname', 'collespintro', 0, '31,32,33,34,35,36,43,44'),
(3, 0, 0, 0, 985017600, 985017600, 'collesapname', 'collesapintro', 0, '37,38,39,40,41,42,43,44'),
(4, 0, 0, 0, 985017600, 985017600, 'attlsname', 'attlsintro', 0, '65,67,68'),
(5, 0, 0, 0, 985017600, 985017600, 'ciqname', 'ciqintro', 0, '69,70,71,72,73');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_survey_analysis`
--

CREATE TABLE IF NOT EXISTS `mdl_survey_analysis` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `survey` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_survanal_use_ix` (`userid`),
  KEY `mdl_survanal_sur_ix` (`survey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='text about each survey submission' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_survey_analysis`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_survey_answers`
--

CREATE TABLE IF NOT EXISTS `mdl_survey_answers` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='the answers to each questions filled by the users' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_survey_answers`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_survey_questions`
--

CREATE TABLE IF NOT EXISTS `mdl_survey_questions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL DEFAULT '',
  `shorttext` varchar(30) NOT NULL DEFAULT '',
  `multi` varchar(100) NOT NULL DEFAULT '',
  `intro` varchar(50) NOT NULL DEFAULT '',
  `type` smallint(3) NOT NULL DEFAULT '0',
  `options` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='the questions conforming one survey' AUTO_INCREMENT=74 ;

--
-- Dumping data for table `mdl_survey_questions`
--

INSERT INTO `mdl_survey_questions` (`id`, `text`, `shorttext`, `multi`, `intro`, `type`, `options`) VALUES
(1, 'colles1', 'colles1short', '', '', 1, 'scaletimes5'),
(2, 'colles2', 'colles2short', '', '', 1, 'scaletimes5'),
(3, 'colles3', 'colles3short', '', '', 1, 'scaletimes5'),
(4, 'colles4', 'colles4short', '', '', 1, 'scaletimes5'),
(5, 'colles5', 'colles5short', '', '', 1, 'scaletimes5'),
(6, 'colles6', 'colles6short', '', '', 1, 'scaletimes5'),
(7, 'colles7', 'colles7short', '', '', 1, 'scaletimes5'),
(8, 'colles8', 'colles8short', '', '', 1, 'scaletimes5'),
(9, 'colles9', 'colles9short', '', '', 1, 'scaletimes5'),
(10, 'colles10', 'colles10short', '', '', 1, 'scaletimes5'),
(11, 'colles11', 'colles11short', '', '', 1, 'scaletimes5'),
(12, 'colles12', 'colles12short', '', '', 1, 'scaletimes5'),
(13, 'colles13', 'colles13short', '', '', 1, 'scaletimes5'),
(14, 'colles14', 'colles14short', '', '', 1, 'scaletimes5'),
(15, 'colles15', 'colles15short', '', '', 1, 'scaletimes5'),
(16, 'colles16', 'colles16short', '', '', 1, 'scaletimes5'),
(17, 'colles17', 'colles17short', '', '', 1, 'scaletimes5'),
(18, 'colles18', 'colles18short', '', '', 1, 'scaletimes5'),
(19, 'colles19', 'colles19short', '', '', 1, 'scaletimes5'),
(20, 'colles20', 'colles20short', '', '', 1, 'scaletimes5'),
(21, 'colles21', 'colles21short', '', '', 1, 'scaletimes5'),
(22, 'colles22', 'colles22short', '', '', 1, 'scaletimes5'),
(23, 'colles23', 'colles23short', '', '', 1, 'scaletimes5'),
(24, 'colles24', 'colles24short', '', '', 1, 'scaletimes5'),
(25, 'collesm1', 'collesm1short', '1,2,3,4', 'collesmintro', 1, 'scaletimes5'),
(26, 'collesm2', 'collesm2short', '5,6,7,8', 'collesmintro', 1, 'scaletimes5'),
(27, 'collesm3', 'collesm3short', '9,10,11,12', 'collesmintro', 1, 'scaletimes5'),
(28, 'collesm4', 'collesm4short', '13,14,15,16', 'collesmintro', 1, 'scaletimes5'),
(29, 'collesm5', 'collesm5short', '17,18,19,20', 'collesmintro', 1, 'scaletimes5'),
(30, 'collesm6', 'collesm6short', '21,22,23,24', 'collesmintro', 1, 'scaletimes5'),
(31, 'collesm1', 'collesm1short', '1,2,3,4', 'collesmintro', 2, 'scaletimes5'),
(32, 'collesm2', 'collesm2short', '5,6,7,8', 'collesmintro', 2, 'scaletimes5'),
(33, 'collesm3', 'collesm3short', '9,10,11,12', 'collesmintro', 2, 'scaletimes5'),
(34, 'collesm4', 'collesm4short', '13,14,15,16', 'collesmintro', 2, 'scaletimes5'),
(35, 'collesm5', 'collesm5short', '17,18,19,20', 'collesmintro', 2, 'scaletimes5'),
(36, 'collesm6', 'collesm6short', '21,22,23,24', 'collesmintro', 2, 'scaletimes5'),
(37, 'collesm1', 'collesm1short', '1,2,3,4', 'collesmintro', 3, 'scaletimes5'),
(38, 'collesm2', 'collesm2short', '5,6,7,8', 'collesmintro', 3, 'scaletimes5'),
(39, 'collesm3', 'collesm3short', '9,10,11,12', 'collesmintro', 3, 'scaletimes5'),
(40, 'collesm4', 'collesm4short', '13,14,15,16', 'collesmintro', 3, 'scaletimes5'),
(41, 'collesm5', 'collesm5short', '17,18,19,20', 'collesmintro', 3, 'scaletimes5'),
(42, 'collesm6', 'collesm6short', '21,22,23,24', 'collesmintro', 3, 'scaletimes5'),
(43, 'howlong', '', '', '', 1, 'howlongoptions'),
(44, 'othercomments', '', '', '', 0, NULL),
(45, 'attls1', 'attls1short', '', '', 1, 'scaleagree5'),
(46, 'attls2', 'attls2short', '', '', 1, 'scaleagree5'),
(47, 'attls3', 'attls3short', '', '', 1, 'scaleagree5'),
(48, 'attls4', 'attls4short', '', '', 1, 'scaleagree5'),
(49, 'attls5', 'attls5short', '', '', 1, 'scaleagree5'),
(50, 'attls6', 'attls6short', '', '', 1, 'scaleagree5'),
(51, 'attls7', 'attls7short', '', '', 1, 'scaleagree5'),
(52, 'attls8', 'attls8short', '', '', 1, 'scaleagree5'),
(53, 'attls9', 'attls9short', '', '', 1, 'scaleagree5'),
(54, 'attls10', 'attls10short', '', '', 1, 'scaleagree5'),
(55, 'attls11', 'attls11short', '', '', 1, 'scaleagree5'),
(56, 'attls12', 'attls12short', '', '', 1, 'scaleagree5'),
(57, 'attls13', 'attls13short', '', '', 1, 'scaleagree5'),
(58, 'attls14', 'attls14short', '', '', 1, 'scaleagree5'),
(59, 'attls15', 'attls15short', '', '', 1, 'scaleagree5'),
(60, 'attls16', 'attls16short', '', '', 1, 'scaleagree5'),
(61, 'attls17', 'attls17short', '', '', 1, 'scaleagree5'),
(62, 'attls18', 'attls18short', '', '', 1, 'scaleagree5'),
(63, 'attls19', 'attls19short', '', '', 1, 'scaleagree5'),
(64, 'attls20', 'attls20short', '', '', 1, 'scaleagree5'),
(65, 'attlsm1', 'attlsm1', '45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64', 'attlsmintro', 1, 'scaleagree5'),
(66, '-', '-', '-', '-', 0, '-'),
(67, 'attlsm2', 'attlsm2', '63,62,59,57,55,49,52,50,48,47', 'attlsmintro', -1, 'scaleagree5'),
(68, 'attlsm3', 'attlsm3', '46,54,45,51,60,53,56,58,61,64', 'attlsmintro', -1, 'scaleagree5'),
(69, 'ciq1', 'ciq1short', '', '', 0, NULL),
(70, 'ciq2', 'ciq2short', '', '', 0, NULL),
(71, 'ciq3', 'ciq3short', '', '', 0, NULL),
(72, 'ciq4', 'ciq4short', '', '', 0, NULL),
(73, 'ciq5', 'ciq5short', '', '', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_tag`
--

CREATE TABLE IF NOT EXISTS `mdl_tag` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag table - this generic table will replace the old "tags" t' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_tag`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_tag_correlation`
--

CREATE TABLE IF NOT EXISTS `mdl_tag_correlation` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` bigint(10) unsigned NOT NULL,
  `correlatedtags` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_tagcorr_tag_ix` (`tagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The rationale for the ''tag_correlation'' table is performance' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_tag_correlation`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_tag_instance`
--

CREATE TABLE IF NOT EXISTS `mdl_tag_instance` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` bigint(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `itemid` bigint(10) unsigned NOT NULL,
  `tiuserid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `ordering` bigint(10) unsigned DEFAULT NULL,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_taginst_iteitetagtiu_uix` (`itemtype`,`itemid`,`tagid`,`tiuserid`),
  KEY `mdl_taginst_tag_ix` (`tagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tag_instance table holds the information of associations bet' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_tag_instance`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_timezone`
--

CREATE TABLE IF NOT EXISTS `mdl_timezone` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rules for calculating local wall clock time for users' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_timezone`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_upgrade_log`
--

CREATE TABLE IF NOT EXISTS `mdl_upgrade_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` bigint(10) NOT NULL,
  `plugin` varchar(100) DEFAULT NULL,
  `version` varchar(100) DEFAULT NULL,
  `targetversion` varchar(100) DEFAULT NULL,
  `info` varchar(255) NOT NULL DEFAULT '',
  `details` text,
  `backtrace` text,
  `userid` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_upgrlog_tim_ix` (`timemodified`),
  KEY `mdl_upgrlog_typtim_ix` (`type`,`timemodified`),
  KEY `mdl_upgrlog_use_ix` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Upgrade logging' AUTO_INCREMENT=455 ;

--
-- Dumping data for table `mdl_upgrade_log`
--

INSERT INTO `mdl_upgrade_log` (`id`, `type`, `plugin`, `version`, `targetversion`, `info`, `details`, `backtrace`, `userid`, `timemodified`) VALUES
(1, 0, 'core', '2011070102.05', '2011070102.05', 'Upgrade savepoint reached', NULL, '', 0, 1320247915),
(2, 0, 'core', '2011070102.05', '2011070102.05', 'Core installed', NULL, '', 0, 1320247981),
(3, 0, 'qtype_calculated', NULL, '2011051900', 'Starting plugin installation', NULL, '', 0, 1320247981),
(4, 0, 'qtype_calculated', '2011051900', '2011051900', 'Upgrade savepoint reached', NULL, '', 0, 1320247986),
(5, 0, 'qtype_calculated', '2011051900', '2011051900', 'Plugin installed', NULL, '', 0, 1320247986),
(6, 0, 'qtype_calculatedmulti', NULL, '2011051900', 'Starting plugin installation', NULL, '', 0, 1320247987),
(7, 0, 'qtype_calculatedmulti', '2011051900', '2011051900', 'Upgrade savepoint reached', NULL, '', 0, 1320247987),
(8, 0, 'qtype_calculatedmulti', '2011051900', '2011051900', 'Plugin installed', NULL, '', 0, 1320247987),
(9, 0, 'qtype_calculatedsimple', NULL, '2011051900', 'Starting plugin installation', NULL, '', 0, 1320247987),
(10, 0, 'qtype_calculatedsimple', '2011051900', '2011051900', 'Upgrade savepoint reached', NULL, '', 0, 1320247987),
(11, 0, 'qtype_calculatedsimple', '2011051900', '2011051900', 'Plugin installed', NULL, '', 0, 1320247988),
(12, 0, 'qtype_description', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247988),
(13, 0, 'qtype_description', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247988),
(14, 0, 'qtype_description', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247988),
(15, 0, 'qtype_essay', NULL, '2011060300', 'Starting plugin installation', NULL, '', 0, 1320247989),
(16, 0, 'qtype_essay', '2011060300', '2011060300', 'Upgrade savepoint reached', NULL, '', 0, 1320247989),
(17, 0, 'qtype_essay', '2011060300', '2011060300', 'Plugin installed', NULL, '', 0, 1320247990),
(18, 0, 'qtype_match', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247990),
(19, 0, 'qtype_match', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247991),
(20, 0, 'qtype_match', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247991),
(21, 0, 'qtype_missingtype', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247992),
(22, 0, 'qtype_missingtype', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247992),
(23, 0, 'qtype_missingtype', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247992),
(24, 0, 'qtype_multianswer', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247992),
(25, 0, 'qtype_multianswer', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247993),
(26, 0, 'qtype_multianswer', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247993),
(27, 0, 'qtype_multichoice', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247993),
(28, 0, 'qtype_multichoice', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247994),
(29, 0, 'qtype_multichoice', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247995),
(30, 0, 'qtype_numerical', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247995),
(31, 0, 'qtype_numerical', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247998),
(32, 0, 'qtype_numerical', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247998),
(33, 0, 'qtype_random', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320247999),
(34, 0, 'qtype_random', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320247999),
(35, 0, 'qtype_random', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320247999),
(36, 0, 'qtype_randomsamatch', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320247999),
(37, 0, 'qtype_randomsamatch', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248000),
(38, 0, 'qtype_randomsamatch', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248000),
(39, 0, 'qtype_shortanswer', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320248000),
(40, 0, 'qtype_shortanswer', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320248001),
(41, 0, 'qtype_shortanswer', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320248001),
(42, 0, 'qtype_truefalse', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320248001),
(43, 0, 'qtype_truefalse', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320248002),
(44, 0, 'qtype_truefalse', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320248003),
(45, 0, 'mod_assignment', NULL, '2010102600', 'Starting plugin installation', NULL, '', 0, 1320248003),
(46, 0, 'mod_assignment', '2010102600', '2010102600', 'Plugin installed', NULL, '', 0, 1320248008),
(47, 0, 'mod_chat', NULL, '2010080302', 'Starting plugin installation', NULL, '', 0, 1320248008),
(48, 0, 'mod_chat', '2010080302', '2010080302', 'Plugin installed', NULL, '', 0, 1320248016),
(49, 0, 'mod_choice', NULL, '2010101301', 'Starting plugin installation', NULL, '', 0, 1320248016),
(50, 0, 'mod_choice', '2010101301', '2010101301', 'Plugin installed', NULL, '', 0, 1320248021),
(51, 0, 'mod_data', NULL, '2011052300', 'Starting plugin installation', NULL, '', 0, 1320248021),
(52, 0, 'mod_data', '2011052300', '2011052300', 'Plugin installed', NULL, '', 0, 1320248031),
(53, 0, 'mod_feedback', NULL, '2011051600', 'Starting plugin installation', NULL, '', 0, 1320248031),
(54, 0, 'mod_feedback', '2011051600', '2011051600', 'Plugin installed', NULL, '', 0, 1320248043),
(55, 0, 'mod_folder', NULL, '2010101400', 'Starting plugin installation', NULL, '', 0, 1320248043),
(56, 0, 'mod_folder', '2010101400', '2010101400', 'Plugin installed', NULL, '', 0, 1320248045),
(57, 0, 'mod_forum', NULL, '2011052300', 'Starting plugin installation', NULL, '', 0, 1320248045),
(58, 0, 'mod_forum', '2011052300', '2011052300', 'Plugin installed', NULL, '', 0, 1320248062),
(59, 0, 'mod_glossary', NULL, '2011052300', 'Starting plugin installation', NULL, '', 0, 1320248063),
(60, 0, 'mod_glossary', '2011052300', '2011052300', 'Plugin installed', NULL, '', 0, 1320248073),
(61, 0, 'mod_imscp', NULL, '2010101400', 'Starting plugin installation', NULL, '', 0, 1320248073),
(62, 0, 'mod_imscp', '2010101400', '2010101400', 'Plugin installed', NULL, '', 0, 1320248075),
(63, 0, 'mod_label', NULL, '2010080300', 'Starting plugin installation', NULL, '', 0, 1320248075),
(64, 0, 'mod_label', '2010080300', '2010080300', 'Plugin installed', NULL, '', 0, 1320248077),
(65, 0, 'mod_lesson', NULL, '2010122200', 'Starting plugin installation', NULL, '', 0, 1320248077),
(66, 0, 'mod_lesson', '2010122200', '2010122200', 'Plugin installed', NULL, '', 0, 1320248087),
(67, 0, 'mod_page', NULL, '2010101400', 'Starting plugin installation', NULL, '', 0, 1320248087),
(68, 0, 'mod_page', '2010101400', '2010101400', 'Plugin installed', NULL, '', 0, 1320248089),
(69, 0, 'mod_quiz', NULL, '2011070100', 'Starting plugin installation', NULL, '', 0, 1320248089),
(70, 0, 'mod_quiz', '2011070100', '2011070100', 'Plugin installed', NULL, '', 0, 1320248100),
(71, 0, 'mod_resource', NULL, '2011022700', 'Starting plugin installation', NULL, '', 0, 1320248100),
(72, 0, 'mod_resource', '2011022700', '2011022700', 'Plugin installed', NULL, '', 0, 1320248103),
(73, 0, 'mod_scorm', NULL, '2011021403', 'Starting plugin installation', NULL, '', 0, 1320248103),
(74, 0, 'mod_scorm', '2011021403', '2011021403', 'Plugin installed', NULL, '', 0, 1320248115),
(75, 0, 'mod_survey', NULL, '2010080300', 'Starting plugin installation', NULL, '', 0, 1320248116),
(76, 0, 'mod_survey', '2010080300', '2010080300', 'Plugin installed', NULL, '', 0, 1320248126),
(77, 0, 'mod_url', NULL, '2010101400', 'Starting plugin installation', NULL, '', 0, 1320248126),
(78, 0, 'mod_url', '2010101400', '2010101400', 'Plugin installed', NULL, '', 0, 1320248128),
(79, 0, 'mod_wiki', NULL, '2011011001', 'Starting plugin installation', NULL, '', 0, 1320248128),
(80, 0, 'mod_wiki', '2011011001', '2011011001', 'Plugin installed', NULL, '', 0, 1320248137),
(81, 0, 'mod_workshop', NULL, '2011061000', 'Starting plugin installation', NULL, '', 0, 1320248138),
(82, 0, 'mod_workshop', '2011061000', '2011061000', 'Plugin installed', NULL, '', 0, 1320248158),
(83, 0, 'auth_cas', NULL, '2010072600', 'Starting plugin installation', NULL, '', 0, 1320248158),
(84, 0, 'auth_cas', '2010072600', '2010072600', 'Upgrade savepoint reached', NULL, '', 0, 1320248159),
(85, 0, 'auth_cas', '2010072600', '2010072600', 'Plugin installed', NULL, '', 0, 1320248159),
(86, 0, 'auth_db', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248159),
(87, 0, 'auth_db', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248159),
(88, 0, 'auth_db', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248160),
(89, 0, 'auth_fc', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248160),
(90, 0, 'auth_fc', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248160),
(91, 0, 'auth_fc', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248161),
(92, 0, 'auth_imap', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248161),
(93, 0, 'auth_imap', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248161),
(94, 0, 'auth_imap', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248162),
(95, 0, 'auth_ldap', NULL, '2010072600', 'Starting plugin installation', NULL, '', 0, 1320248162),
(96, 0, 'auth_ldap', '2010072600', '2010072600', 'Upgrade savepoint reached', NULL, '', 0, 1320248162),
(97, 0, 'auth_ldap', '2010072600', '2010072600', 'Plugin installed', NULL, '', 0, 1320248162),
(98, 0, 'auth_manual', NULL, '2011022700', 'Starting plugin installation', NULL, '', 0, 1320248162),
(99, 0, 'auth_manual', '2011022700', '2011022700', 'Upgrade savepoint reached', NULL, '', 0, 1320248162),
(100, 0, 'auth_manual', '2011022700', '2011022700', 'Plugin installed', NULL, '', 0, 1320248163),
(101, 0, 'auth_mnet', NULL, '2010071300', 'Starting plugin installation', NULL, '', 0, 1320248163),
(102, 0, 'auth_mnet', '2010071300', '2010071300', 'Upgrade savepoint reached', NULL, '', 0, 1320248163),
(103, 0, 'auth_mnet', '2010071300', '2010071300', 'Plugin installed', NULL, '', 0, 1320248168),
(104, 0, 'auth_nntp', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248168),
(105, 0, 'auth_nntp', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248168),
(106, 0, 'auth_nntp', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248168),
(107, 0, 'auth_pam', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248168),
(108, 0, 'auth_pam', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248169),
(109, 0, 'auth_pam', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248169),
(110, 0, 'auth_pop3', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248169),
(111, 0, 'auth_pop3', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248169),
(112, 0, 'auth_pop3', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248170),
(113, 0, 'auth_radius', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248170),
(114, 0, 'auth_radius', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248170),
(115, 0, 'auth_radius', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248171),
(116, 0, 'auth_shibboleth', NULL, '2009112400', 'Starting plugin installation', NULL, '', 0, 1320248171),
(117, 0, 'auth_shibboleth', '2009112400', '2009112400', 'Upgrade savepoint reached', NULL, '', 0, 1320248171),
(118, 0, 'auth_shibboleth', '2009112400', '2009112400', 'Plugin installed', NULL, '', 0, 1320248171),
(119, 0, 'enrol_authorize', NULL, '2010081203', 'Starting plugin installation', NULL, '', 0, 1320248171),
(120, 0, 'enrol_authorize', '2010081203', '2010081203', 'Upgrade savepoint reached', NULL, '', 0, 1320248175),
(121, 0, 'enrol_authorize', '2010081203', '2010081203', 'Plugin installed', NULL, '', 0, 1320248176),
(122, 0, 'enrol_category', NULL, '2010061500', 'Starting plugin installation', NULL, '', 0, 1320248176),
(123, 0, 'enrol_category', '2010061500', '2010061500', 'Upgrade savepoint reached', NULL, '', 0, 1320248176),
(124, 0, 'enrol_category', '2010061500', '2010061500', 'Plugin installed', NULL, '', 0, 1320248177),
(125, 0, 'enrol_cohort', NULL, '2010073100', 'Starting plugin installation', NULL, '', 0, 1320248177),
(126, 0, 'enrol_cohort', '2010073100', '2010073100', 'Upgrade savepoint reached', NULL, '', 0, 1320248177),
(127, 0, 'enrol_cohort', '2010073100', '2010073100', 'Plugin installed', NULL, '', 0, 1320248178),
(128, 0, 'enrol_database', NULL, '2010073101', 'Starting plugin installation', NULL, '', 0, 1320248178),
(129, 0, 'enrol_database', '2010073101', '2010073101', 'Upgrade savepoint reached', NULL, '', 0, 1320248178),
(130, 0, 'enrol_database', '2010073101', '2010073101', 'Plugin installed', NULL, '', 0, 1320248179),
(131, 0, 'enrol_flatfile', NULL, '2010091400', 'Starting plugin installation', NULL, '', 0, 1320248179),
(132, 0, 'enrol_flatfile', '2010091400', '2010091400', 'Upgrade savepoint reached', NULL, '', 0, 1320248180),
(133, 0, 'enrol_flatfile', '2010091400', '2010091400', 'Plugin installed', NULL, '', 0, 1320248181),
(134, 0, 'enrol_guest', NULL, '2010081800', 'Starting plugin installation', NULL, '', 0, 1320248181),
(135, 0, 'enrol_guest', '2010081800', '2010081800', 'Upgrade savepoint reached', NULL, '', 0, 1320248181),
(136, 0, 'enrol_guest', '2010081800', '2010081800', 'Plugin installed', NULL, '', 0, 1320248182),
(137, 0, 'enrol_imsenterprise', NULL, '2011013000', 'Starting plugin installation', NULL, '', 0, 1320248182),
(138, 0, 'enrol_imsenterprise', '2011013000', '2011013000', 'Upgrade savepoint reached', NULL, '', 0, 1320248182),
(139, 0, 'enrol_imsenterprise', '2011013000', '2011013000', 'Plugin installed', NULL, '', 0, 1320248182),
(140, 0, 'enrol_ldap', NULL, '2010071100', 'Starting plugin installation', NULL, '', 0, 1320248183),
(141, 0, 'enrol_ldap', '2010071100', '2010071100', 'Upgrade savepoint reached', NULL, '', 0, 1320248183),
(142, 0, 'enrol_ldap', '2010071100', '2010071100', 'Plugin installed', NULL, '', 0, 1320248183),
(143, 0, 'enrol_manual', NULL, '2010071201', 'Starting plugin installation', NULL, '', 0, 1320248183),
(144, 0, 'enrol_manual', '2010071201', '2010071201', 'Upgrade savepoint reached', NULL, '', 0, 1320248183),
(145, 0, 'enrol_manual', '2010071201', '2010071201', 'Plugin installed', NULL, '', 0, 1320248185),
(146, 0, 'enrol_meta', NULL, '2010073100', 'Starting plugin installation', NULL, '', 0, 1320248185),
(147, 0, 'enrol_meta', '2010073100', '2010073100', 'Upgrade savepoint reached', NULL, '', 0, 1320248185),
(148, 0, 'enrol_meta', '2010073100', '2010073100', 'Plugin installed', NULL, '', 0, 1320248186),
(149, 0, 'enrol_mnet', NULL, '2010071701', 'Starting plugin installation', NULL, '', 0, 1320248186),
(150, 0, 'enrol_mnet', '2010071701', '2010071701', 'Upgrade savepoint reached', NULL, '', 0, 1320248186),
(151, 0, 'enrol_mnet', '2010071701', '2010071701', 'Plugin installed', NULL, '', 0, 1320248189),
(152, 0, 'enrol_paypal', NULL, '2010073100', 'Starting plugin installation', NULL, '', 0, 1320248189),
(153, 0, 'enrol_paypal', '2010073100', '2010073100', 'Upgrade savepoint reached', NULL, '', 0, 1320248189),
(154, 0, 'enrol_paypal', '2010073100', '2010073100', 'Plugin installed', NULL, '', 0, 1320248190),
(155, 0, 'enrol_self', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248190),
(156, 0, 'enrol_self', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248191),
(157, 0, 'enrol_self', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248192),
(158, 0, 'message_email', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248192),
(159, 0, 'message_email', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248192),
(160, 0, 'message_email', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248193),
(161, 0, 'message_jabber', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248193),
(162, 0, 'message_jabber', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248193),
(163, 0, 'message_jabber', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248194),
(164, 0, 'message_popup', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248194),
(165, 0, 'message_popup', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248194),
(166, 0, 'message_popup', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248195),
(167, 0, 'block_activity_modules', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248195),
(168, 0, 'block_activity_modules', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248196),
(169, 0, 'block_admin_bookmarks', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248196),
(170, 0, 'block_admin_bookmarks', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248196),
(171, 0, 'block_blog_menu', NULL, '2009071700', 'Starting plugin installation', NULL, '', 0, 1320248196),
(172, 0, 'block_blog_menu', '2009071700', '2009071700', 'Plugin installed', NULL, '', 0, 1320248196),
(173, 0, 'block_blog_recent', NULL, '2009070900', 'Starting plugin installation', NULL, '', 0, 1320248196),
(174, 0, 'block_blog_recent', '2009070900', '2009070900', 'Plugin installed', NULL, '', 0, 1320248197),
(175, 0, 'block_blog_tags', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248197),
(176, 0, 'block_blog_tags', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248197),
(177, 0, 'block_calendar_month', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248197),
(178, 0, 'block_calendar_month', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248198),
(179, 0, 'block_calendar_upcoming', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248198),
(180, 0, 'block_calendar_upcoming', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248199),
(181, 0, 'block_comments', NULL, '2009072000', 'Starting plugin installation', NULL, '', 0, 1320248199),
(182, 0, 'block_comments', '2009072000', '2009072000', 'Plugin installed', NULL, '', 0, 1320248199),
(183, 0, 'block_community', NULL, '2010042701', 'Starting plugin installation', NULL, '', 0, 1320248199),
(184, 0, 'block_community', '2010042701', '2010042701', 'Plugin installed', NULL, '', 0, 1320248200),
(185, 0, 'block_completionstatus', NULL, '2009072800', 'Starting plugin installation', NULL, '', 0, 1320248200),
(186, 0, 'block_completionstatus', '2009072800', '2009072800', 'Plugin installed', NULL, '', 0, 1320248200),
(187, 0, 'block_course_list', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248200),
(188, 0, 'block_course_list', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248201),
(189, 0, 'block_course_overview', NULL, '2010021100', 'Starting plugin installation', NULL, '', 0, 1320248201),
(190, 0, 'block_course_overview', '2010021100', '2010021100', 'Plugin installed', NULL, '', 0, 1320248201),
(191, 0, 'block_course_summary', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248202),
(192, 0, 'block_course_summary', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248202),
(193, 0, 'block_feedback', NULL, '2010050200', 'Starting plugin installation', NULL, '', 0, 1320248202),
(194, 0, 'block_feedback', '2010050200', '2010050200', 'Plugin installed', NULL, '', 0, 1320248203),
(195, 0, 'block_glossary_random', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248203),
(196, 0, 'block_glossary_random', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248203),
(197, 0, 'block_html', NULL, '2010071900', 'Starting plugin installation', NULL, '', 0, 1320248203),
(198, 0, 'block_html', '2010071900', '2010071900', 'Plugin installed', NULL, '', 0, 1320248203),
(199, 0, 'block_login', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248204),
(200, 0, 'block_login', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248204),
(201, 0, 'block_mentees', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248204),
(202, 0, 'block_mentees', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248204),
(203, 0, 'block_messages', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248204),
(204, 0, 'block_messages', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248205),
(205, 0, 'block_mnet_hosts', NULL, '2010112900', 'Starting plugin installation', NULL, '', 0, 1320248205),
(206, 0, 'block_mnet_hosts', '2010112900', '2010112900', 'Plugin installed', NULL, '', 0, 1320248205),
(207, 0, 'block_myprofile', NULL, '2009123100', 'Starting plugin installation', NULL, '', 0, 1320248205),
(208, 0, 'block_myprofile', '2009123100', '2009123100', 'Plugin installed', NULL, '', 0, 1320248206),
(209, 0, 'block_navigation', NULL, '2010091400', 'Starting plugin installation', NULL, '', 0, 1320248206),
(210, 0, 'block_navigation', '2010091400', '2010091400', 'Plugin installed', NULL, '', 0, 1320248206),
(211, 0, 'block_news_items', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248206),
(212, 0, 'block_news_items', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248206),
(213, 0, 'block_online_users', NULL, '2007101510', 'Starting plugin installation', NULL, '', 0, 1320248206),
(214, 0, 'block_online_users', '2007101510', '2007101510', 'Plugin installed', NULL, '', 0, 1320248207),
(215, 0, 'block_participants', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248207),
(216, 0, 'block_participants', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248208),
(217, 0, 'block_private_files', NULL, '2010030100', 'Starting plugin installation', NULL, '', 0, 1320248208),
(218, 0, 'block_private_files', '2010030100', '2010030100', 'Plugin installed', NULL, '', 0, 1320248209),
(219, 0, 'block_quiz_results', NULL, '2011100300', 'Starting plugin installation', NULL, '', 0, 1320248209),
(220, 0, 'block_quiz_results', '2011100300', '2011100300', 'Plugin installed', NULL, '', 0, 1320248209),
(221, 0, 'block_recent_activity', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248209),
(222, 0, 'block_recent_activity', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248210),
(223, 0, 'block_rss_client', NULL, '2009072901', 'Starting plugin installation', NULL, '', 0, 1320248210),
(224, 0, 'block_rss_client', '2009072901', '2009072901', 'Plugin installed', NULL, '', 0, 1320248211),
(225, 0, 'block_search', NULL, '2010111100', 'Starting plugin installation', NULL, '', 0, 1320248211),
(226, 0, 'block_search', '2010111100', '2010111100', 'Plugin installed', NULL, '', 0, 1320248213),
(227, 0, 'block_search_forums', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248213),
(228, 0, 'block_search_forums', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248214),
(229, 0, 'block_section_links', NULL, '2007101511', 'Starting plugin installation', NULL, '', 0, 1320248214),
(230, 0, 'block_section_links', '2007101511', '2007101511', 'Plugin installed', NULL, '', 0, 1320248214),
(231, 0, 'block_selfcompletion', NULL, '2009072800', 'Starting plugin installation', NULL, '', 0, 1320248214),
(232, 0, 'block_selfcompletion', '2009072800', '2009072800', 'Plugin installed', NULL, '', 0, 1320248215),
(233, 0, 'block_settings', NULL, '2010091400', 'Starting plugin installation', NULL, '', 0, 1320248215),
(234, 0, 'block_settings', '2010091400', '2010091400', 'Plugin installed', NULL, '', 0, 1320248215),
(235, 0, 'block_site_main_menu', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248215),
(236, 0, 'block_site_main_menu', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248216),
(237, 0, 'block_social_activities', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248216),
(238, 0, 'block_social_activities', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248216),
(239, 0, 'block_tag_flickr', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248216),
(240, 0, 'block_tag_flickr', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248216),
(241, 0, 'block_tag_youtube', NULL, '2007101509', 'Starting plugin installation', NULL, '', 0, 1320248216),
(242, 0, 'block_tag_youtube', '2007101509', '2007101509', 'Plugin installed', NULL, '', 0, 1320248217),
(243, 0, 'block_tags', NULL, '2010090502', 'Starting plugin installation', NULL, '', 0, 1320248217),
(244, 0, 'block_tags', '2010090502', '2010090502', 'Plugin installed', NULL, '', 0, 1320248217),
(245, 0, 'filter_emoticon', NULL, '2010102300', 'Starting plugin installation', NULL, '', 0, 1320248219),
(246, 0, 'filter_emoticon', '2010102300', '2010102300', 'Upgrade savepoint reached', NULL, '', 0, 1320248219),
(247, 0, 'filter_emoticon', '2010102300', '2010102300', 'Plugin installed', NULL, '', 0, 1320248220),
(248, 0, 'filter_mediaplugin', NULL, '2011030900', 'Starting plugin installation', NULL, '', 0, 1320248220),
(249, 0, 'filter_mediaplugin', '2011030900', '2011030900', 'Upgrade savepoint reached', NULL, '', 0, 1320248220),
(250, 0, 'filter_mediaplugin', '2011030900', '2011030900', 'Plugin installed', NULL, '', 0, 1320248220),
(251, 0, 'filter_tex', NULL, '2011031301', 'Starting plugin installation', NULL, '', 0, 1320248220),
(252, 0, 'filter_tex', '2011031301', '2011031301', 'Upgrade savepoint reached', NULL, '', 0, 1320248220),
(253, 0, 'filter_tex', '2011031301', '2011031301', 'Plugin installed', NULL, '', 0, 1320248222),
(254, 0, 'filter_urltolink', NULL, '2010100500', 'Starting plugin installation', NULL, '', 0, 1320248222),
(255, 0, 'filter_urltolink', '2010100500', '2010100500', 'Upgrade savepoint reached', NULL, '', 0, 1320248222),
(256, 0, 'filter_urltolink', '2010100500', '2010100500', 'Plugin installed', NULL, '', 0, 1320248222),
(257, 0, 'editor_textarea', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248222),
(258, 0, 'editor_textarea', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248222),
(259, 0, 'editor_textarea', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248223),
(260, 0, 'editor_tinymce', NULL, '2010093000', 'Starting plugin installation', NULL, '', 0, 1320248223),
(261, 0, 'editor_tinymce', '2010093000', '2010093000', 'Upgrade savepoint reached', NULL, '', 0, 1320248223),
(262, 0, 'editor_tinymce', '2010093000', '2010093000', 'Plugin installed', NULL, '', 0, 1320248223),
(263, 0, 'report_courseoverview', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248223),
(264, 0, 'report_courseoverview', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248224),
(265, 0, 'report_courseoverview', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248224),
(266, 0, 'report_customlang', NULL, '2011041900', 'Starting plugin installation', NULL, '', 0, 1320248224),
(267, 0, 'report_customlang', '2011041900', '2011041900', 'Upgrade savepoint reached', NULL, '', 0, 1320248226),
(268, 0, 'report_customlang', '2011041900', '2011041900', 'Plugin installed', NULL, '', 0, 1320248226),
(269, 0, 'report_questioninstances', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248227),
(270, 0, 'report_questioninstances', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248227),
(271, 0, 'report_questioninstances', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248227),
(272, 0, 'report_security', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248228),
(273, 0, 'report_security', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248228),
(274, 0, 'report_security', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248228),
(275, 0, 'report_unittest', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248228),
(276, 0, 'report_unittest', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248228),
(277, 0, 'report_unittest', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248229),
(278, 0, 'report_unsuproles', NULL, '2010071800', 'Starting plugin installation', NULL, '', 0, 1320248229),
(279, 0, 'report_unsuproles', '2010071800', '2010071800', 'Upgrade savepoint reached', NULL, '', 0, 1320248229),
(280, 0, 'report_unsuproles', '2010071800', '2010071800', 'Plugin installed', NULL, '', 0, 1320248230),
(281, 0, 'coursereport_completion', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248230),
(282, 0, 'coursereport_completion', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248230),
(283, 0, 'coursereport_completion', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248231),
(284, 0, 'coursereport_log', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248231),
(285, 0, 'coursereport_log', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248231),
(286, 0, 'coursereport_log', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248232),
(287, 0, 'coursereport_outline', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248232),
(288, 0, 'coursereport_outline', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248233),
(289, 0, 'coursereport_outline', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248233),
(290, 0, 'coursereport_participation', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248233),
(291, 0, 'coursereport_participation', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248233),
(292, 0, 'coursereport_participation', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248234),
(293, 0, 'coursereport_progress', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248234),
(294, 0, 'coursereport_progress', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248234),
(295, 0, 'coursereport_progress', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248235),
(296, 0, 'coursereport_stats', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248235),
(297, 0, 'coursereport_stats', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248235),
(298, 0, 'coursereport_stats', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248236),
(299, 0, 'gradeexport_ods', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248236),
(300, 0, 'gradeexport_ods', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248236),
(301, 0, 'gradeexport_ods', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248237),
(302, 0, 'gradeexport_txt', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248237),
(303, 0, 'gradeexport_txt', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248237),
(304, 0, 'gradeexport_txt', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248238),
(305, 0, 'gradeexport_xls', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248238),
(306, 0, 'gradeexport_xls', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248238),
(307, 0, 'gradeexport_xls', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248239),
(308, 0, 'gradeexport_xml', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248239),
(309, 0, 'gradeexport_xml', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248239),
(310, 0, 'gradeexport_xml', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248240),
(311, 0, 'gradeimport_csv', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248240),
(312, 0, 'gradeimport_csv', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248240),
(313, 0, 'gradeimport_csv', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248241),
(314, 0, 'gradeimport_xml', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248241),
(315, 0, 'gradeimport_xml', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248241),
(316, 0, 'gradeimport_xml', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248242),
(317, 0, 'gradereport_grader', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248242),
(318, 0, 'gradereport_grader', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248242),
(319, 0, 'gradereport_grader', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248243),
(320, 0, 'gradereport_outcomes', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248243),
(321, 0, 'gradereport_outcomes', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248243),
(322, 0, 'gradereport_outcomes', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248244),
(323, 0, 'gradereport_overview', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248244),
(324, 0, 'gradereport_overview', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248244),
(325, 0, 'gradereport_overview', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248245),
(326, 0, 'gradereport_user', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248245),
(327, 0, 'gradereport_user', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248245),
(328, 0, 'gradereport_user', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248246),
(329, 0, 'mnetservice_enrol', NULL, '2010071700', 'Starting plugin installation', NULL, '', 0, 1320248246),
(330, 0, 'mnetservice_enrol', '2010071700', '2010071700', 'Upgrade savepoint reached', NULL, '', 0, 1320248247),
(331, 0, 'mnetservice_enrol', '2010071700', '2010071700', 'Plugin installed', NULL, '', 0, 1320248248),
(332, 0, 'webservice_amf', NULL, '2009101900', 'Starting plugin installation', NULL, '', 0, 1320248248),
(333, 0, 'webservice_amf', '2009101900', '2009101900', 'Upgrade savepoint reached', NULL, '', 0, 1320248248),
(334, 0, 'webservice_amf', '2009101900', '2009101900', 'Plugin installed', NULL, '', 0, 1320248248),
(335, 0, 'webservice_rest', NULL, '2009100800', 'Starting plugin installation', NULL, '', 0, 1320248249),
(336, 0, 'webservice_rest', '2009100800', '2009100800', 'Upgrade savepoint reached', NULL, '', 0, 1320248249),
(337, 0, 'webservice_rest', '2009100800', '2009100800', 'Plugin installed', NULL, '', 0, 1320248249),
(338, 0, 'webservice_soap', NULL, '2009101900', 'Starting plugin installation', NULL, '', 0, 1320248249),
(339, 0, 'webservice_soap', '2009101900', '2009101900', 'Upgrade savepoint reached', NULL, '', 0, 1320248249),
(340, 0, 'webservice_soap', '2009101900', '2009101900', 'Plugin installed', NULL, '', 0, 1320248250),
(341, 0, 'webservice_xmlrpc', NULL, '2009101900', 'Starting plugin installation', NULL, '', 0, 1320248250),
(342, 0, 'webservice_xmlrpc', '2009101900', '2009101900', 'Upgrade savepoint reached', NULL, '', 0, 1320248250),
(343, 0, 'webservice_xmlrpc', '2009101900', '2009101900', 'Plugin installed', NULL, '', 0, 1320248251),
(344, 0, 'repository_alfresco', NULL, '2010050700', 'Starting plugin installation', NULL, '', 0, 1320248251),
(345, 0, 'repository_alfresco', '2010050700', '2010050700', 'Upgrade savepoint reached', NULL, '', 0, 1320248251),
(346, 0, 'repository_alfresco', '2010050700', '2010050700', 'Plugin installed', NULL, '', 0, 1320248251),
(347, 0, 'repository_boxnet', NULL, '2009080105', 'Starting plugin installation', NULL, '', 0, 1320248251),
(348, 0, 'repository_boxnet', '2009080105', '2009080105', 'Upgrade savepoint reached', NULL, '', 0, 1320248251),
(349, 0, 'repository_boxnet', '2009080105', '2009080105', 'Plugin installed', NULL, '', 0, 1320248252),
(350, 0, 'repository_coursefiles', NULL, '2010083100', 'Starting plugin installation', NULL, '', 0, 1320248252),
(351, 0, 'repository_coursefiles', '2010083100', '2010083100', 'Upgrade savepoint reached', NULL, '', 0, 1320248252),
(352, 0, 'repository_coursefiles', '2010083100', '2010083100', 'Plugin installed', NULL, '', 0, 1320248253),
(353, 0, 'repository_dropbox', NULL, '2010051400', 'Starting plugin installation', NULL, '', 0, 1320248253),
(354, 0, 'repository_dropbox', '2010051400', '2010051400', 'Upgrade savepoint reached', NULL, '', 0, 1320248253),
(355, 0, 'repository_dropbox', '2010051400', '2010051400', 'Plugin installed', NULL, '', 0, 1320248253),
(356, 0, 'repository_filesystem', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248253),
(357, 0, 'repository_filesystem', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248254),
(358, 0, 'repository_filesystem', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248255),
(359, 0, 'repository_flickr', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248255),
(360, 0, 'repository_flickr', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248255),
(361, 0, 'repository_flickr', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248255),
(362, 0, 'repository_flickr_public', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248255),
(363, 0, 'repository_flickr_public', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248256),
(364, 0, 'repository_flickr_public', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248256),
(365, 0, 'repository_googledocs', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248256),
(366, 0, 'repository_googledocs', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248256),
(367, 0, 'repository_googledocs', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248257),
(368, 0, 'repository_local', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248257),
(369, 0, 'repository_local', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248257),
(370, 0, 'repository_local', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248258),
(371, 0, 'repository_merlot', NULL, '2009111301', 'Starting plugin installation', NULL, '', 0, 1320248258),
(372, 0, 'repository_merlot', '2009111301', '2009111301', 'Upgrade savepoint reached', NULL, '', 0, 1320248258),
(373, 0, 'repository_merlot', '2009111301', '2009111301', 'Plugin installed', NULL, '', 0, 1320248259),
(374, 0, 'repository_picasa', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248259),
(375, 0, 'repository_picasa', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248259),
(376, 0, 'repository_picasa', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248259),
(377, 0, 'repository_recent', NULL, '2010042202', 'Starting plugin installation', NULL, '', 0, 1320248259),
(378, 0, 'repository_recent', '2010042202', '2010042202', 'Upgrade savepoint reached', NULL, '', 0, 1320248260),
(379, 0, 'repository_recent', '2010042202', '2010042202', 'Plugin installed', NULL, '', 0, 1320248260),
(380, 0, 'repository_s3', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248261),
(381, 0, 'repository_s3', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248261),
(382, 0, 'repository_s3', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248261),
(383, 0, 'repository_upload', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248261),
(384, 0, 'repository_upload', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248261),
(385, 0, 'repository_upload', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248262),
(386, 0, 'repository_url', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248262),
(387, 0, 'repository_url', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248263),
(388, 0, 'repository_url', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248263),
(389, 0, 'repository_user', NULL, '2010052700', 'Starting plugin installation', NULL, '', 0, 1320248263),
(390, 0, 'repository_user', '2010052700', '2010052700', 'Upgrade savepoint reached', NULL, '', 0, 1320248263),
(391, 0, 'repository_user', '2010052700', '2010052700', 'Plugin installed', NULL, '', 0, 1320248265),
(392, 0, 'repository_webdav', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248265),
(393, 0, 'repository_webdav', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248265),
(394, 0, 'repository_webdav', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248266),
(395, 0, 'repository_wikimedia', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248266),
(396, 0, 'repository_wikimedia', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248266),
(397, 0, 'repository_wikimedia', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248267),
(398, 0, 'repository_youtube', NULL, '2009080102', 'Starting plugin installation', NULL, '', 0, 1320248267),
(399, 0, 'repository_youtube', '2009080102', '2009080102', 'Upgrade savepoint reached', NULL, '', 0, 1320248267),
(400, 0, 'repository_youtube', '2009080102', '2009080102', 'Plugin installed', NULL, '', 0, 1320248267),
(401, 0, 'portfolio_boxnet', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248268),
(402, 0, 'portfolio_boxnet', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248268),
(403, 0, 'portfolio_boxnet', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248268),
(404, 0, 'portfolio_download', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248268),
(405, 0, 'portfolio_download', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248268),
(406, 0, 'portfolio_download', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248269),
(407, 0, 'portfolio_flickr', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248269),
(408, 0, 'portfolio_flickr', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248269),
(409, 0, 'portfolio_flickr', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248269),
(410, 0, 'portfolio_googledocs', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248269),
(411, 0, 'portfolio_googledocs', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248270),
(412, 0, 'portfolio_googledocs', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248270),
(413, 0, 'portfolio_mahara', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248270),
(414, 0, 'portfolio_mahara', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248271),
(415, 0, 'portfolio_mahara', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248272),
(416, 0, 'portfolio_picasa', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248272),
(417, 0, 'portfolio_picasa', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248272),
(418, 0, 'portfolio_picasa', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248273),
(419, 0, 'theme_formal_white', NULL, '2011061301', 'Starting plugin installation', NULL, '', 0, 1320248273),
(420, 0, 'theme_formal_white', '2011061301', '2011061301', 'Upgrade savepoint reached', NULL, '', 0, 1320248273),
(421, 0, 'theme_formal_white', '2011061301', '2011061301', 'Plugin installed', NULL, '', 0, 1320248274),
(422, 0, 'assignment_online', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248274),
(423, 0, 'assignment_online', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248274),
(424, 0, 'assignment_online', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248274),
(425, 0, 'quiz_grading', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320248274),
(426, 0, 'quiz_grading', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320248275),
(427, 0, 'quiz_grading', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320248275),
(428, 0, 'quiz_overview', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320248276),
(429, 0, 'quiz_overview', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320248276),
(430, 0, 'quiz_overview', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320248277),
(431, 0, 'quiz_responses', NULL, '2011051200', 'Starting plugin installation', NULL, '', 0, 1320248277),
(432, 0, 'quiz_responses', '2011051200', '2011051200', 'Upgrade savepoint reached', NULL, '', 0, 1320248277),
(433, 0, 'quiz_responses', '2011051200', '2011051200', 'Plugin installed', NULL, '', 0, 1320248277),
(434, 0, 'quiz_statistics', NULL, '2011062600', 'Starting plugin installation', NULL, '', 0, 1320248278),
(435, 0, 'quiz_statistics', '2011062600', '2011062600', 'Upgrade savepoint reached', NULL, '', 0, 1320248278),
(436, 0, 'quiz_statistics', '2011062600', '2011062600', 'Plugin installed', NULL, '', 0, 1320248279),
(437, 0, 'workshopform_accumulative', NULL, '2010091700', 'Starting plugin installation', NULL, '', 0, 1320248279),
(438, 0, 'workshopform_accumulative', '2010091700', '2010091700', 'Upgrade savepoint reached', NULL, '', 0, 1320248280),
(439, 0, 'workshopform_accumulative', '2010091700', '2010091700', 'Plugin installed', NULL, '', 0, 1320248280),
(440, 0, 'workshopform_comments', NULL, '2010091700', 'Starting plugin installation', NULL, '', 0, 1320248280),
(441, 0, 'workshopform_comments', '2010091700', '2010091700', 'Upgrade savepoint reached', NULL, '', 0, 1320248281),
(442, 0, 'workshopform_comments', '2010091700', '2010091700', 'Plugin installed', NULL, '', 0, 1320248282),
(443, 0, 'workshopform_numerrors', NULL, '2010091700', 'Starting plugin installation', NULL, '', 0, 1320248282),
(444, 0, 'workshopform_numerrors', '2010091700', '2010091700', 'Upgrade savepoint reached', NULL, '', 0, 1320248284),
(445, 0, 'workshopform_numerrors', '2010091700', '2010091700', 'Plugin installed', NULL, '', 0, 1320248284),
(446, 0, 'workshopform_rubric', NULL, '2010091700', 'Starting plugin installation', NULL, '', 0, 1320248284),
(447, 0, 'workshopform_rubric', '2010091700', '2010091700', 'Upgrade savepoint reached', NULL, '', 0, 1320248286),
(448, 0, 'workshopform_rubric', '2010091700', '2010091700', 'Plugin installed', NULL, '', 0, 1320248286),
(449, 0, 'workshopeval_best', NULL, '2010090501', 'Starting plugin installation', NULL, '', 0, 1320248287),
(450, 0, 'workshopeval_best', '2010090501', '2010090501', 'Upgrade savepoint reached', NULL, '', 0, 1320248287),
(451, 0, 'workshopeval_best', '2010090501', '2010090501', 'Plugin installed', NULL, '', 0, 1320248288),
(452, 0, 'local_qeupgradehelper', NULL, '2011040400', 'Starting plugin installation', NULL, '', 0, 1320248288),
(453, 0, 'local_qeupgradehelper', '2011040400', '2011040400', 'Upgrade savepoint reached', NULL, '', 0, 1320248288),
(454, 0, 'local_qeupgradehelper', '2011040400', '2011040400', 'Plugin installed', NULL, '', 0, 1320248289);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_url`
--

CREATE TABLE IF NOT EXISTS `mdl_url` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` text,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `externalurl` text,
  `display` smallint(4) unsigned NOT NULL DEFAULT '0',
  `displayoptions` text,
  `parameters` text,
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_url_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each record is one url resource' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_url`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_user`
--

CREATE TABLE IF NOT EXISTS `mdl_user` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `auth` varchar(20) NOT NULL DEFAULT 'manual',
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `policyagreed` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
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
  `city` varchar(120) NOT NULL DEFAULT '',
  `country` varchar(2) NOT NULL DEFAULT '',
  `lang` varchar(30) NOT NULL DEFAULT 'en',
  `theme` varchar(50) NOT NULL DEFAULT '',
  `timezone` varchar(100) NOT NULL DEFAULT '99',
  `firstaccess` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastaccess` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastlogin` bigint(10) unsigned NOT NULL DEFAULT '0',
  `currentlogin` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(45) NOT NULL DEFAULT '',
  `secret` varchar(15) NOT NULL DEFAULT '',
  `picture` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `description` longtext,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `mailformat` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `maildigest` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maildisplay` tinyint(2) unsigned NOT NULL DEFAULT '2',
  `htmleditor` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ajax` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `autosubscribe` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `trackforums` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='One record for each person' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mdl_user`
--

INSERT INTO `mdl_user` (`id`, `auth`, `confirmed`, `policyagreed`, `deleted`, `suspended`, `mnethostid`, `username`, `password`, `idnumber`, `firstname`, `lastname`, `email`, `emailstop`, `icq`, `skype`, `yahoo`, `aim`, `msn`, `phone1`, `phone2`, `institution`, `department`, `address`, `city`, `country`, `lang`, `theme`, `timezone`, `firstaccess`, `lastaccess`, `lastlogin`, `currentlogin`, `lastip`, `secret`, `picture`, `url`, `description`, `descriptionformat`, `mailformat`, `maildigest`, `maildisplay`, `htmleditor`, `ajax`, `autosubscribe`, `trackforums`, `timecreated`, `timemodified`, `trustbitmask`, `imagealt`, `screenreader`) VALUES
(1, 'manual', 1, 0, 0, 0, 1, 'guest', '70787aced1bdeae54fab730a99e707ce', '', 'Guest user', ' ', 'root@localhost', 0, '', '', '', '', '', '', '', '', '', '', '', '', 'en', '', '99', 0, 0, 0, 0, '', '', 0, '', 'This user is a special user that allows read-only access to some courses.', 0, 1, 0, 2, 1, 1, 1, 0, 0, 1320247878, 0, NULL, 0),
(2, 'manual', 1, 0, 0, 0, 1, 'admin', '51d73e02373f2b862eb9f50b40187e35', '', 'Admin', 'User', 'm.deridder@solin.nl', 0, '', '', '', '', '', '', '', '', '', '', 'Breda', 'NL', 'en', '', '99', 0, 1320249142, 0, 1320248895, '0:0:0:0:0:0:0:1', '', 0, '', '', 0, 1, 0, 1, 1, 1, 1, 0, 0, 1320248922, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_enrolments`
--

CREATE TABLE IF NOT EXISTS `mdl_user_enrolments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` bigint(10) unsigned NOT NULL DEFAULT '0',
  `enrolid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `timestart` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeend` bigint(10) unsigned NOT NULL DEFAULT '2147483647',
  `modifierid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_userenro_enruse_uix` (`enrolid`,`userid`),
  KEY `mdl_userenro_enr_ix` (`enrolid`),
  KEY `mdl_userenro_use_ix` (`userid`),
  KEY `mdl_userenro_mod_ix` (`modifierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users participating in courses (aka enrolled users) - everyb' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_user_enrolments`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_info_category`
--

CREATE TABLE IF NOT EXISTS `mdl_user_info_category` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customisable fields categories' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_user_info_category`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_info_data`
--

CREATE TABLE IF NOT EXISTS `mdl_user_info_data` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `fieldid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  `dataformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_userinfodata_usefie_ix` (`userid`,`fieldid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data for the customisable user fields' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_user_info_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_info_field`
--

CREATE TABLE IF NOT EXISTS `mdl_user_info_field` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `shortname` varchar(255) NOT NULL DEFAULT 'shortname',
  `name` longtext NOT NULL,
  `datatype` varchar(255) NOT NULL DEFAULT '',
  `description` longtext,
  `descriptionformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `categoryid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sortorder` bigint(10) unsigned NOT NULL DEFAULT '0',
  `required` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `visible` smallint(4) unsigned NOT NULL DEFAULT '0',
  `forceunique` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `signup` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `defaultdata` longtext,
  `defaultdataformat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `param1` longtext,
  `param2` longtext,
  `param3` longtext,
  `param4` longtext,
  `param5` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customisable user profile fields' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_user_info_field`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_lastaccess`
--

CREATE TABLE IF NOT EXISTS `mdl_user_lastaccess` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `courseid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timeaccess` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_userlast_usecou_uix` (`userid`,`courseid`),
  KEY `mdl_userlast_use_ix` (`userid`),
  KEY `mdl_userlast_cou_ix` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To keep track of course page access times, used in online pa' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_user_lastaccess`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_preferences`
--

CREATE TABLE IF NOT EXISTS `mdl_user_preferences` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_userpref_usenam_uix` (`userid`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Allows modules to store arbitrary user preferences' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `mdl_user_preferences`
--

INSERT INTO `mdl_user_preferences` (`id`, `userid`, `name`, `value`) VALUES
(1, 2, 'auth_forcepasswordchange', '0'),
(2, 2, 'email_bounce_count', '1'),
(3, 2, 'email_send_count', '1');

-- --------------------------------------------------------

--
-- Table structure for table `mdl_user_private_key`
--

CREATE TABLE IF NOT EXISTS `mdl_user_private_key` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='access keys used in cookieless scripts - rss, etc.' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_user_private_key`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_webdav_locks`
--

CREATE TABLE IF NOT EXISTS `mdl_webdav_locks` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resource locks for WebDAV users' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_webdav_locks`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT 'Wiki',
  `intro` mediumtext,
  `introformat` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `firstpagetitle` varchar(255) NOT NULL DEFAULT 'First Page',
  `wikimode` varchar(20) NOT NULL DEFAULT 'collaborative',
  `defaultformat` varchar(20) NOT NULL DEFAULT 'creole',
  `forceformat` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `editbegin` bigint(10) unsigned NOT NULL DEFAULT '0',
  `editend` bigint(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_wiki_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Wiki activity configuration' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki_links`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki_links` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `subwikiid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `frompageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `topageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `tomissingpage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_wikilink_fro_ix` (`frompageid`),
  KEY `mdl_wikilink_sub_ix` (`subwikiid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Page wiki links' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki_links`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki_locks`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki_locks` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `sectionname` varchar(255) DEFAULT NULL,
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `lockedat` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Manages page locks' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki_locks`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki_pages`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki_pages` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `subwikiid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT 'title',
  `cachedcontent` mediumtext NOT NULL,
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timerendered` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageviews` bigint(10) unsigned NOT NULL DEFAULT '0',
  `readonly` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_wikipage_subtituse_uix` (`subwikiid`,`title`,`userid`),
  KEY `mdl_wikipage_sub_ix` (`subwikiid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores wiki pages' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki_subwikis`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki_subwikis` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `wikiid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `groupid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_wikisubw_wikgrouse_uix` (`wikiid`,`groupid`,`userid`),
  KEY `mdl_wikisubw_wik_ix` (`wikiid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores subwiki instances' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki_subwikis`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki_synonyms`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki_synonyms` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `subwikiid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `pagesynonym` varchar(255) NOT NULL DEFAULT 'Pagesynonym',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_wikisyno_pagpag_uix` (`pageid`,`pagesynonym`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores wiki pages synonyms' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki_synonyms`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_wiki_versions`
--

CREATE TABLE IF NOT EXISTS `mdl_wiki_versions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `pageid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `content` mediumtext NOT NULL,
  `contentformat` varchar(20) NOT NULL DEFAULT 'creole',
  `version` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_wikivers_pag_ix` (`pageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores wiki page history' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_wiki_versions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` bigint(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext,
  `introformat` smallint(3) unsigned NOT NULL DEFAULT '0',
  `instructauthors` longtext,
  `instructauthorsformat` smallint(3) unsigned NOT NULL DEFAULT '0',
  `instructreviewers` longtext,
  `instructreviewersformat` smallint(3) unsigned NOT NULL DEFAULT '0',
  `timemodified` bigint(10) unsigned NOT NULL,
  `phase` smallint(3) unsigned DEFAULT '0',
  `useexamples` tinyint(2) unsigned DEFAULT '0',
  `usepeerassessment` tinyint(2) unsigned DEFAULT '0',
  `useselfassessment` tinyint(2) unsigned DEFAULT '0',
  `grade` decimal(10,5) unsigned DEFAULT '80.00000',
  `gradinggrade` decimal(10,5) unsigned DEFAULT '20.00000',
  `strategy` varchar(30) NOT NULL DEFAULT '',
  `evaluation` varchar(30) NOT NULL DEFAULT '',
  `gradedecimals` smallint(3) unsigned DEFAULT '0',
  `nattachments` smallint(3) unsigned DEFAULT '0',
  `latesubmissions` tinyint(2) unsigned DEFAULT '0',
  `maxbytes` bigint(10) unsigned DEFAULT '100000',
  `examplesmode` smallint(3) unsigned DEFAULT '0',
  `submissionstart` bigint(10) unsigned DEFAULT '0',
  `submissionend` bigint(10) unsigned DEFAULT '0',
  `assessmentstart` bigint(10) unsigned DEFAULT '0',
  `assessmentend` bigint(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_work_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about the module instances and ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopeval_best_settings`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopeval_best_settings` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `comparison` smallint(3) unsigned DEFAULT '5',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_workbestsett_wor_uix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Settings for the grading evaluation subplugin Comparison wit' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopeval_best_settings`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_accumulative`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_accumulative` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `sort` bigint(10) unsigned DEFAULT '0',
  `description` longtext,
  `descriptionformat` smallint(3) unsigned DEFAULT '0',
  `grade` bigint(10) NOT NULL,
  `weight` mediumint(5) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_workaccu_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Accumulative gradin' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_accumulative`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_comments`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_comments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `sort` bigint(10) unsigned DEFAULT '0',
  `description` longtext,
  `descriptionformat` smallint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_workcomm_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Comments strategy f' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_numerrors`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_numerrors` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `sort` bigint(10) unsigned DEFAULT '0',
  `description` longtext,
  `descriptionformat` smallint(3) unsigned DEFAULT '0',
  `descriptiontrust` bigint(10) unsigned DEFAULT NULL,
  `grade0` varchar(50) DEFAULT NULL,
  `grade1` varchar(50) DEFAULT NULL,
  `weight` mediumint(5) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `mdl_worknume_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Number of errors gr' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_numerrors`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_numerrors_map`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_numerrors_map` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `nonegative` bigint(10) unsigned NOT NULL,
  `grade` decimal(10,5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_worknumemap_wornon_uix` (`workshopid`,`nonegative`),
  KEY `mdl_worknumemap_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This maps the number of errors to a percentual grade for sub' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_numerrors_map`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_rubric`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_rubric` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `sort` bigint(10) unsigned DEFAULT '0',
  `description` longtext,
  `descriptionformat` smallint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_workrubr_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Rubric grading stra' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_rubric`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_rubric_config`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_rubric_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `layout` varchar(30) DEFAULT 'list',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_workrubrconf_wor_uix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Configuration table for the Rubric grading strategy' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_rubric_config`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshopform_rubric_levels`
--

CREATE TABLE IF NOT EXISTS `mdl_workshopform_rubric_levels` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `dimensionid` bigint(10) unsigned NOT NULL,
  `grade` decimal(10,5) unsigned NOT NULL,
  `definition` longtext,
  `definitionformat` smallint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_workrubrleve_dim_ix` (`dimensionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The definition of rubric rating scales' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshopform_rubric_levels`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_aggregations`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_aggregations` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `userid` bigint(10) unsigned NOT NULL,
  `gradinggrade` decimal(10,5) unsigned DEFAULT NULL,
  `timegraded` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_workaggr_woruse_uix` (`workshopid`,`userid`),
  KEY `mdl_workaggr_wor_ix` (`workshopid`),
  KEY `mdl_workaggr_use_ix` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Aggregated grades for assessment are stored here. The aggreg' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_aggregations`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_assessments`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_assessments` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `submissionid` bigint(10) unsigned NOT NULL,
  `reviewerid` bigint(10) unsigned NOT NULL,
  `weight` bigint(10) unsigned NOT NULL DEFAULT '1',
  `timecreated` bigint(10) unsigned DEFAULT '0',
  `timemodified` bigint(10) unsigned DEFAULT '0',
  `grade` decimal(10,5) unsigned DEFAULT NULL,
  `gradinggrade` decimal(10,5) unsigned DEFAULT NULL,
  `gradinggradeover` decimal(10,5) unsigned DEFAULT NULL,
  `gradinggradeoverby` bigint(10) unsigned DEFAULT NULL,
  `feedbackauthor` longtext,
  `feedbackauthorformat` smallint(3) unsigned DEFAULT '0',
  `feedbackreviewer` longtext,
  `feedbackreviewerformat` smallint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_workasse_sub_ix` (`submissionid`),
  KEY `mdl_workasse_gra_ix` (`gradinggradeoverby`),
  KEY `mdl_workasse_rev_ix` (`reviewerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about the made assessment and automatically calculated ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_assessments`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_assessments_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_assessments_old` (
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
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workasseold_use_ix` (`userid`),
  KEY `mdl_workasseold_mai_ix` (`mailed`),
  KEY `mdl_workasseold_wor_ix` (`workshopid`),
  KEY `mdl_workasseold_sub_ix` (`submissionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_assessments table to be dropped later in Moo' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_assessments_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_comments_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_comments_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assessmentid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `userid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `timecreated` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mailed` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workcommold_use_ix` (`userid`),
  KEY `mdl_workcommold_mai_ix` (`mailed`),
  KEY `mdl_workcommold_wor_ix` (`workshopid`),
  KEY `mdl_workcommold_ass_ix` (`assessmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_comments table to be dropped later in Moodle' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_comments_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_elements_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_elements_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` smallint(3) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `scale` smallint(3) unsigned NOT NULL DEFAULT '0',
  `maxscore` smallint(3) unsigned NOT NULL DEFAULT '1',
  `weight` smallint(3) unsigned NOT NULL DEFAULT '11',
  `stddev` double NOT NULL DEFAULT '0',
  `totalassessments` bigint(10) NOT NULL DEFAULT '0',
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workelemold_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_elements table to be dropped later in Moodle' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_elements_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_grades`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_grades` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `assessmentid` bigint(10) unsigned NOT NULL,
  `strategy` varchar(30) NOT NULL DEFAULT '',
  `dimensionid` bigint(10) unsigned NOT NULL,
  `grade` decimal(10,5) unsigned NOT NULL,
  `peercomment` longtext,
  `peercommentformat` smallint(3) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mdl_workgrad_assstrdim_uix` (`assessmentid`,`strategy`,`dimensionid`),
  KEY `mdl_workgrad_ass_ix` (`assessmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='How the reviewers filled-up the grading forms, given grades ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_grades`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_grades_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_grades_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `assessmentid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` bigint(10) unsigned NOT NULL DEFAULT '0',
  `feedback` text NOT NULL,
  `grade` smallint(3) NOT NULL DEFAULT '0',
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workgradold_wor_ix` (`workshopid`),
  KEY `mdl_workgradold_ass_ix` (`assessmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_grades table to be dropped later in Moodle 2' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_grades_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_old` (
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
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workold_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop table to be dropped later in Moodle 2.x' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_rubrics_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_rubrics_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` bigint(10) unsigned NOT NULL DEFAULT '0',
  `rubricno` smallint(3) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workrubrold_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_rubrics table to be dropped later in Moodle ' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_rubrics_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_stockcomments_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_stockcomments_old` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL DEFAULT '0',
  `elementno` bigint(10) unsigned NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_workstocold_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_stockcomments table to be dropped later in M' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_stockcomments_old`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_submissions`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_submissions` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `workshopid` bigint(10) unsigned NOT NULL,
  `example` tinyint(2) unsigned DEFAULT '0',
  `authorid` bigint(10) unsigned NOT NULL,
  `timecreated` bigint(10) unsigned NOT NULL,
  `timemodified` bigint(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` longtext,
  `contentformat` smallint(3) unsigned NOT NULL DEFAULT '0',
  `contenttrust` smallint(3) unsigned NOT NULL DEFAULT '0',
  `attachment` tinyint(2) unsigned DEFAULT '0',
  `grade` decimal(10,5) unsigned DEFAULT NULL,
  `gradeover` decimal(10,5) unsigned DEFAULT NULL,
  `gradeoverby` bigint(10) unsigned DEFAULT NULL,
  `feedbackauthor` longtext,
  `feedbackauthorformat` smallint(3) unsigned DEFAULT '0',
  `timegraded` bigint(10) unsigned DEFAULT NULL,
  `published` tinyint(2) unsigned DEFAULT '0',
  `late` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mdl_worksubm_wor_ix` (`workshopid`),
  KEY `mdl_worksubm_gra_ix` (`gradeoverby`),
  KEY `mdl_worksubm_aut_ix` (`authorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about the submission and the aggregation of the grade f' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_submissions`
--


-- --------------------------------------------------------

--
-- Table structure for table `mdl_workshop_submissions_old`
--

CREATE TABLE IF NOT EXISTS `mdl_workshop_submissions_old` (
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
  `newplugin` varchar(28) DEFAULT NULL,
  `newid` bigint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_worksubmold_use_ix` (`userid`),
  KEY `mdl_worksubmold_mai_ix` (`mailed`),
  KEY `mdl_worksubmold_wor_ix` (`workshopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Legacy workshop_submissions table to be dropped later in Moo' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `mdl_workshop_submissions_old`
--

