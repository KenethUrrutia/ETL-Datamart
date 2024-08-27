--DROP TABLE tp5_detalle_venta;
--DROP TABLE tp5_maestro_venta;
--DROP TABLE tp5_producto;
--DROP TABLE tp5_empleado;

CREATE TABLE tp5_empleado (
    tem_id NUMBER PRIMARY KEY,
    tem_nombre VARCHAR2(100) NOT NULL,
    tem_email VARCHAR2(50) NOT NULL,
    tem_pass VARCHAR2(50) NOT NULL
);

CREATE TABLE tp5_producto (
    tpr_id NUMBER PRIMARY KEY,
    tpr_nombre VARCHAR2(100) NOT NULL,
    tpr_precio NUMBER(10, 2) NOT NULL,
    tpr_existencias NUMBER NOT NULL
);

CREATE TABLE tp5_maestro_venta (
    tmv_id NUMBER PRIMARY KEY,
    tmv_empleado NUMBER REFERENCES tp5_empleado(tem_id),
    tmv_fecha DATE NOT NULL
);

CREATE TABLE tp5_detalle_venta (
    tdv_venta NUMBER REFERENCES tp5_maestro_venta(tmv_id),
    tdv_linea NUMBER,    
    tdv_producto NUMBER,
    tdv_cantidad NUMBER NOT NULL,
    tdv_precio_unitario NUMBER(10, 2) NOT NULL,
    tdv_subtotal NUMBER(12, 2) NOT NULL,
    CONSTRAINT pk_tp5_detalle_venta PRIMARY KEY (tdv_venta, tdv_linea)
);


ALTER TABLE tp5_detalle_venta ADD CONSTRAINT fk_tp5_detalle_venta_tp5_producto FOREIGN KEY (tdv_producto) REFERENCES tp5_producto(tpr_id);

