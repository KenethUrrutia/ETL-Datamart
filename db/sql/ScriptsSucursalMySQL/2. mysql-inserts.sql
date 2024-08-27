-- INSERTS

USE transaccional_p5;

-- Inserciones para la tabla tp5_empleado
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(1, 'Alondra Gomez', 'alondrag@example.com', 'clave1');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(2, 'Sofía Sánchez', 'ssofia@example.com', 'clave2');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(3, 'Juan López', 'ljuan@example.com', 'clave3');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(4, 'Dora Argueta', 'adorita@example.com', 'clave4');
INSERT INTO tp5_empleado (tem_id, tem_nombre, tem_email, tem_pass) VALUES
(5, 'Javier Ramírez', 'rjavier@example.com', 'clave5');

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
INSERT INTO tp5_producto (tpr_id, tpr_nombre, tpr_precio, tpr_existencias) VALUES
(106, 'Escritorio basico', 950, 20);

-- Inserciones para la tabla tp5_maestro_venta
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(101, 5, '2023-09-01');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(102, 3, '2023-09-02');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(103, 1, '2023-09-03');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(104, 1, '2023-09-04');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(105, 2, '2023-09-05');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(106, 5, '2023-09-06');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(107, 4, '2023-09-07');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(108, 4, '2023-09-08');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(109, 2, '2023-09-09');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(110, 3, '2023-09-10');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(111, 1, '2023-09-11');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(112, 2, '2023-09-12');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(113, 3, '2023-09-13');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(114, 4, '2023-09-14');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(115, 3, '2023-09-15');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(116, 3, '2023-09-16');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(117, 2, '2023-09-17');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(118, 3, '2023-09-18');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(119, 4, '2023-09-19');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(120, 5, '2023-09-20');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(121, 2, '2023-09-21');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(122, 1, '2023-09-22');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(123, 2, '2023-09-23');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(124, 4, '2023-09-24');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(125, 5, '2023-09-25');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(126, 1, '2023-09-26');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(127, 3, '2023-09-26');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(128, 2, '2023-09-28');
INSERT INTO tp5_maestro_venta (tmv_id, tmv_empleado, tmv_fecha) VALUES
(129, 4, '2023-09-30');

SELECT * FROM tp5_producto;
SELECT * FROM tp5_empleado;
SELECT * FROM tp5_maestro_venta;