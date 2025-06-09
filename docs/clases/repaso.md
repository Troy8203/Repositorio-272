---
layout: base
hidden: true
---

# Repaso General: Procedimientos, Cursores y Triggers en PostgreSQL

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../clases/clases)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../README)

`Clase de Repaso - 09/06/2025`

## Procedimientos Almacenados

Los **procedimientos almacenados** permiten ejecutar bloques de código sin retornar un valor, ideales para operaciones como inserciones, actualizaciones o borrados en lote.

### Sintaxis básica

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

### Ejercicio

**Objetivo:** Dado un **ID** de autobús (`xid`) y un peso promedio por asiento (`xpeso`), queremos obtener:

1. El **estado** del autobús (`xestado`), por ejemplo, “En servicio” o “Mantenimiento”.
2. La **capacidad de carga total** (`xcapacidad`), calculada como:

> capacidad de asientos \* peso promedio por asiento

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
$$;

-- Ejecución:
CALL p_estado(1, 20, NULL, NULL);
```

---

## Cursores en PostgreSQL

Los **cursores** permiten recorrer fila por fila el resultado de una consulta y aplicar lógica a cada una.

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

### Ejercicio

**Objetivo:** ecorrer todos los conductores registrados y mostrar su nombre completo utilizando un cursor.

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

---

## Triggers en PostgreSQL

Los **triggers** o disparadores permiten ejecutar código automáticamente antes o después de eventos `INSERT`, `UPDATE`, o `DELETE`.

[![image.png](https://i.postimg.cc/NGRTZrLq/image.png)](https://postimg.cc/c64rnCQX)

### Sintaxis básica

1. **Función de trigger:**

```sql
CREATE OR REPLACE FUNCTION ejemplo_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    --Logica de función
END;
$$ LANGUAGE plpgsql;
```

2. **Crear el trigger:**

```sql
-- INSERT UPDATE DELETE
CREATE OR REPLACE TRIGGER ejemplo_trigger
    AFTER INSERT ON ejemplo_tabla
    FOR EACH ROW
    EXECUTE FUNCTION ejemplo_trigger_func();
```

### Ejercicio INSERT

**Objetivo:** Crear una nueva tabla de nuevos pasajeros y en la misma, almacenar todos los nuevos pasajeros que sean registrados.

#### Crear la tabla

```sql
CREATE TABLE nuevos_pasajeros (
    new_pasajero_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100)
);
```

#### Crear la funcion de inserción

```sql
CREATE OR REPLACE FUNCTION fn_copia_pasajero()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO nuevos_pasajeros (nombre, apellido, telefono, email)
    VALUES (NEW.nombre, NEW.apellido, NEW.telefono, NEW.email);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

#### Crear el trigger

```sql
CREATE OR REPLACE TRIGGER trg_copia_pasajero
    AFTER INSERT ON pasajeros
    FOR EACH ROW
    EXECUTE FUNCTION fn_copia_pasajero();
```

#### Realizar inserción y verificación

```sql
INSERT INTO pasajeros (nombre, apellido, telefono, email)
VALUES ('Juan', 'Pérez', '1234567890', '0o9mM@example.com');

SELECT * FROM nuevos_pasajeros;
```

### Ejercicio UPDATE

**Objetivo:** Despues de modificar una conductor, mantener un historial del antes y despues

#### Crea una tabla del historial

```sql
CREATE TABLE historial_conductores (
    his_conductor_id SERIAL PRIMARY KEY,
    antes_nombre VARCHAR(50) NOT NULL,
    despues_nombre VARCHAR(50) NOT NULL,
    antes_apellido VARCHAR(50) NOT NULL,
    despues_apellido VARCHAR(50) NOT NULL,
    antes_telefono VARCHAR(20),
    despues_telefono VARCHAR(20),
    antes_email VARCHAR(100),
    despues_email VARCHAR(100),
    antes_licencia_conducir VARCHAR(100),
    despues_licencia_conducir VARCHAR(100)
);
```

