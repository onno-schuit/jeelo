-- phpMyAdmin SQL Dump
-- version 3.3.7deb5build0.10.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 01, 2012 at 12:32 PM
-- Server version: 5.1.61
-- PHP Version: 5.3.3-1ubuntu9.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jeelo_buffer`
--

-- --------------------------------------------------------

--
-- Table structure for table `client_categories`
--

CREATE TABLE IF NOT EXISTS `client_categories` (
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
  `client_moodle_id` bigint(10) NOT NULL,
  `original_id` bigint(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mdl_courcate_par_ix` (`parent`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Course categories' AUTO_INCREMENT=54 ;

--
-- Dumping data for table `client_categories`
--

INSERT INTO `client_categories` (`id`, `name`, `description`, `parent`, `sortorder`, `coursecount`, `visible`, `timemodified`, `depth`, `path`, `theme`, `client_moodle_id`, `original_id`) VALUES
(53, 'P01 - Leren niet te huilen in het vliegtuig', '', 0, 30000, 4, 1, 0, 1, '/2', NULL, 122, 2);

-- --------------------------------------------------------

--
-- Table structure for table `client_courses`
--

CREATE TABLE IF NOT EXISTS `client_courses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `shortname` varchar(255) NOT NULL,
  `groupyear` varchar(255) NOT NULL,
  `client_moodle_id` int(255) NOT NULL,
  `parent_category_id` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=211 ;

--
-- Dumping data for table `client_courses`
--

INSERT INTO `client_courses` (`id`, `fullname`, `shortname`, `groupyear`, `client_moodle_id`, `parent_category_id`) VALUES
(210, 'Gewoon je mond houden 4', 'mond_houden_4', '7/8', 122, 53),
(207, 'Gewoon je mond houden', 'mond houden', '1/2', 122, 53),
(208, 'Gewoon je mond houden 2', 'mond_houden_2', '3/4', 122, 53),
(209, 'Gewoon je mond houden 3', 'mond_houden_3', '5/6', 122, 53);

-- --------------------------------------------------------

--
-- Table structure for table `client_moodles`
--

CREATE TABLE IF NOT EXISTS `client_moodles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timecreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `domain` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fullname` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sql_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `codebase_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `csv_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `courses_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_for_client` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'client',
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `exit_code` int(11) NOT NULL DEFAULT '0',
  `timemodified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `is_for_client` (`is_for_client`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=123 ;

--
-- Dumping data for table `client_moodles`
--

INSERT INTO `client_moodles` (`id`, `timecreated`, `domain`, `shortname`, `fullname`, `email`, `sql_filename`, `codebase_filename`, `csv_filename`, `courses_filename`, `is_for_client`, `status`, `exit_code`, `timemodified`) VALUES
(122, '2012-05-29 12:27:04', 'target1.srv1a.jeelo.nl', 'target1', 'Target 1', 'm.deridder@solin.nl', '/etc/moodle_clients/db/target1.srv1a.jeelo.nl_db_20120523.gz', '/etc/moodle_clients/code/target1.srv1a.jeelo.nl_code_20120523.tgz', '/etc/moodle_clients/csv/target1.srv1a.jeelo.nl_csv_20120523.tgz', '/etc/moodle_clients/courses/target1.srv1a.jeelo.nl_courses_20120523.tgz', 'client', 'prepaired_school', 0, '0000-00-00 00:00:00');
