Para esta práctica creará un datamart a partir de bases de datos transaccionales, por medio de un proceso de ETL implementado en Python.

**Bases de datos transaccionales:**

Se usarán dos bases de datos como fuentes de información, una en Oracle y la otra en MySQL. Para este escenario asuma que existen dos sucursales de un mismo negocio, pero cada sucursal funciona de manera independiente, cada una con su propia base de datos, una sucursal implementada en Oracle y la otra sucursal en MySQL. Los empleados de cada sucursal son mutuamente excluyentes (los empleados solo laboran en una sucursal) pero los códigos de productos son los mismos en las dos sucursales.

Los modelos transaccionales pueden ser ligeramente distintos entre sí, pero ambos deben tener al menos las siguientes tablas:

- Producto
- MaestroVenta
- DetalleVenta
- Empleado

Realizar inserciones en ambas bases de datos, al menos 5 empleados, 10 productos y al menos 20 ventas para cada sucursal.

**Proceso para crear Base de Datos de Sucursal en Oracle**

En la carpeta `./db/sql/ScriptsSucursalOracle` se encuentran los scripts para generar Base de Datos Transaccional de la sucursal.

Debe ejecutar los scripts en el siguiente orden:

1. oracle-esquema-transaccional.sql
2. oracle-inserts.sql
3. oracle-insert-detalles.sql 

**Proceso para crear Base de Datos de Sucursal en Oracle**

En la carpeta `./db/sql/ScriptsSucursalMySQL` se encuentran los scripts para generar Base de Datos Transaccional de la sucursal.

Debe ejecutar los scripts en el siguiente orden:

1. mysql-esquema-transaccional.sql
2. mysql-inserts.sql
3. mysql-insert-detalles.sql

**Datamart:**

Deberá crearlo en diseño de estrella, con una tabla de hechos central y tablas de dimensión para empleados, productos y sucursal. Las tablas de dimensión deberán contener los campos de llave y una descripción, mientras que la tabla de hechos contendrá los campos de llave primaria, referencias a las dimensiones y las medidas que se consideraron necesarias.

**ETL:**

Para el proceso ETL desarrolle un programa en Python que realice las siguientes operaciones:

- **Limpiar los datos del datamart:** eliminar todas las tuplas de todas las tablas del datamart (si existieran debido a una prueba anterior).
    
- **Poblar las tablas de dimensiones:** realizar consultas a las bases de datos de ambas sucursales y realizar inserciones al datamart.
    
- **Poblar la tabla de hechos:** realizar consultas a las bases de datos de ambas sucursales, asegurándose de utilizar funciones de agregación si se necesitan y realizar inserciones al datamart.
    

Asumiremos que los sistemas transaccionales de las sucursales tendrán esquemas similares. Además, estarán implementados en los motores: Oracle y MySQL. El modelo dimensional se implementará en MySQL.

**Implementación**

**Estructura del programa:**

├── app.py
├── db
│   ├── data
│   └── sql
│       ├── ScriptsSucursalMySQL
│       ├── ScriptsSucursalOracle
│       ├── 2. ModeloDimensional.png
│       ├── VENTAS.mwb
│       └── VENTAS.sql
├── requirements.txt
└── src
    ├── common
    │   └── utils.py
    └── controllers
        ├── dimensiones.py
        ├── hechos.py
        ├── limpiar.py

- **app.py** contiene la aplicación principal, que consta de un bucle con un menú de opciones
- **Limpiar los datos del datamart:** elimina todas las tuplas de todas las tablas del datamart (si existieran debido a una prueba anterior).
- **Poblar las tablas de dimensiones:** realiza consultas a las bases de datos de ambas sucursales y realiza las inserciones a las tablas de dimensiones del datamart.
- **Poblar la tabla de hechos:** realizar consultas a las bases de datos de ambas sucursales, y realiza las inserciones a la tabla de hechos del datamart.
- **Salir:** salir del programa
- **db/data** usada como volumen enlazado al Contenedor Docker con la base de datos dimensional, almacenando los datos de manera persistente.
- **db/sql** contiene el DDL de la base de datos, y el diagrama dimensional en formato png y mwb para visualizarlo en MySQLWorkbench.
- **db/sql/ScriptsSucursalMySQL** contiene los scripts de creación en inserción de tablas de la sucursal con mysql
- **db/sql/ScriptsSucursalOracle** contiene los scripts de creación en inserción de tablas de la sucursal con oracle
- **requirements.txt** para el desarrollo del programa se utilizó entornos virtuales de python, en este documento se almacenan las dependencias necesarias para el funcionamiento del programa.
- **src/common/utils.py** aqui se definen funciones para conectarse a las diferentes bases de datos.
- **src/controllers/dimensiones.py** contiene las funciones para poblar las tablas de dimensiones.
- **src/controllers/hechos.py** contiene las funciones para poblar la tabla de hechos.
- **src/controllers/limpiar.py** contiene la función que limpia los datos del datamart.

