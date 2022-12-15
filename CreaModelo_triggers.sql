-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cablenor
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cablenor
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cablenor` DEFAULT CHARACTER SET utf8 ;
USE `cablenor` ;

-- -----------------------------------------------------
-- Table `cablenor`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `dni` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `fraude` TINYINT NOT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_modificacion` DATETIME NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `dni_UNIQUE` ON `cablenor`.`cliente` (`dni` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`contrato` (
  `id_contrato` INT NOT NULL AUTO_INCREMENT,
  `fecha_alta` DATETIME NULL,
  `fecha_baja` DATETIME NULL DEFAULT '2222-01-01 00:00:00',
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_contrato`),
  CONSTRAINT `fk_contrato_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cablenor`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_contrato_cliente1_idx` ON `cablenor`.`contrato` (`cliente_id_cliente` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(100) NOT NULL,
  `numero_calle` INT NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `piso` INT NULL,
  `departamento` VARCHAR(1) NULL,
  `codigo_postal` INT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_modificacion` DATETIME NULL,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cablenor`.`tipo_servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`tipo_servicio` (
  `id_tipo_servicio` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo_servicio` VARCHAR(100) NOT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_modificacion` DATETIME NULL,
  PRIMARY KEY (`id_tipo_servicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cablenor`.`precio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`precio` (
  `id_precio` INT NOT NULL AUTO_INCREMENT,
  `monto` FLOAT NULL,
  `fecha_vigencia_desde` DATETIME NULL,
  `fecha_vigencia_hasta` DATETIME NULL,
  `moneda` VARCHAR(2) NULL,
  `id_tipo_servicio` INT NOT NULL,
  PRIMARY KEY (`id_precio`),
  CONSTRAINT `fk_precio_tipo_servicio1`
    FOREIGN KEY (`id_tipo_servicio`)
    REFERENCES `cablenor`.`tipo_servicio` (`id_tipo_servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_precio_tipo_servicio1_idx` ON `cablenor`.`precio` (`id_tipo_servicio` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`servicio` (
  `id_servicio` INT NOT NULL AUTO_INCREMENT,
  `fecha_alta` DATETIME NULL,
  `fecha_baja` DATETIME NULL,
  `id_tipo_servicio` INT NOT NULL,
  `id_contrato` INT NOT NULL,
  PRIMARY KEY (`id_servicio`),
  CONSTRAINT `fk_servicio_tipo_servicio1`
    FOREIGN KEY (`id_tipo_servicio`)
    REFERENCES `cablenor`.`tipo_servicio` (`id_tipo_servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicio_contrato1`
    FOREIGN KEY (`id_contrato`)
    REFERENCES `cablenor`.`contrato` (`id_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_servicio_tipo_servicio1_idx` ON `cablenor`.`servicio` (`id_tipo_servicio` ASC) ;

CREATE INDEX `fk_servicio_contrato1_idx` ON `cablenor`.`servicio` (`id_contrato` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`domicilio` (
  `id_contrato` INT NOT NULL,
  `id_direccion` INT NOT NULL,
  `fecha_alta_domicilio` DATETIME NULL,
  `fecha_baja_domicilio` DATETIME NULL,
  PRIMARY KEY (`id_direccion`, `id_contrato`),
  CONSTRAINT `fk_contrato`
    FOREIGN KEY (`id_contrato`)
    REFERENCES `cablenor`.`contrato` (`id_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `cablenor`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_direccion_idx` ON `cablenor`.`domicilio` (`id_direccion` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`llamado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`llamado` (
  `id_llamado` INT NOT NULL AUTO_INCREMENT,
  `fecha_llamado` DATE NULL,
  `hora_inicio_llamado` TIMESTAMP NULL,
  `hora_fin_llamado` TIMESTAMP NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_llamado`),
  CONSTRAINT `fk_llamado_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cablenor`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_llamado_cliente1_idx` ON `cablenor`.`llamado` (`cliente_id_cliente` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`tipo_reclamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`tipo_reclamo` (
  `id_tipo_reclamo` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo_reclamo` VARCHAR(100) NOT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_modificacion` DATETIME NULL,
  PRIMARY KEY (`id_tipo_reclamo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cablenor`.`tipo_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`tipo_estado` (
  `id_tipo_estado` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo_estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cablenor`.`reclamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`reclamo` (
  `id_reclamo` INT NOT NULL AUTO_INCREMENT,
  `motivo_llamado` VARCHAR(45) NULL,
  `id_llamado` INT NOT NULL,
  `id_tipo_reclamo` INT NOT NULL,
  `id_tipo_estado` INT NOT NULL,
  PRIMARY KEY (`id_reclamo`),
  CONSTRAINT `fk_ticket_llamado1`
    FOREIGN KEY (`id_llamado`)
    REFERENCES `cablenor`.`llamado` (`id_llamado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reclamo_tipo_reclamo1`
    FOREIGN KEY (`id_tipo_reclamo`)
    REFERENCES `cablenor`.`tipo_reclamo` (`id_tipo_reclamo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reclamo_tipo_estado1`
    FOREIGN KEY (`id_tipo_estado`)
    REFERENCES `cablenor`.`tipo_estado` (`id_tipo_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_reclamo_tipo_reclamo1_idx` ON `cablenor`.`reclamo` (`id_tipo_reclamo` ASC) ;

CREATE INDEX `fk_ticket_llamado1_idx` ON `cablenor`.`reclamo` (`id_llamado` ASC) ;

CREATE INDEX `fk_reclamo_tipo_estado1_idx` ON `cablenor`.`reclamo` (`id_tipo_estado` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`email` (
  `id_email` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_modificacion` DATETIME NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_email`),
  CONSTRAINT `fk_email_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cablenor`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_email_cliente1_idx` ON `cablenor`.`email` (`cliente_id_cliente` ASC) ;


-- -----------------------------------------------------
-- Table `cablenor`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cablenor`.`telefono` (
  `id_telefono` INT NOT NULL AUTO_INCREMENT,
  `telefono` VARCHAR(100) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `fecha_modificacion` DATETIME NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_telefono`),
  CONSTRAINT `fk_cliente`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cablenor`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_email_cliente1_idx` ON `cablenor`.`telefono` (`cliente_id_cliente` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




/*cliente valida upper nombre y apellidos*/

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_upper_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_upper_update
BEFORE UPDATE on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.nombre=upper(NEW.nombre), NEW.apellidos=upper(NEW.apellidos);
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_upper_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_upper_insert
BEFORE INSERT  on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.nombre=upper(NEW.nombre), NEW.apellidos=upper(NEW.apellidos);
END$$
DELIMITER ;

/*cliente audit*/

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_update
BEFORE UPDATE on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_insert
BEFORE INSERT  on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

/*tipo_reclamo*/

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_reclamo_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_reclamo_update
BEFORE UPDATE on cablenor.tipo_reclamo
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_reclamo_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_reclamo_insert
BEFORE INSERT  on cablenor.tipo_reclamo
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;


/*tipo_servicio*/

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_servicio_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_servicio_update
BEFORE UPDATE on cablenor.tipo_servicio
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_servicio_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_servicio_insert
BEFORE INSERT  on cablenor.tipo_servicio
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;



/*telefono*/

 DROP TRIGGER IF EXISTS cablenor.tgg_telefono_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_telefono_update
BEFORE UPDATE on cablenor.telefono
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_telefono_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_telefono_insert
BEFORE INSERT  on cablenor.telefono
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;


/*email*/

 DROP TRIGGER IF EXISTS cablenor.tgg_email_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_email_update
BEFORE UPDATE on cablenor.email
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_email_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_email_insert
BEFORE INSERT  on cablenor.email
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;



/*direccion*/

 DROP TRIGGER IF EXISTS cablenor.tgg_direccion_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_direccion_update
BEFORE UPDATE on cablenor.direccion
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_direccion_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_direccion_insert
BEFORE INSERT  on cablenor.direccion
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

