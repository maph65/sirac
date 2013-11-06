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
  CONSTRAINT `fk_ct_medico_has_ct_usuario`
    FOREIGN KEY (`id_medico` )
    REFERENCES `sirac`.`ct_medico` (`id_medico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ct_usuario_ct_medico`
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
  `id_presentacion` INT UNSIGNED NOT NULL ,
  `id_medicina` INT NOT NULL ,
  `tipo_presentacion` VARCHAR(45) NULL ,
  `dosis` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_presentacion`) ,
  INDEX `fk_ct_presentacion_ct_medicina1_idx` (`id_medicina` ASC) ,
  CONSTRAINT `fk_ct_pres_ct_medicina`
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
  `id_presentacion` INT UNSIGNED NOT NULL ,
  `representante` VARCHAR(30) NOT NULL ,
  `fecha` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`id_presentacion`, `representante`, `fecha`) ,
  INDEX `presentacion_has_ct_usuario_idx` (`representante` ASC) ,
  INDEX `fk_ct_usuario_ct_presentacion_idx` (`id_presentacion` ASC) ,
  CONSTRAINT `fk_ct_presentacion_ct_usr`
    FOREIGN KEY (`id_presentacion` )
    REFERENCES `sirac`.`ct_presentacion` (`id_presentacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ct_usuario_representante`
    FOREIGN KEY (`representante` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`ht_mensajes_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`ht_mensajes_usuario` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`ht_mensajes_usuario` (
  `id_mensaje` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `mensaje` LONGTEXT NOT NULL ,
  `emisor` VARCHAR(30) NOT NULL ,
  `receptor` VARCHAR(30) NOT NULL ,
  `leido` TINYINT NOT NULL DEFAULT 0 ,
  `fecha_envio` TIMESTAMP NOT NULL DEFAULT NOW() ,
  PRIMARY KEY (`id_mensaje`) ,
  INDEX `fk_msj_emisor_idx` (`emisor` ASC) ,
  INDEX `fk_msj_receptor_idx` (`receptor` ASC) ,
  CONSTRAINT `fk_msj_emisor`
    FOREIGN KEY (`emisor` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_msj_receptor`
    FOREIGN KEY (`receptor` )
    REFERENCES `sirac`.`ct_usuario` (`usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sirac`.`rl_reporte_medicamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sirac`.`rl_reporte_medicamento` ;

CREATE  TABLE IF NOT EXISTS `sirac`.`rl_reporte_medicamento` (
  `id_ht_plan_trabajo` INT UNSIGNED NOT NULL ,
  `id_presentacion` INT UNSIGNED NOT NULL ,
  `cantidad` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id_ht_plan_trabajo`, `id_presentacion`) ,
  INDEX `fk_medicamento_prese_idx` (`id_presentacion` ASC) ,
  INDEX `fk_plan_medicamento_idx` (`id_ht_plan_trabajo` ASC) ,
  CONSTRAINT `fk_plan_medicamento`
    FOREIGN KEY (`id_ht_plan_trabajo` )
    REFERENCES `sirac`.`ht_plan_trabajo` (`id_ht_plan_trabajo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicamento_prese`
    FOREIGN KEY (`id_presentacion` )
    REFERENCES `sirac`.`ct_presentacion` (`id_presentacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `sirac` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_tipo_usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_tipo_usuario` (`id_tipo_usuario`, `tipo_usuario`) VALUES (1, 'Representante');
INSERT INTO `sirac`.`ct_tipo_usuario` (`id_tipo_usuario`, `tipo_usuario`) VALUES (2, 'Gerente');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_usuario` (`usuario`, `clave`, `email`, `passwd`, `nombre`, `apaterno`, `amaterno`, `id_tipo_usuario`, `gerente`, `token`, `ultimo_acceso`) VALUES ('gerente', 'GRT', 'gerente@cellpharma.com', 'gerente', 'GERENTE', 'PATERNO', 'MATERNO', 2, '', '', '');
INSERT INTO `sirac`.`ct_usuario` (`usuario`, `clave`, `email`, `passwd`, `nombre`, `apaterno`, `amaterno`, `id_tipo_usuario`, `gerente`, `token`, `ultimo_acceso`) VALUES ('ivoyahir', 'ICG', 'ivoyahir@cellpharma.com', 'ivo', 'IVO YAHIR', 'CORTEZ', 'GONZÁLEZ', 1, 'gerente', '', '');
INSERT INTO `sirac`.`ct_usuario` (`usuario`, `clave`, `email`, `passwd`, `nombre`, `apaterno`, `amaterno`, `id_tipo_usuario`, `gerente`, `token`, `ultimo_acceso`) VALUES ('irvingl', 'IRLG', 'irvingl@cellpharma.com', 'irving', 'IRVING RICARDO', 'GOMEZ', 'LUNA', 1, 'gerente', '', '');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_medico`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (1, 'MALDONADO', 'BAUTISTA', 'ALFONSO', ' ', '1586247', ' ', ' ');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (2, 'RHAME', 'ELIAS', 'ANTAR', '', '258563', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (3, 'YAÑEZ', 'LOPEZ', 'ANTONIO', '', '489676', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (4, 'ARANDA', 'VALVERDE', 'JOSE LUIS', '', '1938130', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (5, 'VILLAREAL', 'RODRIGUEZ', 'ARTURO', '', '4681832', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (6, 'DOMÍNGUEZ', 'CAMACHO', 'MARÍA ANGÉLICA', '', '963485', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (7, 'JIMÉNEZ', 'CORDERO', 'FRANCISCO', '', '489676', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (8, 'LOPEZ', 'GARCIA', 'GUILLERMO', '', '1392107', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (9, 'LARRINUA', 'REGALADO', 'GERARDO', '', '1897454', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (10, 'GUERRA', 'RESENDIZ', 'BENJAMIN', '', '677230', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (11, 'MIRELES', 'MUÑOS', 'ANGEL', '', '1143455', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (12, 'MARTINEZ', 'ROJAS', 'CLARA ALEJANDRA', '', '1654902 Y 1964260', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (13, 'PADILLA ', 'RODAS', 'RAUL', '', '283746', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (14, 'TORRIJOS', 'PALLARES', 'JUAN', '', '508243', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (15, 'SOTO', 'MORALES', 'JORGE LUIS', '', '4370973', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (16, 'CASTILLO', 'LORENZO', 'MARIO EIGNAR', '', '6508611', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (17, 'ROSAS', 'CARREON', 'GEORGINA', '', '1199565', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (18, 'DOMINGUEZ', 'ROMERO', 'ALBERTO MANUEL', '', '265976', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (19, 'RAMON', 'MAGAÑA', 'ANTONIO', '', '119948', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (20, 'MONDRAGON', 'CARDENAS', 'BLANCA XOCHILT', '', '2199484', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (21, 'MIRANDA', 'FLORES', 'DAN', '', '197735', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (22, 'PEREZ', 'GARCIA', 'SERGIO', '', '3808232', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (23, 'PALLARES', 'SANCHEZ', 'GENARO', '', '2114674', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (24, 'BARRERA', 'AVENDAÑO', 'GUADALUPE', '', '687837', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (25, 'GONZALEZ', 'SANCHEZ', 'MARIA ROSALBA', '', '1693724', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (26, 'HERNANDEZ', 'ROSAS', 'CIPRIANO', '', '33271114', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (27, 'ROMO', 'MARTINEZ', 'SONIA LAURA', '', '1372256', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (28, 'PONCE ', 'CHAVEZ', 'CARLOS', '', '4558016', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (29, 'PAZARAN ', 'SAAVEDRA', 'RAUL', '', '748439', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (30, 'SANCHEZ', 'ORTIZ', 'OSWALDO', '', '844244', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (31, 'MACÍAS', 'SOLÍS', 'ADOLFO', '', '1755568', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (32, 'BOLAÑOS ', 'ALAVAREZ', 'ADRIANA', '', '3414391', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (33, 'RAMOS ', 'NAVARRETE', 'JOVITA', '', '63846663', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (34, 'RODRIGUEZ', 'DOMINGUEZ', 'PATRICIA', '', '228931', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (35, 'LANDAVERDE', 'MOLINA', 'MERCEDES', '', '4558007', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (36, 'RUBIO', 'SANCHEZ', 'CLEMENTE', '', 'PENDIENTE', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (37, 'PEREZNEGRON', 'GAONA', 'CONRRADO', '', '850461', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (38, 'ROMERO', 'MENDOZA', 'JOSE NICOLAS', '', '5732862', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (39, 'LARA', 'MENDOZA', 'DINORA', '', '2624223', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (40, 'PORTES', 'ACUÑA', 'KAREN', '', '4199245', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (41, 'SANCHEZ', 'MENDOZA ', 'ARIADNA', '', '543130', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (42, 'HERNANDEZ', 'VARGAS', 'MARGARITA', '', '510367', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (43, 'LOZANO', 'BORJA', 'CARLOS', '', '6205355', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (44, 'GONZALEZ', 'TENORIO', 'MARIO', '', '812740', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (45, 'TORRES', 'GUTIERREZ', 'CARLOS', '', '2890542', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (46, 'CORTES', 'NIETO', 'JOSE JUAN', '', '991761', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (47, 'LANDEROS', 'SANCHEZ', 'NORMA', '', '1610904', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (48, 'MERINO', 'CONDE', 'ELIZABETH', '', '721153', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (49, 'RAMIREZ', 'ONTIVERO', 'CARLOS', '', '762853', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (50, 'ROA', 'DORANTES', 'ROLANDO', '', '1081152', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (51, 'SANTOS', 'KEHOE', 'ARTURO', '', '3972207', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (52, 'SANCHEZ', 'OSNAYA', 'HECTOR HUGO', '', '2631260', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (53, 'RUIZ', 'GARCIA', 'ANA LAURA', '', '5736075', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (54, 'MARTINEZ', 'PICHARDO', 'ANTONIO', '', '4667739', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (55, 'MATOS', 'PEREZ', 'RAMIRO RAFAEL', '', '2155732', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (56, 'MATOS', 'Y SANTOS', 'ANGEL RAFAEL', '', '345290', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (57, 'DIAZ', 'DIAZ', 'RAUL', '', '617377', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (58, 'FRYERE', 'MALACARA', 'GUSTAVO', '', '1199017', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (59, 'SANDOVAL', 'VILLEDA', 'MARGARITO', '', '1121661', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (60, 'ORTEGA', 'AMADOR', 'ENRIQUE', '', '2377120', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (61, 'BALBUENA', 'BASALDUA', 'JORGE LUIS', '', '3414852', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (62, 'SANDOVAL', 'GARCIA', 'FRANCISCO', '', '4089002', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (63, 'MARTINEZ', 'SOLORZANO', 'MARCELO', '', '2221531', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (64, 'ZORRAQUIN', 'SANCHEZ', 'ALEJANDRO', '', '704067', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (65, 'SANDOVAL', 'LUNA ', 'ENRIQUE', '', '20322028', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (66, 'SOTELO', 'IDELANDA', 'ELOY', '', '456094', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (67, 'YEPEZ', 'RAMIREZ', 'JUAN PABLO', '', '4064442', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (68, 'ABARCA', 'MATUS', 'ROBERTO', '', '4324230', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (69, 'RODRIGUEZ', 'GUTIERREZ ', 'MARIA JOSE', '', '5907279', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (70, 'GALLEGOS', 'RUBIO', 'MARTA', '', '463127', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (71, 'MOCTEZUMA', 'GUZMAN', 'JORGE ENRIQUE', '', '1185372', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (72, 'HERNANDEZ', 'MARTINEZ', 'JUAN CARLOS', '', 'PENDIENTE', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (73, 'BUSTOS', 'GUTIERREZ', 'SANDRA', '', '653470', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (74, 'GAMBOA', 'ROSAS', 'NORMA', '', '3017224', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (75, 'LOPEZ', 'DURAN', 'ROSELIA', '', '866673', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (76, 'NUÑEZ', 'HERNANDEZ ', 'JOSE', '', '1099018', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (77, 'ORTIZ', 'MONTAÑO', 'LUIS ENRIQUE', '', '977631', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (78, 'GONZALEZ', 'GOMEZ', 'JULIAN', '', '2398277', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (79, 'CABALLERO', 'RIVERA ', 'JESUS', '', '6114450', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (80, 'TRUJILLO', 'CASTRO', 'JOSE ARTURO', '', '769884', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (81, 'HERNANDEZ', 'VIVAR', 'LUIS ENRIQUE', '', '1015525', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (82, 'MARTINEZ', 'ZUNO', 'FRANCISCO', '', '3763935', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (83, 'FLORES', 'BALTAZAR', 'OSWALDO', '', '3880793', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (84, 'CORDOBA', 'BECERRIL', 'NORA ALEJANDRA', '', '2567775', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (85, 'SANTILLAN ', 'TREJO', 'LUIS', '', '34694', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (86, 'PEREZ', 'CORTES', 'ANTONIO', '', '1057974', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (87, 'YAÑEZ', 'CARRANZA', 'JORGE ALFREDO', '', '23777110', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (88, 'VILLASEÑOR', 'LLUEVANOS', 'ROCIO', '', '1669150', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (89, 'NOVIA', 'BENITEZ', 'VICTOR MANUEL', '', '4411551', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (90, 'AVALOS', 'BENITEZ', 'YOLANDA', '', '6287321', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (91, 'BENITEZ', 'VEGA', 'MARIA VICTORIA', '', '157697', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (92, 'IBARRA ', 'LOZANO', 'MARIO', '', '17777111', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (93, 'SEGURA ', 'ESPINOZA', 'DAVID', '', '2497098', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (94, 'RANGEL ', 'ESPINOZA', 'ALFONSO', '', '399852', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (95, 'CAMACHO ', 'OLIVA', 'BELZAY DE JESUS', '', '266036', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (96, 'CASTRO', 'GARCIA', 'YI LIAN', '', '5932315', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (97, 'HERNANDEZ', 'ALVARADO', 'JULIO SERGIO', '', '29770', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (98, 'GOMEZ', 'PEREZ', 'ELOISA', '', '617897', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (99, 'GUZMAN', 'ZAMUDIO', 'DARIO', '', '266615', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (100, 'JUAREZ', 'GARCIA', 'ULISES', '', '963036', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (101, 'NUÑEZ', 'ANTONIO', 'TANIA', '', '3238570', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (102, 'SANCHEZ ', 'VARGAS', 'JUAN IVAN', '', '184952', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (103, 'MARTIN ', 'CASTILLO', 'JUAN MANUEL', '', '750333', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (104, 'RODRIGUEZ', 'SANCHEZ', 'JOSE', '', '167628', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (105, 'CARRILLO', 'MENDOZA', 'VALERIA', '', '3578426', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (106, 'MANCILLA', 'GONZALEZ', 'ALEJANDRA', '', '5888204', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (107, 'WONG', 'MORALES', 'ANA MELAI', '', '1967317', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (108, 'FLORES', 'JUAREZ', 'OMAR', '', '2369452', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (109, 'CALVO ', 'VALENCIA', 'GRISEL', '', '5419406', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (110, 'ALAVEZ', 'RUIZ', 'ROSENDO', '', '173839', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (111, 'AGUILAR', 'ROSAS', 'VICTOR', '', '3309735', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (112, 'CRUZ ', 'ALVAREZ', 'DAVID GERARDO', '', '13966466', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (113, 'MARÍA', 'PINEDA', 'SHEILA RUTH', '', '1343559', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (114, 'GALLARDO ', 'CANDELAS', 'JOSE ANTONIO', '', '1467786', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (115, 'DIAZ', 'PEREZ', 'MARIANO', '', '1099889', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (116, 'HOYO', 'RAMIREZ', 'RUBEN ANTONIO', '', '513502', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (117, 'CERVANTES', 'DOMINGUEZ', 'JOSE PEDRO', '', '297035', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (118, 'CERVANTES', 'LEYZAOLA', 'GUILLERMO', '', '860835', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (119, 'ESCOBAR ', 'PONCE ', 'LUIS FERNANDO', '', '4110882', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (120, 'GONZALEZ', 'MAGAÑA', 'EUGENIA', '', '513135', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (121, 'MIRANDA', 'MARTINEZ', 'FRANCISCO', '', '602672', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (122, 'ZUÑIGA', 'TOPETE', 'MARTIN', '', '3238570', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (123, 'MAGAÑA', 'TIBURCIO', 'MERIRAT', '', 'PENDIENTE', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (124, 'NYFFELER', 'GUTIERREZ', 'ROBERTO IVAN', '', '206354', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (125, 'LOPEZ', 'SUAZO', 'ARTURO', '', '1101810', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (126, 'OCTUNA', 'ESPINOZA', 'GUADALUPE', '', '1082161', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (127, 'PAREDES', 'GARCIA', 'RAFAEL', '', '1883766', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (128, 'VERDUZCO', 'CASTELLANOS', 'LUIS FERNANDO', '', '31777543', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (129, 'RUIZ ', 'MOLINA', 'NORBERTO', '', '672809', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (130, 'AVALOS', 'LOPEZ', 'CONSUELO VERONICA', '', '2198184', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (131, 'LESCAS', 'VAZQUEZ', 'JUAN CARLOS', '', '2045654', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (132, 'PARADELA', 'MONTEJO', 'EDUARDO', '', '3603476', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (133, 'TORRES', 'PEREZ', 'ESTEBAN', '', '1079062', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (134, 'VALLARDY', 'PEREZ', 'LUIS ROBERTO', '', '4222183', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (135, 'DUARTE', 'FLORES', 'FELIPE DE JESUS', '', '3504036', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (136, 'AGUILAR AGUILA', 'OROPEZA', 'MARCO ANTONIO', '', '1448908', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (137, 'AGUILAR AGUILA', 'MARTINEZ', 'MARCO ANTONIO', '', '1448908', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (138, 'CHAVEZ', 'CERVIN', 'JESUS BULMARO', '', 'A5CEM1435', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (139, 'LOBERA', 'TOPETE', 'ELENA FABIOLA', '', '1071789', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (140, 'TAPIA', 'TREJO', 'LEOPOLDO', '', '676625', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (141, 'CASTILLO', 'ROMERO', 'EUGENIO', '', '11981', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (142, 'RODRIGUEZ', 'MOCTEZUMA', 'RAYMUNDO', '', '1079613', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (143, 'CHAVEZ', 'LLAMAS', 'EDGAR DAVID', '', '3848419', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (144, 'GUISA', 'CRUZ', 'SUSANA', '', '249459', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (145, 'MENESES ', 'RAMIREZ', 'JESUS', '', '185571', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (146, 'LOPEZ', 'LOPEZ', 'ENRIQUE', '', '616196', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (147, 'MINUTI', 'LOPEZ', 'ARMANDO', '', '805796', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (148, 'MARTINEZ', 'VILLEGAS', 'NURIA', '', '4412035', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (149, 'BURGOA', 'TOLEDO', 'FRANCISCO', '', '188966', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (150, 'DE LEON', 'MARTINEZ', 'VICTOR MANUEL', '', '3414127', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (151, 'MEZA', 'CANALES', 'MYRNA', '', '4964319', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (152, 'AGUILAR', 'VELAZQUEZ', 'ZHULIN', '', '5446307', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (153, 'MANRIQUE', 'MENDOZA', 'ALEJANDRO', '', '1851554', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (154, 'PONCE', 'GONZÁLEZ', 'NOEL', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (155, 'TREJO', 'ARAUJO', 'MARTA', '', '678757', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (156, 'CARRILLO', 'GONZALEZ', 'SABINO', '', '7440348', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (157, 'LONRADI', 'GUERRERO', 'ÓSCAR', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (158, 'CUEVAS', 'CENTENO', 'GEORGINA', '', '26532', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (159, 'CORTÉS', 'LOPEZ', 'FRANCISCO', '', '1854063', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (160, 'GUIDO', 'PEREYRA', 'JOSE', '', '7930043', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (161, 'ALVARADO', 'SORIANO', 'JUAN CARLOS', '', '2043879', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (162, 'ARIAS', 'LOZA', 'ROSA', '', '704681', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (163, 'BADILLO', 'BARRADAS', 'URIEL', '', '2402986', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (164, 'BAHENA', 'BASAVE', 'ASMINDA ADRIANA', '', '1229852', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (165, 'BARRIGA', 'PEREZ', 'GIL', '', '238831', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (166, 'BEDOLLA', 'ARELLANO', 'LETICIA', '', '3462569', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (167, 'BLANCAS', 'CORIA', 'EDUARDO ESTEBAN', '', '743689', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (168, 'BUSTILLOS', 'CRUZ', 'CARLOS', '', '515788', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (169, 'CARRERAS', 'MARTINEZ', 'JUAN MANUEL', '', '663185', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (170, 'CASTRO', 'CHAPA', 'RICARDO', '', '5445011', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (171, 'CERON ', 'RAMIREZ', 'ERNESTO RUBEN', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (172, 'CHAMLATI', 'SALEM', 'NAGIB', '', '1612326', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (173, 'CHIO ', 'MAGAÑA', 'RAUL', '', '156339', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (174, 'CONTRERAS', 'OROPEZA', 'ALBERTO', '', '1321849', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (175, 'DIAZ', 'LOPEZ', 'ELSA', '', '1693586', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (176, 'DURAZO', 'VILLANUEVA', 'ALBERTO', '', '1278992', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (177, 'ESCANDON', 'PALOMINO', 'JAVIER ', '', '1065421', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (178, 'FERNANDEZ', 'RIVERA ', 'ENRIQUE', '', '870747', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (179, 'FIGUEROA', 'CAL Y MAYOR', 'CESAR', '', '920285', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (180, 'FIGUEROA', 'CAL Y MAYOR', 'FRANCISCO ', '', '1185855', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (181, 'FRENK', 'BARON', 'PAUL', '', '1485087', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (182, 'GABAYET', 'IMADA', 'ENRIQUE', '', '3246918', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (183, 'GALVAN', 'JIMENEZ', 'GUILLERMO', '', '3278706', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (184, 'GOMEZ', 'GARCIA', 'FELIPE', '', '404349', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (185, 'GONZALEZ', 'LOMELI', 'JUAN EDUARDO', '', '1481362', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (186, 'GUZMAN', 'GUZMAN', 'ALICIA', '', '1845402', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (187, 'BURGOS', 'CONTRERAS', 'GUILLERMO ', '', '891769', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (188, 'IÑARRITU', 'CERVANTES', 'ALFREDO', '', '52586', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (189, 'ITURBIDE', 'GUERRA', 'PEDRO ANTONIO', '', '265162', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (190, 'JIMENEZ', 'MEDINA', 'FATIMA', '', '7401209', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (191, 'LEGORRETA', 'CUEVAS', 'GUSTAVO', '', '1315226', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (192, 'LICONA', 'SUAREZ', 'HERMINIA', '', '2284615', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (193, 'LIZAMA', 'FLORES', 'OSCAR', '', '4925033', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (194, 'LOPEZ', 'GARCIA', 'RICARDO', '', '3815727', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (195, 'LUNA', 'TOVAR', 'AGUSTIN', '', '1309337', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (196, 'MARTINEZ', 'FLORES', 'VICTOR', '', '813495', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (197, 'MARTINEZ', 'ZUNZUNEGUI', 'VERONICA', '', '2919291', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (198, 'MORENO', 'GUTIERREZ', 'EFRAIN', '', '272687', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (199, 'NAVA ', 'GARCIA', 'ABEL', '', '860056', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (200, 'PANIAGUA', 'URBINA', 'SONIA', '', '4252693', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (201, 'PICHARDO', 'FARFAN', 'ARTURO', '', '317336', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (202, 'RAMOS', 'MORALES', 'FERNANDO', '', '1922275', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (203, 'RICARDEZ ', 'GARCIA', 'JOSE ABENAMAR', '', '3372281', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (204, 'RIOS ', 'LEAL', 'ALEJANDRO', '', '73674', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (205, 'ROSAS', 'CARRASCO', 'OSCAR', '', '6249974', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (206, 'ROSENDO', 'BECERRA', 'JOAQUIN', '', '3340224', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (207, 'SAAD', 'DAYAN', 'MARCOS', '', '557507', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (208, 'SANGINES', 'MARTINEZ', 'AUGUSTO', '', '345188', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (209, 'SERVIN', 'TORRES', 'ERICK', '', '3163948', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (210, 'SIBAJA', 'AGUILAR', 'ANTONINO', '', '3443577', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (211, 'SOTELO', 'ORTIZ', 'JULIETA MARGARITA', '', '3278464', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (212, 'TIRADO', 'BAIJEN', 'ALEJANDRO', '', '138434', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (213, 'TORRES', 'CARRANZA', 'SELVA ATZIMBA', '', '4795047', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (214, 'VAZQUEZ', 'AGUILERA', 'F.ALEJANDRO', '', '2634513', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (215, 'VAZQUEZ', 'ORTIZ', 'ELOY', '', '2963648', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (216, 'VAZQUEZ', 'CAMPOS', 'FRANCISCO JAVIER', '', '177212', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (217, 'CAÑAVERAL', 'HERNÁNDEZ ', 'BRENDA', '', '4252692', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (218, 'ALVARADO', 'BACHMAN', 'RAUL', '', '3710339', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (219, 'BENBASSAT', 'PALACHI', 'MIGUEL', '', '46459', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (220, 'BENITEZ', 'FLORES', 'EZEQUIEL', '', '638222', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (221, 'CERVANTES', 'CASTRO', 'JORGE', '', '129452', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (222, 'CERVANTES', 'MONTEIL', 'FELIPE', '', '1289203', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (223, 'DERGAL', 'BADUE', 'ELIAS', '', '224759', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (224, 'GARMILLA', 'ESPINOZA', 'JOSE', '', '1484971', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (225, 'GUAJARDO', 'ROSAS', 'JORGE', '', '2748122', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (226, 'GUZMAN', 'NAVARRO', 'LEOPOLDO', '', '151355', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (227, 'HERNANDEZ', 'PEÑA', 'ROBERTO', '', '3006386', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (228, 'HERNANDEZ', 'VALENCIA', 'JOSE ARTURO', '', '1727320', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (229, 'HERRERIAS', 'CANEDO', 'TOMAS', '', '534119', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (230, 'JEAN', 'SILVER', 'ENRIQUE', '', '5475728', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (231, 'LASKY', 'MARKOVISH', 'DAVID ', '', '776098', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (232, 'LEGASPI', 'ZAUTE', 'ALAN', '', '654111', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (233, 'MARTINEZ', 'MUNIVE', 'ANGEL', '', '1817807', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (234, 'MENDOZA', 'CASTRO', 'HERBER', '', '4584384', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (235, 'MORENO', 'SÁNCHEZ', 'FRANCISCO', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (236, 'OCAMPO', 'PATIÑO', 'JOAQUIN', '', '5683909', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (237, 'OROZCO', 'OBREGON', 'PABLO', '', '3278932', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (238, 'ORTIZ ', 'DE LA PEÑA', 'JORGE', '', '654864', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (239, 'OVIEDO', 'ORTEGA', 'JOSE GERARDO', '', '3626809', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (240, 'PINEDA', 'GUERRERO', 'CHRISTIAN GERARDO', '', '6910388', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (241, 'PROCELL', 'VILLALOBOS', 'CARLOS R.', '', '2274073', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (242, 'RIVERA', 'RAMIREZ', 'JAIME ALEJANDRO', '', '5346854', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (243, 'SANTIN', 'RIVERO', 'JORGE', '', '3831161', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (244, 'SHUCHLEIB', 'CHABA', 'SAMUEL', '', '177265', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (245, 'SOLER', 'MONTESINOS', 'LORENZO', '', '158627', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (246, 'STOOPEN', 'MORGAIN', 'ENRIQUE', '', '793641', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (247, 'VEGA', 'BUSTOS', 'MARTIN', '', '1672827', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (248, 'ZAGA', 'RAYEC', 'LUCY', '', '1663727', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (249, 'ALANIS', 'BLANCAS', 'LUIS MANUEL', '', '3245616', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (250, 'ARANDA', 'GALLEGOS', 'JAVIER', '', 'PEND', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (251, 'ARRIOLA', 'SANCHEZ', 'JORGE', '', '1807616', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (252, 'AYALA', 'YAÑEZ', 'RODRIGO', '', 'PEND', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (253, 'CASTAÑEDA', 'LEADER', 'PABLO', '', '3081741', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (254, 'CESARMAN', 'SILVA', 'JAIME', '', '129998', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (255, 'CRUZ', 'MIRANDA', 'ANGEL', '', '5088423', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (256, 'CRUZ', 'MINOLI', 'VIVIAN PATRICIA', '', '4110026', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (257, 'D\'HYVER', 'DE LAS DESES', 'CARLOS', '', '707283', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (258, 'DIAZ', 'ARGUELLO', 'DUDLEY', '', '1694245', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (259, 'FERNANDEZ', 'VAZQUEZ', 'JUAN MANUEL', '', '113623', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (260, 'HAGHENBECK', 'ALTAMIRANO', 'F. JAVIER', '', '1034775', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (261, 'JORBA', 'MATA', 'PEDRO', '', '259425', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (262, 'JUAREZ', 'ROJAS', 'CARLOS', '', '2514880', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (263, 'KLEINFINGER', 'MARCUSCHAMER', 'SAMUEL', '', '1621231', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (264, 'LIMON', 'LUQUE', 'LAURA', '', '860915', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (265, 'LOPEZ', 'RYVADENEIRA', 'ETELBERTO', '', '1967043', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (266, 'MOLINA', 'VARGAS', 'PEGGY', '', '2890186', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (267, 'MUÑIZ', 'VARGAS', 'MARIO ALBERTO', '', '1800133', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (268, 'MUÑOZ', 'GONZALEZ', 'DAVID EDUARDO', '', '1583217', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (269, 'ORTIZ', 'RUIZ', 'ERENDIRA', '', '4239653', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (270, 'AYALA', 'GAMBOA', 'UVALDO', '', '4156774', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (271, 'SANCHEZ ', 'JUREIDINI', 'GABRIEL', '', '5328039', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (272, 'SANCHEZ ', 'DE LEON', 'ALEJANDRA', '', '2473277', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (273, 'SAURI', 'ARCE', 'JOSE CARLOS', '', '578019', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (274, 'STRYGLER', 'ZAGURSKY', 'BERNARDO', '', '1078113', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (275, 'VAZQUEZ', 'CAMACHO', 'ERICK', '', '1967208', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (276, 'ZAMORA ', 'MUÑOZ', 'PAOLA MARITZA', '', '3728380', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (277, 'AVALOS', 'MENDEZ', 'MIGUEL ANGEL', '', '1223084', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (278, 'BORRAJO', 'CARBAJAL', 'FRANCISCO JAVIER', '', '746461', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (279, 'CABEZAS', 'GARCIA', 'EVELIO', '', '274104', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (280, 'CASTELLANOS', 'VALLEJO', 'DANIEL', '', '754872', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (281, 'CASTILLO', 'ALARCON', 'JOSE ', '', '228469', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (282, 'CEDILLO', 'LEY', 'OCTAVIO', '', '1706824', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (283, 'DE AVILA', 'Y ZUÑIGA', 'BERTHA CECILIA', '', '4110193', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (284, 'EGUIARTE', 'CALDERON ', 'ROBERTO', '', '997863', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (285, 'GOMEZ', 'RODRIGUEZ', 'MANUEL', '', '3150291', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (286, 'GONZALEZ', 'GONZALEZ', 'ALBERTO', '', '7055600', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (287, 'HERNANDEZ', 'PADILLA', 'PEDRO A.', '', '399053', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (288, 'HERNANDEZ', 'Y ROBLES', 'LUIS FERNANDO', '', '355514', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (289, 'HERNANDEZ', 'MENDEZ', 'EDUARDO', '', '3664883', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (290, 'IBARRA', 'CHAVARRIA', 'VALENTIN', '', '1228714', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (291, 'ISLAS', 'CORTES', 'RODOLFO', '', '168808', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (292, 'JIMENEZ', 'RIVERA ', 'JOSE ISRAEL', '', 'PEND', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (293, 'LOPEZ', 'FOURNIER', 'PEDRO', '', '252911', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (294, 'LUNA', 'BARTOLIN', 'ROBERTO', '', '1308412', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (295, 'LUNA', 'GARCIA', 'LILIA', '', '3278730', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (296, 'MARTINEZ', 'RUIZ', 'MARIO', '', '3837464', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (297, 'MENDEZ', 'ESPINOZA', 'GERARDO', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (298, 'NAVARRO', 'VENEGAS', 'CAROLINA', '', '2303654', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (299, 'NEME', 'DAVID', 'ALFREDO', '', '153618', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (300, 'NIZ', 'RAMOS ', 'JOSE', '', '152290', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (301, 'OLVERA', 'ALVAREZ', 'ISRAEL', '', '2843843', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (302, 'PEREZ', 'REYES', 'MA.CARMEN', '', '547362', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (303, 'RODRIGUEZ', 'CABRERA', 'JULIO', '', '3603863', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (304, 'SANCHEZ ', 'AGUIRRE', 'FERNANDO', '', '814132', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (305, 'SANTOS', 'GONZALEZ', 'JAVIER ENRIQUE', '', '90400', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (306, 'SAUER', 'RAMIREZ', 'RUBEN', '', '478963', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (307, 'SEQUEIROS', 'LORANCA', 'ERENDIRA', '', '800828', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (308, 'SERRANO', 'BECERRA', 'NOE', '', '4687204', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (309, 'SILVESTRI', 'TOMASSONI', 'ROBERTO', '', '2160942', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (310, 'TOPETE', 'OROZCO', 'LUIS MIGUEL', '', '127973', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (311, 'TOPETE', 'OROZCO', 'JOSE IGNACIO', '', '351538', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (312, 'VELAZQUEZ', 'SANCHEZ', 'MARIA DELPILAR', '', '1318546', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (313, 'VELAZQUEZ', 'FIESCO ', 'IVAN', '', '3290026', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (314, 'VERA', 'VÁZQUEZ ', 'SANDRA ADRIANA', '', '1822507', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (315, 'ORDÓÑEZ', 'CAPUANO', 'LUIS ENRIQUE', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (316, 'ZARAE', 'TREVIÑO', 'ARTURO', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (317, 'SOMELERA', 'CARAVEO', 'ROBERTO', '', '', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (318, 'VERVER', 'MORENO', 'CINTHYA', '', '5823392', '', '');
INSERT INTO `sirac`.`ct_medico` (`id_medico`, `nombre`, `apaterno`, `amaterno`, `fecha_nac`, `cedula`, `universidad`, `celular`) VALUES (319, 'ZENTELLA', 'AGUILAR', 'RAMON', '', '66614', '', '');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_especialidad`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (1, 'ANGIOLÓGOS');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (2, 'MEDICO GENERAL (ULCERAS, PIE DIABÉTICO)');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (3, 'GERIÁTRAS');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (4, 'MEDICO INTERNISTA (ULCERAS, PIE DIABÉTICO)');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (5, 'ONCÓLOGO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (6, 'GASTROENTERÓLOGO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (7, 'CIRUJANO GENERAL');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (8, 'ESTETICO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (9, 'PODÓLOGO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (10, 'PEDIATRA');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (11, 'TERAPIA INTENSIVA');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (12, 'REHABILITACIÓN');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (13, 'URGENCIOLOGO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (14, 'CIR. PLASTICO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (15, 'DERMATÓLOGO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (16, 'GINECÓLOGO');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (17, 'CIR. GRAL. (QUIR)');
INSERT INTO `sirac`.`ct_especialidad` (`id_especialidad`, `especialidad`) VALUES (18, 'TRAUMATÓLOGO');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`rl_medico_especialidad`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (1, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (2, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (3, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (4, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (5, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (6, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (7, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (8, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (9, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (10, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (11, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (12, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (13, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (14, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (15, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (16, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (17, 17, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (18, 18, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (19, 18, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (20, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (21, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (22, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (23, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (24, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (25, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (26, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (27, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (28, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (29, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (30, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (31, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (32, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (33, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (34, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (35, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (36, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (37, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (38, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (39, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (40, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (41, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (42, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (43, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (44, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (45, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (46, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (47, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (48, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (49, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (50, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (51, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (52, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (53, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (54, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (55, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (56, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (57, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (58, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (59, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (60, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (61, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (62, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (63, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (64, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (65, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (66, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (67, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (68, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (69, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (70, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (71, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (72, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (73, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (74, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (75, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (76, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (77, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (78, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (79, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (80, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (81, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (82, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (83, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (84, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (85, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (86, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (87, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (88, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (89, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (90, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (91, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (92, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (93, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (94, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (95, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (96, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (97, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (98, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (99, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (100, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (101, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (102, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (103, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (104, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (105, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (106, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (107, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (108, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (109, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (110, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (111, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (112, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (113, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (114, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (115, 17, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (116, 18, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (117, 18, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (118, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (119, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (120, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (121, 1, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (122, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (123, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (124, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (125, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (126, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (127, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (128, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (129, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (130, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (131, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (132, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (133, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (134, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (135, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (136, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (137, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (138, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (139, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (140, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (141, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (142, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (143, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (144, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (145, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (146, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (147, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (148, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (149, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (150, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (151, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (152, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (153, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (154, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (155, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (156, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (157, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (158, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (159, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (160, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (161, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (162, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (163, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (164, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (165, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (166, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (167, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (168, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (169, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (170, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (171, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (172, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (173, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (174, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (175, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (176, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (177, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (178, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (179, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (180, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (181, 18, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (182, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (183, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (184, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (185, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (186, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (187, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (188, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (189, 17, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (190, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (191, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (192, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (193, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (194, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (195, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (196, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (197, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (198, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (199, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (200, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (201, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (202, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (203, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (204, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (205, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (206, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (207, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (208, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (209, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (210, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (211, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (212, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (213, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (214, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (215, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (216, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (217, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (218, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (219, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (220, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (221, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (222, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (223, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (224, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (225, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (226, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (227, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (228, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (229, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (230, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (231, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (232, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (233, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (234, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (235, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (236, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (237, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (238, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (239, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (240, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (241, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (242, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (243, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (244, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (245, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (246, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (247, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (248, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (249, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (250, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (251, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (252, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (253, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (254, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (255, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (256, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (257, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (258, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (259, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (260, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (261, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (262, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (263, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (264, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (265, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (266, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (267, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (268, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (269, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (270, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (271, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (272, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (273, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (274, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (275, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (276, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (277, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (278, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (279, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (280, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (281, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (282, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (283, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (284, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (285, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (286, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (287, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (288, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (289, 5, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (290, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (291, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (292, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (293, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (294, 11, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (295, 14, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (296, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (297, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (298, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (299, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (300, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (301, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (302, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (303, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (304, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (305, 16, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (306, 15, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (307, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (308, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (309, 8, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (310, 3, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (311, 2, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (312, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (313, 4, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (314, 7, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (315, 12, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (316, 10, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (317, 9, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (318, 6, NULL);
INSERT INTO `sirac`.`rl_medico_especialidad` (`id_medico`, `id_especialidad`, `cedula_especialidad`) VALUES (319, 5, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_sitio`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (1, '', 'AV  JAUREZ', '38', '', 'CENTRO', '52900', 'ATIZAPAN', '', '58226089Y 86287222');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (2, '', 'AV. ADOLFO LOPEZ MATEOS', '49', '', 'CENTRO', '52900', 'ATIZAPAN', '', '58253200');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (3, '', 'AV. ADOLFO LOPEZ MATEOS Y ', '49', '', 'CENTRO', '52900', 'ATIZAPAN', '', '58253200');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (4, '', 'AV. ADOLFO LOPEZ MATEOS', '49', '', 'CENTRO', '52900', 'ATIZAPAN', '', '58253200');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (5, '', 'CONVENTO DE SANTA MONICA', '120', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '53989852');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (6, '', 'RAMCHO ÑA HERRADURA', 'P', '', 'SAN ANTONIO', '54725', 'CUAUTITLAN IZCALLI', '', '58179923');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (7, '', '16 DE SEPTIEMBRE ', '66', '', 'BONFIL', '52919', 'ATIZAPAN', '', '5516175396');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (8, '', 'AV. JUAREZ', '38', '', 'CENTRO', '52900', 'ATIZAPAN', '', '58224411');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (9, '', 'CTO PLAZA ESMERALDA NO ', '11', '', 'ZONA ESMERALDA', '52930', 'ATIZAPAN', '', '53082231');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (10, '', 'AV JINETEZ', '163', '', 'ARBOLEDAS', '52950', 'ATIZAPAN', '', '53782878');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (11, '', 'AV JINETEZ', '163', '', 'ARBOLEDAS', '52950', 'ATIZAPAN', '', '53782878');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (12, '', 'LOPEZ MATEOS', '117', '', 'MEXICO NUEVO', '52966', 'ATIZAPAN', '', '58244423');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (13, '', 'LOPEZ MATEOS', '117', '', ' MEXICO NUEVO', '52966', 'ATIZAPAN', '', '58244423');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (14, '', 'AV. HIDALGO', '41', '', 'HIDALGO', '54060', 'TLALNEPANTLA', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (15, '', 'LOPEZ MATEOS', '117', '', 'MEXICO NUEVO', '52966', 'ATIZAPAN', '', '58244423');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (16, '', 'AV JIMENEZ CANTU', 'S/N', '', 'ZONA ESMERALDA', '52930', 'ATIZAPAN', '', '53084147');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (17, '', 'LOPEZ MATEOS', '117', '', 'MEXICO NUEVO', '5966', 'ATIZAPAN', '', '58244423');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (18, '', 'ADOLFO LOPEZ MATEOS Y CUAHUTEMOC 40 TLANE', '49', '', 'CENTRO', '52900', 'ATIZAPAN', '', '58253200');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (19, '', 'CONDOR', '7', '', 'ARBOLEDAS', '54026', 'ATIZAPAN', '', '53791125');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (20, '', 'AV JIENTEZ', '16', '', 'ARBOLEDAS', '54026', 'ATIZAPAN', '', '5300650');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (21, '', 'JIMENEZ CANTU PLAZA ESMERALDA', '2 PISO', '', 'ZONA ESMERALDA', '52930', 'ATIZAPAN', '', '53082231');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (22, '', 'CEDRO', '22', '', 'SAN JUAN', '54800', 'CUAUTITLAN', '', '58704252');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (23, '', 'ABASOLO', '5', '', 'CENTRO', '54800', 'CUAUTITLAN', '', '58724307');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (24, '', 'CARILLO PUERTO', '208', '', 'CUAUTITLAN', '13360', 'CUAUTITLAN', '', '58704160');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (25, '', 'CALZADA DE GUADALUPE', '212', '', 'CUAUTITLAN', '54800', 'CUAUTITLAN', '', '58701314');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (26, '', 'ZARAGOZA', '201', '', 'EL HUERTO', '13360', 'CUAUTITLAN', '', '58723747');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (27, '', 'CIPRES', '4', '', 'LOS MORALES', '54800', 'CUAUTITLAN', '', '58701755');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (28, '', 'AV FRESNOS', '37', '', 'LOS MORALES', '54800', 'CUAUTITLAN', '', '26204579');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (29, '', 'CEDRO', '22', '', 'SAN JUAN', '54800', 'CUAUTITLAN', '', '58704252');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (30, '', 'CEDRO', '22', '', 'SAN JUAN', '54800', 'CUAUTITLAN', '', '58704252');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (31, '', 'AV. 16 DE SEPTIEMBRE ', 'S/N', '', 'BONFIL', '52940', 'ATIZAPAN', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (32, '', 'SOR JUANA INES DE LA CRUZ', '225', '', 'EL HUERTO', '13360', 'CUAUTITLAN', '', '58708488');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (33, '', 'ZARAGOZA', '203', '', 'EL HUERTO', '13360', 'CUAUTITLAN', '', '58720448');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (34, '', 'ZARAGOZA', '203', '', 'EL HUERTO', '13360', 'CUAUTITLAN', '', '58720448');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (35, '', 'FRESNOS', '37', '', 'LOS MORALES', '54800', 'CUAUTITLAN', '', '26204579');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (36, '', 'FRESNOS', '14', '', 'LOS MORALES', '54800', 'CUAUTITLAN', '', '26201232');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (37, '', 'LUIS DE LA PEÑA', '21', '', 'PARQUES', '54720', 'CUAUTITLAN IZCALLI', '', '58733710');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (38, '', 'AV JIMENEZ ZONA ESMERALDA', 'S/N', '', 'ZONA ESMERALDA', '52930', 'ATIZAPAN', '', '53084147');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (39, '', 'AV AUSTRAL', '43', '', 'ATLANTA', '54740', 'CUAUTITLAN IZCALLI', '', '58736341');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (40, '', 'AV AUSTRAL', '43', '', 'ATLANTA', '54740', 'CUAUTITLAN IZCALLI', '', '58736341');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (41, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54740', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (42, '', 'MP CUAUTITLAN IZCALLI', 'S/N', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58717883');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (43, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54740', 'CUUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (44, '', 'AV DEL TRABAJO', '11', '', 'BELLAVISTA', '54710', 'CUAUTITLAN IZCALLI', '', '50094154');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (45, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54740', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (46, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (47, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (48, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (49, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (50, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (51, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (52, '', 'AV CUAUTITLAN', 'M-29', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (53, '', 'GUAYABOS', 'M-18', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58774639');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (54, '', 'JILOTZONGO', '40', '', 'CUMBRIA', '54740', 'CUAUTITLAN IZCALLI', '', '58730451');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (55, '', 'TIANGUISTENGO', '15', '', 'CUMBRIA', '54740', 'CUAUTITLAN IZCALLI', '', '58730451');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (56, '', 'TIANGUISTENGO', '15', '', 'CUMBRIA', '54740', 'CUAUTITLAN IZCALLI', '', '58730451');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (57, '', 'NETZAHUALCOYOLT', '58', '', 'CUMBRIA', '54740', 'CUAUTITLAN IZCALLI', '', '58712247');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (58, '', 'RIO HONDDO', '3', '', 'COLINAS DEL LAGO', '54744', 'CUAUTITLAN IZCALLI', '', '58817156');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (59, '', 'NEPTUNO', '27', '', 'ENSUEÑOS', '54740', 'CUAUTITLAN IZCALLI', '', '58716965');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (60, '', 'LA QUEBRADA', '89', '', 'LA QUEBRADA', '54760', 'CUAUTITLAN IZCALLI', '', '53100040');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (61, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (62, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (63, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (64, '', 'AV CIRCUNVALACION Y 16 DE SEPTIEMBRE', 'S/N', '', 'LA AURORA', '54725', 'CUAUTITLAN IZCALLI', '', '58891812');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (65, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (66, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (67, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZACALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (68, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (69, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (70, '', 'QUINTO SOL', '48', '', 'PARQUES', '54720', 'CUAUTITLAN IZCALLI', '', '58687374');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (71, '', 'MUSAS', '68', '', 'ENSUEÑOS', '54740', 'CUAUTITLAN IZCALLI', '', '58734429');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (72, '', 'TLATAYA', '3A', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58734429');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (73, '', 'TLATAYA', '3A', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58734429');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (74, '', 'TLATAYA', '3A', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58734429');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (75, '', 'TEMOAYA', '36', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58716586');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (76, '', 'LA QUEBRADA', '89', '', 'LA QUEBRADA', '54769', 'CUAUTITLAN IZCALLI', '', '53100040');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (77, '', 'LAZARO CARDENAS Y JIMENEZ CANTU', 'S/N', '', 'TEPALCAPA', '54768', 'CUAUTITLAN IZCALLI', '', '58935537');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (78, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (79, '', 'AV CIRCUNVALACION Y 16 DE SEPTIEMBRE', 'S/N', '', 'LA AURORA', '54725', 'CUAUTITLAN IZCALLI', '', '58891812');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (80, '', 'TLATAYA', '3A', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58733825');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (81, '', 'NARANJOS ORIENTE', '24', '', 'ARCOS DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58717882');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (82, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (83, '', 'NEPTUNO', '27', '', 'ENSUEÑOS', '54740', 'CUAUTITLAN IZCALLI', '', '58716965');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (84, '', 'TEMOAYA', '17 B', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58735139');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (85, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58726100');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (86, '', 'GUAYABOS', 'L8', '', 'BOSQUES DE MORELOS', '54760', 'CUAUTITLAN IZCALLI', '', '58771499');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (87, '', 'REYNOLDS ALUMINOO', '4', '', 'VISTERMOSA', '54080', 'TLALNEPANTLA', '', '53987823');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (88, '', '2 RETORNO DE BOSENCHEVE', '13', '', 'JARDINES DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58730101');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (89, '', 'AV SAN ANTONIO', '107', '', 'LA CONCEPCION', '54900', 'TULTITLAN', '', '58720838');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (90, '', 'AV SAN ANTONIO', '107', '', 'LA CONCEPCION', '54900', 'TULTITLAN', '', '58720838');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (91, '', 'AV SAN ANTONIO', '107', '', 'LA CONCEPCION', '54900', 'TULTITLAN', '', '58720838');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (92, '', 'AV TLALNEPANTLA', '27', '', 'LA CONCEPCION', '54900', 'TULTITLAN', '', '58720838');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (93, '', 'TLATAYA', '3A', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58717883');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (94, '', 'CITLATEPELT', '515', '', 'VALLE DORADO', '54026', 'TLALNEPANTLA', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (95, '', 'AV LOPEZ MATEOS', '309', '', 'JACARANDAS', '54050', 'TLALNEPANTLA', '', '53610338');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (96, '', 'ATENAS', '137', '', 'VALLE DORADO', '54020', 'TLALNEPANTLA', '', '53708301');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (97, '', 'AV LOPEZ MATEOS', '323', '', 'JACARANDAS', '54050', 'TLALNEPANTLA', '', '53626008');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (98, '', 'CONVENTO DE ACOLMAN', '35', '', 'SANTA MONICA', '54050', 'TLALNEPANTLA', '', '53613720');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (99, '', 'CONVENTO DE SANTA MONICA', '128', '', 'SANTA MONICA', '54050', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (100, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54050', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (101, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54050', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (102, '', 'ATENAS', '137', '', 'VALLE DORADO', '54023', 'TLALNEPANTLA', '', '53708301');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (103, '', 'TEOTIHUACAN', '56', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', '55650621');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (104, '', 'TOLTECAS', '41', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (105, '', 'GUSTAVO BAZ', '219', '', 'BARRIENTOS', '54010', 'TLALNEPANTLA', '', '5321223');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (106, '', 'GUSTAVO BAZ', '219', '', 'BARRIENTOS', '54010', 'TLALNEPANTLA', '', '5321223');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (107, '', 'BLVD DE LOS CONTINENTES', '76', '', 'VALLE DORADO', '54060', 'TLALNEPANTLA', '', '53790027');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (108, '', 'VIVEROS DE HUMAN', '28', '', 'VIVEROS DEL VALLE', '54060', 'TLALNEPANTLA', '', '53628636');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (109, '', 'GUSTAVO BAZ', '219', '', 'BARRIENTOS', '54010', 'TLALNEPANTLA', '', '5321223');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (110, '', 'TOLTECAS', '41', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', '55656934');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (111, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (112, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (113, '', 'PENDIENTE', '47', '', 'PENDIENTE', '52978', 'ATIZAPAN', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (114, '', 'VIVEROS DE HUMAN', '28', '', 'VIVEROS DEL VALLE', '54060', 'TLALNEPANTLA', '', '53628636');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (115, '', 'AV JUAREZ', '5', '', 'CENTRO', '54000', 'TLALNEPANTLA', '', '53924376');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (116, '', 'AV JUAREZ', '5', '', 'CENTRO', '54000', 'TLALNEPANTLA', '', '53924376');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (117, '', 'CONVENTO DE SANTA MONICA', '79', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '53977302');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (118, '', 'CONVENTO DE SANTA MONICA', '120', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '53989852');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (119, '', 'CONVENTO DE SANTA MONICA', '69', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '50919730');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (120, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (121, '', 'MORELOS', '8', '', 'BOSQUES DE MORELOS', '54760', 'TLALNEPANTLA', '', '5510450287');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (122, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (123, '', 'AV DE LOS DEPORTES', '168', '', 'ARBOLEDAS', '54030', 'ATIZAPAN', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (124, '', 'ATENAS', '137', '', 'VALLE DORADO', '54023', 'TLALNEPANTLA', '', '53708301');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (125, '', 'CUAHTEMOC', '40', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', '55654803');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (126, '', 'CUAHTEMOC', '40', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', '55654803');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (127, '', 'CUAHTEMOC', '40', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', '55654803');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (128, '', 'BLVD DE LOS CONTINENTES', '11', '', 'VALLE DORADO', '54020', 'TLALNEPANTLA', '', '53702193');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (129, '', 'BLVD DE LOS CONTINENTES', '11', '', 'VALLE DORADO', '54020', 'TLALNEPANTLA', '', '53702193');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (130, '', 'CONVENTO DE SANTA MONICA', '120', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '53989852');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (131, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (132, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (133, '', 'CONVENTO DE SANTA MONICA', 'PENDIENTE', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '5554384013');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (134, '', 'VIVEROS DE HUMAN', '28', '', 'VIVEROS DEL VALLE', '54060', 'TLALNEPANTLA', '', '53628636');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (135, '', 'VIVEROS DE HUMAN', '28', '', 'VIVEROS DEL VALLE', '54060', 'TLALNEPANTLA', '', '53628636');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (136, '', 'JINETEZ', '14', '', 'ARBOLEDAS', '54026', 'TLALNEPANTLA', '', '53628636');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (137, '', 'JINETEZ', '14', '', 'ARBOLEDAS', '54026', 'TLALNEPANTLA', '', '53622836');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (138, '', 'CERRADA DEL RUBI', '3B', '', 'LA JOYA', '54020', 'TLALNEPANTLA', '', '53709276');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (139, '', 'AV JUAREZ', '5', '', 'CENTRO', '54000', 'TLALNEPANTLA', '', '53924376');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (140, '', 'GUERRERO', 'PENDIENTE', '', 'SAN JAVIER', '54030', 'TLALNEPANTLA', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (141, '', 'CERRO URIBE', '209', '', 'PIRULES', '54040', 'TLALNEPANTLA', '', '53704239');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (142, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (143, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '4625000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (144, '', 'GOODYEAR OXXO', '3', '', 'VISTERMOSA', '54080', 'TLALNEPANTLA', '', '52407135');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (145, '', 'RIO DE JANEIRO', '236', '', 'VALLE DORADO', '54020', 'TLALNEPANTLA', '', '53781494');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (146, '', 'LAGO DE GUADALUPE ESQUINA CONTITUYENTES', 'L4', '', 'MAZA DE JUAREZ', '52926', 'ATIZAPAN', '', '53050218');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (147, '', 'BOLIVAR NORTE', '310', '', 'CUAUTITLAN', '54800', 'CUAUTITLAN', '', '58720461');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (148, '', 'AUTOPISTA MEXICO QRO', '43', '', 'LA LUZ', '54800', 'CUAUTITLAN IZCALLI', '', '58720461');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (149, '', 'CONJUNTO CAPRICORNIO', 'L20', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58680565');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (150, '', 'AV DE LOS CHOPOS', '138', '', 'ARCOS DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58646464');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (151, '', 'AV SAN ANTONIO', '107', '', 'LA CONCEPCION', '52900', 'TULTITLAN', '', '58720838');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (152, '', 'CARRETERA LAGO DE GUADALUPE', 'L4', '', 'MAZA DE JUAREZ', '52926', 'ATIZAPAN', '', '53050218');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (153, '', 'PLAZA MRGA IZCALLI LOCAL', '410', '', 'CENTRO URBANO', '54700', 'CUAUTITLAN IZCALLI', '', '58739726');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (154, '', 'ADOLFO LOPEZ MATEOS ', '98', '', 'JARDINES DE ATIZAPAN', '52978', 'CUAUTITLAN IZCALLI', '', '16681259');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (155, '', 'AV RUIZ CORTINES', '214', '', 'LA CONDESA', '52965', 'ATIZAPAN', '', '50773272');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (156, '', 'SANTIAGO', '220', '', 'VALLE DORADO', '54020', 'TLALNEPANTLA', '', '53785538');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (157, '', 'MARIO COLIN', '37', '', 'EL CORTIJO', '54070', 'TLALNEPANTLA', '', '53905068');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (158, '', 'NARANJOS ORIENTE', '24', '', 'ARCOS DEL ALBA', '54750', 'CUAUTITLAN IZCALLI', '', '58717882');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (159, '', 'AV. INDEPENDENCIA', 'S/NO', '', 'SANTO TOMÁS', '', 'CUAUTITLAN IZCALLI', '', '26202035');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (160, '', 'CONVENTO DE SANTA MONICA', '113', '', 'SANTA MONICA', '54040', 'TLALNEPANTLA', '', '46256000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (161, 'MOCEL', 'GELATI', '29-209', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (162, 'MOCEL', 'GRAL. CANO ', '94 - 302', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52715077');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (163, 'MOCEL', 'I ESTEVA', '107-203', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (164, 'CONSULTORIO', 'HÉROES CHURUBUSCO 55B', '55 B', '', 'TACUBAYA', '11870', 'MIGUEL HIDALGO', '', '55167396');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (165, 'MOCEL', 'I ESTEVA', '107 -101', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (166, 'MOCEL', 'GELATI', '29- PISO 1', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (167, 'MOCEL', 'IGNACIO ESTEVA', '107-002', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52782602');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (168, 'MOCEL', 'GELATI', '33-402', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', 'MOCELITO');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (169, 'MOCEL', 'GRAL CANO', '94-102', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (170, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (171, 'MOCEL', 'I ESTEVA', '107-103', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (172, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (173, 'MOCEL', 'GELATI', '33-403', '', 'SN MIGUEL CHAP', '11800', 'MIGUEL HIDALGO', '', '52710220');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (174, 'MOCEL', 'I ESTEVA', '107-104', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (175, 'MOCEL', 'GELATI', '29- PISO 1', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (176, 'MOCEL', 'GELATI', '29-405', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (177, 'MOCEL', 'IGNACIO ESTEVA', '107-004', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52782604');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (178, 'MOCEL', 'GELATI', '29-106', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52782600');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (179, 'MOCEL', 'GELATI ', '29-1204', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52726630');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (180, 'MOCEL', 'GELATI', '29-1204', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52726630');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (181, 'MOCEL', 'I ESTEVA', '107-204', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (182, 'ABC OBSERVATORIO', 'SUR 136', '116-P12 TB', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5230-8000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (183, 'MOCEL', 'GELATI', '29-109', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (184, 'MOCEL', 'I ESTEVA', '107-003', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (185, 'MOCEL', 'GELATI', '29-205', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169044');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (186, 'MOCEL', 'GELATI', '29- ANEXO 11', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55166338');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (187, 'MOCEL', 'GELATI', '29-213', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (188, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (189, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (190, 'CONSULTORIO', 'MARTIRES DE LA CONQUISTA', '15-PB', '', 'TACUBAYA', '11800', 'MIGUEL HIDALGO', '', '55153536');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (191, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (192, 'MOCEL', 'GRAL. CANO ', '94-101', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '10544773');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (193, 'MOCEL', 'I ESTEVA', '107-203 a verfif cons', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (194, 'MOCEL', 'GELATI', '33-205', '', 'SAN MIGUEL CHAPULTEPEC', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (195, 'MOCEL', 'GELATI', '29-209', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52710220');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (196, 'MOCEL', 'GELATI', '54', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52713935');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (197, 'MOCEL', 'GELATI', '29 ANEXO P-1 B', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (198, 'MOCEL', 'GELATI', '33-403', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52710220');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (199, 'MOCEL', 'IGNACIO ESTEVA', '107-003', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52782603');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (200, 'ASOC ASIST PRIV OCE', 'TIBURCIO MONTIEL', '81', '', 'SN MIGUEL CHAP', '11800', 'MIGUEL HIDALGO', '', '52737347');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (201, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (202, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (203, 'MOCEL', 'GELATI', '29-1202', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52782341');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (204, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '55169577');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (205, 'MOCEL', 'I ESTEVA', '107-104', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (206, 'MOCEL', 'GELATI', '29-403', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (207, 'MOCEL', 'GELATI', '29-PB', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (208, 'MOCEL', 'GELATI', '29- ANEXO 16', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52710773');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (209, 'MOCEL', 'I ESTEVA', '107-101', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (210, 'MOCEL', 'I ESTEVA', '107-002', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (211, 'MOCEL', 'I ESTEVA', '107-108', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (212, 'CONSULTORIO', 'RAFAEL REBOLLAR', '81', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (213, 'MOCEL', 'IGNACIO ESTEVA', '107-106', '', 'SAN MIGUEL CHAPULTEPEC', '11850', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (214, 'MOCEL', 'GELATI', '29-210', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (215, 'MOCEL', 'I ESTEVA', '107-001', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (216, 'MOCEL', 'I ESTEVA', '107-103', '', 'SAN MIGUELCH', '11800', 'MIGUEL HIDALGO', '', '52782300');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (217, 'ASOC ASIST PRIV OCE', 'TIBURCIO MONTIEL', '81', '', 'SN MIGUEL CHAP', '11800', 'MIGUEL HIDALGO', '', '52737347');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (218, 'ABC OBSERVATORIO', 'SUR 132', '108-602', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5272-0651');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (219, 'ABC OBSERVATORIO', 'SUR 132', '108-305', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5515-3647');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (220, 'ABC OBSERVATORIO', 'SUR 136 ', '116-415', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52762727');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (221, 'ABC OBSERVATORIO', 'SUR 136', '116-508', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5230-8000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (222, 'ABC OBSERVATORIO', 'SUR 132', '108-408', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5272-1309');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (223, 'ABC OBSERVATORIO', 'SUR 136 ', '116-501', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52723241');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (224, 'ABC OBSERVATORIO', 'SUR 136', '116-501', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52723241');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (225, 'ABC OBSERVATORIO', 'SUR 136', '116-517', '', 'LAS AMERICAS', '11800', 'MIGUEL HIDALGO', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (226, 'ABC OBSERVATORIO', 'SUR 136', '116-501', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (227, 'ABC OBSERVATORIO', 'SUR 136', '116-511', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (228, 'ABC OBSERVATORIO', 'SUR 136', '116-501', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (229, 'ABC OBSERVATORIO', 'SUR 132', '118-303', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52718001');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (230, 'ABC OBSERVATORIO', 'SUR 136', '116-511', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (231, 'ABC OBSERVATORIO', 'SUR 132 ', '108-308', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (232, 'ABC OBSERVATORIO', 'SUR 136', '116-C-ONCO 202', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5230-8000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (233, 'ABC OBSERVATORIO', 'SUR 136', '116 -201', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (234, 'H   DIOMED', 'AV.OBSERVATORIO', '354', '', 'DIECISEIS SEPT', '11800', 'MIGUEL HIDALGO', '', '91594000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (235, 'ABC OBSERVATORIO', 'SUR 136', '116-CONSUL2 EDIF.C', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (236, 'ABC OBSERVATORIO', 'SUR 136', '116-PISO 3', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5230-8000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (237, 'ABC OBSERVATORIO', 'SUR 136', '116 - 511', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5271-8999');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (238, 'ABC OBSERVATORIO', 'SUR 136', '116-511', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (239, 'ABC OBSERVATORIO', 'SUR 132', '116-307', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5271-8999');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (240, 'H   DIOMED', 'AV.OBSERVATORIO', '354', '', 'DIECISEIS SEPT', '11800', 'MIGUEL HIDALGO', '', '91594000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (241, 'ABC OBSERVATORIO', 'SUR 136', '116-411', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (242, 'ABC OBSERVATORIO', 'SUR 136', '116-504', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (243, 'ABC OBSERVATORIO', 'SUR 132', '108- 602', '', 'LAS AMERICAS', '112', 'ALVARO OBREGON', '', '52620651');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (244, 'ABC OBSERVATORIO', 'SUR 136', '116-515', '', 'LAS AMERICAS', '11800', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (245, 'ABC OBSERVATORIO', 'SUR 136', '116-504', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (246, 'ABC OBSERVATORIO', 'SUR 136', '116-CONSUL-504', '', 'LAS AMERICAS', '1120', 'ALVARO OBREGON', '', '5230-8000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (247, 'ABC OBSERVATORIO', 'SUR 136', '118-304', '', 'LAS AMERICAS', '11800', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (248, 'ABC OBSERVATORIO', 'SUR 132 Y OBSERV', '116PISO1PFUERA', '', 'LAS AMERICAS', '11800', 'ALVARO OBREGON', '', '52308000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (249, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-CONSUL-207', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7012');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (250, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G330', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7201');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (251, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-106', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '5230-8246');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (252, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G339', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (253, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-405', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (254, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G336', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7249');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (255, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-C-402', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (256, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G333', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (257, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-408', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (258, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G336', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7196');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (259, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-406', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (260, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G339', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7208');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (261, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G330', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (262, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-406', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (263, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-417', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (264, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G340', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (265, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G336', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7196');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (266, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G331', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (267, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G333', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7235');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (268, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G330', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (269, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G330', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (270, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-406', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (271, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-108', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7080');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (272, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G331', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (273, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-222', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7151');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (274, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-417', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (275, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-G336', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '1664-7196');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (276, 'ABC STA. FÉ', 'AV. CARLOS GRAEF FERNANDEZ', '154-402', '', 'TLAXALA SANTAFE', '5300', 'CUAJIMALPA DE MORELOS', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (277, 'H. DE MÈXICO', 'AGRARISMO', '208-653B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (278, 'H. DE MÈXICO', 'AGRARISMO', '208-505A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169662');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (279, 'H. DE MÈXICO', 'AGRARISMO', '208-601A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52726211');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (280, 'H. DE MÈXICO', 'AGRARISMO', '208-557 Y 558', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52762847');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (281, 'H. DE MÈXICO', 'AGRARISMO', '208-407A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (282, 'H. DE MÈXICO', 'AGRARISMO', '208-561B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (283, 'H. DE MÈXICO', 'AGRARISMO', '208-801A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '53731230');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (284, 'H. DE MÈXICO', 'AGRARISMO', '208-901', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '53731230');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (285, 'H. DE MÈXICO', 'AGRARISMO', '208-954B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (286, 'CONSULTORIO', 'UNION Y MARTI', '', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', 'PENDIENTE');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (287, 'H. DE MÈXICO', 'AGRARISMO', '208-954B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '5271-5844');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (288, 'H. DE MÈXICO', 'AGRARISMO', '208-608A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169700');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (289, 'H. DE MÈXICO', 'AGRARISMO', '208-555B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (290, 'H. DE MÈXICO', 'AGRARISMO', '208-103A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52732130');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (291, 'H. DE MÈXICO', 'AGRARISMO', '208-501A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55166508');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (292, 'H. DE MÈXICO', 'AGRARISMO', '208-909 O URG ', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (293, 'H. DE MÈXICO', 'AGRARISMO', '208-954B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (294, 'H. DE MÈXICO', 'AGRARISMO', '208-905A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52773146');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (295, 'H. DE MÈXICO', 'AGRARISMO', '208-560B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52762000');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (296, 'H. DE MÈXICO', 'AGRARISMO', '208-651B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '51711240');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (297, 'H. DE MÈXICO', 'AGRARISMO', '208-606', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52731470');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (298, 'H. DE MÈXICO', 'AGRARISMO', '208-408A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55847184');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (299, 'H. DE MÈXICO', 'AGRARISMO', '208-854B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55847184');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (300, 'H. DE MÈXICO', 'AGRARISMO', '208-653B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169820');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (301, 'H. DE MÈXICO', 'AGRARISMO', '208-854B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (302, 'H. DE MÈXICO', 'AGRARISMO', '208-952B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (303, 'H. DE MÈXICO', 'AGRARISMO', '208-854B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (304, 'H. DE MÈXICO', 'AGRARISMO', '208-503 A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (305, 'H. DE MÈXICO', 'AGRARISMO', '208-806', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (306, 'H. DE MÈXICO', 'AGRARISMO', '208-806', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (307, 'H. DE MÈXICO', 'AGRARISMO', '208-805B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (308, 'C.ZAR', 'PROGRESO ', '231', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '84888070');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (309, 'H. DE MÈXICO', 'AGRARISMO', '208-554B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '26143869');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (310, 'H. DE MÈXICO', 'AGRARISMO', '208-103', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52762847');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (311, 'H. DE MÈXICO', 'AGRARISMO', '208-103', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169900');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (312, 'H. DE MÈXICO', 'AGRARISMO', '208-2A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52732758');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (313, 'H. DE MÈXICO', 'AGRARISMO', '208-PB', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (314, 'H. DE MÈXICO', 'AGRARISMO', '208-853B', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52729051');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (315, 'H. DE MÈXICO', 'AGRARISMO', '208-601', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (316, 'H. DE MÈXICO', 'AGRARISMO', '208-601', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (317, 'H. DE MÈXICO', 'AGRARISMO', '208-605', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (318, 'H. DE MÈXICO', 'AGRARISMO', '208-608A', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '55169700');
INSERT INTO `sirac`.`ct_sitio` (`id_sitio`, `nombre`, `calle`, `num_exterior`, `num_interior`, `colonia`, `cp`, `delegacion`, `estado`, `telefono`) VALUES (319, 'CONSULTORIO', 'AGRARISMO', '31', '', 'ESCANDON', '11800', 'MIGUEL HIDALGO', '', '52733775');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`rl_medico_sitio`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (1, 1, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (2, 2, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (3, 3, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (4, 4, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (5, 5, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (6, 6, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (7, 7, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (8, 8, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (9, 9, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (10, 10, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (11, 11, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (12, 12, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (13, 13, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (14, 14, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (15, 15, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (16, 16, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (17, 17, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (18, 18, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (19, 19, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (20, 20, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (21, 21, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (22, 22, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (23, 23, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (24, 24, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (25, 25, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (26, 26, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (27, 27, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (28, 28, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (29, 29, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (30, 30, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (31, 31, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (32, 32, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (33, 33, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (34, 34, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (35, 35, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (36, 36, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (37, 37, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (38, 38, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (39, 39, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (40, 40, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (41, 41, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (42, 42, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (43, 43, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (44, 44, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (45, 45, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (46, 46, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (47, 47, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (48, 48, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (49, 49, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (50, 50, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (51, 51, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (52, 52, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (53, 53, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (54, 54, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (55, 55, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (56, 56, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (57, 57, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (58, 58, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (59, 59, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (60, 60, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (61, 61, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (62, 62, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (63, 63, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (64, 64, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (65, 65, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (66, 66, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (67, 67, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (68, 68, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (69, 69, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (70, 70, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (71, 71, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (72, 72, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (73, 73, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (74, 74, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (75, 75, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (76, 76, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (77, 77, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (78, 78, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (79, 79, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (80, 80, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (81, 81, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (82, 82, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (83, 83, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (84, 84, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (85, 85, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (86, 86, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (87, 87, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (88, 88, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (89, 89, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (90, 90, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (91, 91, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (92, 92, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (93, 93, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (94, 94, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (95, 95, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (96, 96, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (97, 97, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (98, 98, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (99, 99, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (100, 100, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (101, 101, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (102, 102, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (103, 103, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (104, 104, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (105, 105, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (106, 106, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (107, 107, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (108, 108, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (109, 109, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (110, 110, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (111, 111, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (112, 112, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (113, 113, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (114, 114, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (115, 115, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (116, 116, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (117, 117, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (118, 118, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (119, 119, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (120, 120, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (121, 121, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (122, 122, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (123, 123, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (124, 124, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (125, 125, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (126, 126, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (127, 127, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (128, 128, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (129, 129, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (130, 130, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (131, 131, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (132, 132, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (133, 133, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (134, 134, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (135, 135, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (136, 136, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (137, 137, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (138, 138, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (139, 139, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (140, 140, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (141, 141, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (142, 142, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (143, 143, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (144, 144, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (145, 145, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (146, 146, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (147, 147, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (148, 148, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (149, 149, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (150, 150, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (151, 151, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (152, 152, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (153, 153, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (154, 154, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (155, 155, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (156, 156, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (157, 157, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (158, 158, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (159, 159, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (160, 160, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (161, 161, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (162, 162, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (163, 163, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (164, 164, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (165, 165, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (166, 166, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (167, 167, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (168, 168, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (169, 169, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (170, 170, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (171, 171, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (172, 172, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (173, 173, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (174, 174, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (175, 175, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (176, 176, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (177, 177, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (178, 178, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (179, 179, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (180, 180, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (181, 181, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (182, 182, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (183, 183, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (184, 184, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (185, 185, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (186, 186, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (187, 187, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (188, 188, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (189, 189, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (190, 190, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (191, 191, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (192, 192, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (193, 193, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (194, 194, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (195, 195, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (196, 196, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (197, 197, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (198, 198, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (199, 199, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (200, 200, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (201, 201, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (202, 202, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (203, 203, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (204, 204, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (205, 205, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (206, 206, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (207, 207, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (208, 208, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (209, 209, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (210, 210, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (211, 211, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (212, 212, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (213, 213, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (214, 214, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (215, 215, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (216, 216, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (217, 217, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (218, 218, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (219, 219, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (220, 220, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (221, 221, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (222, 222, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (223, 223, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (224, 224, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (225, 225, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (226, 226, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (227, 227, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (228, 228, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (229, 229, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (230, 230, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (231, 231, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (232, 232, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (233, 233, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (234, 234, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (235, 235, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (236, 236, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (237, 237, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (238, 238, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (239, 239, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (240, 240, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (241, 241, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (242, 242, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (243, 243, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (244, 244, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (245, 245, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (246, 246, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (247, 247, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (248, 248, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (249, 249, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (250, 250, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (251, 251, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (252, 252, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (253, 253, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (254, 254, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (255, 255, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (256, 256, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (257, 257, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (258, 258, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (259, 259, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (260, 260, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (261, 261, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (262, 262, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (263, 263, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (264, 264, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (265, 265, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (266, 266, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (267, 267, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (268, 268, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (269, 269, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (270, 270, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (271, 271, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (272, 272, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (273, 273, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (274, 274, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (275, 275, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (276, 276, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (277, 277, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (278, 278, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (279, 279, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (280, 280, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (281, 281, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (282, 282, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (283, 283, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (284, 284, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (285, 285, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (286, 286, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (287, 287, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (288, 288, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (289, 289, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (290, 290, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (291, 291, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (292, 292, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (293, 293, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (294, 294, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (295, 295, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (296, 296, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (297, 297, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (298, 298, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (299, 299, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (300, 300, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (301, 301, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (302, 302, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (303, 303, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (304, 304, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (305, 305, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (306, 306, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (307, 307, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (308, 308, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (309, 309, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (310, 310, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (311, 311, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (312, 312, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (313, 313, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (314, 314, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (315, 315, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (316, 316, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (317, 317, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (318, 318, NULL, 0);
INSERT INTO `sirac`.`rl_medico_sitio` (`id_medico`, `id_sitio`, `telefono_consultorio`, `farmacia`) VALUES (319, 319, NULL, 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_potencial`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_potencial` (`id_potencial`, `descripcion`) VALUES ('AA', 'C. PLASTICO, ANGIÓLOGO, DERMATÓLOGO, MG (ULCERAS PIE DIABÉTICO)');
INSERT INTO `sirac`.`ct_potencial` (`id_potencial`, `descripcion`) VALUES ('A', 'TRAUMATÓLOGO, GINECO OBSTETRA, MI (PIE DIABÉTICO), M CIRUJANO (POT. POR N°  DE CIRUGIAS)');
INSERT INTO `sirac`.`ct_potencial` (`id_potencial`, `descripcion`) VALUES ('B', 'CIRUJÁNOS GENERALES, GINECÓLOGOS, GASTROS, ONCÓLOGO.');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_dia_semana`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (1, 'L', 'Lunes');
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (2, 'M', 'Martes');
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (3, 'W', 'Miércoles');
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (4, 'J', 'Jueves');
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (5, 'V', 'Viernes');
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (6, 'S', 'Sábado');
INSERT INTO `sirac`.`ct_dia_semana` (`id_semana`, `abreviatura`, `dia`) VALUES (7, 'D', 'Domingo');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_plan_trabajo`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (1, 'ivoyahir', 1, 1, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (2, 'ivoyahir', 2, 2, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (3, 'ivoyahir', 3, 3, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (4, 'ivoyahir', 4, 4, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (5, 'ivoyahir', 5, 5, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (6, 'ivoyahir', 6, 6, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (7, 'ivoyahir', 7, 7, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (8, 'ivoyahir', 8, 8, 1, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (9, 'ivoyahir', 9, 9, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (10, 'ivoyahir', 10, 10, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (11, 'ivoyahir', 11, 11, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (12, 'ivoyahir', 12, 12, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (13, 'ivoyahir', 13, 13, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (14, 'ivoyahir', 14, 14, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (15, 'ivoyahir', 15, 15, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (16, 'ivoyahir', 16, 16, 1, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (17, 'ivoyahir', 17, 17, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (18, 'ivoyahir', 18, 18, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (19, 'ivoyahir', 19, 19, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (20, 'ivoyahir', 20, 20, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (21, 'ivoyahir', 21, 21, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (22, 'ivoyahir', 22, 22, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (23, 'ivoyahir', 23, 23, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (24, 'ivoyahir', 24, 24, 1, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (25, 'ivoyahir', 25, 25, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (26, 'ivoyahir', 26, 26, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (27, 'ivoyahir', 27, 27, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (28, 'ivoyahir', 28, 28, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (29, 'ivoyahir', 29, 29, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (30, 'ivoyahir', 30, 30, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (31, 'ivoyahir', 31, 31, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (32, 'ivoyahir', 32, 32, 1, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (33, 'ivoyahir', 33, 33, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (34, 'ivoyahir', 34, 34, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (35, 'ivoyahir', 35, 35, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (36, 'ivoyahir', 36, 36, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (37, 'ivoyahir', 37, 37, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (38, 'ivoyahir', 38, 38, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (39, 'ivoyahir', 39, 39, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (40, 'ivoyahir', 40, 40, 1, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (41, 'ivoyahir', 41, 41, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (42, 'ivoyahir', 42, 42, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (43, 'ivoyahir', 43, 43, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (44, 'ivoyahir', 44, 44, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (45, 'ivoyahir', 45, 45, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (46, 'ivoyahir', 46, 46, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (47, 'ivoyahir', 47, 47, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (48, 'ivoyahir', 48, 48, 2, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (49, 'ivoyahir', 49, 49, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (50, 'ivoyahir', 50, 50, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (51, 'ivoyahir', 51, 51, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (52, 'ivoyahir', 52, 52, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (53, 'ivoyahir', 53, 53, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (54, 'ivoyahir', 54, 54, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (55, 'ivoyahir', 55, 55, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (56, 'ivoyahir', 56, 56, 2, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (57, 'ivoyahir', 57, 57, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (58, 'ivoyahir', 58, 58, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (59, 'ivoyahir', 59, 59, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (60, 'ivoyahir', 60, 60, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (61, 'ivoyahir', 61, 61, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (62, 'ivoyahir', 62, 62, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (63, 'ivoyahir', 63, 63, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (64, 'ivoyahir', 64, 64, 2, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (65, 'ivoyahir', 65, 65, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (66, 'ivoyahir', 66, 66, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (67, 'ivoyahir', 67, 67, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (68, 'ivoyahir', 68, 68, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (69, 'ivoyahir', 69, 69, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (70, 'ivoyahir', 70, 70, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (71, 'ivoyahir', 71, 71, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (72, 'ivoyahir', 72, 72, 2, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (73, 'ivoyahir', 73, 73, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (74, 'ivoyahir', 74, 74, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (75, 'ivoyahir', 75, 75, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (76, 'ivoyahir', 76, 76, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (77, 'ivoyahir', 77, 77, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (78, 'ivoyahir', 78, 78, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (79, 'ivoyahir', 79, 79, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (80, 'ivoyahir', 80, 80, 2, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (81, 'ivoyahir', 81, 81, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (82, 'ivoyahir', 82, 82, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (83, 'ivoyahir', 83, 83, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (84, 'ivoyahir', 84, 84, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (85, 'ivoyahir', 85, 85, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (86, 'ivoyahir', 86, 86, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (87, 'ivoyahir', 87, 87, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (88, 'ivoyahir', 88, 88, 3, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (89, 'ivoyahir', 89, 89, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (90, 'ivoyahir', 90, 90, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (91, 'ivoyahir', 91, 91, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (92, 'ivoyahir', 92, 92, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (93, 'ivoyahir', 93, 93, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (94, 'ivoyahir', 94, 94, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (95, 'ivoyahir', 95, 95, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (96, 'ivoyahir', 96, 96, 3, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (97, 'ivoyahir', 97, 97, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (98, 'ivoyahir', 98, 98, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (99, 'ivoyahir', 99, 99, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (100, 'ivoyahir', 100, 100, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (101, 'ivoyahir', 101, 101, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (102, 'ivoyahir', 102, 102, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (103, 'ivoyahir', 103, 103, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (104, 'ivoyahir', 104, 104, 3, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (105, 'ivoyahir', 105, 105, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (106, 'ivoyahir', 106, 106, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (107, 'ivoyahir', 107, 107, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (108, 'ivoyahir', 108, 108, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (109, 'ivoyahir', 109, 109, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (110, 'ivoyahir', 110, 110, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (111, 'ivoyahir', 111, 111, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (112, 'ivoyahir', 112, 112, 3, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (113, 'ivoyahir', 113, 113, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (114, 'ivoyahir', 114, 114, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (115, 'ivoyahir', 115, 115, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (116, 'ivoyahir', 116, 116, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (117, 'ivoyahir', 117, 117, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (118, 'ivoyahir', 118, 118, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (119, 'ivoyahir', 119, 119, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (120, 'ivoyahir', 120, 120, 3, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (121, 'ivoyahir', 121, 121, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (122, 'ivoyahir', 122, 122, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (123, 'ivoyahir', 123, 123, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (124, 'ivoyahir', 124, 124, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (125, 'ivoyahir', 125, 125, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (126, 'ivoyahir', 126, 126, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (127, 'ivoyahir', 127, 127, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (128, 'ivoyahir', 128, 128, 4, 1, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (129, 'ivoyahir', 129, 129, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (130, 'ivoyahir', 130, 130, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (131, 'ivoyahir', 131, 131, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (132, 'ivoyahir', 132, 132, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (133, 'ivoyahir', 133, 133, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (134, 'ivoyahir', 134, 134, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (135, 'ivoyahir', 135, 135, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (136, 'ivoyahir', 136, 136, 4, 2, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (137, 'ivoyahir', 137, 137, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (138, 'ivoyahir', 138, 138, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (139, 'ivoyahir', 139, 139, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (140, 'ivoyahir', 140, 140, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (141, 'ivoyahir', 141, 141, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (142, 'ivoyahir', 142, 142, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (143, 'ivoyahir', 143, 143, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (144, 'ivoyahir', 144, 144, 4, 3, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (145, 'ivoyahir', 145, 145, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (146, 'ivoyahir', 146, 146, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (147, 'ivoyahir', 147, 147, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (148, 'ivoyahir', 148, 148, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (149, 'ivoyahir', 149, 149, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (150, 'ivoyahir', 150, 150, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (151, 'ivoyahir', 151, 151, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (152, 'ivoyahir', 152, 152, 4, 4, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (153, 'ivoyahir', 153, 153, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (154, 'ivoyahir', 154, 154, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (155, 'ivoyahir', 155, 155, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (156, 'ivoyahir', 156, 156, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (157, 'ivoyahir', 157, 157, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (158, 'ivoyahir', 158, 158, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (159, 'ivoyahir', 159, 159, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (160, 'ivoyahir', 160, 160, 4, 5, 201);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (161, 'irvingl', 161, 161, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (162, 'irvingl', 162, 162, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (163, 'irvingl', 163, 163, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (164, 'irvingl', 164, 164, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (165, 'irvingl', 165, 165, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (166, 'irvingl', 166, 166, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (167, 'irvingl', 167, 167, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (168, 'irvingl', 168, 168, 1, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (169, 'irvingl', 169, 169, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (170, 'irvingl', 170, 170, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (171, 'irvingl', 171, 171, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (172, 'irvingl', 172, 172, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (173, 'irvingl', 173, 173, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (174, 'irvingl', 174, 174, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (175, 'irvingl', 175, 175, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (176, 'irvingl', 176, 176, 1, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (177, 'irvingl', 177, 177, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (178, 'irvingl', 178, 178, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (179, 'irvingl', 179, 179, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (180, 'irvingl', 180, 180, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (181, 'irvingl', 181, 181, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (182, 'irvingl', 182, 182, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (183, 'irvingl', 183, 183, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (184, 'irvingl', 184, 184, 1, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (185, 'irvingl', 185, 185, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (186, 'irvingl', 186, 186, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (187, 'irvingl', 187, 187, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (188, 'irvingl', 188, 188, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (189, 'irvingl', 189, 189, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (190, 'irvingl', 190, 190, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (191, 'irvingl', 191, 191, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (192, 'irvingl', 192, 192, 1, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (193, 'irvingl', 193, 193, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (194, 'irvingl', 194, 194, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (195, 'irvingl', 195, 195, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (196, 'irvingl', 196, 196, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (197, 'irvingl', 197, 197, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (198, 'irvingl', 198, 198, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (199, 'irvingl', 199, 199, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (200, 'irvingl', 200, 200, 1, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (201, 'irvingl', 201, 201, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (202, 'irvingl', 202, 202, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (203, 'irvingl', 203, 203, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (204, 'irvingl', 204, 204, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (205, 'irvingl', 205, 205, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (206, 'irvingl', 206, 206, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (207, 'irvingl', 207, 207, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (208, 'irvingl', 208, 208, 2, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (209, 'irvingl', 209, 209, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (210, 'irvingl', 210, 210, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (211, 'irvingl', 211, 211, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (212, 'irvingl', 212, 212, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (213, 'irvingl', 213, 213, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (214, 'irvingl', 214, 214, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (215, 'irvingl', 215, 215, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (216, 'irvingl', 216, 216, 2, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (217, 'irvingl', 217, 217, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (218, 'irvingl', 218, 218, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (219, 'irvingl', 219, 219, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (220, 'irvingl', 220, 220, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (221, 'irvingl', 221, 221, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (222, 'irvingl', 222, 222, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (223, 'irvingl', 223, 223, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (224, 'irvingl', 224, 224, 2, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (225, 'irvingl', 225, 225, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (226, 'irvingl', 226, 226, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (227, 'irvingl', 227, 227, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (228, 'irvingl', 228, 228, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (229, 'irvingl', 229, 229, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (230, 'irvingl', 230, 230, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (231, 'irvingl', 231, 231, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (232, 'irvingl', 232, 232, 2, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (233, 'irvingl', 233, 233, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (234, 'irvingl', 234, 234, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (235, 'irvingl', 235, 235, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (236, 'irvingl', 236, 236, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (237, 'irvingl', 237, 237, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (238, 'irvingl', 238, 238, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (239, 'irvingl', 239, 239, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (240, 'irvingl', 240, 240, 2, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (241, 'irvingl', 241, 241, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (242, 'irvingl', 242, 242, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (243, 'irvingl', 243, 243, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (244, 'irvingl', 244, 244, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (245, 'irvingl', 245, 245, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (246, 'irvingl', 246, 246, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (247, 'irvingl', 247, 247, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (248, 'irvingl', 248, 248, 3, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (249, 'irvingl', 249, 249, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (250, 'irvingl', 250, 250, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (251, 'irvingl', 251, 251, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (252, 'irvingl', 252, 252, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (253, 'irvingl', 253, 253, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (254, 'irvingl', 254, 254, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (255, 'irvingl', 255, 255, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (256, 'irvingl', 256, 256, 3, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (257, 'irvingl', 257, 257, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (258, 'irvingl', 258, 258, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (259, 'irvingl', 259, 259, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (260, 'irvingl', 260, 260, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (261, 'irvingl', 261, 261, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (262, 'irvingl', 262, 262, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (263, 'irvingl', 263, 263, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (264, 'irvingl', 264, 264, 3, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (265, 'irvingl', 265, 265, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (266, 'irvingl', 266, 266, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (267, 'irvingl', 267, 267, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (268, 'irvingl', 268, 268, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (269, 'irvingl', 269, 269, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (270, 'irvingl', 270, 270, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (271, 'irvingl', 271, 271, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (272, 'irvingl', 272, 272, 3, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (273, 'irvingl', 273, 273, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (274, 'irvingl', 274, 274, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (275, 'irvingl', 275, 275, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (276, 'irvingl', 276, 276, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (277, 'irvingl', 277, 277, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (278, 'irvingl', 278, 278, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (279, 'irvingl', 279, 279, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (280, 'irvingl', 280, 280, 3, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (281, 'irvingl', 281, 281, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (282, 'irvingl', 282, 282, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (283, 'irvingl', 283, 283, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (284, 'irvingl', 284, 284, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (285, 'irvingl', 285, 285, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (286, 'irvingl', 286, 286, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (287, 'irvingl', 287, 287, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (288, 'irvingl', 288, 288, 4, 1, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (289, 'irvingl', 289, 289, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (290, 'irvingl', 290, 290, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (291, 'irvingl', 291, 291, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (292, 'irvingl', 292, 292, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (293, 'irvingl', 293, 293, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (294, 'irvingl', 294, 294, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (295, 'irvingl', 295, 295, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (296, 'irvingl', 296, 296, 4, 2, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (297, 'irvingl', 297, 297, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (298, 'irvingl', 298, 298, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (299, 'irvingl', 299, 299, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (300, 'irvingl', 300, 300, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (301, 'irvingl', 301, 301, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (302, 'irvingl', 302, 302, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (303, 'irvingl', 303, 303, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (304, 'irvingl', 304, 304, 4, 3, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (305, 'irvingl', 305, 305, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (306, 'irvingl', 306, 306, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (307, 'irvingl', 307, 307, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (308, 'irvingl', 308, 308, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (309, 'irvingl', 309, 309, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (310, 'irvingl', 310, 310, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (311, 'irvingl', 311, 311, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (312, 'irvingl', 312, 312, 4, 4, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (313, 'irvingl', 313, 313, 4, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (314, 'irvingl', 314, 314, 4, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (315, 'irvingl', 315, 315, 4, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (316, 'irvingl', 316, 316, 4, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (317, 'irvingl', 317, 317, 4, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (318, 'irvingl', 318, 318, 4, 5, 109);
INSERT INTO `sirac`.`ct_plan_trabajo` (`id_plan_trabajo`, `id_usuario`, `id_medico`, `id_sitio`, `semana`, `id_dia`, `territorio`) VALUES (319, 'irvingl', 319, 319, 4, 5, 109);

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_prescriptor`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_prescriptor` (`id_prescritor`, `tipo_prescriptor`) VALUES (1, 'Muy alta');
INSERT INTO `sirac`.`ct_prescriptor` (`id_prescritor`, `tipo_prescriptor`) VALUES (2, 'Alta');
INSERT INTO `sirac`.`ct_prescriptor` (`id_prescritor`, `tipo_prescriptor`) VALUES (3, 'Media');
INSERT INTO `sirac`.`ct_prescriptor` (`id_prescritor`, `tipo_prescriptor`) VALUES (4, 'Baja');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_ciclo`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('1', '2013-10-07', '2013-11-03');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('2', '2013-11-04', '2013-12-01');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('3', '2013-12-02', '2013-12-29');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('4', '2013-12-30', '2014-01-26');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('5', '2014-01-27', '2014-02-23');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('6', '2014-02-24', '2014-03-23');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('7', '2014-03-24', '2014-04-20');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('8', '2014-04-21', '2014-05-18');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('9', '2014-05-19', '2014-06-15');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('10', '2014-06-16', '2014-07-13');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('11', '2014-07-14', '2014-08-10');
INSERT INTO `sirac`.`ct_ciclo` (`id_ciclo`, `fecha_inicio`, `fecha_termino`) VALUES ('12', '2014-08-11', '2014-09-07');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`rl_medico_representante`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (1, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (2, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (3, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (4, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (5, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (6, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (7, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (8, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (9, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (10, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (11, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (12, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (13, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (14, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (15, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (16, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (17, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (18, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (19, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (20, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (21, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (22, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (23, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (24, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (25, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (26, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (27, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (28, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (29, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (30, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (31, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (32, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (33, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (34, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (35, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (36, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (37, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (38, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (39, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (40, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (41, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (42, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (43, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (44, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (45, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (46, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (47, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (48, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (49, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (50, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (51, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (52, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (53, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (54, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (55, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (56, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (57, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (58, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (59, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (60, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (61, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (62, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (63, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (64, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (65, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (66, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (67, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (68, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (69, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (70, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (71, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (72, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (73, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (74, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (75, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (76, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (77, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (78, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (79, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (80, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (81, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (82, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (83, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (84, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (85, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (86, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (87, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (88, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (89, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (90, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (91, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (92, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (93, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (94, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (95, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (96, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (97, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (98, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (99, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (100, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (101, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (102, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (103, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (104, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (105, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (106, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (107, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (108, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (109, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (110, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (111, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (112, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (113, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (114, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (115, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (116, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (117, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (118, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (119, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (120, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (121, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (122, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (123, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (124, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (125, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (126, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (127, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (128, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (129, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (130, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (131, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (132, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (133, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (134, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (135, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (136, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (137, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (138, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (139, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (140, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (141, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (142, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (143, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (144, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (145, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (146, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (147, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (148, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (149, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (150, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (151, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (152, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (153, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (154, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (155, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (156, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (157, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (158, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (159, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (160, 'irvingl');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (161, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (162, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (163, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (164, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (165, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (166, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (167, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (168, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (169, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (170, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (171, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (172, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (173, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (174, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (175, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (176, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (177, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (178, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (179, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (180, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (181, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (182, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (183, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (184, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (185, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (186, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (187, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (188, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (189, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (190, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (191, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (192, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (193, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (194, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (195, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (196, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (197, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (198, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (199, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (200, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (201, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (202, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (203, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (204, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (205, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (206, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (207, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (208, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (209, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (210, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (211, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (212, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (213, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (214, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (215, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (216, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (217, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (218, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (219, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (220, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (221, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (222, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (223, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (224, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (225, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (226, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (227, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (228, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (229, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (230, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (231, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (232, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (233, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (234, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (235, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (236, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (237, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (238, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (239, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (240, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (241, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (242, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (243, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (244, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (245, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (246, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (247, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (248, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (249, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (250, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (251, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (252, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (253, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (254, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (255, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (256, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (257, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (258, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (259, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (260, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (261, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (262, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (263, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (264, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (265, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (266, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (267, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (268, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (269, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (270, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (271, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (272, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (273, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (274, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (275, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (276, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (277, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (278, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (279, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (280, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (281, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (282, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (283, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (284, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (285, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (286, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (287, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (288, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (289, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (290, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (291, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (292, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (293, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (294, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (295, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (296, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (297, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (298, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (299, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (300, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (301, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (302, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (303, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (304, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (305, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (306, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (307, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (308, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (309, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (310, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (311, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (312, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (313, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (314, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (315, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (316, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (317, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (318, 'ivoyahir');
INSERT INTO `sirac`.`rl_medico_representante` (`id_medico`, `usuario`) VALUES (319, 'ivoyahir');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_medicina`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_medicina` (`id_medicina`, `nombre`, `descripcion`) VALUES (1, 'Zaxcell', 'Zaxcell');
INSERT INTO `sirac`.`ct_medicina` (`id_medicina`, `nombre`, `descripcion`) VALUES (2, 'Kitoscell', 'Kitoscell');
INSERT INTO `sirac`.`ct_medicina` (`id_medicina`, `nombre`, `descripcion`) VALUES (3, 'Accua Asceptic', 'Accua Asceptic');
INSERT INTO `sirac`.`ct_medicina` (`id_medicina`, `nombre`, `descripcion`) VALUES (4, 'TricClean', 'TricClean');

COMMIT;

-- -----------------------------------------------------
-- Data for table `sirac`.`ct_presentacion`
-- -----------------------------------------------------
START TRANSACTION;
USE `sirac`;
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (1, 1, 'Gel', '30 Grs');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (2, 1, 'Gel', '5 Grs');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (3, 2, 'Tubo', '10 Gr.');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (4, 2, 'Tubo', '30 Gr.');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (5, 2, 'Tubo', '60 Gr.');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (6, 3, 'Gel', '30 Gr.');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (7, 3, 'Spray', '240 Ml.');
INSERT INTO `sirac`.`ct_presentacion` (`id_presentacion`, `id_medicina`, `tipo_presentacion`, `dosis`) VALUES (8, 4, 'Mousse', '50 ml');

COMMIT;
