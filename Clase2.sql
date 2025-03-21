CREATE OR REPLACE FUNCTION fn_fullname(xid NUMBER)
RETURN VARCHAR2
IS
    nombre_completo VARCHAR2(200);
BEGIN

    SELECT (NOMBRE || ' '|| APELLIDO) as full_name INTO nombre_completo
        FROM PASAJEROS
        WHERE PASAJERO_ID=xid;
        
    RETURN nombre_completo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No encontrado';
END fn_fullname;

--Exe1
SELECT fn_fullname(2) as nombre_completo
FROM dual;
--Exe2
SELECT PASAJEROS.PASAJERO_ID,FN_FULLNAME(PASAJERO_ID) as nombre_completo
FROM PASAJEROS


--EJER2
CREATE OR REPLACE FUNCTION fn_totales( xid IN NUMBER ) 
RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT SUM(PASAJEROS_TRANSPORTADOS) INTO total
        FROM VIAJES
        WHERE VIAJE_ID=xid;

    RETURN total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;