from src.controllers.limpiar import etl_limpiar_datos
from src.controllers.dimensiones import etl_dim_fecha, etl_dim_empleado, etl_dim_producto, etl_dim_sucursal
from src.controllers.hechos import etl_fact_ventas

def main():
    while True: 
        print("\n\n--------------------------------------------------------")
        print("\t\t\tETL - DataMart")
        print("--------------------------------------------------------")

        print("1. Limpiar datos de Datamart")
        print("2. Poblar tablas de dimensiones")
        print("3. Poblar tabla de hechos")
        print("4. Salir")
        opcion = input("Ingrese una opción: ")
        print("\n--------------------------------------------------------\n\n")
        if opcion == "1":
            etl_limpiar_datos()
        elif opcion == "2":
            etl_dim_sucursal()
            etl_dim_producto()
            etl_dim_empleado()
            etl_dim_fecha()
            print("\nTablas de dimensiones pobladas")
        elif opcion == "3":
            etl_fact_ventas()
            print("\nTabla de hechos poblada")
        elif opcion == "4":
            break
        else:
            print("Opción no válida")
            continue


if __name__ == "__main__":
    main()