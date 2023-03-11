-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`station_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`station_data` ;

CREATE TABLE IF NOT EXISTS `mydb`.`station_data` (
  `highway_name` VARCHAR(100) NOT NULL,
  `station_distance` INT NOT NULL,
  `some_int` INT NULL,
  `station_name` VARCHAR(45) NULL,
  `station_relative_position` VARCHAR(10) NULL,
  `is_pavillon` VARCHAR(10) NULL,
  `latitude` VARCHAR(11) NULL,
  `latitude_seconds` VARCHAR(11) NULL,
  `longitutde` VARCHAR(11) NULL,
  `longitude_seconds` VARCHAR(11) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`highway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`highway` ;

CREATE TABLE IF NOT EXISTS `mydb`.`highway` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`position` ;

CREATE TABLE IF NOT EXISTS `mydb`.`position` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `position_UNIQUE` (`position` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`station`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`station` ;

CREATE TABLE IF NOT EXISTS `mydb`.`station` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `is_pavilion` TINYINT(1) NULL,
  `distance` FLOAT NULL,
  `highway_name` VARCHAR(45) NULL,
  `position_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `highway_idx` (`highway_name` ASC) VISIBLE,
  INDEX `fk_station_position1_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `highway`
    FOREIGN KEY (`highway_name`)
    REFERENCES `mydb`.`highway` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_station_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `mydb`.`position` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`end_point`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`end_point` ;

CREATE TABLE IF NOT EXISTS `mydb`.`end_point` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`point_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`point_type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`point_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`highway_end_point`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`highway_end_point` ;

CREATE TABLE IF NOT EXISTS `mydb`.`highway_end_point` (
  `highway_name` VARCHAR(45) NOT NULL,
  `end_point_id` INT NOT NULL,
  `point_type` INT NULL,
  PRIMARY KEY (`highway_name`, `end_point_id`),
  INDEX `ep_hw_fk_idx` (`end_point_id` ASC) VISIBLE,
  INDEX `point_type_idx` (`point_type` ASC) VISIBLE,
  CONSTRAINT `ep_hw_fk`
    FOREIGN KEY (`end_point_id`)
    REFERENCES `mydb`.`end_point` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hw_hw_ep_fk`
    FOREIGN KEY (`highway_name`)
    REFERENCES `mydb`.`highway` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `point_type`
    FOREIGN KEY (`point_type`)
    REFERENCES `mydb`.`point_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
