---
layout: base
hidden: true
---

# Funciones Almacenadas con PostgreSQL

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../README)

`Clase 5 - 15/04/2025`

## Guía Básica - Manejo de Excepciones en PostgreSQL

### ¿Qué son las excepciones?

Las **excepciones** permiten capturar errores que puedan ocurrir durante la ejecución de funciones almacenadas y manejar esos errores de forma controlada, evitando que la función falle inesperadamente.

---

### Sintaxis general

```sql
BEGIN
    -- Instrucciones
EXCEPTION
    WHEN nombre_excepcion THEN
        -- Código para manejar el error
END;
```

---

### Excepciones comunes en PostgreSQL

| Excepción             | Descripción                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| `NO_DATA_FOUND`       | No se encontró ningún registro que cumpla la condición.                     |
| `DIVISION_BY_ZERO`    | Se intentó dividir un número por cero.                                      |
| `INVALID_TEXT_REPRESENTATION` | Conversión de tipo inválida, como intentar convertir 'abc' a número. |
| `OTHERS`              | Captura cualquier otro error no específico.                                 |

---

Perfecto, vamos a darle forma de documentación clara, educativa y coherente con el estilo anterior. Aquí tienes la sección completa con explicaciones, código y observaciones importantes, organizada de forma profesional:

---

## Manejo de Excepciones en PostgreSQL

### Introducción

El manejo de errores en PostgreSQL a través de **excepciones** (`EXCEPTION`) permite controlar situaciones inesperadas durante la ejecución de funciones almacenadas, tales como datos faltantes, errores de tipo, divisiones por cero, entre otros.

---

## Ejemplos prácticos

### Ejemplo 1: Capturar un registro no encontrado

**Descripción**: Crear una función que obtenga el nombre de un conductor a partir de su ID. Si no existe el conductor, debe retornar el valor `'Desconocido'`.

Primero se construye la consulta base:

```sql
SELECT nombre
    FROM conductores
    WHERE conductor_id = 1;
```

Luego, la estructura de la función con manejo de excepciones:

```sql
CREATE OR REPLACE FUNCTION fn_nombre_conductor(xid INT)
RETURNS VARCHAR AS $$
DECLARE
    xnombre VARCHAR;
BEGIN
    SELECT nombre INTO xnombre
        FROM conductores
        WHERE conductor_id = xid;

    RETURN xnombre;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Desconocido';
    WHEN OTHERS THEN
        RAISE NOTICE 'Error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

> Esta función retorna el nombre del conductor si existe. En caso contrario, devuelve `'Desconocido'`.

---

### Ejemplo 2: Validación manual de `NULL` y excepción forzada

**Descripción**: Crear una función que, dado un número, determine si es par o impar. Si el número es `NULL`, se debe lanzar una excepción personalizada.

Consulta base:

```sql
SELECT MOD(4, 2); -- Devuelve 0 (es par)
```

Estructura de la función:

```sql
CREATE OR REPLACE FUNCTION fn_par(xnumber INT)
RETURNS BOOLEAN AS $$
DECLARE
    es_par BOOLEAN;
BEGIN
    -- Validar manualmente si el valor es NULL
    IF xnumber IS NULL THEN
        RAISE EXCEPTION 'El valor no puede ser null';
    END IF;

    -- Verificar si es par
    IF MOD(xnumber, 2) = 0 THEN
        es_par := TRUE;
    ELSE
        es_par := FALSE;
    END IF;

    RETURN es_par;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

### Resultado esperado

Al ejecutar:

```sql
SELECT fn_par(NULL);
```

Se produce el siguiente resultado:

[![image.png](https://i.postimg.cc/7PpzQfBf/image.png)](https://postimg.cc/QVJVFxZ3)

> La función detecta el `NULL`, lanza una excepción, y evita que la operación continúe con un resultado no deseado.

---

### ¿Por qué usar `IF x IS NULL THEN RAISE EXCEPTION`?

- PostgreSQL **no lanza errores automáticamente** al trabajar con `NULL`.
- Operaciones como `MOD(NULL, 2)` o `NULL + 5` son válidas, pero devuelven `NULL`.
- Esto puede causar errores lógicos silenciosos si no se controlan a tiempo.
- **Solución recomendada**: Validar `NULL` explícitamente y lanzar excepciones cuando sea necesario.