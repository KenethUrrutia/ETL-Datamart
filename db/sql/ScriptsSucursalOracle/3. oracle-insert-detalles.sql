SET SERVEROUTPUT ON;
--Funcion para elegir un codigo de producto aleatorio que no se haya usado en una venta
CREATE OR REPLACE FUNCTION RAND_PROD_ID(id_venta NUMBER)
RETURN NUMBER
IS
    v_producto tp5_producto.tpr_id%TYPE;
    v_count NUMBER DEFAULT 0;
BEGIN
    --Seed al modulo random
    DBMS_RANDOM.SEED (TO_NUMBER(TO_CHAR(SYSDATE, 'SSSSS')));
    
    --Verificar si existe al menos una linea de detalle para la venta
    SELECT 
        COUNT(*) INTO v_count
    FROM tp5_detalle_venta
    WHERE tdv_venta = id_venta;
       
    IF v_count > 0 THEN
        SELECT 
            tpr_id INTO v_producto
        FROM
            tp5_producto
        WHERE tpr_id NOT IN (
            SELECT tdv_producto
            FROM tp5_detalle_venta
            WHERE tdv_venta = id_venta
        )
        ORDER BY DBMS_RANDOM.RANDOM
        FETCH FIRST 1 ROWS ONLY;  
    ELSE        
        SELECT 
            tpr_id INTO v_producto
        FROM
            tp5_producto
        ORDER BY DBMS_RANDOM.RANDOM
        FETCH FIRST 1 ROWS ONLY;
    END IF;   
    
    RETURN v_producto;
END;
/


-- Inserciones para la tabla tp5_detalle_venta
CREATE OR REPLACE PROCEDURE RAND_DETALLE_VENTA AS
  CURSOR c_ventas IS
    SELECT tmv_id
    FROM tp5_maestro_venta; -- Selecciona las tuplas que formarán el cursor

  v_id_venta tp5_detalle_venta.tdv_venta%TYPE;
  v_cantidad INTEGER DEFAULT 0;
  v_count_lineas_venta INTEGER DEFAULT 0;  
  
BEGIN
  --Borrando registros previos 
  DELETE FROM tp5_detalle_venta;
  
  DBMS_RANDOM.SEED (TO_NUMBER(TO_CHAR(SYSDATE, 'SSSSS')));
  -- Abrir el cursor
  OPEN c_ventas;

  -- Loop a traves de los registros del cursor
  LOOP
    -- Recuperar el ID del ejemplar
    FETCH c_ventas INTO v_id_venta;
    EXIT WHEN c_ventas%NOTFOUND;
    
    v_count_lineas_venta := DBMS_RANDOM.VALUE(1,5);
    DBMS_OUTPUT.PUT_LINE(v_id_venta || ', lineas: ' || v_count_lineas_venta);
    
    FOR linea IN 1 .. v_count_lineas_venta
    LOOP
        v_cantidad := DBMS_RANDOM.VALUE(1,10);
        INSERT INTO tp5_detalle_venta (tdv_venta, tdv_linea, tdv_producto, tdv_cantidad, tdv_precio_unitario, tdv_subtotal) VALUES
            (
                v_id_venta, 
                linea, 
                RAND_PROD_ID(v_id_venta), 
                v_cantidad, 
                0.00, 
                0.00
            );
    END LOOP;
    
  END LOOP;
    
  -- Cerrar el cursor
  CLOSE c_ventas;
  
  --Actualizando valores de precio unitario y total
  UPDATE tp5_detalle_venta
  SET
    tdv_precio_unitario = (SELECT tpr_precio FROM tp5_producto WHERE tpr_id = tdv_producto);
    
  UPDATE tp5_detalle_venta
  SET
    tdv_subtotal = tdv_cantidad*tdv_precio_unitario; 

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al insertar en la columna tp5_detalle_venta.');
END;
/

BEGIN 
    RAND_DETALLE_VENTA();
END;
/

SELECT * FROM tp5_detalle_venta ORDER BY tdv_venta, tdv_linea;

   
