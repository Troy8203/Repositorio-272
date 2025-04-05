---
layout: base
hidden: true
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
INSERT INTO Autobuses (
        matricula,
        marca,
        modelo,
        capacidad,
        fecha_fabricacion,
        estado
    )
VALUES (
        'ABC123',
        'Mercedes-Benz',
        'Sprinter',
        20,
        '2020-05-15',
        'Activo'
    ),
    (
        'DEF456',
        'Volvo',
        '9700',
        50,
        '2019-11-20',
        'Activo'
    ),
    (
        'GHI789',
        'Scania',
        'Interlink',
        45,
        '2021-03-10',
        'En Mantenimiento'
    ),
    (
        'JKL012',
        'MAN',
        'Lion''s Coach',
        55,
        '2018-07-25',
        'Activo'
    ),
    (
        'MNO345',
        'Iveco',
        'Magelys',
        40,
        '2022-01-30',
        'Activo'
    ),
    (
        'PQR678',
        'Setra',
        'S 511 HD',
        60,
        '2020-09-12',
        'Inactivo'
    ),
    (
        'STU901',
        'Neoplan',
        'Tourliner',
        50,
        '2019-04-05',
        'Activo'
    ),
    (
        'VWX234',
        'Van Hool',
        'TX15',
        55,
        '2021-07-18',
        'Activo'
    ),
    (
        'YZA567',
        'Marcopolo',
        'Paradiso G7',
        45,
        '2020-12-01',
        'En Mantenimiento'
    ),
    (
        'BCD890',
        'Mercedes-Benz',
        'Tourismo',
        50,
        '2022-02-14',
        'Activo'
    );
-- Inserción de datos en la tabla Conductores
INSERT INTO Conductores (
        nombre,
        apellido,
        fecha_nacimiento,
        telefono,
        email,
        licencia_conducir
    )
VALUES (
        'Juan',
        'Pérez',
        '1985-05-20',
        '5551234567',
        'juan.perez@email.com',
        'DL12345678'
    ),
    (
        'María',
        'Gómez',
        '1990-08-15',
        '5552345678',
        'maria.gomez@email.com',
        'DL23456789'
    ),
    (
        'Carlos',
        'López',
        '1982-11-30',
        '5553456789',
        'carlos.lopez@email.com',
        'DL34567890'
    ),
    (
        'Ana',
        'Martínez',
        '1978-03-25',
        '5554567890',
        'ana.martinez@email.com',
        'DL45678901'
    ),
    (
        'Luis',
        'Rodríguez',
        '1987-07-10',
        '5555678901',
        'luis.rodriguez@email.com',
        'DL56789012'
    ),
    (
        'Sofía',
        'Hernández',
        '1992-01-05',
        '5556789012',
        'sofia.hernandez@email.com',
        'DL67890123'
    ),
    (
        'Pedro',
        'García',
        '1980-09-18',
        '5557890123',
        'pedro.garcia@email.com',
        'DL78901234'
    ),
    (
        'Laura',
        'Díaz',
        '1989-04-22',
        '5558901234',
        'laura.diaz@email.com',
        'DL89012345'
    ),
    (
        'Jorge',
        'Fernández',
        '1975-12-08',
        '5559012345',
        'jorge.fernandez@email.com',
        'DL90123456'
    ),
    (
        'Mónica',
        'Sánchez',
        '1983-06-14',
        '5550123456',
        'monica.sanchez@email.com',
        'DL01234567'
    );
-- Inserción de datos en la tabla Rutas
INSERT INTO Rutas (
        nombre_ruta,
        origen,
        destino,
        distancia_km,
        duracion_estimada_min
    )
VALUES (
        'Ruta 1',
        'Ciudad de México',
        'Guadalajara',
        540,
        360
    ),
    ('Ruta 2', 'Monterrey', 'Tampico', 520, 330),
    ('Ruta 3', 'Puebla', 'Veracruz', 300, 210),
    ('Ruta 4', 'Mérida', 'Cancún', 320, 240),
    ('Ruta 5', 'León', 'Querétaro', 180, 120),
    ('Ruta 6', 'Tijuana', 'Ensenada', 110, 90),
    ('Ruta 7', 'Acapulco', 'Zihuatanejo', 240, 180),
    (
        'Ruta 8',
        'San Luis Potosí',
        'Aguascalientes',
        220,
        150
    ),
    ('Ruta 9', 'Chihuahua', 'Durango', 450, 300),
    (
        'Ruta 10',
        'Oaxaca',
        'Puerto Escondido',
        280,
        210
    );
-- Inserción de datos en la tabla Autobus_Ruta
INSERT INTO Autobus_Ruta (autobus_id, ruta_id, fecha_asignacion)
VALUES (1, 1, '2023-01-10'),
    (2, 2, '2023-01-15'),
    (3, 3, '2023-01-20'),
    (4, 4, '2023-02-05'),
    (5, 5, '2023-02-10'),
    (6, 6, '2023-02-15'),
    (7, 7, '2023-03-01'),
    (8, 8, '2023-03-05'),
    (9, 9, '2023-03-10'),
    (10, 10, '2023-03-15');
