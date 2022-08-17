CREATE SCHEMA IF NOT EXISTS `cautela` DEFAULT CHARACTER SET utf8;
USE `cautela`;

CREATE TABLE IF NOT EXISTS `cautela`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `cautela`.`itens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


INSERT INTO `itens` (title, is_active) VALUES ('Notebook', 1);