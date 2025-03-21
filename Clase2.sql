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


SELECT (nombre || ' ' || apellido) full_name
FROM pasajeros
WHERE pasajero_id=1