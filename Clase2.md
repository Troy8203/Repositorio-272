## Funciones
```sql
CREATE OR REPLACE FUNCTION function_name(param1 datatype, param2 datatype)
RETURN return_datatype
IS
    output_value return_datatype;
BEGIN
    -- cuerpo de la función con INTO
    RETURN output_value;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN value_default;
END function_name;
```

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