from src.common.utils import get_dim_mysql_connection, close_dim_mysql_connection
import pymysql

def etl_limpiar_datos():
    dim_connection = get_dim_mysql_connection() # Conexión a MySQL para la tabla de dimension

    try:
        # Crear un cursores para lectura
        dim_cursor = dim_connection.cursor()
        
        try:
            mysql_query = "SET FOREIGN_KEY_CHECKS = 0"
            dim_cursor.execute(mysql_query)
            mysql_query = "TRUNCATE TABLE VENTA"
            dim_cursor.execute(mysql_query)
            mysql_query = "TRUNCATE TABLE EMPLEADO"
            dim_cursor.execute(mysql_query)
            mysql_query = "TRUNCATE TABLE FECHA"
            dim_cursor.execute(mysql_query)
            mysql_query = "TRUNCATE TABLE PRODUCTO"
            dim_cursor.execute(mysql_query)
            mysql_insert_query = "TRUNCATE TABLE SUCURSAL"
            dim_cursor.execute(mysql_insert_query)
            mysql_query = "SET FOREIGN_KEY_CHECKS = 1"
            dim_cursor.execute(mysql_insert_query)

            print("Datos limpiados correctamente")
        except pymysql.Error as error:
            # otras excepciones de base de datos
            print(f"Database error: {error}")

        dim_connection.commit() # Confirmar cambios en la base de datos

    except pymysql.Error as e:
        dim_connection.rollback()
        print(f"Error al ejecutar la consulta: {e}")
    finally:
        # Cerrar cursores
        if dim_cursor:
            dim_cursor.close()
        # Cerrar conexiones
        if dim_connection:
            close_dim_mysql_connection(dim_connection)