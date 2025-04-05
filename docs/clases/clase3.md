---
layout: base
hidden: true
---

# Funciones Almacenadas con PostgreSQL

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../README)

`Clase 3 - 28/03/2025`

## Funciones Almacenadas con PostgreSQL

Las **funciones almacenadas** en PostgreSQL permiten encapsular lógica de negocio en la base de datos, reduciendo la carga en las aplicaciones cliente y mejorando la eficiencia de las consultas. Estas funciones pueden recibir parámetros, devolver valores y manejar excepciones para una mayor robustez.

A continuación, se presentan ejemplos prácticos de funciones almacenadas utilizando el lenguaje procedural **PL/pgSQL**.

---

## Definición de Funciones en PostgreSQL

Una función en PostgreSQL se define con la siguiente estructura:

```sql
CREATE OR REPLACE FUNCTION function_name(param1 datatype, param2 datatype)
RETURNS return_datatype AS $$
DECLARE
    output_value return_datatype;
BEGIN
    -- Intentar asignar un valor usando SELECT INTO
    SELECT columna INTO output_value
    FROM tabla
    WHERE condicion = param1 AND otra_condicion = param2;

    -- Si se encuentra el valor, devolverlo
    RETURN output_value;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Manejo del error: devolver un valor por defecto
        RETURN value_default;
    WHEN OTHERS THEN
        -- Manejo de cualquier otro error
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

---

## Ejercicios Prácticos

A continuación, se presentan algunos ejercicios con ejemplos de funciones almacenadas aplicadas a un sistema de gestión de autobuses.

### 1. Obtener el Estado de un Autobús

Esta función busca el estado de un autobús a partir de su ID y maneja el caso en que no se encuentre un registro.

```sql
CREATE OR REPLACE FUNCTION obtener_estado_autobus(autobus_id INT)
RETURNS VARCHAR AS $$
DECLARE
    estado_autobus VARCHAR;
BEGIN
    SELECT estado INTO estado_autobus
    FROM Autobuses
    WHERE Autobuses.autobus_id = obtener_estado_autobus.autobus_id;

    RETURN estado_autobus;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Desconocido';
    WHEN OTHERS THEN
        RAISE NOTICE 'Ocurrió un error inesperado en obtener_estado_autobus';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

**Ejecución:**

```sql
SELECT obtener_estado_autobus(5);
```

---

### 2. Contar los Boletos Vendidos en un Viaje

Esta función calcula la cantidad de boletos vendidos en un viaje específico.

```sql
CREATE OR REPLACE FUNCTION contar_boletos_vendidos(viaje_id INT)
RETURNS INT AS $$
DECLARE
    total_boletos INT;
BEGIN
    SELECT COALESCE(COUNT(*), 0) INTO total_boletos
    FROM Boletos
    WHERE Boletos.viaje_id = contar_boletos_vendidos.viaje_id;

    RETURN total_boletos;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE NOTICE 'Error inesperado en contar_boletos_vendidos';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

**Ejecución:**

```sql
SELECT contar_boletos_vendidos(2);
```

---

### 3. Ejercicios Extra

- 1. Crear una funcion que me muestre el nombre completo del conductor dado su licencia de conducir

- 2. Crear una funcion que muestre cada conductor cuanta distancia ha recorrido en todos sus viajes dado su id

> Recuerda que hay conductores que estan registrados pero no han recorrido ningun viaje

Mostrar el siguiente resultado:

[![image.png](https://i.postimg.cc/3xCLYH0S/image.png)](https://postimg.cc/NKF8kS4m)
