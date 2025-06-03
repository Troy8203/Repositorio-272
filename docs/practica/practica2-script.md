---
layout: base
hidden: true
---

# Base de Datos restaurante

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../configuracion/configuracion)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../../)

Las siguiente base de datos tiene la siguiente estructura:

[![Screenshot-2025-05-31-at-10-05-26-Untitled-dbdiagram-io.png](https://i.postimg.cc/T30MfSWx/Screenshot-2025-05-31-at-10-05-26-Untitled-dbdiagram-io.png)](https://postimg.cc/hXX302rZ)

## **Comando para Crear la base de datos:**

```sql
-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE restaurante;
```

### **Comando para Crear las Tablas:**

```sql
-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100)
);

-- Tabla de mesas
CREATE TABLE mesas (
    id_mesa SERIAL PRIMARY KEY,
    numero_mesa INTEGER UNIQUE NOT NULL,
    capacidad INTEGER NOT NULL
);

-- Tabla de empleados
CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    puesto VARCHAR(50)
);

-- Tabla de categorías de productos (por ejemplo: bebidas, entradas, platos fuertes, postres)
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de productos (platos y bebidas)
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10, 2) NOT NULL,
    id_categoria INTEGER REFERENCES categorias(id_categoria)
);

-- Tabla de órdenes (pedidos)
CREATE TABLE ordenes (
    id_orden SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES clientes(id_cliente),
    id_mesa INTEGER REFERENCES mesas(id_mesa),
    id_empleado INTEGER REFERENCES empleados(id_empleado),
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de detalles de órdenes (relación muchos a muchos entre ordenes y productos)
CREATE TABLE detalle_orden (
    id_detalle SERIAL PRIMARY KEY,
    id_orden INTEGER REFERENCES ordenes(id_orden) ON DELETE CASCADE,
    id_producto INTEGER REFERENCES productos(id_producto),
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10, 2) NOT NULL
);
```

### **Comando para realizar la inserción de Datos**

```sql
-- INSERCIÓN DE DATOS

-- Clientes
INSERT INTO clientes (nombre, apellido, telefono, correo_electronico) VALUES
('Lucía', 'Martínez', '3001234567', 'lucia.martinez@gmail.com'),
('Carlos', 'Rojas', '3019876543', 'c.rojas@hotmail.com'),
('Diana', 'Salcedo', '3028765432', 'diana.salcedo@yahoo.com'),
('Andrés', 'González', '3102233445', 'andres.gon@outlook.com'),
('Tatiana', 'Ramírez', '3114455667', 'tati.rami@gmail.com');

-- Mesas
INSERT INTO mesas (numero_mesa, capacidad) VALUES
(1, 4),
(2, 2),
(3, 6),
(4, 4),
(5, 8);

-- Empleados
INSERT INTO empleados (nombre, apellido, telefono, puesto) VALUES
('Jorge', 'Pineda', '3156677889', 'Mesero'),
('Mónica', 'Estrada', '3169988776', 'Cocinera'),
('Samuel', 'Mejía', '3173344556', 'Cajero'),
('Luisa', 'Camargo', '3185566774', 'Mesera');

-- Categorías
INSERT INTO categorias (nombre) VALUES
('Entradas'),
('Platos Fuertes'),
('Bebidas'),
('Postres');

-- Productos
INSERT INTO productos (nombre, descripcion, precio, id_categoria) VALUES
('Ceviche de camarón', 'Mariscos frescos con cítricos y hierbas', 23000.00, 1),
('Ensalada caprese', 'Tomate, mozzarella y albahaca', 18000.00, 1),
('Lomo saltado', 'Carne salteada con papas y arroz', 35000.00, 2),
('Pasta al pesto', 'Tallarines con salsa de albahaca', 29000.00, 2),
('Jugo de maracuyá', 'Jugo natural sin azúcar', 7000.00, 3),
('Limonada cerezada', 'Limonada con cereza natural', 8500.00, 3),
('Tiramisú', 'Postre italiano con café y queso mascarpone', 12000.00, 4),
('Helado artesanal', 'Tres bolas de sabores a elección', 10000.00, 4);

-- Órdenes
INSERT INTO ordenes (id_cliente, id_mesa, id_empleado, fecha) VALUES
(1, 1, 1, '2025-05-28 13:15:00'),
(2, 2, 1, '2025-05-28 13:45:00'),
(3, 3, 4, '2025-05-29 19:00:00'),
(4, 5, 1, '2025-05-30 20:10:00'),
(5, 4, 3, '2025-05-31 12:30:00');

-- Detalles de órdenes
INSERT INTO detalle_orden (id_orden, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 23000.00),
(1, 5, 2, 7000.00),
(2, 3, 1, 35000.00),
(2, 6, 1, 8500.00),
(3, 4, 2, 29000.00),
(3, 7, 1, 12000.00),
(4, 2, 1, 18000.00),
(4, 8, 2, 10000.00),
(5, 3, 1, 35000.00),
(5, 5, 1, 7000.00);
```

### **Comando para Eliminar las Tablas:**

```sql
-- ELIMINAR TODAS LAS TABLAS EN ORDEN POR DEPENDENCIAS

DROP TABLE IF EXISTS detalle_orden;
DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS mesas;
DROP TABLE IF EXISTS clientes;

-- MENSAJE DE CONFIRMACIÓN
SELECT 'Todas las tablas del supermercado han sido eliminadas correctamente' AS mensaje;
```
