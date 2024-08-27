-- INSERTS

-- Inserciones para la tabla tp5_empleado
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(1, 'Juan Pérez', 'juan.perez@example.com', 'clave1');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(2, 'María Rodríguez', 'maria.rodriguez@example.com', 'clave2');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(3, 'Pedro López', 'pedro.lopez@example.com', 'clave3');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(4, 'Ana García', 'ana.garcia@example.com', 'clave4');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(5, 'Carlos Martínez', 'carlos.martinez@example.com', 'clave5');

-- Inserciones para la tabla tp5_producto
INSERT INTO tp5_producto (tpr_id, tpr_nombre, tpr_precio, tpr_existencias) VALUES
(101, 'Escritorio ejecutivo premium', 1500, 100);
INSERT INTO tp5_producto (tpr_id, tpr_nombre, tpr_precio, tpr_existencias) VALUES
(102, 'Escritorio ejecutivo premium plus', 1975, 50);
INSERT INTO tp5_producto (tpr_id, tpr_nombre, tpr_precio, tpr_existencias) VALUES
(103, 'Silla ejecutiva básica', 899, 75);
INSERT INTO tp5_producto (tpr_id, tpr_nombre, tpr_precio, tpr_existencias) VALUES
(104, 'Silla ejecutiva premium', 1225, 30);
INSERT INTO tp5_producto (tpr_id, tpr_nombre, tpr_precio, tpr_existencias) VALUES
(105, 'Silla ejecutiva ergonomica', 4970, 90);

-- Inserciones para la tabla tp5_maestro_venta
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1001, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1002, 2, TO_DATE('2023-09-02', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1003, 3, TO_DATE('2023-09-03', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1004, 2, TO_DATE('2023-09-04', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1005, 5, TO_DATE('2023-09-05', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1006, 1, TO_DATE('2023-09-06', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1007, 2, TO_DATE('2023-09-07', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1008, 3, TO_DATE('2023-09-08', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1009, 2, TO_DATE('2023-09-09', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1010, 3, TO_DATE('2023-09-10', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1011, 1, TO_DATE('2023-09-11', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1012, 2, TO_DATE('2023-09-12', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1013, 3, TO_DATE('2023-09-13', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1014, 4, TO_DATE('2023-09-14', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1015, 3, TO_DATE('2023-09-15', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1016, 3, TO_DATE('2023-09-16', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1017, 2, TO_DATE('2023-09-17', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1018, 3, TO_DATE('2023-09-18', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1019, 4, TO_DATE('2023-09-19', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1020, 5, TO_DATE('2023-09-20', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1021, 3, TO_DATE('2023-09-21', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1022, 2, TO_DATE('2023-09-22', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1023, 4, TO_DATE('2023-09-23', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1024, 4, TO_DATE('2023-09-24', 'YYYY-MM-DD'));
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(1025, 5, TO_DATE('2023-09-25', 'YYYY-MM-DD'));

SELECT * FROM tp5_producto;
SELECT * FROM tp5_empleado;
SELECT * FROM tp5_maestro_venta;
SELECT * FROM tp5_detalle_venta;



