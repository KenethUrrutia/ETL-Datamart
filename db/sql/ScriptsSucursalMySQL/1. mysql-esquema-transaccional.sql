-- Active: 1724639250021@@127.0.0.1@3307@transaccional_p5
DROP DATABASE IF EXISTS transaccional_p5;

CREATE DATABASE transaccional_p5;

USE transaccional_p5;

CREATE TABLE tp5_empleado (
    tem_id INTEGER PRIMARY KEY,
    tem_nombre VARCHAR(100) NOT NULL,
    tem_email VARCHAR(50) NOT NULL,
    tem_pass VARCHAR(50) NOT NULL
);

CREATE TABLE tp5_producto (
    tpr_id INTEGER PRIMARY KEY,
    tpr_nombre VARCHAR(100) NOT NULL,
    tpr_precio DECIMAL(10, 2) NOT NULL,
    tpr_existencias INTEGER NOT NULL
);

CREATE TABLE tp5_maestro_venta (
    tmv_id INTEGER PRIMARY KEY,
    tmv_empleado INTEGER REFERENCES tp5_empleado (tem_id),
    tmv_fecha DATE NOT NULL
);

CREATE TABLE tp5_detalle_venta (
    tdv_venta INTEGER,
    tdv_linea INTEGER,
    tdv_producto INTEGER,
    tdv_cantidad INTEGER NOT NULL,
    tdv_precio_unitario DECIMAL(10, 2) NOT NULL,
    tdv_subtotal DECIMAL(12, 2) NOT NULL,
    CONSTRAINT pk_tp5_detalle_venta PRIMARY KEY (tdv_venta, tdv_linea)
);

ALTER TABLE tp5_detalle_venta
ADD CONSTRAINT fk_tp5_detalle_venta_tp5_producto FOREIGN KEY (tdv_producto) REFERENCES tp5_producto (tpr_id);

ALTER TABLE tp5_detalle_venta
ADD CONSTRAINT fk_tp5_detalle_venta_tp5_venta FOREIGN KEY (tdv_venta) REFERENCES tp5_maestro_venta (tmv_id);