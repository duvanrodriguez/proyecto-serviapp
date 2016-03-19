-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ServiApp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ServiApp` ;

-- -----------------------------------------------------
-- Schema ServiApp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ServiApp` DEFAULT CHARACTER SET utf8 ;
USE `ServiApp` ;

-- -----------------------------------------------------
-- Table `ServiApp`.`PAISES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`PAISES` (
  `id_pais` VARCHAR(3) NOT NULL,
  `nombre_pais` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`DEPARTAMENTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`DEPARTAMENTOS` (
  `id_departamento` INT NOT NULL,
  `nombre_departamento` VARCHAR(60) NOT NULL,
  `id_pais` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id_departamento`),
  CONSTRAINT `fk_DEPARTAMENTOS_PAISES1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `ServiApp`.`PAISES` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEPARTAMENTOS_PAISES1_idx` ON `ServiApp`.`DEPARTAMENTOS` (`id_pais` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`CIUDADES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`CIUDADES` (
  `id_ciudad` INT NOT NULL,
  `nombre_ciudad` VARCHAR(60) NOT NULL,
  `id_departamento` INT NOT NULL,
  PRIMARY KEY (`id_ciudad`, `id_departamento`),
  CONSTRAINT `fk_CIUDADES_DEPARTAMENTOS1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `ServiApp`.`DEPARTAMENTOS` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_CIUDADES_DEPARTAMENTOS1_idx` ON `ServiApp`.`CIUDADES` (`id_departamento` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`TIPOS_SERVICIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`TIPOS_SERVICIOS` (
  `id_tipo_servicio` TINYINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_tipo_servicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`TIPO_DOCUMENTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`TIPO_DOCUMENTOS` (
  `id_tipo_documento` VARCHAR(3) NOT NULL,
  `nombre_documento` VARCHAR(35) NOT NULL,
  PRIMARY KEY (`id_tipo_documento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`USUARIOS` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(40) NOT NULL,
  `apellidos` VARCHAR(40) NOT NULL,
  `telefono` VARCHAR(16) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `id_ciudad` INT NOT NULL,
  `id_departamento` INT NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `sexo` CHAR NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `foto_perfil` LONGBLOB NULL,
  `id_tipo_documento` VARCHAR(3) NOT NULL,
  `numero_documento` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_USUARIOS_CIUDADES1`
    FOREIGN KEY (`id_ciudad` , `id_departamento`)
    REFERENCES `ServiApp`.`CIUDADES` (`id_ciudad` , `id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIOS_TIPO_DOCUMENTOS1`
    FOREIGN KEY (`id_tipo_documento`)
    REFERENCES `ServiApp`.`TIPO_DOCUMENTOS` (`id_tipo_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_USUARIOS_CIUDADES1_idx` ON `ServiApp`.`USUARIOS` (`id_ciudad` ASC, `id_departamento` ASC);

CREATE INDEX `fk_USUARIOS_TIPO_DOCUMENTOS1_idx` ON `ServiApp`.`USUARIOS` (`id_tipo_documento` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`SERVICIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`SERVICIOS` (
  `id_servicio` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `valor` DOUBLE NOT NULL,
  `id_tipo_servicio` TINYINT NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_servicio`),
  CONSTRAINT `fk_SERVICIOS_TIPOSSERVICIO1`
    FOREIGN KEY (`id_tipo_servicio`)
    REFERENCES `ServiApp`.`TIPOS_SERVICIOS` (`id_tipo_servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SERVICIOS_USUARIOS1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ServiApp`.`USUARIOS` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_SERVICIOS_TIPOSSERVICIO1_idx` ON `ServiApp`.`SERVICIOS` (`id_tipo_servicio` ASC);

CREATE INDEX `fk_SERVICIOS_USUARIOS1_idx` ON `ServiApp`.`SERVICIOS` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`CALIFICACIONES_SERVICIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`CALIFICACIONES_SERVICIOS` (
  `id_calificacion` INT NOT NULL,
  `puntuacion` TINYINT NOT NULL,
  `comentario` VARCHAR(140) NULL,
  `fecha` DATE NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_servicio` INT NOT NULL,
  PRIMARY KEY (`id_calificacion`),
  CONSTRAINT `fk_CALIFICACIONES_SERVICIOS_USUARIOS1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ServiApp`.`USUARIOS` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CALIFICACIONES_SERVICIOS_SERVICIOS1`
    FOREIGN KEY (`id_servicio`)
    REFERENCES `ServiApp`.`SERVICIOS` (`id_servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_CALIFICACIONES_SERVICIOS_USUARIOS1_idx` ON `ServiApp`.`CALIFICACIONES_SERVICIOS` (`id_usuario` ASC);

CREATE INDEX `fk_CALIFICACIONES_SERVICIOS_SERVICIOS1_idx` ON `ServiApp`.`CALIFICACIONES_SERVICIOS` (`id_servicio` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`ROLES` (
  `id_rol` VARCHAR(10) NOT NULL,
  `nombre_rol` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`ROLES_USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`ROLES_USUARIOS` (
  `id_rol` VARCHAR(10) NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_rol`, `id_usuario`),
  CONSTRAINT `fk_ROLES_has_USUARIOS_ROLES1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `ServiApp`.`ROLES` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ROLES_has_USUARIOS_USUARIOS1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ServiApp`.`USUARIOS` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ROLES_has_USUARIOS_USUARIOS1_idx` ON `ServiApp`.`ROLES_USUARIOS` (`id_usuario` ASC);

CREATE INDEX `fk_ROLES_has_USUARIOS_ROLES1_idx` ON `ServiApp`.`ROLES_USUARIOS` (`id_rol` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`NIVELES_EDUCATIVOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`NIVELES_EDUCATIVOS` (
  `id_nivel_educativo` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_nivel_educativo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`TITULOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`TITULOS` (
  `id_titulo` INT NOT NULL AUTO_INCREMENT,
  `titulo_obtenido` VARCHAR(150) NOT NULL,
  `fecha_terminacion` DATE NOT NULL,
  `institucion` VARCHAR(45) NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_nivel_educativo` INT NOT NULL,
  PRIMARY KEY (`id_titulo`),
  CONSTRAINT `fk_TITULOS_USUARIOS1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ServiApp`.`USUARIOS` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TITULOS_NIVELES_EDUCATIVOS1`
    FOREIGN KEY (`id_nivel_educativo`)
    REFERENCES `ServiApp`.`NIVELES_EDUCATIVOS` (`id_nivel_educativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TITULOS_USUARIOS1_idx` ON `ServiApp`.`TITULOS` (`id_usuario` ASC);

CREATE INDEX `fk_TITULOS_NIVELES_EDUCATIVOS1_idx` ON `ServiApp`.`TITULOS` (`id_nivel_educativo` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`TRABAJOS_REALIZADOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`TRABAJOS_REALIZADOS` (
  `id_trabajo_realizado` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_trabajo_realizado`),
  CONSTRAINT `fk_TRABAJOS_REALIZADOS_USUARIOS1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ServiApp`.`USUARIOS` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TRABAJOS_REALIZADOS_USUARIOS1_idx` ON `ServiApp`.`TRABAJOS_REALIZADOS` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`IMAGENES_TRABAJOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`IMAGENES_TRABAJOS` (
  `id_imagen_trabajo` INT NOT NULL AUTO_INCREMENT,
  `imagen` LONGBLOB NULL,
  `id_trabajo_realizado` INT NOT NULL,
  PRIMARY KEY (`id_imagen_trabajo`),
  CONSTRAINT `fk_IMAGENES_TRABAJOS_TRABAJOS_REALIZADOS1`
    FOREIGN KEY (`id_trabajo_realizado`)
    REFERENCES `ServiApp`.`TRABAJOS_REALIZADOS` (`id_trabajo_realizado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_IMAGENES_TRABAJOS_TRABAJOS_REALIZADOS1_idx` ON `ServiApp`.`IMAGENES_TRABAJOS` (`id_trabajo_realizado` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`FACTURAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`FACTURAS` (
  `num_factura` INT NOT NULL AUTO_INCREMENT,
  `valor_total` FLOAT NOT NULL,
  `fecha` DATE NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`num_factura`),
  CONSTRAINT `fk_FACTURAS_USUARIOS1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ServiApp`.`USUARIOS` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_FACTURAS_USUARIOS1_idx` ON `ServiApp`.`FACTURAS` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`TIPOS_OFERTAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`TIPOS_OFERTAS` (
  `id_tipo_oferta` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_oferta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`OFERTAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`OFERTAS` (
  `id_oferta` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NOT NULL,
  `descuento` VARCHAR(100) NOT NULL,
  `servicio_minimo` INT NOT NULL,
  `dia_minimo` INT NOT NULL,
  `id_tipo_oferta` INT NOT NULL,
  PRIMARY KEY (`id_oferta`, `id_tipo_oferta`),
  CONSTRAINT `fk_OFERTAS_TIPOS_OFERTAS1`
    FOREIGN KEY (`id_tipo_oferta`)
    REFERENCES `ServiApp`.`TIPOS_OFERTAS` (`id_tipo_oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_OFERTAS_TIPOS_OFERTAS1_idx` ON `ServiApp`.`OFERTAS` (`id_tipo_oferta` ASC);


-- -----------------------------------------------------
-- Table `ServiApp`.`COBROS_SERVICIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`COBROS_SERVICIOS` (
  `id_cobro_servicio` INT NOT NULL AUTO_INCREMENT,
  `valor_dia_servicio` FLOAT NULL,
  `descripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`id_cobro_servicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiApp`.`DETALLES_SERVICIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`DETALLES_SERVICIOS` (
  `num_factura` INT NOT NULL,
  `id_cobro_servicio` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `cantidad_dia` INT NOT NULL,
  `cantidad_serviciol` INT NOT NULL,
  `descripcion` VARCHAR(150) NULL,
  `id_oferta` INT NOT NULL,
  `id_tipo_oferta` INT NOT NULL,
  PRIMARY KEY (`num_factura`, `id_cobro_servicio`),
  CONSTRAINT `fk_FACTURAS_has_COBROS_SERVICIOS_FACTURAS1`
    FOREIGN KEY (`num_factura`)
    REFERENCES `ServiApp`.`FACTURAS` (`num_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURAS_has_COBROS_SERVICIOS_COBROS_SERVICIOS1`
    FOREIGN KEY (`id_cobro_servicio`)
    REFERENCES `ServiApp`.`COBROS_SERVICIOS` (`id_cobro_servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk__OFERTAS1`
    FOREIGN KEY (`id_oferta` , `id_tipo_oferta`)
    REFERENCES `ServiApp`.`OFERTAS` (`id_oferta` , `id_tipo_oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_FACTURAS_has_COBROS_SERVICIOS_COBROS_SERVICIOS1_idx` ON `ServiApp`.`DETALLES_SERVICIOS` (`id_cobro_servicio` ASC);

CREATE INDEX `fk_FACTURAS_has_COBROS_SERVICIOS_FACTURAS1_idx` ON `ServiApp`.`DETALLES_SERVICIOS` (`num_factura` ASC);

CREATE INDEX `fk__OFERTAS1_idx` ON `ServiApp`.`DETALLES_SERVICIOS` (`id_oferta` ASC, `id_tipo_oferta` ASC);

USE `ServiApp` ;

-- -----------------------------------------------------
-- Placeholder table for view `ServiApp`.`USUARIOS_ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiApp`.`USUARIOS_ROLES` (`email` INT, `password` INT, `id_rol` INT);

-- -----------------------------------------------------
-- View `ServiApp`.`USUARIOS_ROLES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ServiApp`.`USUARIOS_ROLES`;
USE `ServiApp`;
CREATE  OR REPLACE VIEW `USUARIOS_ROLES` AS
SELECT email, password, ROLES.id_rol
FROM
(USUARIOS JOIN ROLES) JOIN ROLES_USUARIOS
WHERE 
(USUARIOS.id_usuario = ROLES_USUARIOS.id_usuario) AND
(ROLES.id_rol = ROLES_USUARIOS.id_rol);






SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ServiApp`.`PAISES`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiApp`;
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ABW', 'ARUBA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AFG', 'AFGHANISTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AGO', 'ANGOLA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AIA', 'ANGUILLA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ALB', 'ALBANIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AND', 'ANDORRA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ANT', 'NETHERLANDS ANTILLES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ARE', 'UNITED ARAB EMIRATES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ARG', 'ARGENTINA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ARM', 'ARMENIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ASM', 'AMERICAN SAMOA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ATA', 'ANTARCTICA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ATF', 'FRENCH SOUTHERN TERRITORIES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ATG', 'ANTIGUA AND BARBUDA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AUS', 'AUSTRALIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AUT', 'AUSTRIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('AZE', 'AZERBAIJAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BDI', 'BURUNDI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BEL', 'BELGIUM');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BEN', 'BENIN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BFA', 'BURKINA FASO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BGD', 'BANGLADESH');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BGR', 'BULGARIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BHR', 'BAHRAIN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BHS', 'BAHAMAS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BIH', 'BOSNIA AND HERZEGOVINA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BLR', 'BELARUS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BLZ', 'BELIZE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BMU', 'BERMUDA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BOL', 'BOLIVIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BRA', 'BRAZIL');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BRB', 'BARBADOS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BRN', 'BRUNEI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BTN', 'BHUTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BVT', 'BOUVET ISLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('BWA', 'BOTSWANA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CAF', 'CENTRAL AFRICAN REPUBLIC');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CAN', 'CANADA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CCK', 'COCOS (KEELING) ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CHE', 'SWITZERLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CHL', 'CHILE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CHN', 'CHINA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CIV', 'CÔTE DIVOIRE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CMR', 'CAMEROON');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('COD', 'CONGO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('COG', 'CONGO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('COK', 'COOK ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('COL', 'COLOMBIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('COM', 'COMOROS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CPV', 'CAPE VERDE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CRI', 'COSTA RICA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CUB', 'CUBA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CXR', 'CHRISTMAS ISLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CYM', 'CAYMAN ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CYP', 'CYPRUS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('CZE', 'CZECH REPUBLIC');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('DEU', 'GERMANY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('DJI', 'DJIBOUTI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('DMA', 'DOMINICA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('DNK', 'DENMARK');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('DOM', 'DOMINICAN REPUBLIC');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('DZA', 'ALGERIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ECU', 'ECUADOR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('EGY', 'EGYPT');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ERI', 'ERITREA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ESH', 'WESTERN SAHARA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ESP', 'SPAIN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('EST', 'ESTONIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ETH', 'ETHIOPIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('FIN', 'FINLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('FJI', 'FIJI ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('FLK', 'FALKLAND ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('FRA', 'FRANCE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('FRO', 'FAROE ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('FSM', 'MICRONESIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GAB', 'GABON');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GBR', 'UNITED KINGDOM');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GEO', 'GEORGIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GHA', 'GHANA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GIB', 'GIBRALTAR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GIN', 'GUINEA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GLP', 'GUADELOUPE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GMB', 'GAMBIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GNB', 'GUINEA-BISSAU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GNQ', 'EQUATORIAL GUINEA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GRC', 'GREECE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GRD', 'GRENADA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GRL', 'GREENLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GTM', 'GUATEMALA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GUF', 'FRENCH GUIANA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GUM', 'GUAM');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('GUY', 'GUYANA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('HKG', 'HONG KONG');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('HMD', 'HEARD ISLAND AND MCDONALD ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('HND', 'HONDURAS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('HRV', 'CROATIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('HTI', 'HAITI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('HUN', 'HUNGARY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('IDN', 'INDONESIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('IND', 'INDIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('IOT', 'BRITISH INDIAN OCEAN TERRITORY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('IRL', 'IRELAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('IRN', 'IRAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('IRQ', 'IRAQ');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ISL', 'ICELAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ISR', 'ISRAEL');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ITA', 'ITALY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('JAM', 'JAMAICA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('JOR', 'JORDAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('JPN', 'JAPAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KAZ', 'KAZAKSTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KEN', 'KENYA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KGZ', 'KYRGYZSTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KHM', 'CAMBODIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KIR', 'KIRIBATI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KNA', 'SAINT KITTS AND NEVIS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KOR', 'SOUTH KOREA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('KWT', 'KUWAIT');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LAO', 'LAOS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LBN', 'LEBANON');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LBR', 'LIBERIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LBY', 'LIBYAN ARAB JAMAHIRIYA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LCA', 'SAINT LUCIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LIE', 'LIECHTENSTEIN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LKA', 'SRI LANKA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LSO', 'LESOTHO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LTU', 'LITHUANIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LUX', 'LUXEMBOURG');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('LVA', 'LATVIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MAC', 'MACAO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MAR', 'MOROCCO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MCO', 'MONACO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MDA', 'MOLDOVA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MDG', 'MADAGASCAR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MDV', 'MALDIVES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MEX', 'MEXICO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MHL', 'MARSHALL ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MKD', 'MACEDONIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MLI', 'MALI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MLT', 'MALTA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MMR', 'MYANMAR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MNG', 'MONGOLIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MNP', 'NORTHERN MARIANA ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MOZ', 'MOZAMBIQUE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MRT', 'MAURITANIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MSR', 'MONTSERRAT');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MTQ', 'MARTINIQUE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MUS', 'MAURITIUS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MWI', 'MALAWI');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MYS', 'MALAYSIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('MYT', 'MAYOTTE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NAM', 'NAMIBIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NCL', 'NEW CALEDONIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NER', 'NIGER');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NFK', 'NORFOLK ISLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NGA', 'NIGERIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NIC', 'NICARAGUA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NIU', 'NIUE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NLD', 'NETHERLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NOR', 'NORWAY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NPL', 'NEPAL');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NRU', 'NAURU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('NZL', 'NEW ZEALAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('OMN', 'OMAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PAK', 'PAKISTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PAN', 'PANAMA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PCN', 'PITCAIRN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PER', 'PERU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PHL', 'PHILIPPINES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PLW', 'PALAU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PNG', 'PAPUA NEW GUINEA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('POL', 'POLAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PRI', 'PUERTO RICO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PRK', 'NORTH KOREA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PRT', 'PORTUGAL');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PRY', 'PARAGUAY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PSE', 'PALESTINE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('PYF', 'FRENCH POLYNESIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('QAT', 'QATAR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('REU', 'RÉUNION');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ROM', 'ROMANIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('RUS', 'RUSSIAN FEDERATION');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('RWA', 'RWANDA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SAU', 'SAUDI ARABIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SDN', 'SUDAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SEN', 'SENEGAL');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SGP', 'SINGAPORE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SGS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SHN', 'SAINT HELENA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SJM', 'SVALBARD AND JAN MAYEN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SLB', 'SOLOMON ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SLE', 'SIERRA LEONE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SLV', 'EL SALVADOR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SMR', 'SAN MARINO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SOM', 'SOMALIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SPM', 'SAINT PIERRE AND MIQUELON');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('STP', 'SAO TOME AND PRINCIPE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SUR', 'SURINAME');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SVK', 'SLOVAKIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SVN', 'SLOVENIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SWE', 'SWEDEN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SWZ', 'SWAZILAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SYC', 'SEYCHELLES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('SYR', 'SYRIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TCA', 'TURKS AND CAICOS ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TCD', 'CHAD');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TGO', 'TOGO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('THA', 'THAILAND');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TJK', 'TAJIKISTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TKL', 'TOKELAU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TKM', 'TURKMENISTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TMP', 'EAST TIMOR');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TON', 'TONGA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TTO', 'TRINIDAD AND TOBAGO');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TUN', 'TUNISIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TUR', 'TURKEY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TUV', 'TUVALU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TWN', 'TAIWAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('TZA', 'TANZANIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('UGA', 'UGANDA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('UKR', 'UKRAINE');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('UMI', 'UNITED STATES MINOR OUTLYING ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('URY', 'URUGUAY');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('USA', 'UNITED STATES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('UZB', 'UZBEKISTAN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VAT', 'HOLY SEE (VATICAN CITY STATE)');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VCT', 'SAINT VINCENT AND THE GRENADINES');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VEN', 'VENEZUELA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VGB', 'VIRGIN ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VIR', 'VIRGIN ISLANDS');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VNM', 'VIETNAM');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('VUT', 'VANUATU');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('WLF', 'WALLIS AND FUTUNA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('WSM', 'SAMOA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('YEM', 'YEMEN');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('YUG', 'YUGOSLAVIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ZAF', 'SOUTH AFRICA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ZMB', 'ZAMBIA');
INSERT INTO `ServiApp`.`PAISES` (`id_pais`, `nombre_pais`) VALUES ('ZWE', 'ZIMBABWE');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiApp`.`DEPARTAMENTOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiApp`;
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (5, 'ANTIOQUIA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (8, 'ATLANTICO', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (11, 'BOGOTA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (13, 'BOLIVAR', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (15, 'BOYACA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (17, 'CALDAS', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (18, 'CAQUETA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (19, 'CAUCA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (20, 'CESAR', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (23, 'CORDOBA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (25, 'CUNDINAMARCA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (27, 'CHOCO', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (41, 'HUILA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (44, 'LA GUAJIRA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (47, 'MAGDALENA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (50, 'META', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (52, 'NARIÑO', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (54, 'N. DE SANTANDER', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (63, 'QUINDIO', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (66, 'RISARALDA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (68, 'SANTANDER', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (70, 'SUCRE', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (73, 'TOLIMA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (76, 'VALLE DEL CAUCA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (81, 'ARAUCA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (85, 'CASANARE', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (86, 'PUTUMAYO', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (88, 'SAN ANDRES', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (91, 'AMAZONAS', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (94, 'GUAINIA', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (95, 'GUAVIARE', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (97, 'VAUPES', 'COL');
INSERT INTO `ServiApp`.`DEPARTAMENTOS` (`id_departamento`, `nombre_departamento`, `id_pais`) VALUES (99, 'VICHADA', 'COL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiApp`.`CIUDADES`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiApp`;
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'LETICIA', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (263, 'EL ENCANTO', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (405, 'LA CHORRERA', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (407, 'LA PEDRERA', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (430, 'LA VICTORIA', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (460, 'MIRITI - PARANÁ', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (530, 'PUERTO ALEGRÍA', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (536, 'PUERTO ARICA', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (540, 'PUERTO NARIÑO', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (669, 'PUERTO SANTANDER', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (798, 'TARAPACÁ', 91);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'MEDELLÍN', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (002, 'ABEJORRAL', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (004, 'ABRIAQUÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (021, 'ALEJANDRÍA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (030, 'AMAGÁ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (031, 'AMALFI', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (034, 'ANDES', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (036, 'ANGELÓPOLIS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (038, 'ANGOSTURA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (040, 'ANORÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (042, 'SANTAFÉ DE ANTIOQUIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (044, 'ANZA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (045, 'APARTADÓ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (051, 'ARBOLETES', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (055, 'ARGELIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (059, 'ARMENIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (079, 'BARBOSA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (086, 'BELMIRA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (088, 'BELLO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (091, 'BETANIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (093, 'BETULIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (101, 'CIUDAD BOLÍVAR', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (107, 'BRICEÑO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (113, 'BURITICÁ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (120, 'CÁCERES', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (125, 'CAICEDO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (129, 'CALDAS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (134, 'CAMPAMENTO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (138, 'CAÑASGORDAS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (142, 'CARACOLÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (145, 'CARAMANTA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (147, 'CAREPA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (148, 'EL CARMEN DE VIBORAL', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (150, 'CAROLINA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (154, 'CAUCASIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (172, 'CHIGORODÓ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (190, 'CISNEROS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (197, 'COCORNÁ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (206, 'CONCEPCIÓN', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (209, 'CONCORDIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (212, 'COPACABANA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (234, 'DABEIBA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (237, 'DONMATÍAS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (240, 'EBÉJICO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL BAGRE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (264, 'ENTRERRIOS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (266, 'ENVIGADO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (282, 'FREDONIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (284, 'FRONTINO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (306, 'GIRALDO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (308, 'GIRARDOTA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (310, 'GÓMEZ PLATA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (313, 'GRANADA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (315, 'GUADALUPE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUARNE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (321, 'GUATAPE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (347, 'HELICONIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (353, 'HISPANIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (360, 'ITAGUI', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (361, 'ITUANGO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (364, 'JARDÍN', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (368, 'JERICÓ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (376, 'LA CEJA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (380, 'LA ESTRELLA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (390, 'LA PINTADA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'LA UNIÓN', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (411, 'LIBORINA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (425, 'MACEO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (440, 'MARINILLA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (467, 'MONTEBELLO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (475, 'MURINDÓ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (480, 'MUTATÁ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (483, 'NARIÑO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (490, 'NECOCLÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (495, 'NECHÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (501, 'OLAYA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (541, 'PEÑOL', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (543, 'PEQUE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (576, 'PUEBLORRICO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (579, 'PUERTO BERRÍO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (585, 'PUERTO NARE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (591, 'PUERTO TRIUNFO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (604, 'REMEDIOS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (607, 'RETIRO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (615, 'RIONEGRO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (628, 'SABANALARGA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (631, 'SABANETA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (642, 'SALGAR', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (647, 'SAN ANDRÉS DE CUERQUÍA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (649, 'SAN CARLOS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (652, 'SAN FRANCISCO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (656, 'SAN JERÓNIMO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (658, 'SAN JOSÉ DE LA MONTAÑA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (659, 'SAN JUAN DE URABÁ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SAN LUIS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (664, 'SAN PEDRO DE LOS MILAGROS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (665, 'SAN PEDRO DE URABA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (667, 'SAN RAFAEL', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (670, 'SAN ROQUE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (674, 'SAN VICENTE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (679, 'SANTA BÁRBARA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (686, 'SANTA ROSA DE OSOS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (690, 'SANTO DOMINGO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (697, 'EL SANTUARIO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (736, 'SEGOVIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (756, 'SONSON', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (761, 'SOPETRÁN', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (789, 'TÁMESIS', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (790, 'TARAZÁ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (792, 'TARSO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (809, 'TITIRIBÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (819, 'TOLEDO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (837, 'TURBO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (842, 'URAMITA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (847, 'URRAO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (854, 'VALDIVIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (856, 'VALPARAÍSO', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (858, 'VEGACHÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (861, 'VENECIA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (873, 'VIGÍA DEL FUERTE', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (885, 'YALÍ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (887, 'YARUMAL', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (890, 'YOLOMBÓ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (893, 'YONDÓ', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (895, 'ZARAGOZA', 05);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'ARAUCA', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (065, 'ARAUQUITA', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (220, 'CRAVO NORTE', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (300, 'FORTUL', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (591, 'PUERTO RONDÓN', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (736, 'SARAVENA', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (794, 'TAME', 81);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'BARRANQUILLA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (078, 'BARANOA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (137, 'CAMPO DE LA CRUZ', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (141, 'CANDELARIA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (296, 'GALAPA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (372, 'JUAN DE ACOSTA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (421, 'LURUACO', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (433, 'MALAMBO', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (436, 'MANATÍ', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (520, 'PALMAR DE VARELA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (549, 'PIOJÓ', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (558, 'POLONUEVO', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (560, 'PONEDERA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (573, 'PUERTO COLOMBIA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (606, 'REPELÓN', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (634, 'SABANAGRANDE', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (638, 'SABANALARGA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (675, 'SANTA LUCÍA', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (685, 'SANTO TOMÁS', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (758, 'SOLEDAD', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (770, 'SUAN', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (832, 'TUBARÁ', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (849, 'USIACURÍ', 08);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'BOGOTÁ, D.C.', 11);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'CARTAGENA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (006, 'ACHÍ', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (030, 'ALTOS DEL ROSARIO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (042, 'ARENAL', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (052, 'ARJONA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (062, 'ARROYOHONDO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (074, 'BARRANCO DE LOBA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (140, 'CALAMAR', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (160, 'CANTAGALLO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (188, 'CICUCO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (212, 'CÓRDOBA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (222, 'CLEMENCIA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (244, 'EL CARMEN DE BOLÍVAR', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (248, 'EL GUAMO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (268, 'EL PEÑÓN', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (300, 'HATILLO DE LOBA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (430, 'MAGANGUÉ', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (433, 'MAHATES', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (440, 'MARGARITA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (442, 'MARÍA LA BAJA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (458, 'MONTECRISTO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (468, 'MOMPÓS', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (473, 'MORALES', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (490, 'NOROSÍ', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (549, 'PINILLOS', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (580, 'REGIDOR', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (600, 'RÍO VIEJO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (620, 'SAN CRISTÓBAL', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (647, 'SAN ESTANISLAO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (650, 'SAN FERNANDO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (654, 'SAN JACINTO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (655, 'SAN JACINTO DEL CAUCA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (657, 'SAN JUAN NEPOMUCENO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (667, 'SAN MARTÍN DE LOBA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (670, 'SAN PABLO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (673, 'SANTA CATALINA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (683, 'SANTA ROSA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (688, 'SANTA ROSA DEL SUR', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (744, 'SIMITÍ', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (760, 'SOPLAVIENTO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (780, 'TALAIGUA NUEVO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (810, 'TIQUISIO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (836, 'TURBACO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (838, 'TURBANÁ', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (873, 'VILLANUEVA', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (894, 'ZAMBRANO', 13);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'TUNJA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (022, 'ALMEIDA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (047, 'AQUITANIA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (051, 'ARCABUCO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (087, 'BELÉN', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (090, 'BERBEO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (092, 'BETÉITIVA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (097, 'BOAVITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (104, 'BOYACÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (106, 'BRICEÑO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (109, 'BUENAVISTA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (114, 'BUSBANZÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (131, 'CALDAS', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (135, 'CAMPOHERMOSO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (162, 'CERINZA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (172, 'CHINAVITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (176, 'CHIQUINQUIRÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (180, 'CHISCAS', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (183, 'CHITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (185, 'CHITARAQUE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (187, 'CHIVATÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (189, 'CIÉNEGA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (204, 'CÓMBITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (212, 'COPER', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (215, 'CORRALES', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (218, 'COVARACHÍA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (223, 'CUBARÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (224, 'CUCAITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (226, 'CUÍTIVA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (232, 'CHÍQUIZA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (236, 'CHIVOR', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (238, 'DUITAMA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (244, 'EL COCUY', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (248, 'EL ESPINO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (272, 'FIRAVITOBA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (276, 'FLORESTA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (293, 'GACHANTIVÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (296, 'GAMEZA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (299, 'GARAGOA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (317, 'GUACAMAYAS', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (322, 'GUATEQUE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (325, 'GUAYATÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (332, 'GÜICÁN', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (362, 'IZA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (367, 'JENESANO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (368, 'JERICÓ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (377, 'LABRANZAGRANDE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (380, 'LA CAPILLA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (401, 'LA VICTORIA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (403, 'LA UVITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (407, 'VILLA DE LEYVA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (425, 'MACANAL', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (442, 'MARIPÍ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (455, 'MIRAFLORES', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (464, 'MONGUA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (466, 'MONGUÍ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (469, 'MONIQUIRÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (476, 'MOTAVITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (480, 'MUZO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (491, 'NOBSA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (494, 'NUEVO COLÓN', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (500, 'OICATÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (507, 'OTANCHE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (511, 'PACHAVITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (514, 'PÁEZ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (516, 'PAIPA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (518, 'PAJARITO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (522, 'PANQUEBA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (531, 'PAUNA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (533, 'PAYA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (537, 'PAZ DE RÍO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (542, 'PESCA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (550, 'PISBA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (572, 'PUERTO BOYACÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (580, 'QUÍPAMA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (599, 'RAMIRIQUÍ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (600, 'RÁQUIRA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (621, 'RONDÓN', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (632, 'SABOYÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (638, 'SÁCHICA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (646, 'SAMACÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SAN EDUARDO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (664, 'SAN JOSÉ DE PARE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (667, 'SAN LUIS DE GACENO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (673, 'SAN MATEO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (676, 'SAN MIGUEL DE SEMA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (681, 'SAN PABLO DE BORBUR', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (686, 'SANTANA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (690, 'SANTA MARÍA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (693, 'SANTA ROSA DE VITERBO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (696, 'SANTA SOFÍA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (720, 'SATIVANORTE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (723, 'SATIVASUR', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (740, 'SIACHOQUE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (753, 'SOATÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (755, 'SOCOTÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (757, 'SOCHA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (759, 'SOGAMOSO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (761, 'SOMONDOCO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (762, 'SORA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (763, 'SOTAQUIRÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (764, 'SORACÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (774, 'SUSACÓN', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (776, 'SUTAMARCHÁN', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (778, 'SUTATENZA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (790, 'TASCO', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (798, 'TENZA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (804, 'TIBANÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (806, 'TIBASOSA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (808, 'TINJACÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (810, 'TIPACOQUE', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (814, 'TOCA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (816, 'TOGÜÍ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (820, 'TÓPAGA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (822, 'TOTA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (832, 'TUNUNGUÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (835, 'TURMEQUÉ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (837, 'TUTA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (839, 'TUTAZÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (842, 'UMBITA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (861, 'VENTAQUEMADA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (879, 'VIRACACHÁ', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (897, 'ZETAQUIRA', 15);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'MANIZALES', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (013, 'AGUADAS', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (042, 'ANSERMA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (050, 'ARANZAZU', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (088, 'BELALCÁZAR', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (174, 'CHINCHINÁ', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (272, 'FILADELFIA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (380, 'LA DORADA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (388, 'LA MERCED', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (433, 'MANZANARES', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (442, 'MARMATO', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (444, 'MARQUETALIA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (446, 'MARULANDA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (486, 'NEIRA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (495, 'NORCASIA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (513, 'PÁCORA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (524, 'PALESTINA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (541, 'PENSILVANIA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (614, 'RIOSUCIO', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (616, 'RISARALDA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (653, 'SALAMINA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (662, 'SAMANÁ', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (665, 'SAN JOSÉ', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (777, 'SUPÍA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (867, 'VICTORIA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (873, 'VILLAMARÍA', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (877, 'VITERBO', 17);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'FLORENCIA', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (029, 'ALBANIA', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (094, 'BELÉN DE LOS ANDAQUÍES', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (150, 'CARTAGENA DEL CHAIRÁ', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (205, 'CURILLO', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (247, 'EL DONCELLO', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (256, 'EL PAUJIL', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (410, 'LA MONTAÑITA', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (460, 'MILÁN', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (479, 'MORELIA', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (592, 'PUERTO RICO', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (610, 'SAN JOSÉ DEL FRAGUA', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (753, 'SAN VICENTE DEL CAGUÁN', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (756, 'SOLANO', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (785, 'SOLITA', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (860, 'VALPARAÍSO', 18);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'YOPAL', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (010, 'AGUAZUL', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (015, 'CHAMEZA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (125, 'HATO COROZAL', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (136, 'LA SALINA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (139, 'MANÍ', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (162, 'MONTERREY', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (225, 'NUNCHÍA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (230, 'OROCUÉ', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'PAZ DE ARIPORO', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (263, 'PORE', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (279, 'RECETOR', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (300, 'SABANALARGA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (315, 'SÁCAMA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (325, 'SAN LUIS DE PALENQUE', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'TÁMARA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (410, 'TAURAMENA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (430, 'TRINIDAD', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (440, 'VILLANUEVA', 85);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'POPAYÁN', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (022, 'ALMAGUER', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (050, 'ARGELIA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (075, 'BALBOA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (100, 'BOLÍVAR', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (110, 'BUENOS AIRES', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (130, 'CAJIBÍO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (137, 'CALDONO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (142, 'CALOTO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (212, 'CORINTO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (256, 'EL TAMBO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (290, 'FLORENCIA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (300, 'GUACHENÉ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUAPI', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (355, 'INZÁ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (364, 'JAMBALÓ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (392, 'LA SIERRA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (397, 'LA VEGA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (418, 'LÓPEZ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (450, 'MERCADERES', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (455, 'MIRANDA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (473, 'MORALES', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (513, 'PADILLA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (517, 'PAEZ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (532, 'PATÍA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (533, 'PIAMONTE', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (548, 'PIENDAMÓ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (573, 'PUERTO TEJADA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (585, 'PURACÉ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (622, 'ROSAS', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (693, 'SAN SEBASTIÁN', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (698, 'SANTANDER DE QUILICHAO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (701, 'SANTA ROSA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (743, 'SILVIA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (760, 'SOTARA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (780, 'SUÁREZ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (785, 'SUCRE', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (807, 'TIMBÍO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (809, 'TIMBIQUÍ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (821, 'TORIBIO', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (824, 'TOTORÓ', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (845, 'VILLA RICA', 19);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'VALLEDUPAR', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (011, 'AGUACHICA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (013, 'AGUSTÍN CODAZZI', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (032, 'ASTREA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (045, 'BECERRIL', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (060, 'BOSCONIA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (175, 'CHIMICHAGUA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (178, 'CHIRIGUANÁ', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (228, 'CURUMANÍ', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (238, 'EL COPEY', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL PASO', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (295, 'GAMARRA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (310, 'GONZÁLEZ', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (383, 'LA GLORIA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'LA JAGUA DE IBIRICO', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (443, 'MANAURE', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (517, 'PAILITAS', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (550, 'PELAYA', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (570, 'PUEBLO BELLO', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (614, 'RÍO DE ORO', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (621, 'LA PAZ', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (710, 'SAN ALBERTO', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (750, 'SAN DIEGO', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (770, 'SAN MARTÍN', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (787, 'TAMALAMEQUE', 20);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'QUIBDÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (006, 'ACANDÍ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (025, 'ALTO BAUDÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (050, 'ATRATO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (073, 'BAGADÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (075, 'BAHÍA SOLANO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (077, 'BAJO BAUDÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (099, 'BOJAYA', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (135, 'EL CANTÓN DEL SAN PABLO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (150, 'CARMEN DEL DARIÉN', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (160, 'CÉRTEGUI', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (205, 'CONDOTO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (245, 'EL CARMEN DE ATRATO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL LITORAL DEL SAN JUAN', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (361, 'ISTMINA', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (372, 'JURADÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (413, 'LLORÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (425, 'MEDIO ATRATO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (430, 'MEDIO BAUDÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (450, 'MEDIO SAN JUAN', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (491, 'NÓVITA', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (495, 'NUQUÍ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (580, 'RÍO IRÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (600, 'RÍO QUITO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (615, 'RIOSUCIO', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SAN JOSÉ DEL PALMAR', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (745, 'SIPÍ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (787, 'TADÓ', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (800, 'UNGUÍA', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (810, 'UNIÓN PANAMERICANA', 27);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'MONTERÍA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (068, 'AYAPEL', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (079, 'BUENAVISTA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (090, 'CANALETE', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (162, 'CERETÉ', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (168, 'CHIMÁ', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (182, 'CHINÚ', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (189, 'CIÉNAGA DE ORO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (300, 'COTORRA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (350, 'LA APARTADA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (417, 'LORICA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (419, 'LOS CÓRDOBAS', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (464, 'MOMIL', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (466, 'MONTELÍBANO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (500, 'MOÑITOS', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (555, 'PLANETA RICA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (570, 'PUEBLO NUEVO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (574, 'PUERTO ESCONDIDO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (580, 'PUERTO LIBERTADOR', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (586, 'PURÍSIMA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SAHAGÚN', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (670, 'SAN ANDRÉS SOTAVENTO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (672, 'SAN ANTERO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (675, 'SAN BERNARDO DEL VIENTO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (678, 'SAN CARLOS', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (682, 'SAN JOSÉ DE URÉ', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (686, 'SAN PELAYO', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (807, 'TIERRALTA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (815, 'TUCHÍN', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (855, 'VALENCIA', 23);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'AGUA DE DIOS', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (019, 'ALBÁN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (035, 'ANAPOIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (040, 'ANOLAIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (053, 'ARBELÁEZ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (086, 'BELTRÁN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (095, 'BITUIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (099, 'BOJACÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (120, 'CABRERA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (123, 'CACHIPAY', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (126, 'CAJICÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (148, 'CAPARRAPÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (151, 'CAQUEZA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (154, 'CARMEN DE CARUPA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (168, 'CHAGUANÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (175, 'CHÍA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (178, 'CHIPAQUE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (181, 'CHOACHÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (183, 'CHOCONTÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (200, 'COGUA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (214, 'COTA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (224, 'CUCUNUBÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (245, 'EL COLEGIO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (258, 'EL PEÑÓN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (260, 'EL ROSAL', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (269, 'FACATATIVÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (279, 'FOMEQUE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (281, 'FOSCA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (286, 'FUNZA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (288, 'FÚQUENE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (290, 'FUSAGASUGÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (293, 'GACHALA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (295, 'GACHANCIPÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (297, 'GACHETÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (299, 'GAMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (307, 'GIRARDOT', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (312, 'GRANADA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (317, 'GUACHETÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (320, 'GUADUAS', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (322, 'GUASCA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (324, 'GUATAQUÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (326, 'GUATAVITA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (328, 'GUAYABAL DE SIQUIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (335, 'GUAYABETAL', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (339, 'GUTIÉRREZ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (368, 'JERUSALÉN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (372, 'JUNÍN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (377, 'LA CALERA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (386, 'LA MESA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (394, 'LA PALMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (398, 'LA PEÑA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (402, 'LA VEGA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (407, 'LENGUAZAQUE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (426, 'MACHETA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (430, 'MADRID', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (436, 'MANTA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (438, 'MEDINA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (473, 'MOSQUERA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (483, 'NARIÑO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (486, 'NEMOCÓN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (488, 'NILO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (489, 'NIMAIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (491, 'NOCAIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (506, 'VENECIA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (513, 'PACHO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (518, 'PAIME', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (524, 'PANDI', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (530, 'PARATEBUENO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (535, 'PASCA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (572, 'PUERTO SALGAR', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (580, 'PULÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (592, 'QUEBRADANEGRA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (594, 'QUETAME', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (596, 'QUIPILE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (599, 'APULO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (612, 'RICAURTE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (645, 'SAN ANTONIO DEL TEQUENDAMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (649, 'SAN BERNARDO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (653, 'SAN CAYETANO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (658, 'SAN FRANCISCO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (662, 'SAN JUAN DE RÍO SECO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (718, 'SASAIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (736, 'SESQUILÉ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (740, 'SIBATÉ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (743, 'SILVANIA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (745, 'SIMIJACA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (754, 'SOACHA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (758, 'SOPÓ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (769, 'SUBACHOQUE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (772, 'SUESCA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (777, 'SUPATÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (779, 'SUSA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (781, 'SUTATAUSA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (785, 'TABIO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (793, 'TAUSA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (797, 'TENA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (799, 'TENJO', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (805, 'TIBACUY', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (807, 'TIBIRITA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (815, 'TOCAIMA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (817, 'TOCANCIPÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (823, 'TOPAIPÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (839, 'UBALÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (841, 'UBAQUE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (843, 'VILLA DE SAN DIEGO DE UBATE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (845, 'UNE', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (851, 'ÚTICA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (862, 'VERGARA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (867, 'VIANÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (871, 'VILLAGÓMEZ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (873, 'VILLAPINZÓN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (875, 'VILLETA', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (878, 'VIOTÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (885, 'YACOPÍ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (898, 'ZIPACÓN', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (899, 'ZIPAQUIRÁ', 25);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'INÍRIDA', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (343, 'BARRANCO MINAS', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (663, 'MAPIRIPANA', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (883, 'SAN FELIPE', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (884, 'PUERTO COLOMBIA', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (885, 'LA GUADALUPE', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (886, 'CACAHUAL', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (887, 'PANA PANA', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (888, 'MORICHAL', 94);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'SAN JOSÉ DEL GUAVIARE', 95);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (015, 'CALAMAR', 95);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (025, 'EL RETORNO', 95);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (200, 'MIRAFLORES', 95);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'NEIVA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (006, 'ACEVEDO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (013, 'AGRADO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (016, 'AIPE', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (020, 'ALGECIRAS', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (026, 'ALTAMIRA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (078, 'BARAYA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (132, 'CAMPOALEGRE', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (206, 'COLOMBIA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (244, 'ELÍAS', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (298, 'GARZÓN', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (306, 'GIGANTE', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (319, 'GUADALUPE', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (349, 'HOBO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (357, 'IQUIRA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (359, 'ISNOS', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (378, 'LA ARGENTINA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (396, 'LA PLATA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (483, 'NÁTAGA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (503, 'OPORAPA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (518, 'PAICOL', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (524, 'PALERMO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (530, 'PALESTINA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (548, 'PITAL', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (551, 'PITALITO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (615, 'RIVERA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SALADOBLANCO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (668, 'SAN AGUSTÍN', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (676, 'SANTA MARÍA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (770, 'SUAZA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (791, 'TARQUI', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (797, 'TESALIA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (799, 'TELLO', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (801, 'TERUEL', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (807, 'TIMANÁ', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (872, 'VILLAVIEJA', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (885, 'YAGUARÁ', 41);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'RIOHACHA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (035, 'ALBANIA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (078, 'BARRANCAS', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (090, 'DIBULLA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (098, 'DISTRACCIÓN', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (110, 'EL MOLINO', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (279, 'FONSECA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (378, 'HATONUEVO', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (420, 'LA JAGUA DEL PILAR', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (430, 'MAICAO', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (560, 'MANAURE', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (650, 'SAN JUAN DEL CESAR', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (847, 'URIBIA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (855, 'URUMITA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (874, 'VILLANUEVA', 44);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'SANTA MARTA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (030, 'ALGARROBO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (053, 'ARACATACA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (058, 'ARIGUANÍ', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (161, 'CERRO SAN ANTONIO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (170, 'CHIVOLO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (189, 'CIÉNAGA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (205, 'CONCORDIA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (245, 'EL BANCO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (258, 'EL PIÑON', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (268, 'EL RETÉN', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (288, 'FUNDACIÓN', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUAMAL', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (460, 'NUEVA GRANADA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (541, 'PEDRAZA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (545, 'PIJIÑO DEL CARMEN', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (551, 'PIVIJAY', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (555, 'PLATO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (570, 'PUEBLOVIEJO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (605, 'REMOLINO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SABANAS DE SAN ANGEL', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (675, 'SALAMINA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (692, 'SAN SEBASTIÁN DE BUENAVISTA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (703, 'SAN ZENÓN', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (707, 'SANTA ANA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (720, 'SANTA BÁRBARA DE PINTO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (745, 'SITIONUEVO', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (798, 'TENERIFE', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (960, 'ZAPAYÁN', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (980, 'ZONA BANANERA', 47);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'VILLAVICENCIO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (006, 'ACACÍAS', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (110, 'BARRANCA DE UPÍA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (124, 'CABUYARO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (150, 'CASTILLA LA NUEVA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (223, 'CUBARRAL', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (226, 'CUMARAL', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (245, 'EL CALVARIO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (251, 'EL CASTILLO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (270, 'EL DORADO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (287, 'FUENTE DE ORO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (313, 'GRANADA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUAMAL', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (325, 'MAPIRIPÁN', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (330, 'MESETAS', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (350, 'LA MACARENA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (370, 'URIBE', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'LEJANÍAS', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (450, 'PUERTO CONCORDIA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (568, 'PUERTO GAITÁN', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (573, 'PUERTO LÓPEZ', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (577, 'PUERTO LLERAS', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (590, 'PUERTO RICO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (606, 'RESTREPO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (680, 'SAN CARLOS DE GUAROA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (683, 'SAN JUAN DE ARAMA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (686, 'SAN JUANITO', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (689, 'SAN MARTÍN', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (711, 'VISTAHERMOSA', 50);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'PASTO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (019, 'ALBÁN', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (022, 'ALDANA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (036, 'ANCUYÁ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (051, 'ARBOLEDA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (079, 'BARBACOAS', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (083, 'BELÉN', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (110, 'BUESACO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (203, 'COLÓN', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (207, 'CONSACA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (210, 'CONTADERO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (215, 'CÓRDOBA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (224, 'CUASPUD', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (227, 'CUMBAL', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (233, 'CUMBITARA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (240, 'CHACHAGÜÍ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL CHARCO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (254, 'EL PEÑOL', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (256, 'EL ROSARIO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (258, 'EL TABLÓN DE GÓMEZ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (260, 'EL TAMBO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (287, 'FUNES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (317, 'GUACHUCAL', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (320, 'GUAITARILLA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (323, 'GUALMATÁN', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (352, 'ILES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (354, 'IMUÉS', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (356, 'IPIALES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (378, 'LA CRUZ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (381, 'LA FLORIDA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (385, 'LA LLANADA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (390, 'LA TOLA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (399, 'LA UNIÓN', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (405, 'LEIVA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (411, 'LINARES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (418, 'LOS ANDES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (427, 'MAGÜI', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (435, 'MALLAMA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (473, 'MOSQUERA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (480, 'NARIÑO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (490, 'OLAYA HERRERA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (506, 'OSPINA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (520, 'FRANCISCO PIZARRO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (540, 'POLICARPA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (560, 'POTOSÍ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (565, 'PROVIDENCIA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (573, 'PUERRES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (585, 'PUPIALES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (612, 'RICAURTE', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (621, 'ROBERTO PAYÁN', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (678, 'SAMANIEGO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (683, 'SANDONÁ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (685, 'SAN BERNARDO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (687, 'SAN LORENZO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (693, 'SAN PABLO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (694, 'SAN PEDRO DE CARTAGO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (696, 'SANTA BÁRBARA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (699, 'SANTACRUZ', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (720, 'SAPUYES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (786, 'TAMINANGO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (788, 'TANGUA', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (835, 'SAN ANDRES DE TUMACO', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (838, 'TÚQUERRES', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (885, 'YACUANQUER', 52);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'CÚCUTA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (003, 'ABREGO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (051, 'ARBOLEDAS', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (099, 'BOCHALEMA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (109, 'BUCARASICA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (125, 'CÁCOTA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (128, 'CACHIRÁ', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (172, 'CHINÁCOTA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (174, 'CHITAGÁ', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (206, 'CONVENCIÓN', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (223, 'CUCUTILLA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (239, 'DURANIA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (245, 'EL CARMEN', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL TARRA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (261, 'EL ZULIA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (313, 'GRAMALOTE', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (344, 'HACARÍ', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (347, 'HERRÁN', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (377, 'LABATECA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (385, 'LA ESPERANZA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (398, 'LA PLAYA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (405, 'LOS PATIOS', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (418, 'LOURDES', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (480, 'MUTISCUA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (498, 'OCAÑA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (518, 'PAMPLONA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (520, 'PAMPLONITA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (553, 'PUERTO SANTANDER', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (599, 'RAGONVALIA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (660, 'SALAZAR', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (670, 'SAN CALIXTO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (673, 'SAN CAYETANO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (680, 'SANTIAGO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (720, 'SARDINATA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (743, 'SILOS', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (800, 'TEORAMA', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (810, 'TIBÚ', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (820, 'TOLEDO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (871, 'VILLA CARO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (874, 'VILLA DEL ROSARIO', 54);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'MOCOA', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (219, 'COLÓN', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (320, 'ORITO', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (568, 'PUERTO ASÍS', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (569, 'PUERTO CAICEDO', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (571, 'PUERTO GUZMÁN', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (573, 'PUERTO LEGUÍZAMO', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (749, 'SIBUNDOY', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (755, 'SAN FRANCISCO', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (757, 'SAN MIGUEL', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (760, 'SANTIAGO', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (865, 'VALLE DEL GUAMUEZ', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (885, 'VILLAGARZÓN', 86);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'ARMENIA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (111, 'BUENAVISTA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (130, 'CALARCA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (190, 'CIRCASIA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (212, 'CÓRDOBA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (272, 'FILANDIA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (302, 'GÉNOVA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (401, 'LA TEBAIDA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (470, 'MONTENEGRO', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (548, 'PIJAO', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (594, 'QUIMBAYA', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (690, 'SALENTO', 63);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'PEREIRA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (045, 'APÍA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (075, 'BALBOA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (088, 'BELÉN DE UMBRÍA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (170, 'DOSQUEBRADAS', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUÁTICA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (383, 'LA CELIA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'LA VIRGINIA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (440, 'MARSELLA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (456, 'MISTRATÓ', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (572, 'PUEBLO RICO', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (594, 'QUINCHÍA', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (682, 'SANTA ROSA DE CABAL', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (687, 'SANTUARIO', 66);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'SAN ANDRÉS', 88);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (564, 'PROVIDENCIA', 88);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'BUCARAMANGA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (013, 'AGUADA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (020, 'ALBANIA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (051, 'ARATOCA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (077, 'BARBOSA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (079, 'BARICHARA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (081, 'BARRANCABERMEJA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (092, 'BETULIA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (101, 'BOLÍVAR', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (121, 'CABRERA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (132, 'CALIFORNIA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (147, 'CAPITANEJO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (152, 'CARCASÍ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (160, 'CEPITÁ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (162, 'CERRITO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (167, 'CHARALÁ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (169, 'CHARTA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (176, 'CHIMA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (179, 'CHIPATÁ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (190, 'CIMITARRA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (207, 'CONCEPCIÓN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (209, 'CONFINES', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (211, 'CONTRATACIÓN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (217, 'COROMORO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (229, 'CURITÍ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (235, 'EL CARMEN DE CHUCURÍ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (245, 'EL GUACAMAYO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL PEÑÓN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (255, 'EL PLAYÓN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (264, 'ENCINO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (266, 'ENCISO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (271, 'FLORIÁN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (276, 'FLORIDABLANCA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (296, 'GALÁN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (298, 'GAMBITA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (307, 'GIRÓN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUACA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (320, 'GUADALUPE', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (322, 'GUAPOTÁ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (324, 'GUAVATÁ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (327, 'GÜEPSA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (344, 'HATO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (368, 'JESÚS MARÍA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (370, 'JORDÁN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (377, 'LA BELLEZA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (385, 'LANDÁZURI', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (397, 'LA PAZ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (406, 'LEBRIJA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (418, 'LOS SANTOS', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (425, 'MACARAVITA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (432, 'MÁLAGA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (444, 'MATANZA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (464, 'MOGOTES', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (468, 'MOLAGAVITA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (498, 'OCAMONTE', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (500, 'OIBA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (502, 'ONZAGA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (522, 'PALMAR', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (524, 'PALMAS DEL SOCORRO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (533, 'PÁRAMO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (547, 'PIEDECUESTA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (549, 'PINCHOTE', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (572, 'PUENTE NACIONAL', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (573, 'PUERTO PARRA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (575, 'PUERTO WILCHES', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (615, 'RIONEGRO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (655, 'SABANA DE TORRES', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (669, 'SAN ANDRÉS', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (673, 'SAN BENITO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (679, 'SAN GIL', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (682, 'SAN JOAQUÍN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (684, 'SAN JOSÉ DE MIRANDA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (686, 'SAN MIGUEL', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (689, 'SAN VICENTE DE CHUCURÍ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (705, 'SANTA BÁRBARA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (720, 'SANTA HELENA DEL OPÓN', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (745, 'SIMACOTA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (755, 'SOCORRO', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (770, 'SUAITA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (773, 'SUCRE', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (780, 'SURATÁ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (820, 'TONA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (855, 'VALLE DE SAN JOSÉ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (861, 'VÉLEZ', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (867, 'VETAS', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (872, 'VILLANUEVA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (895, 'ZAPATOCA', 68);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'SINCELEJO', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (110, 'BUENAVISTA', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (124, 'CAIMITO', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (204, 'COLOSO', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (215, 'COROZAL', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (221, 'COVEÑAS', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (230, 'CHALÁN', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (233, 'EL ROBLE', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (235, 'GALERAS', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (265, 'GUARANDA', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'LA UNIÓN', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (418, 'LOS PALMITOS', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (429, 'MAJAGUAL', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (473, 'MORROA', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (508, 'OVEJAS', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (523, 'PALMITO', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (670, 'SAMPUÉS', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (678, 'SAN BENITO ABAD', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (702, 'SAN JUAN DE BETULIA', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (708, 'SAN MARCOS', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (713, 'SAN ONOFRE', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (717, 'SAN PEDRO', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (742, 'SAN LUIS DE SINCÉ', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (771, 'SUCRE', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (820, 'SANTIAGO DE TOLÚ', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (823, 'TOLÚ VIEJO', 70);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'IBAGUÉ', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (024, 'ALPUJARRA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (026, 'ALVARADO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (030, 'AMBALEMA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (043, 'ANZOÁTEGUI', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (055, 'ARMERO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (067, 'ATACO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (124, 'CAJAMARCA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (148, 'CARMEN DE APICALÁ', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (152, 'CASABIANCA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (168, 'CHAPARRAL', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (200, 'COELLO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (217, 'COYAIMA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (226, 'CUNDAY', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (236, 'DOLORES', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (268, 'ESPINAL', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (270, 'FALAN', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (275, 'FLANDES', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (283, 'FRESNO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (319, 'GUAMO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (347, 'HERVEO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (349, 'HONDA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (352, 'ICONONZO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (408, 'LÉRIDA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (411, 'LÍBANO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (443, 'SAN SEBASTIÁN DE MARIQUITA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (449, 'MELGAR', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (461, 'MURILLO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (483, 'NATAGAIMA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (504, 'ORTEGA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (520, 'PALOCABILDO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (547, 'PIEDRAS', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (555, 'PLANADAS', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (563, 'PRADO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (585, 'PURIFICACIÓN', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (616, 'RIOBLANCO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (622, 'RONCESVALLES', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (624, 'ROVIRA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (671, 'SALDAÑA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (675, 'SAN ANTONIO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (678, 'SAN LUIS', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (686, 'SANTA ISABEL', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (770, 'SUÁREZ', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (854, 'VALLE DE SAN JUAN', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (861, 'VENADILLO', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (870, 'VILLAHERMOSA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (873, 'VILLARRICA', 73);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'CALI', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (020, 'ALCALÁ', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (036, 'ANDALUCÍA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (041, 'ANSERMANUEVO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (054, 'ARGELIA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (100, 'BOLÍVAR', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (109, 'BUENAVENTURA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (111, 'GUADALAJARA DE BUGA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (113, 'BUGALAGRANDE', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (122, 'CAICEDONIA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (126, 'CALIMA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (130, 'CANDELARIA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (147, 'CARTAGO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (233, 'DAGUA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (243, 'EL ÁGUILA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (246, 'EL CAIRO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (248, 'EL CERRITO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (250, 'EL DOVIO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (275, 'FLORIDA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (306, 'GINEBRA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (318, 'GUACARÍ', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (364, 'JAMUNDÍ', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (377, 'LA CUMBRE', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (400, 'LA UNIÓN', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (403, 'LA VICTORIA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (497, 'OBANDO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (520, 'PALMIRA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (563, 'PRADERA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (606, 'RESTREPO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (616, 'RIOFRÍO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (622, 'ROLDANILLO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (670, 'SAN PEDRO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (736, 'SEVILLA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (823, 'TORO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (828, 'TRUJILLO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (834, 'TULUÁ', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (845, 'ULLOA', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (863, 'VERSALLES', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (869, 'VIJES', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (890, 'YOTOCO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (892, 'YUMBO', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (895, 'ZARZAL', 76);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'MITÚ', 97);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (161, 'CARURU', 97);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (511, 'PACOA', 97);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (666, 'TARAIRA', 97);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (777, 'PAPUNAUA', 97);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (889, 'YAVARATÉ', 97);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (001, 'PUERTO CARREÑO', 99);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (524, 'LA PRIMAVERA', 99);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (624, 'SANTA ROSALÍA', 99);
INSERT INTO `ServiApp`.`CIUDADES` (`id_ciudad`, `nombre_ciudad`, `id_departamento`) VALUES (773, 'CUMARIBO', 99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiApp`.`TIPO_DOCUMENTOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiApp`;
INSERT INTO `ServiApp`.`TIPO_DOCUMENTOS` (`id_tipo_documento`, `nombre_documento`) VALUES ('CC', 'Cedula Ciudadania');
INSERT INTO `ServiApp`.`TIPO_DOCUMENTOS` (`id_tipo_documento`, `nombre_documento`) VALUES ('NIT', 'Numero Identificacion Tributaria');
INSERT INTO `ServiApp`.`TIPO_DOCUMENTOS` (`id_tipo_documento`, `nombre_documento`) VALUES ('PAS', 'Pasaporte ');
INSERT INTO `ServiApp`.`TIPO_DOCUMENTOS` (`id_tipo_documento`, `nombre_documento`) VALUES ('CE', 'Cedula De Extranjeria');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiApp`.`USUARIOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiApp`;
INSERT INTO `ServiApp`.`USUARIOS` (`id_usuario`, `nombres`, `apellidos`, `telefono`, `direccion`, `id_ciudad`, `id_departamento`, `email`, `fecha_nac`, `sexo`, `password`, `foto_perfil`, `id_tipo_documento`, `numero_documento`) VALUES (01, 'aura ', 'narvaez', '3175895415', 'calle 69a # 26 a 79', 001, 91, 'yeral.ns@hotmail.com', '1989-08-30', 'f', '1234', NULL, 'CC', '1256955895');
INSERT INTO `ServiApp`.`USUARIOS` (`id_usuario`, `nombres`, `apellidos`, `telefono`, `direccion`, `id_ciudad`, `id_departamento`, `email`, `fecha_nac`, `sexo`, `password`, `foto_perfil`, `id_tipo_documento`, `numero_documento`) VALUES (02, 'nora ', 'acosta', '3193784707', 'carrera 42 a # 66-119', 263, 91, 'izabelitap48@hotmail.com', '1994-07-17', 'f', '0000', NULL, 'CC', '1113669618');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiApp`.`ROLES`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiApp`;
INSERT INTO `ServiApp`.`ROLES` (`id_rol`, `nombre_rol`) VALUES ('ADMIN', 'Administrador');
INSERT INTO `ServiApp`.`ROLES` (`id_rol`, `nombre_rol`) VALUES ('USER', 'Usuario Estandar');
INSERT INTO `ServiApp`.`ROLES` (`id_rol`, `nombre_rol`) VALUES ('PRES', 'Prestador Servicio');

COMMIT;

