---
layout: base
hidden: true
---

# Procedimientos Almacenadas con PostgreSQL - Clase Avanzada

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../index)

`Clase 9 - 16/05/2025`

## Cursores en PostgreSQL — Clase Introductoria

En esta clase aprenderemos qué es un **cursor** en PostgreSQL, para qué sirve, cómo se utiliza, y cómo puede ayudarte a **recorrer datos fila por fila** dentro de un bloque `PL/pgSQL`.

---

### ¿Qué es un cursor?

Un **cursor** es una herramienta que nos permite **leer varias filas de una consulta SQL, una a la vez**, dentro de un bloque de código.
Esto es útil cuando:

- Necesitas aplicar **lógica personalizada** a cada fila.
- Quieres recorrer resultados **paso a paso**.
- Trabajas con **grandes cantidades de datos** y no quieres cargarlos todos de golpe.

---

### Sintaxis básica

```sql
DO $$
DECLARE
    -- Declaración del cursor: reemplaza la consulta por la que necesites
    example_cursor CURSOR FOR
        SELECT columna1, columna2 FROM tu_tabla;

    -- Variable para almacenar temporalmente cada fila
    row_data RECORD;
BEGIN
    OPEN example_cursor;

    LOOP
        FETCH example_cursor INTO row_data;
        EXIT WHEN NOT FOUND;

        -- Aquí puedes trabajar con los datos extraídos
        RAISE NOTICE 'ID: %: %', row_data.column1, row_data.column2;
    END LOOP;

    CLOSE example_cursor;
END;
$$;
```

[![image.png](https://i.postimg.cc/zXmTmYCS/image.png)](https://postimg.cc/qgLNnYZz)

---

### Ejemplo práctico

Queremos mostrar todos los **autobuses** registrados con su ID y estado.

```sql
DO $$
DECLARE
    autobus_cursor CURSOR FOR
        SELECT * FROM autobuses;
    autobus_row RECORD;
BEGIN
    OPEN autobus_cursor;
    LOOP
        FETCH autobus_cursor INTO autobus_row;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %: %', autobus_row.autobus_id, autobus_row.matricula;
    END LOOP;

    CLOSE autobus_cursor;
END;
$$;
```

---

### ¿Qué está pasando aquí?

1. **Declaramos el cursor** `bus_cursor` con una consulta.
2. **Abrimos el cursor** con `OPEN`.
3. Usamos `FETCH` para traer **una fila por vez** y guardarla en `bus_record`.
4. Imprimimos los datos con `RAISE NOTICE`.
5. **Salimos del bucle** cuando ya no hay más filas (`EXIT WHEN NOT FOUND`).
6. Cerramos el cursor con `CLOSE`.

---

### Ventajas de los cursores

- Puedes procesar cada fila **de forma individual**
- Útil cuando hay **mucha lógica o condiciones**
- Ideal para consultas que retornan **muchas filas**

---

## Ejercicio para practicar

**Objetivo:**
Recorrer todos los conductores registrados y mostrar su nombre completo utilizando un cursor.

**Pista:**
Puedes usar esta estructura como base:

```sql
DO $$
DECLARE
    driver_cursor CURSOR FOR SELECT * FROM conductores;
    driver_record RECORD;
BEGIN
    OPEN driver_cursor;
    LOOP
        FETCH driver_cursor INTO driver_record;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'CONDUCTOR: % %', driver_record.nombre, driver_record.apellido;
    END LOOP;
    CLOSE driver_cursor;
END;
$$;
```
