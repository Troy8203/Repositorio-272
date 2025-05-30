---
layout: base
hidden: true
---

# Cursores en PostgreSQL — Casos Especiales y Comparaciones

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../index)

`Clase 10 - 22/05/2025`

---

## ¿Cuándo usar cursores en lugar de procedimientos almacenados?

Los **cursores** y los **procedimientos almacenados** tienen propósitos diferentes, pero complementarios:

| Característica                      | Cursores                                                 | Procedimientos Almacenados                        |
| ----------------------------------- | -------------------------------------------------------- | ------------------------------------------------- |
| Lectura fila por fila               | Sí                                                       | No necesariamente                                 |
| Control sobre el flujo por registro | Total                                                    | ⚠️ Limitado (a menos que se combine con cursores) |
| Fácil integración en bloques `DO`   | Sí                                                       | Sí                                                |
| Reusabilidad                        | No (a menos que se encapsule dentro de un procedimiento) | Sí                                                |
| Ideal para operaciones secuenciales | Sí                                                       | ⚠️ Depende del caso                               |

---

## Caso especial 1: Cursor con lógica condicional

Recorrer todos los autobuses y mostrar solo aquellos que **están en servicio**.

```sql
DO $$
DECLARE
    bus_cursor CURSOR FOR
        SELECT * FROM autobuses;
    bus_record RECORD;
BEGIN
    OPEN bus_cursor;

    LOOP
        FETCH bus_cursor INTO bus_record;
        EXIT WHEN NOT FOUND;

        -- Solo mostramos si el autobús está en servicio
        IF bus_record.estado = 'En servicio' THEN
            RAISE NOTICE 'BUS ID: %, MATRÍCULA: %', bus_record.autobus_id, bus_record.matricula;
        END IF;
    END LOOP;

    CLOSE bus_cursor;
END;
$$;
```

---

## Caso especial 2: Cursor con operaciones acumuladas

Sumar la distancia total recorrida por todos los viajes registrados.

```sql
DO $$
DECLARE
    trip_cursor CURSOR FOR SELECT distancia_km FROM viajes;
    trip_record RECORD;
    total_km INT := 0;
BEGIN
    OPEN trip_cursor;

    LOOP
        FETCH trip_cursor INTO trip_record;
        EXIT WHEN NOT FOUND;

        total_km := total_km + trip_record.distancia_km;
    END LOOP;

    CLOSE trip_cursor;

    RAISE NOTICE 'DISTANCIA TOTAL RECORRIDA: % KM', total_km;
END;
$$;
```

---

## Caso especial 3: Cursor dinámico con múltiples condiciones

Recorrer viajes, y dependiendo de la distancia, mostrar un mensaje distinto.

```sql
DO $$
DECLARE
    trip_cursor CURSOR FOR SELECT destino, distancia_km FROM rutas;
    route_record RECORD;
BEGIN
    OPEN trip_cursor;

    LOOP
        FETCH trip_cursor INTO route_record;
        EXIT WHEN NOT FOUND;

        IF route_record.distancia_km < 100 THEN
            RAISE NOTICE 'RUTA CORTA: % (% KM)', route_record.destino, route_record.distancia_km;
        ELSIF route_record.distancia_km < 300 THEN
            RAISE NOTICE 'RUTA MEDIA: % (% KM)', route_record.destino, route_record.distancia_km;
        ELSE
            RAISE NOTICE 'RUTA LARGA: % (% KM)', route_record.destino, route_record.distancia_km;
        END IF;
    END LOOP;

    CLOSE trip_cursor;
END;
$$;
```

---

## Buenas prácticas con cursores

Úsalos cuando:

- Requieres lógica paso a paso por fila.
- Necesitas aplicar múltiples condiciones internas por registro.
- Estás acumulando datos en tiempo real.

Evítalos cuando:

- Una sola consulta SQL puede resolver el problema.
- El rendimiento es crítico (pueden ser más lentos en grandes volúmenes si no están bien usados).

---

## Ejercicio final de clase

**Objetivo:** Usar un cursor para recorrer todos los conductores y mostrar cuántos viajes tiene cada uno.

**Pista:** Usa un `SELECT COUNT(*)` dentro del bucle para cada conductor.
