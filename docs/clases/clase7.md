---
layout: base
hidden: true
---

# Procedimientos Almacenadas con PostgreSQL - Clase Avanzada

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../index)

`Clase 7 - 02/05/2025`

Perfecto, aquí te lo dejo limpio, sin emojis ni sección de conceptos clave, listo para compartir como material de clase.

---

## Procedimientos Almacenados en PostgreSQL — Clase Avanzada

En esta clase avanzamos en el uso de **procedimientos almacenados** para resolver problemas más complejos, como calcular la capacidad de carga de un autobús según su número de asientos y un peso promedio por asiento.

### Objetivo

Dado un **ID** de autobús (`xid`) y un peso promedio por asiento (`xpeso`), queremos obtener:

1. El **estado** del autobús (`xestado`), por ejemplo, “En servicio” o “Mantenimiento”.
2. La **capacidad de carga total** (`xcapacidad`), calculada como:

$$
\text{capacidad de asientos} \times \text{peso promedio por asiento}
$$

---

### Procedimiento almacenado: `p_estado`

```sql
CREATE OR REPLACE PROCEDURE p_estado(IN xid INT, IN xpeso INT, OUT xestado VARCHAR, OUT xcapacidad INT)
AS $$
BEGIN
    -- Obtener el estado del autobús
    SELECT estado INTO xestado
    FROM autobuses
    WHERE autobus_id = xid;

    -- Calcular la capacidad de carga
    SELECT capacidad * xpeso INTO xcapacidad
    FROM autobuses
    WHERE autobus_id = xid;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error en el procedimiento';
        xestado := NULL;
END;
$$ LANGUAGE plpgsql;
```

---

### Ejecución del procedimiento

Para probar el procedimiento, se puede usar un bloque anónimo `DO $$` que recorra todos los autobuses:

```sql
DO $$
DECLARE
    each_row RECORD;
    xestado VARCHAR;
    xpeso INT := 6; -- Peso promedio por asiento en kg
    xcapacidad INT;
BEGIN
    RAISE NOTICE 'CAPACIDAD POR ASIENTO: % KG', xpeso;
    FOR each_row IN (SELECT * FROM autobuses ORDER BY autobus_id) LOOP
        CALL p_estado(each_row.autobus_id, xpeso, xestado, xcapacidad);
        RAISE NOTICE 'BUS %: %, SOPORTA % KG', each_row.autobus_id, xestado, xcapacidad;
    END LOOP;
END;
$$;
```

---

### Ejemplo de salida esperada

```
NOTICE:  CAPACIDAD POR ASIENTO: 6 KG
NOTICE:  BUS 1: En servicio, SOPORTA 300 KG
NOTICE:  BUS 2: Mantenimiento, SOPORTA 240 KG
NOTICE:  BUS 3: En servicio, SOPORTA 360 KG
```

---

## Ejercicio para practicar

**Objetivo:** Crear un procedimiento almacenado que, dado el ID de un conductor (`xid`), muestre los viajes que ha realizado junto con su respectiva distancia.

**Ejemplo de uso:**

Si `xid := 1`, la salida debería ser algo como:

```
NOMBRE: JUAN
VIAJES
ORURO, 200KM
LA PAZ, 300KM
SANTA CRUZ, 400KM
POTOSI, 100KM
```