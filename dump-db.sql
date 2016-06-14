-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 14, 2016 at 04:16 PM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `catstagram`
--

-- --------------------------------------------------------

--
-- Table structure for table `cats`
--

CREATE TABLE `cats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catname` varchar(255) NOT NULL,
  `description` text,
  `city` varchar(255) DEFAULT NULL,
  `birth_time` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cats_on_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=893516549 ;

--
-- Dumping data for table `cats`
--

INSERT INTO `cats` (`id`, `catname`, `description`, `city`, `birth_time`, `created_at`, `updated_at`, `user_id`) VALUES
(36826545, 'Catnonymous', 'A generic anonymous cat', NULL, NULL, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 1),
(38194071, '??', 'A cat I''ve seen once', 'Switzerland', NULL, '2016-06-14 14:15:30', '2016-06-14 14:15:30', NULL),
(458201647, 'Mickey', NULL, 'Lausanne, VD, CH', '2016-05-19', '2016-06-14 14:15:30', '2016-06-14 14:15:30', 3),
(893516548, 'Houille', 'A nice black cat living in the countryside of Switzerland.', 'Attalens VD', '2016-06-10', '2016-06-14 14:15:30', '2016-06-14 14:15:30', 2);

-- --------------------------------------------------------

--
-- Table structure for table `cats_photos`
--

CREATE TABLE `cats_photos` (
  `photo_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  KEY `index_cats_photos_on_photo_id_and_cat_id` (`photo_id`,`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cats_photos`
--

INSERT INTO `cats_photos` (`photo_id`, `cat_id`) VALUES
(1, 36826545),
(2, 458201647),
(3, 38194071),
(4, 893516548),
(5, 38194071),
(5, 458201647),
(5, 893516548),
(6, 36826545);

-- --------------------------------------------------------

--
-- Table structure for table `hashtags`
--

CREATE TABLE `hashtags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1018350796 ;

--
-- Dumping data for table `hashtags`
--

INSERT INTO `hashtags` (`id`, `tag`, `created_at`, `updated_at`) VALUES
(51848956, 'cute', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(113629430, 'switzerland', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(281110143, 'sunny', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(298486374, 'summer', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(374648174, 'Catstagram', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(638205575, 'love', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(980190962, 'cat', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(1018350795, 'nice', '2016-06-14 14:15:30', '2016-06-14 14:15:30');

-- --------------------------------------------------------

--
-- Table structure for table `hashtags_photos`
--

CREATE TABLE `hashtags_photos` (
  `photo_id` int(11) NOT NULL,
  `hashtag_id` int(11) NOT NULL,
  KEY `index_hashtags_photos_on_photo_id_and_hashtag_id` (`photo_id`,`hashtag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hashtags_photos`
--

INSERT INTO `hashtags_photos` (`photo_id`, `hashtag_id`) VALUES
(1, 113629430),
(1, 980190962),
(2, 281110143),
(2, 298486374),
(2, 638205575),
(3, 51848956),
(3, 980190962),
(4, 51848956),
(4, 281110143),
(4, 298486374),
(4, 638205575),
(5, 51848956),
(5, 281110143),
(5, 1018350795);

-- --------------------------------------------------------

--
-- Table structure for table `photos`
--

CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) NOT NULL,
  `caption` text,
  `view_count` int(11) NOT NULL DEFAULT '0',
  `like_count` int(11) NOT NULL DEFAULT '0',
  `report_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_photos_on_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `photos`
--

INSERT INTO `photos` (`id`, `image_url`, `caption`, `view_count`, `like_count`, `report_count`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'cat1.jpeg', 'A nice cat', 13, 2, 0, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 1),
(2, 'cat2.jpg', 'a nicer cat taken in switzerland', 12, 5, 0, '2016-05-14 00:00:00', '2016-06-14 14:15:30', 3),
(3, 'cat3.jpg', 'a very very nice cat', 12, 3, 0, '2016-05-19 00:00:00', '2016-06-14 14:15:30', 2),
(4, 'cat4.jpg', 'even nicer.... miaou', 12, 7, 0, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 1),
(5, 'cat5.jpg', 'A bunch of nice cats for Catstagram!', 134, 45, 1, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 2),
(6, 'dog.jpg', 'a bad reported photo, it''s not a cat, it''s a dog!', 13, 0, 5, '2015-06-13 00:00:00', '2016-06-14 14:15:30', 4);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1011897929 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(135138680, 'admin', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(227792459, 'user', '2016-06-14 14:15:30', '2016-06-14 14:15:30'),
(1011897928, 'tester', '2016-06-14 14:15:30', '2016-06-14 14:15:30');

-- --------------------------------------------------------

--
-- Table structure for table `roles_users`
--

CREATE TABLE `roles_users` (
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles_users`
--

INSERT INTO `roles_users` (`role_id`, `user_id`) VALUES
(227792459, 1),
(135138680, 1),
(227792459, 2),
(227792459, 3),
(227792459, 4),
(227792459, 5),
(1011897928, 5);

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20160419114104'),
('20160419114226'),
('20160419114306'),
('20160419114320'),
('20160419120345'),
('20160419120402'),
('20160419121437'),
('20160419121452'),
('20160606173242'),
('20160606184919'),
('20160606185145');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `biography` text,
  `banned_until` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `avatar_url`, `biography`, `banned_until`, `created_at`, `updated_at`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`) VALUES
(1, 'admin', 'user1.png', 'I am THE admin of Catstagram, I''m a cat lover.', NULL, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 'admin@cat.com', '$2a$11$qTLoPw0yaDK.urLEGUDEDew3xrwtsH2GTWLx/FUhQNXg6d7Dx2X/6', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(2, 'paranoodle', 'user2.png', 'I am the main user of Catstagram, I love nice cats.', NULL, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 'paranoodle@cat.com', '$2a$11$WqwUwcwQPOB.JPtyp31r6e9r1Hj7ZhxLoZ.3gzMfOTtQdZzKqwdpy', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(3, 'val', 'user3.png', 'I like cats but I prefer dogs (don''t tell paranoodle!)', NULL, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 'val@cat.com', '$2a$11$nAV1/tDeA95pkb70udN8u.7wqzgUxPfOXFGUyBjGVqvaZ/HfjrDKO', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(4, 'bad', 'user4.png', 'I am a bad guy and I''m banned...', '2016-07-11 00:00:00', '2016-06-14 14:15:30', '2016-06-14 14:15:30', 'bad@cat.com', '$2a$11$AA.GvO2ZOREJPllD.N2MiO0zs4aaza7vRf4/8vhH7os/wZBhFi5PS', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(5, 'dev', 'user5.png', 'I test the website', NULL, '2016-06-14 14:15:30', '2016-06-14 14:15:30', 'dev@cat.com', '$2a$11$y2URbsMbV0ZqBvQSYgOZged9Efv3yjzsmzPuGFueVNaNEYVThwnyy', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cats`
--
ALTER TABLE `cats`
  ADD CONSTRAINT `fk_rails_1b8c4f14b9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `photos`
--
ALTER TABLE `photos`
  ADD CONSTRAINT `fk_rails_c79d76afc0` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
