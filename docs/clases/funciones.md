---
layout: base
hidden: true
---

## Guía Básica - Funciones Almacenadas en PostgreSQL

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../README)

Las funciones almacenadas permiten encapsular lógica SQL compleja y reutilizable, escrita en PL/pgSQL, un lenguaje estructurado con soporte para control de flujo, manejo de excepciones, y más.

---

### Estructura General

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

    RETURN output_value;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN value_default;
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

---

### Ejemplo Práctico 1: Obtener nombre completo de un pasajero

```sql
CREATE OR REPLACE FUNCTION fn_fullname(xpasajero_id INT)
RETURNS VARCHAR AS $$
DECLARE
    full_name VARCHAR;
BEGIN
    SELECT (nombre || ' ' || apellido) INTO full_name
    FROM pasajeros
    WHERE pasajero_id = xpasajero_id;

    RETURN full_name;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No hay';
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

---

### Ejemplo Práctico 2: Calcular el área de un rectángulo

```sql
CREATE OR REPLACE FUNCTION fn_area_rectangulo(ancho INT, alto INT)
RETURNS INT AS $$
DECLARE
    area INT;
BEGIN
    IF ancho IS NULL OR alto IS NULL THEN
        RAISE EXCEPTION 'Ninguno de los valores puede ser NULL';
    END IF;

    area := ancho * alto;
    RETURN area;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

---

## Recomendaciones al trabajar con funciones en PostgreSQL

| Recomendación                                                                 | Detalle                                                                                      |
|-------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| **Usar `SELECT INTO` para asignar valores**                                  | Cuando se espera un solo resultado de una consulta, se debe usar `SELECT ... INTO variable` |
| **Declarar variables en la sección `DECLARE`**                               | Todas las variables que se van a usar deben declararse allí                                 |
| **Asignación con `:=`**                                                      | PostgreSQL utiliza `:=` para asignar valores a variables (no `=`)                          |
| **Usar `RAISE NOTICE` como herramienta de depuración**                       | Permite mostrar mensajes en consola durante la ejecución                                    |
| **Impresión de variables con `RAISE NOTICE` y `%`**                          | Ejemplo: `RAISE NOTICE 'Valor recibido: %', variable;`                                     |
| **Validar siempre valores `NULL` cuando sea necesario**                      | Los `NULL` pueden propagarse sin generar errores visibles                                   |
| **Usar `COALESCE` para manejar posibles `NULL` en resultados**               | Ejemplo: `COALESCE(SUM(valor), 0)` evita retornar `NULL`                                   |
| **Evitar nombres ambiguos en variables y columnas**                          | Nombres como `id`, `nombre` deben tener prefijos para mayor claridad (ej: `xnombre`)       |
| **Manejo de errores con `EXCEPTION`**                                        | Siempre prever errores comunes como `NO_DATA_FOUND`, pero también `OTHERS`                 |