**Pasos para iniciar el Programa de ETL Datamart**

1. **Creación de Virtual Environments en Python**

Se utilizaron entornos virtuales de python para utilizar el programa de manera aislada. Para crear el entorno virtual ejecute:

```
python3 -m venv ./.venv
```

Para activar el entorno virtual ejecute:

```
source .venv/bin/activate 
```

Una vez activo, si utiliza VisualStudioCode, en la terminal se mostrará al inicio del Prompt el entorno en el que se encuentra:

A veces no se reconocen algunas librerías dentro de los archivos de python, puede ser que no se esté trabajando en el entorno virtual. Para esto presione Ctrl + Shift + P para abrir la paleta de comando de VSCode, y escriba select interpreter:

Secciona la opción y elige el entorno virtual (.venv):

**Instalar los requerimientos y dependencias python**   

Para que el programa se ejecute se necesitan la siguientes dependencias:

```
cffi==1.17.0

cryptography==43.0.0

cx-Oracle==8.3.0

mysql-connector==2.2.9

pycparser==2.22

PyMySQL==1.1.1

```
En los archivos del programa se encuentra el archivo `requirements.txt` que contiene estas dependencias, para instalarlas en el entorno virtual ejecutar el siguiente comando:

```
pip install -r requirements.txt
```

3. **Bases de Datos**
    

Este programa consta de 3 conexiones a base de datos:

- Base de Datos Transaccional de Sucursal 1 (OracleDB)
    
- Base de Datos Transaccional de Sucursal 2 (MySQL)
    
- Base de Datos Dimensional (MySQL)
    

En el caso de las bases de datos transaccionales, estas se encuentran alojadas en su respectivo servidor, mientras que para la base de datos dimensional se pensó que estuviera relacionada al programa y que fuera gestionada por un contenedor de Docker:

Para levantar el contenedor de la base de datos dimensional ejecute en la carpeta raíz del programa:

```
docker run -d  --name nombre -v ./db/data:/var/lib/mysql -p 3310:3306 -e MYSQL_ROOT_PASSWORD=password mysql
```

Cambie los datos de nombre y password a su criterio.

Puede cambiar el valor de los puertos a uno que considere conveniente.

Abra una terminal y ejecute el siguiente comando para acceder al mysql client de la base de datos:

```
mysql -h localhost -P 3310 -u root -p
```

Le pedirá ingresar la contraseña previamente establecida. Una vez dentro ejecute el siguiente comando para poder acceder a la base de datos por medio del programa ETL:

```
ALTER USER 'root'@'localhost' IDENTIFIED WITH sha256_password BY 'password';
FLUSH PRIVILEGES;
```

Recuerde cambiar el valor de password por la contraseña establecida a su criterio.

Puede gestionar diferentes usuarios si así lo desea, en este caso se aplicó al usuario root.

Ahora podemos utilizar nuestro gestor de bases de datos preferido, en mi caso utilizaré la extensión de VSCode llamada MySQL de database-client.com

Crearemos una nueva conexión con los datos del contenedor que creamos y le daremos en el botón de conectar:

Ejecutaremos el script DDL ubicado en `./db/sql/VENTAS.sql` y lo ejecutamos para crear las tablas del modelo dimensional:
Con esto podemos proceder a conectar el programa con las bases de datos.

4. **Conexión a bases de datos**

En el archivo `./src/common/utils.py` se encuentra 6 funciones:

- get_dim_mysql_connection
- close_dim_mysql_connection
- get_mysql_connection
- close_mysql_connection
- get_oracle_connection
- close_oracle_connection
    

Debemos asignar en las funciones get los valores correspondientes a la base de datos a la cual nos queremos conectar:

- get_dim_mysql_connection
```
host='localhost'      
database='VENTAS_SUCURSAL'
user='root'     
password='password'
port=3310 
```
- get_mysql_connection
```
host='localhost'     
database='VENTAS_SUCURSAL'
user='root'     
password='password'
port=3306
```

- get_oracle_connectiondb_
```
user = "FOO"
db_password = "password"
db_service = "192.168.x.x:1521/xe"
```
5. **Ejecutar el programa**
    

Para ejecutar el programa, abra una terminal en el directorio raíz y ejecute

```
python3 ./app.py
```