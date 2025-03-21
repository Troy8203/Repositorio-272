## Funciones


## Ejercicios
#### Ejercicio 1
Dado un el id del pasajero listar el nombre completo
Estructura
```sql
SELECT (nombre || ' ' || apellido) full_name

FROM pasajeros

WHERE pasajero_id=1
```
Respuesta
```sql
CREATE OR REPLACE FUNCTION fn_fullname(xpasajero_id NUMBER)

RETURN VARCHAR2

IS

full_name VARCHAR2(200);

BEGIN

SELECT (nombre || ' ' || apellido) full_name INTO full_name

FROM pasajeros

WHERE pasajero_id=xpasajero_id;

RETURN full_name;

EXCEPTION

WHEN NO_DATA_FOUND THEN

RETURN 'No hay';

END fn_fullname;
```
Ejecución
```sql
SELECT fn_fullname(1) as Nombre_Completo

FROM dual;
```

```sql
SELECT pasajero_id, fn_fullname(pasajero_id) as nombre_completo
FROM pasajeros;
```

#### Ejercicio 2
Calcular el Total de Pasajeros Transportados por un Autobús
```sql
SELECT SUM(pasajeros_transportados) total
FROM viajes
WHERE viaje_id = 1
```

#### Ejercicio 3
Para ustedes
Calcular el Costo Total de Mantenimiento de un Autobús
```sql
SELECT SUM(costo)
FROM mantenimiento
WHERE mantenimiento_id=1
```

#### Ejercicio 4
Verificar la Disponibilidad de un Autobús en una Fecha
Usar `TO_DATE('2023-10-10', 'YYYY-MM-DD')`
2 Parametros
```sql
SELECT *
FROM viajes
WHERE viaje_id = 1 AND fecha_viaje = (TO_DATE('2023-10-12', 'YYYY-MM-DD'))
```

```sql
CREATE OR REPLACE FUNCTION AutobusDisponible(
    p_autobus_id IN NUMBER,
    p_fecha IN DATE
) RETURN BOOLEAN
IS
    v_viajes_count NUMBER := 0;
BEGIN
    -- Contar los viajes programados para el autobús en la fecha dada
    SELECT COUNT(*)
    INTO v_viajes_count
    FROM Viajes
    WHERE autobus_id = p_autobus_id
      AND TRUNC(fecha_viaje) = TRUNC(p_fecha); -- TRUNC para ignorar la hora

    -- Retornar TRUE si no hay viajes, FALSE en caso contrario
    RETURN (v_viajes_count = 0);
END;
/
```