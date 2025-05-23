---
layout: base
hidden: true
---

# Procedimientos Almacenadas con PostgreSQL - Clase Avanzada

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../index)

`Clase 8 - 09/05/2025`

## Procedimientos Almacenados en PostgreSQL — Clase Avanzada

En esta clase avanzamos en el uso de **procedimientos almacenados** y **funciones** para consultar datos relacionados entre varias tablas y presentar resultados ordenados, como obtener los viajes de un conductor con sus respectivas distancias.

---

### Objetivo

Dado un **ID de conductor** (`xid`), queremos obtener:

1. El **nombre completo** del conductor (`nombre apellido`).
2. La lista de **viajes realizados** junto con la **distancia en kilómetros**.

---

### Función: `fn_fullname`

Esta función devuelve el nombre completo de un conductor:

```sql
CREATE OR REPLACE FUNCTION fn_fullname(xid INT)
RETURNS VARCHAR AS $$
DECLARE
    xname VARCHAR;
BEGIN
    SELECT (nombre || ' ' || apellido) INTO xname
    FROM conductores
    WHERE conductor_id = xid;

    RETURN xname;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No encontrado';
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN 'No name';
END;
$$ LANGUAGE plpgsql;
```

---

### Procedimiento almacenado: `p_routes`

Este procedimiento devuelve el **destino** y la **distancia** de una ruta específica:

```sql
CREATE OR REPLACE PROCEDURE p_routes(IN xid INT, OUT xdestino VARCHAR, OUT xdistancia INT)
AS $$
BEGIN
    SELECT destino, distancia_km INTO xdestino, xdistancia
    FROM VIAJES, RUTAS
    WHERE VIAJES.ruta_id = xid
    AND VIAJES.ruta_id = RUTAS.ruta_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error en el procedimiento';
END;
$$ LANGUAGE plpgsql;
```

---

### Procedimiento almacenado: `p_mostrar_viajes_conductor`

Este procedimiento muestra todos los viajes realizados por un conductor, usando `fn_fullname` y `p_routes`:

```sql
CREATE OR REPLACE PROCEDURE p_mostrar_viajes_conductor(IN xid INT)
AS $$
DECLARE
    each_row RECORD;
    xdestino VARCHAR;
    xdistancia INT;
    xcount INT := 0;
BEGIN
    RAISE NOTICE '%', fn_fullname(xid);

    FOR each_row IN (SELECT * FROM VIAJES WHERE conductor_id = xid) LOOP
        xcount := xcount + 1;
        CALL p_routes(each_row.ruta_id, xdestino, xdistancia);
        RAISE NOTICE '%) %, %KM', xcount, xdestino, xdistancia;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
```

---

### Ejecución del procedimiento para un conductor

```sql
CALL p_mostrar_viajes_conductor(1);
```

---

### Ejecución para todos los conductores

Podemos usar un bloque `DO $$` para recorrer todos los conductores:

```sql
DO $$
DECLARE
    each_row RECORD;
BEGIN
    FOR each_row IN (SELECT * FROM CONDUCTORES) LOOP
        CALL p_mostrar_viajes_conductor(each_row.conductor_id);
        RAISE NOTICE '----------------';
    END LOOP;
END;
$$;
```

---

### Ejemplo de salida esperada

```
NOTICE:  JUAN PÉREZ
NOTICE: 1) ORURO, 200KM
NOTICE: 2) LA PAZ, 300KM
NOTICE: 3) SANTA CRUZ, 400KM
NOTICE: 4) POTOSÍ, 100KM
NOTICE: ----------------
NOTICE:  ANA LÓPEZ
NOTICE: 1) COCHABAMBA, 250KM
NOTICE: 2) SUCRE, 150KM
```

---
