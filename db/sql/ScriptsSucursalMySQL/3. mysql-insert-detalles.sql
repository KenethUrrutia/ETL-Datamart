USE transaccional_p5;

SET GLOBAL log_bin_trust_function_creators = 1;
-- Funcion para elegir un codigo de producto aleatorio que no se haya usado en una venta
DROP FUNCTION IF EXISTS RAND_PROD_ID;
DELIMITER $$
CREATE FUNCTION RAND_PROD_ID(id_venta INTEGER)
RETURNS INTEGER
BEGIN
    DECLARE v_producto INTEGER;
    DECLARE v_count INTEGER DEFAULT 0;
    -- Verificar si existe al menos una linea de detalle para la venta
    SELECT 
        COUNT(*) INTO v_count
    FROM tp5_detalle_venta
    WHERE tdv_venta = id_venta;
	
    SELECT 
		tpr_id INTO v_producto
	FROM
		tp5_producto
	WHERE tpr_id NOT IN (
		SELECT tdv_producto
		FROM tp5_detalle_venta
		WHERE tdv_venta = id_venta
	)
	ORDER BY RAND()
	LIMIT 1;
    -- IF v_count > 0 THEN
--         SELECT 
--             tpr_id INTO v_producto
--         FROM
--             tp5_producto
--         WHERE tpr_id NOT IN (
--             SELECT tdv_producto
--             FROM tp5_detalle_venta
--             WHERE tdv_venta = id_venta
--         )
--         ORDER BY RAND()
--         LIMIT 1;  
--     ELSE        
--         SELECT 
--             tpr_id INTO v_producto
--         FROM
--             tp5_producto
--         ORDER BY RAND()
--         LIMIT 1;
--     END IF;   
    
    RETURN v_producto;
END$$

DELIMITER ;


-- Inserciones para la tabla tp5_detalle_venta
DROP PROCEDURE IF EXISTS RAND_DETALLE_VENTA;
DELIMITER $$
CREATE PROCEDURE RAND_DETALLE_VENTA() 
BEGIN


  DECLARE v_id_venta INTEGER;
  DECLARE v_cantidad INTEGER DEFAULT 0;
  DECLARE v_count_lineas_venta INTEGER DEFAULT 0; 
  DECLARE v_linea INTEGER DEFAULT 0;
  
  DECLARE done BOOL DEFAULT false;

  DECLARE c_ventas CURSOR FOR
  SELECT tmv_id
  FROM tp5_maestro_venta; -- Selecciona las tuplas que formarán el cursor
  -- handle para not found
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
  
  SET SQL_SAFE_UPDATES = 0;
  -- Borrando registros previos 
  DELETE FROM tp5_detalle_venta;
  
  -- Abrir el cursor
  OPEN c_ventas;

  -- Loop a traves de los registros del cursor
  detallar_ventas: LOOP
    -- Recuperar el ID del ejemplar
    FETCH c_ventas INTO v_id_venta;
    
    IF done = true THEN 
		LEAVE detallar_ventas;
	END IF;
    
    SET v_count_lineas_venta = FLOOR(RAND()*5+1);
    SET v_linea = 1;
    
    insert_lineas: LOOP
		
        SET v_cantidad = FLOOR(RAND()*9+1);
        INSERT INTO tp5_detalle_venta (tdv_venta, tdv_linea, tdv_producto, tdv_cantidad, tdv_precio_unitario, tdv_subtotal) VALUES
            (
                v_id_venta, 
                v_linea, 
                RAND_PROD_ID(v_id_venta), 
                v_cantidad, 
                0.00, 
                0.00
            );		
        
		IF v_linea = v_count_lineas_venta THEN
			LEAVE insert_lineas;
		END IF;
        
		SET v_linea = v_linea + 1;
    END LOOP;
    
  END LOOP;
    
  -- Cerrar el cursor
  CLOSE c_ventas;
  
  -- Actualizando valores de precio unitario y total
  UPDATE tp5_detalle_venta
  SET
    tdv_precio_unitario = (SELECT tpr_precio FROM tp5_producto WHERE tpr_id = tdv_producto);

  UPDATE tp5_detalle_venta
  SET
    tdv_subtotal = tdv_cantidad*tdv_precio_unitario; 
  SET SQL_SAFE_UPDATES = 1;
  
END$$
DELIMITER ;

CALL RAND_DETALLE_VENTA();


SELECT * FROM tp5_detalle_venta ORDER BY tdv_venta, tdv_linea;

   
