SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `sirac` ;
CREATE SCHEMA IF NOT EXISTS `sirac` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `sirac` ;

-- -----------------------------------------------------
-- Table `sirac`.`ct_tipo_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_tipo_usuario` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_tipo_usuario` (
  `id_tipo_usuario` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `tipo_usuario` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id_tipo_usuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_usuario` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_usuario` (
  `usuario` VARCHAR(30) NOT NULL ,
  `clave` VARCHAR(10) NULL COMMENT 'Este campo sólo aplica para el asesor científico (Gerente)' ,
  `email` VARCHAR(100) NOT NULL ,
  `passwd` VARCHAR(60) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `apaterno` VARCHAR(45) NULL ,
  `amaterno` VARCHAR(45) NULL ,
  `id_tipo_usuario` INT UNSIGNED NOT NULL ,
  `gerente` VARCHAR(30) NULL ,
  `token` VARCHAR(100) NULL ,
  `ultimo_acceso` DATETIME NULL ,
  PRIMARY KEY (`usuario`) ,
  INDEX `rl_tipo_usuario_idx` (`id_tipo_usuario` ASC) ,
  CONSTRAINT `rl_tipo_usuario`
    FOREIGN KEY (`id_tipo_usuario` )
    REFERENCES `sirac`.`ct_tipo_usuario` (`id_tipo_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_medico` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_medico` (
  `id_medico` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apaterno` VARCHAR(45) NOT NULL ,
  `amaterno` VARCHAR(45) NOT NULL ,
  `fecha_nac` DATE NULL ,
  `cedula` VARCHAR(45) NULL ,
  `universidad` VARCHAR(100) NULL ,
  `celular` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_medico`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_especialidad` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_especialidad` (
  `id_especialidad` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `especialidad` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`id_especialidad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`rl_medico_especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`rl_medico_especialidad` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`rl_medico_especialidad` (
  `id_medico` INT UNSIGNED NOT NULL ,
  `id_especialidad` INT UNSIGNED NOT NULL ,
  `cedula_especialidad` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_medico`, `id_especialidad`) ,
  INDEX `rl_especialidad_idx` (`id_especialidad` ASC) ,
  CONSTRAINT `rl_medico`
    FOREIGN KEY (`id_medico` )
    REFERENCES `sirac`.`ct_medico` (`id_medico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_especialidad`
    FOREIGN KEY (`id_especialidad` )
    REFERENCES `sirac`.`ct_especialidad` (`id_especialidad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_correo_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_correo_usuario` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_correo_usuario` (
  `id_correo_usuario` INT UNSIGNED NOT NULL ,
  `id_usuario` VARCHAR(30) NOT NULL ,
  `correo` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id_correo_usuario`, `id_usuario`) ,
  INDEX `rl_correo_usuario_idx` (`id_usuario` ASC) ,
  CONSTRAINT `rl_correo_usuario`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_sitio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_sitio` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_sitio` (
  `id_sitio` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(200) NULL ,
  `calle` VARCHAR(45) NOT NULL ,
  `num_exterior` VARCHAR(5) NOT NULL ,
  `num_interior` VARCHAR(5) NULL ,
  `colonia` VARCHAR(70) NULL ,
  `cp` VARCHAR(6) NOT NULL ,
  `delegacion` VARCHAR(60) NOT NULL ,
  `estado` VARCHAR(100) NULL COMMENT 'De esta tabla es posible separar la delegacion y estado en otras dos tablas.' ,
  `telefono` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_sitio`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`rl_medico_sitio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`rl_medico_sitio` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`rl_medico_sitio` (
  `id_medico` INT UNSIGNED NOT NULL ,
  `id_sitio` INT UNSIGNED NOT NULL ,
  `telefono_consultorio` VARCHAR(20) NULL ,
  `farmacia` TINYINT NOT NULL DEFAULT 0 COMMENT '0 Para No\n1 Para Si' ,
  PRIMARY KEY (`id_medico`, `id_sitio`) ,
  INDEX `rl_sitio_medico_idx` (`id_sitio` ASC) ,
  CONSTRAINT `rl_medico_sitio`
    FOREIGN KEY (`id_medico` )
    REFERENCES `sirac`.`ct_medico` (`id_medico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_sitio_medico`
    FOREIGN KEY (`id_sitio` )
    REFERENCES `sirac`.`ct_sitio` (`id_sitio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_potencial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_potencial` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_potencial` (
  `id_potencial` VARCHAR(5) NOT NULL ,
  `descripcion` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`id_potencial`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_dia_semana`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_dia_semana` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_dia_semana` (
  `id_semana` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `abreviatura` VARCHAR(2) NOT NULL ,
  `dia` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`id_semana`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_plan_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_plan_trabajo` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_plan_trabajo` (
  `id_plan_trabajo` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_usuario` VARCHAR(30) NOT NULL ,
  `id_medico` INT UNSIGNED NOT NULL ,
  `id_sitio` INT UNSIGNED NOT NULL ,
  `semana` INT UNSIGNED NOT NULL ,
  `id_dia` INT UNSIGNED NOT NULL ,
  `territorio` INT NULL ,
  PRIMARY KEY (`id_plan_trabajo`) ,
  INDEX `fk_id_usuario_plan_idx` (`id_usuario` ASC) ,
  INDEX `fk_id_medico_plan_idx` (`id_medico` ASC) ,
  INDEX `fk_id_sitio_plan_idx` (`id_sitio` ASC) ,
  INDEX `fk_id_dia_plan_idx` (`id_dia` ASC) ,
  CONSTRAINT `fk_id_usuario_plan`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_medico_plan`
    FOREIGN KEY (`id_medico` )
    REFERENCES `sirac`.`ct_medico` (`id_medico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_sitio_plan`
    FOREIGN KEY (`id_sitio` )
    REFERENCES `sirac`.`ct_sitio` (`id_sitio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_dia_plan`
    FOREIGN KEY (`id_dia` )
    REFERENCES `sirac`.`ct_dia_semana` (`id_semana` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_prescriptor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_prescriptor` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_prescriptor` (
  `id_prescritor` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `tipo_prescriptor` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id_prescritor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_ciclo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_ciclo` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_ciclo` (
  `id_ciclo` VARCHAR(10) NOT NULL ,
  `fecha_inicio` DATE NOT NULL ,
  `fecha_termino` DATE NOT NULL ,
  PRIMARY KEY (`id_ciclo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ht_plan_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ht_plan_trabajo` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ht_plan_trabajo` (
  `id_ht_plan_trabajo` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_usuario` VARCHAR(30) NOT NULL ,
  `id_medico` INT UNSIGNED NOT NULL ,
  `id_sitio` INT UNSIGNED NOT NULL ,
  `id_ciclo` VARCHAR(10) NOT NULL ,
  `fecha_visita` DATE NOT NULL ,
  `hora_visita` TIME NOT NULL ,
  `activo` TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id_ht_plan_trabajo`) ,
  INDEX `rl_ht_plan_usuario_idx` (`id_usuario` ASC) ,
  INDEX `rl_ht_plan_medico_idx` (`id_medico` ASC) ,
  INDEX `rl_ht_plan_sitio_idx` (`id_sitio` ASC) ,
  INDEX `rl_ht_plan_ciclo_idx` (`id_ciclo` ASC) ,
  CONSTRAINT `rl_ht_plan_usuario`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_ht_plan_medico`
    FOREIGN KEY (`id_medico` )
    REFERENCES `sirac`.`ct_medico` (`id_medico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_ht_plan_sitio`
    FOREIGN KEY (`id_sitio` )
    REFERENCES `sirac`.`ct_sitio` (`id_sitio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_ht_plan_ciclo`
    FOREIGN KEY (`id_ciclo` )
    REFERENCES `sirac`.`ct_ciclo` (`id_ciclo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ht_reporte_plan_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ht_reporte_plan_trabajo` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ht_reporte_plan_trabajo` (
  `id_ht_plan_trabajo` INT UNSIGNED NOT NULL ,
  `id_potencial` VARCHAR(5) NOT NULL ,
  `farmacia` TINYINT NOT NULL ,
  `prescriptor` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id_ht_plan_trabajo`) ,
  INDEX `rl_reporte_prescriptor_idx` (`prescriptor` ASC) ,
  INDEX `rl_reporte_potencial_idx` (`id_potencial` ASC) ,
  CONSTRAINT `rl_reporte_prescriptor`
    FOREIGN KEY (`prescriptor` )
    REFERENCES `sirac`.`ct_prescriptor` (`id_prescritor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_reporte_potencial`
    FOREIGN KEY (`id_potencial` )
    REFERENCES `sirac`.`ct_potencial` (`id_potencial` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rl_reporte_plan_trabajo`
    FOREIGN KEY (`id_ht_plan_trabajo` )
    REFERENCES `sirac`.`ht_plan_trabajo` (`id_ht_plan_trabajo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`rl_medico_representante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`rl_medico_representante` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`rl_medico_representante` (
  `id_medico` INT UNSIGNED NOT NULL ,
  `usuario` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id_medico`, `usuario`) ,
  INDEX `fk_ct_medico_has_ct_usuario_ct_usuario1_idx` (`usuario` ASC) ,
  INDEX `fk_ct_medico_has_ct_usuario_ct_medico1_idx` (`id_medico` ASC) ,
  CONSTRAINT `fk_ct_medico_has_ct_usuario_ct_medico1`
    FOREIGN KEY (`id_medico` )
    REFERENCES `sirac`.`ct_medico` (`id_medico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ct_medico_has_ct_usuario_ct_usuario1`
    FOREIGN KEY (`usuario` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_medicina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_medicina` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_medicina` (
  `id_medicina` INT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `descripcion` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_medicina`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_presentacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_presentacion` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_presentacion` (
  `id_presentacion` INT NOT NULL ,
  `id_medicina` INT NOT NULL ,
  `tipo_presentacion` VARCHAR(45) NULL ,
  `dosis` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_presentacion`) ,
  INDEX `fk_ct_presentacion_ct_medicina1_idx` (`id_medicina` ASC) ,
  CONSTRAINT `fk_ct_presentacion_ct_medicina1`
    FOREIGN KEY (`id_medicina` )
    REFERENCES `sirac`.`ct_medicina` (`id_medicina` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ct_presentacion_has_ct_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ct_presentacion_has_ct_usuario` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ct_presentacion_has_ct_usuario` (
  `id_presentacion` INT NOT NULL ,
  `representante` VARCHAR(30) NOT NULL ,
  `fecha` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`id_presentacion`, `representante`, `fecha`) ,
  INDEX `fk_ct_presentacion_has_ct_usuario_ct_usuario1_idx` (`representante` ASC) ,
  INDEX `fk_ct_presentacion_has_ct_usuario_ct_presentacion1_idx` (`id_presentacion` ASC) ,
  CONSTRAINT `fk_ct_presentacion_has_ct_usuario_ct_presentacion1`
    FOREIGN KEY (`id_presentacion` )
    REFERENCES `sirac`.`ct_presentacion` (`id_presentacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ct_presentacion_has_ct_usuario_ct_usuario1`
    FOREIGN KEY (`representante` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `sirac` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
