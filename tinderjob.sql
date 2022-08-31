SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `tinderjob` DEFAULT CHARACTER SET utf8mb3 ;
USE `tinderjob` ;

CREATE TABLE IF NOT EXISTS `tinderjob`.`country` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`state` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `code` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` VARCHAR(50) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `state_ibfk_1_idx` (`country_id` ASC) VISIBLE,
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`country` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`city` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `code` VARCHAR(45) NULL DEFAULT NULL,
  `state_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `state_idx` (`state_id` ASC) VISIBLE,
    FOREIGN KEY (`state_id`)
    REFERENCES `mydb`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `level` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`field` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `website` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `dateOfFounding` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` VARCHAR(45) NULL DEFAULT NULL,
  `field_id` INT NOT NULL,
  `founder_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_organization_field1_idx` (`field_id` ASC) VISIBLE,
  INDEX `founder_idx` (`founder_id` ASC) VISIBLE,
    FOREIGN KEY (`field_id`)
    REFERENCES `mydb`.`field` (`id`),
    FOREIGN KEY (`founder_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`user` (
  `id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(32) NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `avatar` VARCHAR(1024) NULL DEFAULT NULL,
  `birthdate` VARCHAR(45) NULL DEFAULT NULL,
  `pronouns` VARCHAR(10) NULL DEFAULT NULL,
  `nationality` VARCHAR(45) NULL DEFAULT NULL,
  `residence` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(1024) NULL DEFAULT NULL,
  `actualJob` VARCHAR(45) NULL DEFAULT NULL,
  `active` TINYINT NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `language_id` INT NOT NULL,
  `organization_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_language1_idx` (`language_id` ASC) VISIBLE,
  INDEX `fk_user_organization1_idx` (`organization_id` ASC) VISIBLE,
  INDEX `fk_user_country1_idx` (`country_id` ASC) VISIBLE,
  INDEX `state_id_idx` (`state_id` ASC) VISIBLE,
  INDEX `cty_id_idx` (`city_id` ASC) VISIBLE,
    FOREIGN KEY (`language_id`)
    REFERENCES `mydb`.`language` (`id`),
    FOREIGN KEY (`organization_id`)
    REFERENCES `mydb`.`organization` (`id`),
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`country` (`id`),
    FOREIGN KEY (`state_id`)
    REFERENCES `mydb`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` VARCHAR(1024) NULL DEFAULT NULL,
  `multimedia` VARCHAR(500) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `updatedAt` VARCHAR(45) NULL DEFAULT NULL,
  `author_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_idx` (`author_id` ASC) VISIBLE,
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS `tinderjob`.`comment` (
  `id` INT NOT NULL,
  `body` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` VARCHAR(45) NULL DEFAULT NULL,
  `post_id` INT NOT NULL,
  `written_by` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `written_by_idx` (`written_by` ASC) VISIBLE,
  INDEX `post_id_idx` (`post_id` ASC) VISIBLE,
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`written_by`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`hobby` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tinderjob`.`skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `level` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `field_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_skill_field1_idx` (`field_id` ASC) VISIBLE,
    FOREIGN KEY (`field_id`)
    REFERENCES `mydb`.`field` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;