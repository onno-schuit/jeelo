-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 07, 2012 at 10:55 AM
-- Server version: 5.1.62
-- PHP Version: 5.3.2-1ubuntu4.15

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Course categories' AUTO_INCREMENT=3 ;

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
  `backup_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

