Eliminar la base de datos

```sql
DROP TABLE Boletos;

DROP TABLE Viajes;

DROP TABLE Pasajeros;

DROP TABLE Mantenimiento;

DROP TABLE Horarios;

DROP TABLE Autobus_Ruta;

DROP TABLE Rutas;

DROP TABLE Conductores;

DROP TABLE Autobuses;
```
Crear base de datos
```sql
-- Tabla para almacenar información de los autobuses
CREATE TABLE Autobuses (
    autobus_id NUMBER PRIMARY KEY,
    matricula VARCHAR2(10) NOT NULL UNIQUE,
    marca VARCHAR2(50) NOT NULL,
    modelo VARCHAR2(50) NOT NULL,
    capacidad NUMBER NOT NULL,
    fecha_fabricacion DATE NOT NULL,
    estado VARCHAR2(20) CHECK (estado IN ('Activo', 'Inactivo', 'En Mantenimiento'))
);

-- Tabla para almacenar información de los conductores
CREATE TABLE Conductores (
    conductor_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR2(15),
    email VARCHAR2(100) UNIQUE,
    licencia_conducir VARCHAR2(20) NOT NULL UNIQUE
);

-- Tabla para almacenar las rutas de los autobuses
CREATE TABLE Rutas (
    ruta_id NUMBER PRIMARY KEY,
    nombre_ruta VARCHAR2(100) NOT NULL,
    origen VARCHAR2(100) NOT NULL,
    destino VARCHAR2(100) NOT NULL,
    distancia_km NUMBER NOT NULL,
    duracion_estimada_min NUMBER NOT NULL
);

-- Tabla para asignar autobuses a rutas
CREATE TABLE Autobus_Ruta (
    autobus_id NUMBER,
    ruta_id NUMBER,
    fecha_asignacion DATE DEFAULT SYSDATE,
    PRIMARY KEY (autobus_id, ruta_id),
    FOREIGN KEY (autobus_id) REFERENCES Autobuses(autobus_id),
    FOREIGN KEY (ruta_id) REFERENCES Rutas(ruta_id)
);

-- Tabla para almacenar los horarios de las rutas
CREATE TABLE Horarios (
    horario_id NUMBER PRIMARY KEY,
    ruta_id NUMBER,
    hora_salida TIMESTAMP NOT NULL,
    hora_llegada TIMESTAMP NOT NULL,
    FOREIGN KEY (ruta_id) REFERENCES Rutas(ruta_id)
);

-- Tabla para registrar el mantenimiento de los autobuses
CREATE TABLE Mantenimiento (
    mantenimiento_id NUMBER PRIMARY KEY,
    autobus_id NUMBER,
    fecha_mantenimiento DATE DEFAULT SYSDATE,
    tipo_mantenimiento VARCHAR2(50) CHECK (tipo_mantenimiento IN ('Preventivo', 'Correctivo')),
    descripcion VARCHAR2(500),
    costo NUMBER,
    FOREIGN KEY (autobus_id) REFERENCES Autobuses(autobus_id)
);

-- Tabla para registrar los viajes realizados
CREATE TABLE Viajes (
    viaje_id NUMBER PRIMARY KEY,
    autobus_id NUMBER,
    ruta_id NUMBER,
    conductor_id NUMBER,
    fecha_viaje DATE DEFAULT SYSDATE,
    pasajeros_transportados NUMBER,
    FOREIGN KEY (autobus_id) REFERENCES Autobuses(autobus_id),
    FOREIGN KEY (ruta_id) REFERENCES Rutas(ruta_id),
    FOREIGN KEY (conductor_id) REFERENCES Conductores(conductor_id)
);

-- Tabla para registrar los pasajeros
CREATE TABLE Pasajeros (
    pasajero_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(100) NOT NULL,
    telefono VARCHAR2(15),
    email VARCHAR2(100) UNIQUE
);

-- Tabla para registrar los boletos vendidos (relación entre viajes y pasajeros)
CREATE TABLE Boletos (
    boleto_id NUMBER PRIMARY KEY,
    viaje_id NUMBER,
    pasajero_id NUMBER,
    fecha_compra DATE DEFAULT SYSDATE,
    precio NUMBER NOT NULL,
    asiento VARCHAR2(10),
    FOREIGN KEY (viaje_id) REFERENCES Viajes(viaje_id),
    FOREIGN KEY (pasajero_id) REFERENCES Pasajeros(pasajero_id)
);
```
Insercion
```sql
-- Insertar datos en la tabla Autobuses
INSERT INTO Autobuses (autobus_id, matricula, marca, modelo, capacidad, fecha_fabricacion, estado)
VALUES (1, 'ABC123', 'Mercedes', 'Sprinter', 20, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Activo');

INSERT INTO Autobuses (autobus_id, matricula, marca, modelo, capacidad, fecha_fabricacion, estado)
VALUES (2, 'XYZ789', 'Volvo', '9700', 50, TO_DATE('2018-05-20', 'YYYY-MM-DD'), 'Activo');

-- Insertar datos en la tabla Conductores
INSERT INTO Conductores (conductor_id, nombre, apellido, fecha_nacimiento, telefono, email, licencia_conducir)
VALUES (1, 'Juan', 'Pérez', TO_DATE('1985-03-10', 'YYYY-MM-DD'), '555-1234', 'juan.perez@example.com', 'LIC123456');

INSERT INTO Conductores (conductor_id, nombre, apellido, fecha_nacimiento, telefono, email, licencia_conducir)
VALUES (2, 'Ana', 'Gómez', TO_DATE('1990-07-22', 'YYYY-MM-DD'), '555-5678', 'ana.gomez@example.com', 'LIC654321');

-- Insertar datos en la tabla Rutas
INSERT INTO Rutas (ruta_id, nombre_ruta, origen, destino, distancia_km, duracion_estimada_min)
VALUES (1, 'Ruta A', 'Ciudad X', 'Ciudad Y', 100, 120);

INSERT INTO Rutas (ruta_id, nombre_ruta, origen, destino, distancia_km, duracion_estimada_min)
VALUES (2, 'Ruta B', 'Ciudad Y', 'Ciudad Z', 150, 180);

-- Insertar datos en la tabla Autobus_Ruta
INSERT INTO Autobus_Ruta (autobus_id, ruta_id, fecha_asignacion)
VALUES (1, 1, TO_DATE('2023-10-01', 'YYYY-MM-DD'));

INSERT INTO Autobus_Ruta (autobus_id, ruta_id, fecha_asignacion)
VALUES (2, 2, TO_DATE('2023-10-02', 'YYYY-MM-DD'));

-- Insertar datos en la tabla Horarios
INSERT INTO Horarios (horario_id, ruta_id, hora_salida, hora_llegada)
VALUES (1, 1, TO_TIMESTAMP('2023-10-10 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-10-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Horarios (horario_id, ruta_id, hora_salida, hora_llegada)
VALUES (2, 2, TO_TIMESTAMP('2023-10-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-10-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insertar datos en la tabla Mantenimiento
INSERT INTO Mantenimiento (mantenimiento_id, autobus_id, fecha_mantenimiento, tipo_mantenimiento, descripcion, costo)
VALUES (1, 1, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'Preventivo', 'Cambio de aceite y revisión general', 200);

INSERT INTO Mantenimiento (mantenimiento_id, autobus_id, fecha_mantenimiento, tipo_mantenimiento, descripcion, costo)
VALUES (2, 2, TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'Correctivo', 'Reparación de motor', 500);

-- Insertar datos en la tabla Viajes
INSERT INTO Viajes (viaje_id, autobus_id, ruta_id, conductor_id, fecha_viaje, pasajeros_transportados)
VALUES (1, 1, 1, 1, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 18);

INSERT INTO Viajes (viaje_id, autobus_id, ruta_id, conductor_id, fecha_viaje, pasajeros_transportados)
VALUES (2, 2, 2, 2, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 45);

-- Insertar datos en la tabla Pasajeros
INSERT INTO Pasajeros (pasajero_id, nombre, apellido, telefono, email)
VALUES (1, 'Carlos', 'López', '555-9876', 'carlos.lopez@example.com');

INSERT INTO Pasajeros (pasajero_id, nombre, apellido, telefono, email)
VALUES (2, 'María', 'Martínez', '555-4321', 'maria.martinez@example.com');

-- Insertar datos en la tabla Boletos
INSERT INTO Boletos (boleto_id, viaje_id, pasajero_id, fecha_compra, precio, asiento)
VALUES (1, 1, 1, TO_DATE('2023-10-09', 'YYYY-MM-DD'), 50, 'A1');

INSERT INTO Boletos (boleto_id, viaje_id, pasajero_id, fecha_compra, precio, asiento)
VALUES (2, 2, 2, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 75, 'B2');
```

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