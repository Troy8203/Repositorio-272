---
layout: page
title: ""
---

# **Proyecto Base - Base de Datos para Autobuses**

## **Estructura**

Esta es una base de datos de ejemplo para un sistema de gestión de autobuses. Contiene tablas para Autobuses, Conductores, Rutas, Viajes y otros elementos relacionados.

![Diagrama de la base de datos](https://i.postimg.cc/wMvxsZ1L/Screenshot-2025-03-21-at-07-39-04-Untitled-dbdiagram-io.png)

## **1. Crear la Base de Datos**

Aquí se define la estructura inicial de las tablas necesarias para el sistema de gestión de autobuses.

**Tablas a Crear:**

- **Autobuses**
- **Conductores**
- **Rutas**
- **Autobus_Ruta**
- **Horarios**
- **Mantenimiento**
- **Viajes**
- **Pasajeros**
- **Boletos**

### **Comando para Crear las Tablas:**

```postgresql
CREATE TABLE Autobuses (
    autobus_id SERIAL PRIMARY KEY,
    matricula VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    fecha_fabricacion DATE NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Activo', 'Inactivo', 'En Mantenimiento'))
);

CREATE TABLE Conductores (
    conductor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    licencia_conducir VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Rutas (
    ruta_id SERIAL PRIMARY KEY,
    nombre_ruta VARCHAR(100) NOT NULL,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    distancia_km INT NOT NULL,
    duracion_estimada_min INT NOT NULL
);

CREATE TABLE Autobus_Ruta (
    autobus_id INT REFERENCES Autobuses(autobus_id),
    ruta_id INT REFERENCES Rutas(ruta_id),
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (autobus_id, ruta_id)
);

CREATE TABLE Horarios (
    horario_id SERIAL PRIMARY KEY,
    ruta_id INT REFERENCES Rutas(ruta_id),
    hora_salida TIMESTAMP NOT NULL,
    hora_llegada TIMESTAMP NOT NULL
);

CREATE TABLE Mantenimiento (
    mantenimiento_id SERIAL PRIMARY KEY,
    autobus_id INT REFERENCES Autobuses(autobus_id),
    fecha_mantenimiento DATE DEFAULT CURRENT_DATE,
    tipo_mantenimiento VARCHAR(50) CHECK (tipo_mantenimiento IN ('Preventivo', 'Correctivo')),
    descripcion VARCHAR(500),
    costo NUMERIC
);

CREATE TABLE Viajes (
    viaje_id SERIAL PRIMARY KEY,
    autobus_id INT REFERENCES Autobuses(autobus_id),
    ruta_id INT REFERENCES Rutas(ruta_id),
    conductor_id INT REFERENCES Conductores(conductor_id),
    fecha_viaje DATE DEFAULT CURRENT_DATE,
    pasajeros_transportados INT
);

CREATE TABLE Pasajeros (
    pasajero_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Boletos (
    boleto_id SERIAL PRIMARY KEY,
    viaje_id INT REFERENCES Viajes(viaje_id),
    pasajero_id INT REFERENCES Pasajeros(pasajero_id),
    fecha_compra DATE DEFAULT CURRENT_DATE,
    precio NUMERIC NOT NULL,
    asiento VARCHAR(10)
);
```

---

## **2. Inserción de Datos de Ejemplo**

Aquí te mostramos cómo insertar datos de ejemplo para que puedas trabajar con la base de datos de manera más efectiva.

### **Comando para Insertar Datos de Ejemplo:**

```postgresql
-- Insertar datos de ejemplo
INSERT INTO Autobuses (matricula, marca, modelo, capacidad, fecha_fabricacion, estado) VALUES
('ABC123', 'Mercedes', 'Sprinter', 20, '2018-05-10', 'Activo'),
('XYZ789', 'Volvo', '7700', 30, '2017-07-15', 'En Mantenimiento'),
('JKL456', 'Scania', 'Citywide', 40, '2019-08-20', 'Activo');

INSERT INTO Conductores (nombre, apellido, fecha_nacimiento, telefono, email, licencia_conducir) VALUES
('Juan', 'Perez', '1985-04-12', '123456789', 'juan.perez@email.com', 'ABC12345'),
('Maria', 'Lopez', '1990-06-25', '987654321', 'maria.lopez@email.com', 'DEF67890');

INSERT INTO Rutas (nombre_ruta, origen, destino, distancia_km, duracion_estimada_min) VALUES
('Ruta Norte', 'Ciudad A', 'Ciudad B', 150, 120),
('Ruta Sur', 'Ciudad C', 'Ciudad D', 200, 180);

INSERT INTO Autobus_Ruta (autobus_id, ruta_id) VALUES
(1, 1),
(2, 2);

INSERT INTO Horarios (ruta_id, hora_salida, hora_llegada) VALUES
(1, '2024-03-28 08:00:00', '2024-03-28 10:00:00'),
(2, '2024-03-28 15:00:00', '2024-03-28 18:00:00');

INSERT INTO Mantenimiento (autobus_id, tipo_mantenimiento, descripcion, costo) VALUES
(2, 'Correctivo', 'Cambio de frenos', 500),
(1, 'Preventivo', 'Revisión general', 300);

INSERT INTO Viajes (autobus_id, ruta_id, conductor_id, pasajeros_transportados) VALUES
(1, 1, 1, 18),
(2, 2, 2, 25);

INSERT INTO Pasajeros (nombre, apellido, telefono, email) VALUES
('Carlos', 'Martinez', '111111111', 'carlos.martinez@email.com'),
('Ana', 'Gomez', '222222222', 'ana.gomez@email.com');

INSERT INTO Boletos (viaje_id, pasajero_id, precio, asiento) VALUES
(1, 1, 15.50, 'A1'),
(2, 2, 18.75, 'B2');
```

---

## **3. Eliminación de la Base de Datos**

Si necesitas eliminar toda la base de datos, utiliza el siguiente comando:

### **Comando para Eliminar las Tablas:**

```postgresql
DROP TABLE IF EXISTS Boletos, Pasajeros, Viajes, Mantenimiento, Horarios, Autobus_Ruta, Rutas, Conductores, Autobuses CASCADE;
```

---

Con esta estructura y los comandos proporcionados, ahora tienes una base de datos completamente funcional para el sistema de gestión de autobuses. ¡Listo para ser utilizado en tu proyecto!
