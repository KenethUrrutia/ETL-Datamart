from src.common.utils import get_oracle_connection, get_mysql_connection, close_mysql_connection, close_oracle_connection, get_dim_mysql_connection, close_dim_mysql_connection
import pymysql

def etl_fact_ventas():    
    print("\n\n--------------------------------------------------------")  
    print("ETL Hecho Venta\n")
    ora_connection = get_oracle_connection() # Conexión a Oracle
    mysql_connection = get_mysql_connection() # Conexión a MySQL
    dim_connection = get_dim_mysql_connection() # Conexión a MySQL para la tabla de dimension
    
    # Query para recuperar valores oracle y mysql
    select_query = "SELECT tmv.tmv_id, tmv.tmv_empleado, tdv.tdv_producto, tmv.tmv_fecha, tdv.tdv_cantidad, tdv.tdv_subtotal, tdv.tdv_linea, tdv.tdv_precio_unitario FROM tp5_maestro_venta tmv INNER JOIN tp5_detalle_venta tdv ON tmv.tmv_id = tdv.tdv_venta"
    # Query para insertar valores en la tabla de dimension
    mysql_insert_query = "INSERT INTO VENTA (IDVENTAORIGINAL, IDEMPLEADO, IDPRODUCTO, IDSUCURSAL, IDFECHA, CANTIDADPRODUCTOS, TOTALVENTA, LINEA, PRECIO) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"

    try:
        # Crear un cursores para lectura
        ora_cursor = ora_connection.cursor()
        mysql_cursor = mysql_connection.cursor()
        dim_cursor = dim_connection.cursor()

        # Query para recuperar valores
        ora_cursor.execute(select_query)
        mysql_cursor.execute(select_query)
        
        # Iterando sobre la lectura de oracle e insertando en dimension
        rows = ora_cursor.fetchall()
        for row in rows:
            try:
                idventaoriginal = row[0]
                dim_cursor.execute("SELECT IDEMPLEADO FROM EMPLEADO WHERE IDEMPLEADO_ORIGINAL = %s AND IDSUCURSAL = 1", (row[1],))
                idempleado = dim_cursor.fetchone()[0]
                idproducto = row[2]
                idsucursal = "1"
                dim_cursor.execute("SELECT IDFECHA FROM FECHA WHERE FECHA = %s", (row[3],))
                idfecha = dim_cursor.fetchone()[0]
                cantidadproductos = row[4]
                totalventa = row[5]
                linea = row[6]
                precio = row[7]

                print("IDVenta:", idventaoriginal, "Empleado:", idempleado, "Producto:", idproducto, "Sucursal:", idsucursal, "Fecha:", idfecha, "Cantidad:", cantidadproductos, "Total:", totalventa, "Linea:", linea, "Precio:", precio)
                data_to_insert = (idventaoriginal, idempleado, idproducto, idsucursal, idfecha, cantidadproductos, totalventa, linea, precio)
                dim_cursor.execute(mysql_insert_query, data_to_insert)
            except pymysql.IntegrityError as integrity_error:
                # Al encontrar un valor repetido para la columna que usa constraint unique
                print(f"Unique constraint violated: {integrity_error}")
                # Se continua con el siguiente registro
                continue
            except pymysql.Error as error:
                # otras excepciones de base de datos
                print(f"Database error: {error}")
                continue
        dim_connection.commit() # Confirmar cambios en la base de datos

        # Iterando sobre la lectura de mysql e insertando en dimension
        rows = mysql_cursor.fetchall()
        for row in rows:
            try:
                idventaoriginal = row[0]
                dim_cursor.execute("SELECT IDEMPLEADO FROM EMPLEADO WHERE IDEMPLEADO_ORIGINAL = %s AND IDSUCURSAL = 2", (row[1], ))
                idempleado = dim_cursor.fetchone()[0]
                idproducto = row[2]
                idsucursal = "2"
                dim_cursor.execute("SELECT IDFECHA FROM FECHA WHERE FECHA = %s", (row[3],))
                idfecha = dim_cursor.fetchone()[0]
                cantidadproductos = row[4]
                totalventa = row[5]
                linea = row[6]
                precio = row[7]

                print("IDVenta:", idventaoriginal, "Empleado:", idempleado, "Producto:", idproducto, "Sucursal:", idsucursal, "Fecha:", idfecha, "Cantidad:", cantidadproductos, "Total:", totalventa, "Linea:", linea, "Precio:", precio)
                data_to_insert = (idventaoriginal, idempleado, idproducto, idsucursal, idfecha, cantidadproductos, totalventa, linea, precio)
                dim_cursor.execute(mysql_insert_query, data_to_insert)
            except pymysql.IntegrityError as integrity_error:
                # Al encontrar un valor repetido para la columna que usa constraint unique
                print(f"Unique constraint violated: {integrity_error}")
                # Se continua con el siguiente registro
                continue
            except pymysql.Error as error:
                # otras excepciones de base de datos
                print(f"Database error: {error}")
                continue
        dim_connection.commit() # Confirmar cambios en la base de datos

    except pymysql.Error as e:
        dim_connection.rollback()
        print(f"Error al ejecutar la consulta: {e}")
    finally:
        # Cerrar cursores
        if ora_cursor:
            ora_cursor.close()
        if mysql_cursor:
            mysql_cursor.close()
        if dim_cursor:
            dim_cursor.close()
        # Cerrar conexiones
        if ora_connection: 
            close_oracle_connection(ora_connection)
        if mysql_connection:
            close_mysql_connection(mysql_connection)
        if dim_connection:
            close_dim_mysql_connection(dim_connection)
   