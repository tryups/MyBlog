-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 19/12/2020 às 18:39
-- Versão do servidor: 5.7.26
-- Versão do PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Banco de dados: `MyBlog`
--
CREATE DATABASE IF NOT EXISTS `MyBlog` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE `MyBlog`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci,
  `term` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `term` (`term`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Despejando dados para a tabela `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `term`, `group`) VALUES
(1, 'Sem Categoria', NULL, 'sem-categoria', 1),
(2, 'Filmes', NULL, 'filmes', 0),
(3, 'Comedia', NULL, 'comedia', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `author_ip` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_status` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  `comment_group` bigint(20) NOT NULL DEFAULT '0',
  `comment_type` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `comment_post` (`post_id`),
  KEY `comment_author` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `author` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `summary` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  `views` decimal(10,0) NOT NULL DEFAULT '0',
  `post_security` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  `comment_security` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  `term` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  `post_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `term` (`term`),
  KEY `post_author` (`author`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `post_cats`
--

DROP TABLE IF EXISTS `post_cats`;
CREATE TABLE IF NOT EXISTS `post_cats` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_category` (`cat_id`),
  KEY `cat_post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
CREATE TABLE IF NOT EXISTS `post_tags` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `term` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tag_post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `preferences`
--

DROP TABLE IF EXISTS `preferences`;
CREATE TABLE IF NOT EXISTS `preferences` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Despejando dados para a tabela `preferences`
--

INSERT INTO `preferences` (`id`, `name`, `value`) VALUES
(1, 'blog_name', 'MyBlog'),
(2, 'blog_desc', 'Best blog service'),
(3, 'blog_url', 'http://localhost/myblog'),
(4, 'blog_template', 'downsbr'),
(5, 'blog_public', '1'),
(6, 'admin_email', 'webmaster@localhost'),
(7, 'maintenance', '0'),
(8, 'maintenace_enddate', '00/00/0000 00:00:00'),
(9, 'language', 'en-US'),
(10, 'MYB_SECRET_KEY', 'MYBLOG'),
(11, 'JWT_KEY', 'MYBLOG');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `fullname` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `about` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `birthdate` datetime NOT NULL,
  `registered` datetime NOT NULL,
  `status` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0',
  `rank` enum('0','1','2','3','4','5') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '0' COMMENT '0 - Assinante, 1 - Assinante Notificado,  2 - Assinante Premium, 3 - Moderador, 4 - Administrador, 5 - Proprietario',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_keys` (`user`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `user`, `email`, `pass`, `fullname`, `about`, `birthdate`, `registered`, `status`, `rank`) VALUES
(1, 'Bloguinho', 'bloguinho@tryups.ml', 'MYB_DEFAULT_PASSWORD', 'MyBlog Team', '', '2020-12-08 15:25:44', '2020-12-08 15:25:44', '0', '0'),
(2, 'admin', 'admin@gmail.com', '$argon2i$v=19$m=65536,t=4,p=1$ZkQuM1NCNWQ4QVRDYUtlRw$Yu/3t1ae3+LL7HhmyJmJUKjMsui4FHZ6FEbZvXJBAO4', 'Admin The Legend', '', '2000-02-22 00:00:00', '2020-12-10 16:46:15', '0', '0');

--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comment_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `comment_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `post_author` FOREIGN KEY (`author`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `post_cats`
--
ALTER TABLE `post_cats`
  ADD CONSTRAINT `cat_category` FOREIGN KEY (`cat_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `cat_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `tag_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;