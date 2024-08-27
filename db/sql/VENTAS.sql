-- Active: 1724790339425@@127.0.0.1@3310
DROP DATABASE IF EXISTS VENTAS_SUCURSAL;

CREATE DATABASE IF NOT EXISTS VENTAS_SUCURSAL;

USE VENTAS_SUCURSAL;

-- -----------------------------------------------------
-- Table `PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRODUCTO` (
    `IDPRODUCTO` INT NOT NULL,
    `NOMBRE` VARCHAR(45) NULL,
    `PRECIO` DECIMAL NULL,
    `CANTIDAD` INT NULL,
    PRIMARY KEY (`IDPRODUCTO`)
);

-- -----------------------------------------------------
-- Table `SUCURSAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SUCURSAL` (
    `IDSUCURSAL` INT NOT NULL AUTO_INCREMENT,
    `DESCRIPCION` VARCHAR(45) NULL,
    PRIMARY KEY (`IDSUCURSAL`)
);

-- -----------------------------------------------------
-- Table `EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EMPLEADO` (
    `IDEMPLEADO` INT NOT NULL AUTO_INCREMENT,
    `IDEMPLEADO_ORIGINAL` INT NOT NULL,
    `NOMBRE` VARCHAR(45) NULL,
    `IDSUCURSAL` INT NULL,
    PRIMARY KEY (`IDEMPLEADO`)
);

-- -----------------------------------------------------
-- Table `FECHA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FECHA` (
    `IDFECHA` INT NOT NULL AUTO_INCREMENT,
    `FECHA` DATE NOT NULL UNIQUE,
    `ANIO` INT NULL,
    `MES` INT NULL,
    `DIA` INT NULL,
    PRIMARY KEY (`IDFECHA`)
);

-- -----------------------------------------------------
-- Table `VENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENTA` (
    `IDVENTA` INT NOT NULL AUTO_INCREMENT,
    `IDVENTAORIGINAL` INT NOT NULL,
    `IDEMPLEADO` INT NOT NULL,
    `IDPRODUCTO` INT NOT NULL,
    `IDSUCURSAL` INT NOT NULL,
    `IDFECHA` INT NOT NULL,
    `CANTIDADPRODUCTOS` INT NULL,
    `TOTALVENTA` DECIMAL NULL,
    `LINEA` INT NULL,
    `PRECIO` VARCHAR(45) NULL,
    PRIMARY KEY (
        `IDVENTA`,
        `IDEMPLEADO`,
        `IDPRODUCTO`,
        `IDSUCURSAL`,
        `IDFECHA`
    ),
    CONSTRAINT `fk_table4_EMPLEADO` FOREIGN KEY (`IDEMPLEADO`) REFERENCES `EMPLEADO` (`IDEMPLEADO`),
    CONSTRAINT `fk_table4_PRODUCTO1` FOREIGN KEY (`IDPRODUCTO`) REFERENCES `PRODUCTO` (`IDPRODUCTO`),
    CONSTRAINT `fk_table4_SUCURSAL1` FOREIGN KEY (`IDSUCURSAL`) REFERENCES `SUCURSAL` (`IDSUCURSAL`),
    CONSTRAINT `fk_VENTA_FECHA1` FOREIGN KEY (`IDFECHA`) REFERENCES `FECHA` (`IDFECHA`)
);