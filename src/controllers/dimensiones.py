from src.common.utils import get_oracle_connection, get_mysql_connection, close_mysql_connection, close_oracle_connection, get_dim_mysql_connection, close_dim_mysql_connection
import pymysql

def etl_dim_fecha():  
    print("\n\n--------------------------------------------------------")  
    print("ETL Dimension Fecha\n")
    ora_connection = get_oracle_connection() # Conexión a Oracle
    mysql_connection = get_mysql_connection() # Conexión a MySQL
    dim_connection = get_dim_mysql_connection() # Conexión a MySQL para la tabla de dimension
    
    # Query para recuperar valores oracle
    ora_select_query = "SELECT UNIQUE tmv_fecha, EXTRACT(DAY FROM tmv_fecha), EXTRACT(MONTH FROM tmv_fecha), EXTRACT(YEAR FROM tmv_fecha) FROM tp5_maestro_venta"
    # Query para recuperar valores mysql 
    mysql_select_query = "SELECT DISTINCT tmv_fecha, EXTRACT( DAY FROM tmv_fecha ), EXTRACT( MONTH FROM tmv_fecha ), EXTRACT(YEAR FROM tmv_fecha) FROM tp5_maestro_venta"
    # Query para insertar valores en la tabla de dimension
    mysql_insert_query = "INSERT INTO FECHA (FECHA, ANIO, MES, DIA) VALUES (%s, %s, %s, %s)"

    try:
        # Crear un cursores para lectura
        ora_cursor = ora_connection.cursor()
        mysql_cursor = mysql_connection.cursor()
        dim_cursor = dim_connection.cursor()

        # Query para recuperar valores
        ora_cursor.execute(ora_select_query)
        mysql_cursor.execute(mysql_select_query)
        
        # Iterando sobre la lectura de oracle e insertando en dimension
        rows = ora_cursor.fetchall()
        for row in rows:
            try:
                print("Fecha:", row[0],"dia:", row[1], "mes:", row[2], "año:", row[3])
                data_to_insert = (row[0], row[3], row[2], row[1])
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
                print("Fecha:", row[0],"dia:", row[1], "mes:", row[2], "año:", row[3])
                data_to_insert = (row[0], row[3], row[2], row[1])                
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
          
def etl_dim_empleado():
    print("\n\n--------------------------------------------------------")  
    print("ETL Dimension Empleado\n")
    ora_connection = get_oracle_connection() # Conexión a Oracle
    mysql_connection = get_mysql_connection() # Conexión a MySQL
    dim_connection = get_dim_mysql_connection() # Conexión a MySQL para la tabla de dimension
    
    # Query para recuperar valores oracle
    ora_select_query = "SELECT UNIQUE TEM_ID, TEM_NOMBRE FROM TP5_EMPLEADO"
    # Query para recuperar valores mysql 
    mysql_select_query = "SELECT DISTINCT tem_id, tem_nombre FROM tp5_empleado"
    # Query para insertar valores en la tabla de dimension
    mysql_insert_query = "INSERT INTO EMPLEADO (IDEMPLEADO_ORIGINAL, NOMBRE, IDSUCURSAL) VALUES (%s, %s, %s)"

    try:
        # Crear un cursores para lectura
        ora_cursor = ora_connection.cursor()
        mysql_cursor = mysql_connection.cursor()
        dim_cursor = dim_connection.cursor()

        # Query para recuperar valores
        ora_cursor.execute(ora_select_query)
        mysql_cursor.execute(mysql_select_query)
        
        # Iterando sobre la lectura de oracle e insertando en dimension
        rows = ora_cursor.fetchall()
        for row in rows:
            try:
                print("ID:", row[0],"nombre:", row[1])
                data_to_insert = (row[0], row[1], "1")
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
                print("ID:", row[0],"nombre:", row[1])
                data_to_insert = (row[0], row[1], "2")            
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

def etl_dim_producto():
    print("\n\n--------------------------------------------------------")  
    print("ETL Dimension Producto\n")
    ora_connection = get_oracle_connection() # Conexión a Oracle
    mysql_connection = get_mysql_connection() # Conexión a MySQL
    dim_connection = get_dim_mysql_connection() # Conexión a MySQL para la tabla de dimension
    
    # Query para recuperar valores oracle
    ora_select_query = "SELECT tpr_id, tpr_nombre, tpr_precio, tpr_existencias FROM tp5_producto"
    # Query para recuperar valores mysql 
    mysql_select_query = "SELECT tpr_id, tpr_nombre, tpr_precio, tpr_existencias FROM tp5_producto"
    # Query para insertar valores en la tabla de dimension
    mysql_insert_query = "INSERT INTO PRODUCTO (IDPRODUCTO, NOMBRE, PRECIO, CANTIDAD) VALUES (%s, %s, %s, %s)"
    # Query para sumar las existencias de los productos
    mysql_update_query = "UPDATE PRODUCTO SET CANTIDAD = CANTIDAD + %s WHERE IDPRODUCTO = %s"
    try:
        # Crear un cursores para lectura
        ora_cursor = ora_connection.cursor()
        mysql_cursor = mysql_connection.cursor()
        dim_cursor = dim_connection.cursor()

        # Query para recuperar valores
        ora_cursor.execute(ora_select_query)
        mysql_cursor.execute(mysql_select_query)
        
        # Iterando sobre la lectura de oracle e insertando en dimension
        rows = ora_cursor.fetchall()
        for row in rows:
            try:
                print("ID:", row[0],"nombre:", row[1], "Precio:", row[2], "Cantidad:", row[3])
                data_to_insert = (row[0], row[1], row[2], row[3])
                dim_cursor.execute(mysql_insert_query, data_to_insert)
            except pymysql.IntegrityError as integrity_error:
                # Al encontrar un valor repetido para la columna que usa constraint unique
                dim_cursor.execute(mysql_update_query, (row[3], row[0]))
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
                print("ID:", row[0],"nombre:", row[1], "Precio:", row[2], "Cantidad:", row[3])
                data_to_insert = (row[0], row[1], row[2], row[3])
                dim_cursor.execute(mysql_insert_query, data_to_insert)
            except pymysql.IntegrityError as integrity_error:
                # Al encontrar un valor repetido para la columna que usa constraint unique
                dim_cursor.execute(mysql_update_query, (row[3], row[0]))
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

def etl_dim_sucursal():
    print("\n\n--------------------------------------------------------")  
    print("ETL Dimension Sucursal\n")
    dim_connection = get_dim_mysql_connection() # Conexión a MySQL para la tabla de dimension
    
    # Query para insertar valores en la tabla de dimension
    mysql_insert_query = "INSERT INTO SUCURSAL (IDSUCURSAL, DESCRIPCION) VALUES (%s, %s)"

    try:
        # Crear un cursores para lectura
        dim_cursor = dim_connection.cursor()
        
        try:
            data_to_insert = (1, "Sucursal 1 que utiliza oracle")
            print("ID:", data_to_insert[0],"nombre:", data_to_insert[1])
            dim_cursor.execute(mysql_insert_query, data_to_insert)

            data_to_insert = (2, "Sucursal 2 que utiliza mysql")
            print("ID:", data_to_insert[0],"nombre:", data_to_insert[1])
            dim_cursor.execute(mysql_insert_query, data_to_insert)
            
        except pymysql.IntegrityError as integrity_error:
            # Al encontrar un valor repetido para la columna que usa constraint unique
            print(f"Unique constraint violated: {integrity_error}")
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