#### Crear la función que guarde el historial

```sql
CREATE OR REPLACE FUNCTION fn_historial_conductor()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historial_conductores (
        antes_nombre,
        despues_nombre,
        antes_apellido,
        despues_apellido,
        antes_telefono,
        despues_telefono,
        antes_email,
        despues_email,
        antes_licencia_conducir,
        despues_licencia_conducir
    )
    VALUES (
        OLD.nombre,
        NEW.nombre,
        OLD.apellido,
        NEW.apellido,
        OLD.telefono,
        NEW.telefono,
        OLD.email,
        NEW.email,
        OLD.licencia_conducir,
        NEW.licencia_conducir
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

#### Crear el trigger

```sql
CREATE OR REPLACE TRIGGER trg_historial_conductor
    AFTER UPDATE ON conductores
    FOR EACH ROW
    EXECUTE FUNCTION fn_historial_conductor();
```

#### Realizar actualización de la tabla

```sql
UPDATE conductores
SET nombre = 'Pepe', apellido = '-'
WHERE conductor_id = 7;

SELECT * FROM historial_conductores;
```

### Ejercicio UPDATE

**Objetivo:** Mantener un registro de las rutas eliminadas en una nueva tabla

#### Realizar nuevar inserciones

```sql
INSERT INTO rutas (nombre_ruta, origen, destino, distancia_km, duracion_estimada_min)
VALUES ('Nueva Ruta', 'Ciudad de México', 'Guadalajara', 540, 360);
INSERT INTO rutas (nombre_ruta, origen, destino, distancia_km, duracion_estimada_min)
VALUES ('Ruta rapida', 'Monterrey', 'Tampico', 520, 330);
INSERT INTO rutas (nombre_ruta, origen, destino, distancia_km, duracion_estimada_min)
VALUES ('Ruta en tiempo', 'Puebla', 'Veracruz', 300, 210);
```

> Se crea nueva inserciones para no eliminar elementos que dependa de otras tablas

#### Crear nueva tabla backup

```sql
CREATE TABLE rutas_eliminadas (
    ruta_eliminada_id SERIAL PRIMARY KEY,
    nombre_ruta VARCHAR(50) NOT NULL,
    origen VARCHAR(50) NOT NULL,
    destino VARCHAR(50) NOT NULL,
    distancia_km INTEGER NOT NULL,
    duracion_estimada_min INTEGER NOT NULL
);
```

#### Crear función

```sql
CREATE OR REPLACE FUNCTION fn_backup_rutas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO rutas_eliminadas ( nombre_ruta, origen, destino, distancia_km, duracion_estimada_min )
    VALUES ( OLD.nombre_ruta, OLD.origen, OLD.destino, OLD.distancia_km, OLD.duracion_estimada_min );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

#### Crear el trigger

```sql
CREATE OR REPLACE TRIGGER trg_rutas_eliminadas
    AFTER DELETE ON rutas
    FOR EACH ROW
    EXECUTE FUNCTION fn_backup_rutas();
```

#### Eliminar elementos de la tabla

```sql
DELETE FROM rutas
WHERE ruta_id = 14;

SELECT * FROM rutas_eliminadas;
```

## 📘 `NEW` y `OLD`: ¿Cuándo se usan?

| Operación | BEFORE/AFTER | ¿`NEW` disponible? | ¿`OLD` disponible? |
| --------- | ------------ | ------------------ | ------------------ |
| INSERT    | BEFORE/AFTER | ✅ Sí              | ❌ No              |
| UPDATE    | BEFORE/AFTER | ✅ Sí              | ✅ Sí              |
| DELETE    | BEFORE/AFTER | ❌ No              | ✅ Sí              |

## 📌 `BEFORE` vs `AFTER` (Triggers en PostgreSQL)

- **`BEFORE`**: Para **validar o modificar** datos antes de que se guarden.
- **`AFTER`**: Para **registrar o reaccionar** a cambios ya realizados.