-- Inserción de datos en la tabla Horarios
INSERT INTO Horarios (ruta_id, hora_salida, hora_llegada)
VALUES (1, '2023-04-01 08:00:00', '2023-04-01 14:00:00'),
    (2, '2023-04-01 09:30:00', '2023-04-01 15:00:00'),
    (3, '2023-04-02 07:00:00', '2023-04-02 10:30:00'),
    (4, '2023-04-02 10:00:00', '2023-04-02 14:00:00'),
    (5, '2023-04-03 06:30:00', '2023-04-03 08:30:00'),
    (6, '2023-04-03 11:00:00', '2023-04-03 12:30:00'),
    (7, '2023-04-04 08:00:00', '2023-04-04 11:00:00'),
    (8, '2023-04-04 13:00:00', '2023-04-04 15:30:00'),
    (9, '2023-04-05 07:30:00', '2023-04-05 12:30:00'),
    (10, '2023-04-05 09:00:00', '2023-04-05 12:30:00');
-- Inserción de datos en la tabla Mantenimiento
INSERT INTO Mantenimiento (
        autobus_id,
        fecha_mantenimiento,
        tipo_mantenimiento,
        descripcion,
        costo
    )
VALUES (
        1,
        '2023-01-05',
        'Preventivo',
        'Cambio de aceite y filtros',
        2500.00
    ),
    (
        2,
        '2023-01-10',
        'Correctivo',
        'Reparación de frenos',
        4800.00
    ),
    (
        3,
        '2023-01-15',
        'Preventivo',
        'Revisión general',
        1800.00
    ),
    (
        4,
        '2023-02-01',
        'Correctivo',
        'Cambio de neumáticos',
        6500.00
    ),
    (
        5,
        '2023-02-05',
        'Preventivo',
        'Alineación y balanceo',
        2200.00
    ),
    (
        6,
        '2023-02-10',
        'Correctivo',
        'Reparación de motor',
        12000.00
    ),
    (
        7,
        '2023-02-20',
        'Preventivo',
        'Cambio de líquidos',
        3000.00
    ),
    (
        8,
        '2023-03-01',
        'Correctivo',
        'Reparación de transmisión',
        8500.00
    ),
    (
        9,
        '2023-03-05',
        'Preventivo',
        'Revisión eléctrica',
        2000.00
    ),
    (
        10,
        '2023-03-10',
        'Correctivo',
        'Reparación de suspensión',
        5500.00
    );
-- Inserción de datos en la tabla Pasajeros
INSERT INTO Pasajeros (nombre, apellido, telefono, email)
VALUES (
        'Alejandro',
        'Ramírez',
        '5551112233',
        'alejandro.ramirez@email.com'
    ),
    (
        'Beatriz',
        'Castro',
        '5552223344',
        'beatriz.castro@email.com'
    ),
    (
        'Daniel',
        'Ortega',
        '5553334455',
        'daniel.ortega@email.com'
    ),
    (
        'Elena',
        'Vargas',
        '5554445566',
        'elena.vargas@email.com'
    ),
    (
        'Francisco',
        'Mendoza',
        '5555556677',
        'francisco.mendoza@email.com'
    ),
    (
        'Gabriela',
        'Silva',
        '5556667788',
        'gabriela.silva@email.com'
    ),
    (
        'Héctor',
        'Ríos',
        '5557778899',
        'hector.rios@email.com'
    ),
    (
        'Isabel',
        'Flores',
        '5558889900',
        'isabel.flores@email.com'
    ),
    (
        'José',
        'Miranda',
        '5559990011',
        'jose.miranda@email.com'
    ),
    (
        'Karen',
        'Guerrero',
        '5550001122',
        'karen.guerrero@email.com'
    );
-- Inserción de datos en la tabla Viajes
INSERT INTO Viajes (
        autobus_id,
        ruta_id,
        conductor_id,
        fecha_viaje,
        pasajeros_transportados
    )
VALUES (1, 2, 2, '2023-04-01', 18),
    (2, 1, 1, '2023-04-01', 45),
    (3, 5, 4, '2023-04-02', 35),
    (4, 5, 5, '2023-04-02', 50),
    (5, 1, 3, '2023-04-03', 38),
    (6, 1, 1, '2023-04-03', 10),
    (7, 5, 4, '2023-04-04', 42),
    (8, 4, 1, '2023-04-04', 48),
    (9, 3, 4, '2023-04-05', 40),
    (10, 3, 2, '2023-04-05', 44);
-- Inserción de datos en la tabla Boletos
INSERT INTO Boletos (
        viaje_id,
        pasajero_id,
        fecha_compra,
        precio,
        asiento
    )
VALUES (1, 1, '2023-03-30', 450.00, 'A1'),
    (1, 2, '2023-03-31', 450.00, 'A2'),
    (2, 3, '2023-03-29', 380.00, 'B3'),
    (2, 4, '2023-03-30', 380.00, 'B4'),
    (3, 5, '2023-04-01', 280.00, 'C5'),
    (3, 6, '2023-04-01', 280.00, 'C6'),
    (4, 7, '2023-03-28', 350.00, 'D7'),
    (4, 8, '2023-03-29', 350.00, 'D8'),
    (5, 9, '2023-04-02', 180.00, 'E9'),
    (5, 10, '2023-04-02', 180.00, 'E10');
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
