---
layout: base
hidden: true
---

## Guía Básica - Funciones Almacenadas en PostgreSQL

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