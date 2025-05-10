---
layout: base
hidden: true
---

# Procedimientos Almacenadas con PostgreSQL

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../index)

`Clase 6 - 25/04/2025`

## Procedimientos Almacenados en PostgreSQL

Para comprender qué es un procedimiento almacenado, primero es necesario entender su funcionamiento básico. Imagina un conjunto de sentencias que debes ejecutar una tras otra, cada vez que necesitas realizar una tarea específica.

[![image.png](https://i.postimg.cc/sxTtqWK6/image.png)](https://postimg.cc/CnfPfz3k)

Los procedimientos almacenados resuelven justamente este problema: evitan tener que escribir las mismas sentencias repetidamente para realizar la misma tarea.

[![image.png](https://i.postimg.cc/QtswMmyY/image.png)](https://postimg.cc/06WcWYx7)

A primera vista, su comportamiento puede parecer similar al de una función, pero con una diferencia clave: un procedimiento puede tener múltiples salidas (`OUTPUT`), lo cual lo hace más flexible en ciertos escenarios.

### Diferencias principales

Los **procedimientos almacenados** en PostgreSQL son similares a las funciones pero con algunas diferencias clave:

- No devuelven un valor directamente (aunque pueden tener parámetros `OUT`)
- Se ejecutan con `CALL` en lugar de `SELECT`
- Son más adecuados para operaciones que modifican datos o realizan transacciones

## Definición de Procedimientos en PostgreSQL

Un procedimiento en PostgreSQL se define con la siguiente estructura:

```sql
CREATE OR REPLACE PROCEDURE procedure_name( IN param1 datatype, OUT param2 datatype)
AS $$
DECLARE
    variable1 datatype;
BEGIN
    -- Lógica del procedimiento
    -- Puede incluir INSERT, UPDATE, DELETE, etc.
    -- Intentar asignar un valor usando SELECT INTO

    -- Manejo de excepciones
EXCEPTION
    WHEN others THEN
        -- Manejo de errores
        RAISE NOTICE 'Error en el procedimiento';
END;
$$ LANGUAGE plpgsql;
```

Ejecuta esta línea para correr un procedimiento

```sql
CALL procedure_name(param1, param2);
```

Ejecuta esta sentencia SQL que recorre toda la tabla y ejecuta el procedimiento

```sql
DO $$
DECLARE
    each_row RECORD;
    param2 VARCHAR;
BEGIN
    FOR each_row IN (SELECT * FROM table) LOOP
        CALL procedure_name(each_row.param1, param2);
        RAISE NOTICE 'ID: %: %', each_row.param1, param2;
    END LOOP;
END;
$$;
```

### Como funcionan los procedimientos almacenados

Un procedimiento almacenado (stored procedure) permite ejecutar lógica en la base de datos, recibiendo parámetros de entrada. Sin embargo, a diferencia de una consulta que opera sobre una tabla completa, un procedimiento no puede recibir directamente una tabla completa como parámetro (a menos que se utilicen tipos especiales como arrays o TABLE TYPE, lo cual requiere diseño adicional).

> Por esta razón, si queremos ejecutar el procedimiento sobre cada fila de una tabla, debemos llamarlo una vez por cada fila.

```sql
CALL procedure_name(param1, param2);
```

[![image.png](https://i.postimg.cc/Znf5HCNZ/image.png)](https://postimg.cc/YLW7q28y)

Para aplicar un procedimiento sobre cada fila de una tabla, se utiliza un ciclo (LOOP) en un bloque anónimo:

```sql
DO $$
DECLARE
    each_row RECORD;
    param2 VARCHAR;
BEGIN
    FOR each_row IN (SELECT * FROM table) LOOP
        CALL procedure_name(each_row.param1, param2);
        RAISE DEBUG 'ID: %: %', each_row.param1, param2;
    END LOOP;
END;
$$;
```

[![image.png](https://i.postimg.cc/jdXF8yCy/image.png)](https://postimg.cc/YhvR0G6S)

🔹 [Funcionamiento `DO $$`](#funcionamiento-do)  
🔹 [Funcionamiento `RAISE`](#funcionamiento-raise)

## Ejercicios Prácticos

### 1. Obtener el Estado de un Autobús (como procedimiento)

Primero creamos nuestra sentencia base

```sql
SELECT estado
FROM autobuses
WHERE autobus_id = 1;
```

Luego creamos el procedimiento almacenado con los correspondientes cambios en base a nuestra sentencia base

```sql
CREATE OR REPLACE PROCEDURE p_estado(IN xid INT, OUT xestado VARCHAR)
AS $$
BEGIN
    SELECT estado INTO xestado
    FROM autobuses
    WHERE autobus_id = xid;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error en el procedimiento';
        xestado := NULL;
END;
$$ LANGUAGE plpgsql;
```

Ejecutamos el procedimiento

```sql
CALL p_estado(3, NULL);
```

> Note que debemos enviar como NULL las variables de salida

Para que podamos ver toda la lista ejecutar el siguiente bloque anonimo

```sql
DO $$
DECLARE
    each_row RECORD;
    xestado VARCHAR;
BEGIN
    FOR each_row IN (SELECT * FROM autobuses) LOOP
        CALL p_estado(each_row.autobus_id, xestado);
        RAISE NOTICE 'ID: %: %', each_row.autobus_id, xestado;
    END LOOP;
END;
$$;
```

Resultado

[![image.png](https://i.postimg.cc/VNR9wFQF/image.png)](https://postimg.cc/yJD3XcNJ)

#### Con manejo de excepciones

Para el manejo de excepciones se debe modificar lo siguiente

```sql
SELECT estado
FROM autobuses
WHERE autobus_id = 1;

SELECT estado
FROM autobuses
WHERE autobus_id = 5;

CREATE OR REPLACE PROCEDURE p_estado(IN xid INT, OUT xestado VARCHAR)
AS $$
BEGIN
    SELECT estado INTO xestado
    FROM autobuses
    WHERE autobus_id = xid;

    IF xestado IS NULL THEN
        --RAISE NOTICE 'El autobus % no tiene estado', xid;
        xestado := 'Nada';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error en el procedimiento';
        xestado := NULL;
END;
$$ LANGUAGE plpgsql;
```

> Recuerda que para el manejo de excepciones siempre se debe hacer uso de un IF

---

## Funcionamiento `DO $$`

El bloque `DO $$` es una estructura de código anónimo que permite ejecutar lógica en PL/pgSQL **sin necesidad de crear una función almacenada**. Es ideal para scripts rápidos, tareas administrativas o pruebas.

**Sintaxis básica:**

```sql
DO $$
DECLARE
    -- Declaración de variables (opcional)
    variable INTEGER := 0;
BEGIN
    -- Instrucciones PL/pgSQL aquí
    RAISE NOTICE 'Valor: %', variable;
END;
$$;
```

- `$$` delimita el bloque de código.
- Dentro del `BEGIN ... END;` puedes usar bucles, condiciones, llamadas a procedimientos, etc.
- `DECLARE` es opcional, pero se usa para definir variables internas del bloque.

### Ejemplo DO

```sql
DO $$
DECLARE
  x INT := 1;
  y INT := 2;
  z INT;
BEGIN
  z := x + y;
  RAISE NOTICE '%', z;
END $$;
```

## Funcionamiento `RAISE`

`RAISE` se utiliza en PL/pgSQL para **mostrar mensajes** durante la ejecución del código. Es muy útil para depuración (`DEBUG`) o para lanzar errores personalizados.

**Tipos comunes de mensajes:**

```sql
DO $$
BEGIN
  RAISE INFO 'information message %', now() ;
  RAISE LOG 'log message %', now();
  RAISE DEBUG 'debug message %', now();
  RAISE WARNING 'warning message %', now();
  RAISE NOTICE 'notice message %', now();
END $$;
```

- `NOTICE` , `WARNING` y `DEBUG` son visibles dependiendo del nivel de configuración del servidor (por ejemplo, `client_min_messages`).
- `DEBUG` no siempre se muestra a menos que se active explícitamente.

Para ver los logs de `INFO` y `LOG` se puede ver en docker con el siguiente comando

```bash
docker compose logs postgres
```
