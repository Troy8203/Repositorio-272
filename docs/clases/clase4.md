---
layout: base
hidden: true
---

# Funciones Almacenadas con PostgreSQL

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../index)

`Clase 4 - 11/04/2025`

## Ejercicios Extra - Funciones Almacenadas con PostgreSQL

### Solucion ejercicio 3

- 1. Crear una funcion que me muestre el nombre completo del conductor dado su licencia de conducir

Primero se construye la senctencia de la función

```sql
SELECT (nombre || ' ' || apellido)
    FROM conductores
    WHERE licencia_conducir = 'DL12345678';
```

Luego se construye la estructura de la función

```sql


CREATE OR REPLACE FUNCTION fn_full_name(xlicencia_conducir VARCHAR) RETURNS VARCHAR AS $$
DECLARE
    xfull_name VARCHAR;
BEGIN
    SELECT (nombre || ' ' || apellido) INTO xfull_name
        FROM conductores
        WHERE licencia_conducir = xlicencia_conducir;

    RETURN xfull_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '';
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

Execución de la Función

```sql
SELECT fn_full_name('DL12345678')
```

- 2. Crear una funcion que muestre cada conductor cuanta distancia ha recorrido en todos sus viajes dado su id

> Recuerda que hay conductores que estan registrados pero no han recorrido ningun viaje

Mostrar el siguiente resultado:

[![image.png](https://i.postimg.cc/3xCLYH0S/image.png)](https://postimg.cc/NKF8kS4m)

Crear la sentecia de la Función

```sql
SELECT SUM(distancia_km)
    FROM conductores,
        viajes,
        rutas
    WHERE conductores.conductor_id = 1
        AND conductores.conductor_id = viajes.conductor_id
        AND viajes.ruta_id = rutas.ruta_id;
```

Crear la estructura de la Función

```sql
CREATE OR REPLACE FUNCTION fn_distancia(xconductor_id INT)
RETURNS INT AS $$
DECLARE
    xdistancia INT;
BEGIN
    SELECT COALESCE(SUM(distancia_km), 0) INTO xdistancia
        FROM conductores,
            viajes,
            rutas
        WHERE conductores.conductor_id = xconductor_id
            AND conductores.conductor_id = viajes.conductor_id
            AND viajes.ruta_id = rutas.ruta_id;

    RETURN xdistancia;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN 0;
END;
$$ LANGUAGE plpgsql;
```

---

## Delimitadores en funciones almacenadas con PostgreSQL

Las funciones almacenadas en PostgreSQL pueden ser declaradas utilizando el delimitador de lenguaje **$$** para indicar el inicio y el fin de la función.

### Ejemplo:

```sql
CREATE OR REPLACE FUNCTION fn_full_name(xlicencia_conducir VARCHAR) RETURNS VARCHAR AS $$
DECLARE
    xfull_name VARCHAR;
BEGIN
    SELECT (nombre || ' ' || apellido) INTO xfull_name
        FROM conductores
        WHERE licencia_conducir = xlicencia_conducir;

    RETURN xfull_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '';
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

### Otra manera de declarar la Función

```sql
CREATE OR REPLACE FUNCTION fn_full_name(xlicencia_conducir VARCHAR) RETURNS VARCHAR AS $func$
DECLARE
    xfull_name VARCHAR;
BEGIN
    SELECT (nombre || ' ' || apellido) INTO xfull_name
        FROM conductores
        WHERE licencia_conducir = xlicencia_conducir;

    RETURN xfull_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '';
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$func$ LANGUAGE plpgsql;
```

> Los delimitadores funcionan como "" con el fin de evitar conflictos con las cadenas de texto en las funciones.

### Diferencias `$$ LANGUAJE plpgsql` y `$$ LANGUAJE sql`

`LANGUAGE sql` se usa para funciones simples basadas en una sola consulta, mientras que `LANGUAGE plpgsql` permite lógica compleja con variables, control de flujo y manejo de errores.

| **Característica**                        | **`LANGUAGE sql`**                                   | **`LANGUAGE plpgsql`**                       |
| ----------------------------------------- | ---------------------------------------------------- | -------------------------------------------- |
| **Simple y directo**                      | ✅ Ideal para funciones de una sola línea o consulta | ❌ No tan directo para funciones muy simples |
| **Control de flujo (`IF`, `LOOP`, etc.)** | ❌ No se puede                                       | ✅ Totalmente soportado                      |
| **Variables locales**                     | ❌ No                                                | ✅ Sí, puedes declarar y usar variables      |
| **Asignación de valores (`:=`)**          | ❌ No                                                | ✅ Sí                                        |
| **Uso de `SELECT INTO`**                  | ❌ No                                                | ✅ Sí, para asignar resultados a variables   |
| **Manejo de errores (`EXCEPTION`)**       | ❌ No                                                | ✅ Sí, manejo con `EXCEPTION`, `WHEN`, etc.  |

#### Ejemplos

```sql
CREATE OR REPLACE FUNCTION sumar(a INT, b INT)
RETURNS INT AS $$
DECLARE
    resultado INT;
BEGIN
    resultado := a + b;
    RETURN resultado;
END;
$$ LANGUAGE sql;
```

> ❌ No funciona porque no se puede usar variables en `$$ LANGUAGE sql`

```sql
CREATE OR REPLACE FUNCTION sumar(a INT, b INT)
RETURNS INT AS $$
DECLARE
    resultado INT;
BEGIN
    resultado := a + b;
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;
```

> ✅ Funciona porque se puede usar variables en `$$ LANGUAGE plpgsql`

### Otros delimitadores

- **Delimitador PL/pgSQL**

  ```sql
  $$ LANGUAGE plpgsql;
  ```

- **Delimitador SQL**

  ```sql
  $$ LANGUAGE sql;
  ```

- **Delimitador PLV8 (JavaScript)**

  ```sql
  $$ LANGUAGE plv8;
  ```

- **Delimitador PL/Python (sin restricciones de seguridad)**

  ```sql
  $$ LANGUAGE plpythonu;
  ```

- **Delimitador PL/Python (seguro)**

  ```sql
  $$ LANGUAGE plpython3u;
  ```

- **Delimitador PL/Perl (sin restricciones de seguridad)**

  ```sql
  $$ LANGUAGE plperlu;
  ```

- **Delimitador PL/Perl (seguro)**

  ```sql
  $$ LANGUAGE plperl;
  ```

- **Delimitador PL/R (lenguaje R)**
  ```sql
  $$ LANGUAGE plr;
  ```

#### Ejemplo delimitador PLV8 (JavaScript)

Para hacer uso de estos delimitadores es necesario tener la extensiión **plv8** instalada en la base de datos.

```sql
-- Verificar si existe
SELECT * FROM pg_available_extensions WHERE name = 'plv8';

-- Instalar la extención
CREATE EXTENSION plv8;
```

Hola mundo en JavaScript

```sql
CREATE OR REPLACE FUNCTION hello_world()
RETURNS TEXT AS $$
    return "Hola desde JavaScript!";
$$ LANGUAGE plv8;

SELECT hello_world()
```

Serie de Fibonacci en JavaScript

```sql
CREATE OR REPLACE FUNCTION fibonacci_js(n INTEGER)
RETURNS TEXT AS $$
    var a = 0, b = 1, resultado = [];

    for (var i = 0; i < n; i++) {
        resultado.push(a);
        var temp = a + b;
        a = b;
        b = temp;
    }

    return resultado.join(', ');
$$ LANGUAGE plv8;


SELECT fibonacci_js(10)
```
