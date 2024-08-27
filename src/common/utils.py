import cx_Oracle
import pymysql

#Conexión a la base de datos dimensional
def get_dim_mysql_connection():
    try:
        connection = pymysql.connect(
            host='localhost',       
            database='VENTAS_SUCURSAL', 
            user='root',      
            password='201940854',
            port=3310
        )
        return connection
    except pymysql.Error as e:
        print(f"Error al conectar a MySQL: {e}")
        return None
    
def close_dim_mysql_connection(connection):
    try:
        connection.close()
    except pymysql.Error as e:
        print(f"Error al cerrar conexión a MySQL: {e}")


#Conexión a la base de datos transaccional de mysql
def get_mysql_connection():
    try:
        connection = pymysql.connect(
            host='localhost',       
            database='transaccional_p5', 
            user='root',      
            password='201940854',
            port=3307  
        )
        return connection
    except pymysql.Error as e:
        print(f"Error al conectar a MySQL: {e}")
        return None

def close_mysql_connection(connection):
    try:
        connection.close()
    except pymysql.Error as e:
        print(f"Error al cerrar conexión a MySQL: {e}")


#Conexión a la base de datos transaccional de oracle
def get_oracle_connection():
    db_user = "FOO"
    db_password = "201940854"
    db_service = "192.168.56.102:1521/xe"
    try:
        # Configurar la conexión a Oracle
        connection = cx_Oracle.connect(db_user, db_password, db_service)
        return connection
    except cx_Oracle.DatabaseError as e:
        print(f"Error al conectar a Oracle: {e}")
        return None

def close_oracle_connection(connection):
    try:
        if connection:
            connection.close()
    except cx_Oracle.DatabaseError as e:
        print(f"Error al cerrar conexión a Oracle: {e}")
