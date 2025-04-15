---
layout: base
hidden: true
---

# Base de Datos supermercado

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../configuracion/configuracion)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../../)

Las siguiente base de datos tiene la siguiente estructura:

[![Screenshot-2025-04-14-at-00-16-58-Untitled-dbdiagram-io.png](https://i.postimg.cc/wBVCRzcK/Screenshot-2025-04-14-at-00-16-58-Untitled-dbdiagram-io.png)](https://postimg.cc/PLC30BRK)

## **Comando para Crear la base de datos:**

### **Comando para Crear la base de datos:**

```sql
-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE supermercado;
```

### **Comando para Crear las Tablas:**

```sql
-- Tabla de Categorías
CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Proveedores
CREATE TABLE proveedores (
    proveedor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT,
    email VARCHAR(100),
    ruc VARCHAR(20) UNIQUE
);

-- Tabla de Productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    codigo_barras VARCHAR(50) UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    stock_minimo INT DEFAULT 10,
    categoria_id INT REFERENCES categorias(categoria_id),
    proveedor_id INT REFERENCES proveedores(proveedor_id),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Clientes
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    puntos_acumulados INT DEFAULT 0
);

-- Tabla de Empleados
CREATE TABLE empleados (
    empleado_id SERIAL PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    fecha_contratacion DATE NOT NULL,
    salario DECIMAL(10,2),
    cargo VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Ventas
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(cliente_id),
    empleado_id INT REFERENCES empleados(empleado_id),
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10,2) NOT NULL,
    iva DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50),
    estado VARCHAR(20) DEFAULT 'COMPLETADA'
);

-- Tabla de Detalle de Ventas
CREATE TABLE detalle_ventas (
    detalle_id SERIAL PRIMARY KEY,
    venta_id INT REFERENCES ventas(venta_id),
    producto_id INT REFERENCES productos(producto_id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL
);
```

### **Comando para realizar la inserción de Datos**

```sql
-- INSERCIÓN DE DATOS
-- Insertar Categorías (10 registros)
INSERT INTO categorias (nombre, descripcion) VALUES
('Lácteos', 'Productos derivados de la leche'),
('Frutas y Verduras', 'Productos frescos de origen vegetal'),
('Carnicería', 'Carnes frescas y procesadas'),
('Panadería', 'Pan y productos de repostería'),
('Bebidas', 'Refrescos, jugos y bebidas alcohólicas'),
('Limpieza', 'Productos de limpieza para el hogar'),
('Electrodomésticos', 'Artículos electrónicos para el hogar'),
('Congelados', 'Alimentos congelados'),
('Enlatados', 'Alimentos en conserva'),
('Cuidado Personal', 'Productos de higiene y belleza');

-- Insertar Proveedores (10 registros)
INSERT INTO proveedores (nombre, contacto, telefono, direccion, email, ruc) VALUES
('Alimentos S.A.', 'Juan Pérez', '0987654321', 'Av. Principal 123', 'contacto@alimentos.com', '1234567890123'),
('Lácteos del Valle', 'María Gómez', '0998765432', 'Calle 10 de Agosto 456', 'ventas@lacteosdelvalle.com', '2345678901234'),
('Distribuidora Norte', 'Carlos Ruiz', '0976543210', 'Av. Amazonas 789', 'info@distribuidoranorte.com', '3456789012345'),
('Frutas Frescas Cía.', 'Luisa Fernández', '0965432109', 'Calle Guayaquil 1011', 'compras@frutasfrescas.com', '4567890123456'),
('Carnes Premium', 'Roberto Mendoza', '0954321098', 'Av. Shyris 1213', 'ventas@carnespremium.com', '5678901234567'),
('Bebidas Internacionales', 'Ana Castro', '0943210987', 'Calle Rumiñahui 1415', 'info@bebidasinternacionales.com', '6789012345678'),
('Limpieza Total', 'Pedro Vargas', '0932109876', 'Av. de los Shyris 1617', 'contacto@limpiezatotal.com', '7890123456789'),
('ElectroHogar', 'Sofía Ramírez', '0921098765', 'Calle Juan León Mera 1819', 'ventas@electrohogar.com', '8901234567890'),
('Congelados del Pacífico', 'Diego Torres', '0910987654', 'Av. 6 de Diciembre 2021', 'info@congeladospacifico.com', '9012345678901'),
('Belleza Natural', 'Carolina Ortiz', '0909876543', 'Calle Almagro 2223', 'contacto@bellezanatural.com', '0123456789012');

-- Insertar Productos (10 registros)
INSERT INTO productos (codigo_barras, nombre, descripcion, precio_compra, precio_venta, stock, stock_minimo, categoria_id, proveedor_id) VALUES
('7501001234567', 'Leche Entera 1L', 'Leche entera pasteurizada', 0.85, 1.20, 150, 30, 1, 2),
('7501002345678', 'Manzanas Royal Gala', 'Manzanas frescas importadas', 0.50, 0.75, 200, 50, 2, 4),
('7501003456789', 'Pechuga de Pollo', 'Pechuga de pollo sin hueso', 2.50, 3.75, 80, 20, 3, 5),
('7501004567890', 'Pan Integral', 'Pan integral de trigo', 0.60, 0.90, 100, 40, 4, 1),
('7501005678901', 'Coca-Cola 2L', 'Refresco de cola', 1.00, 1.50, 120, 30, 5, 6),
('7501006789012', 'Detergente Líquido', 'Detergente para ropa 3L', 3.50, 4.99, 60, 15, 6, 7),
('7501007890123', 'Microondas 20L', 'Horno microondas digital', 45.00, 69.99, 15, 5, 7, 8),
('7501008901234', 'Pizza Congelada', 'Pizza de pepperoni 12"', 2.80, 4.25, 50, 10, 8, 9),
('7501009012345', 'Atún en Lata', 'Atún en agua 180g', 1.20, 1.80, 90, 25, 9, 3),
('7501010123456', 'Shampoo Anticaspa', 'Shampoo para cabello graso', 2.30, 3.45, 70, 20, 10, 10);

-- Insertar Clientes (10 registros)
INSERT INTO clientes (cedula, nombre, apellido, telefono, email, direccion, puntos_acumulados) VALUES
('1712345678', 'Juan', 'Martínez', '0987654321', 'juan.martinez@email.com', 'Av. Amazonas 123', 150),
('1723456789', 'María', 'González', '0998765432', 'maria.gonzalez@email.com', 'Calle Guayaquil 456', 75),
('1734567890', 'Carlos', 'Rodríguez', '0976543210', 'carlos.rodriguez@email.com', 'Av. 6 de Diciembre 789', 200),
('1745678901', 'Ana', 'López', '0965432109', 'ana.lopez@email.com', 'Calle Rumiñahui 1011', 50),
('1756789012', 'Pedro', 'Sánchez', '0954321098', 'pedro.sanchez@email.com', 'Av. Shyris 1213', 300),
('1767890123', 'Lucía', 'Pérez', '0943210987', 'lucia.perez@email.com', 'Calle Juan León Mera 1415', 25),
('1778901234', 'Diego', 'Fernández', '0932109876', 'diego.fernandez@email.com', 'Av. de los Shyris 1617', 180),
('1789012345', 'Sofía', 'García', '0921098765', 'sofia.garcia@email.com', 'Calle Almagro 1819', 90),
('1790123456', 'Miguel', 'Díaz', '0910987654', 'miguel.diaz@email.com', 'Av. 10 de Agosto 2021', 120),
('1701234567', 'Laura', 'Romero', '0909876543', 'laura.romero@email.com', 'Calle Veintimilla 2223', 60);

-- Insertar Empleados (10 registros)
INSERT INTO empleados (cedula, nombre, apellido, telefono, email, direccion, fecha_contratacion, salario, cargo) VALUES
('1712345001', 'Roberto', 'Vargas', '0987000001', 'roberto.vargas@supermercado.com', 'Av. Colon 100', '2020-01-15', 850.00, 'Cajero'),
('1723456002', 'Patricia', 'Mendoza', '0998000002', 'patricia.mendoza@supermercado.com', 'Calle Loja 200', '2019-05-20', 900.00, 'Supervisor'),
('1734567003', 'Fernando', 'Castro', '0976000003', 'fernando.castro@supermercado.com', 'Av. América 300', '2021-03-10', 800.00, 'Reponedor'),
('1745678004', 'Gabriela', 'Ortega', '0965000004', 'gabriela.ortega@supermercado.com', 'Calle Quito 400', '2018-11-05', 950.00, 'Gerente'),
('1756789005', 'Ricardo', 'Silva', '0954000005', 'ricardo.silva@supermercado.com', 'Av. Atahualpa 500', '2022-02-18', 820.00, 'Cajero'),
('1767890006', 'Diana', 'Paredes', '0943000006', 'diana.paredes@supermercado.com', 'Calle Bolívar 600', '2020-07-22', 880.00, 'Atención al Cliente'),
('1778901007', 'Jorge', 'Ríos', '0932000007', 'jorge.rios@supermercado.com', 'Av. Mariscal Sucre 700', '2019-09-30', 870.00, 'Reponedor'),
('1789012008', 'Carmen', 'Valdez', '0921000008', 'carmen.valdez@supermercado.com', 'Calle Rocafuerte 800', '2021-01-12', 920.00, 'Supervisor'),
('1790123009', 'Oscar', 'Navarro', '0910000009', 'oscar.navarro@supermercado.com', 'Av. 12 de Octubre 900', '2018-04-15', 1000.00, 'Gerente'),
('1701234010', 'Verónica', 'Jiménez', '0909000010', 'veronica.jimenez@supermercado.com', 'Calle Maldonado 1000', '2022-06-05', 830.00, 'Cajero');

-- Insertar Ventas (10 registros)
INSERT INTO ventas (cliente_id, empleado_id, subtotal, iva, total, metodo_pago, estado) VALUES
(1, 1, 45.75, 5.49, 51.24, 'Tarjeta de Crédito', 'COMPLETADA'),
(3, 2, 28.90, 3.47, 32.37, 'Efectivo', 'COMPLETADA'),
(5, 1, 67.20, 8.06, 75.26, 'Tarjeta de Débito', 'COMPLETADA'),
(2, 3, 15.50, 1.86, 17.36, 'Efectivo', 'COMPLETADA'),
(4, 4, 92.30, 11.08, 103.38, 'Transferencia', 'COMPLETADA'),
(7, 2, 34.75, 4.17, 38.92, 'Efectivo', 'COMPLETADA'),
(6, 5, 21.80, 2.62, 24.42, 'Tarjeta de Crédito', 'COMPLETADA'),
(8, 3, 56.40, 6.77, 63.17, 'Efectivo', 'COMPLETADA'),
(9, 1, 43.25, 5.19, 48.44, 'Tarjeta de Débito', 'COMPLETADA'),
(10, 4, 78.60, 9.43, 88.03, 'Transferencia', 'COMPLETADA');

-- Insertar Detalle de Ventas (22 registros - más de 10 para relaciones)
INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 3, 2, 3.75, 7.50),
(1, 5, 4, 1.50, 6.00),
(1, 7, 1, 69.99, 69.99),
(2, 2, 5, 0.75, 3.75),
(2, 4, 3, 0.90, 2.70),
(2, 6, 2, 4.99, 9.98),
(3, 1, 10, 1.20, 12.00),
(3, 8, 3, 4.25, 12.75),
(3, 10, 5, 3.45, 17.25),
(4, 9, 2, 1.80, 3.60),
(4, 5, 1, 1.50, 1.50),
(5, 7, 2, 69.99, 139.98),
(6, 2, 8, 0.75, 6.00),
(6, 4, 6, 0.90, 5.40),
(7, 1, 3, 1.20, 3.60),
(7, 3, 1, 3.75, 3.75),
(8, 5, 2, 1.50, 3.00),
(8, 6, 1, 4.99, 4.99),
(9, 8, 4, 4.25, 17.00),
(9, 10, 2, 3.45, 6.90),
(10, 9, 3, 1.80, 5.40),
(10, 7, 1, 69.99, 69.99);
```

### **Comando para Eliminar las Tablas:**

```sql
-- 1. Eliminar tabla detalle_ventas (depende de ventas y productos)
DROP TABLE IF EXISTS detalle_ventas CASCADE;

-- 2. Eliminar tabla ventas (depende de clientes y empleados)
DROP TABLE IF EXISTS ventas CASCADE;

-- 3. Eliminar tabla productos (depende de categorias y proveedores)
DROP TABLE IF EXISTS productos CASCADE;

-- 4. Eliminar tablas independientes
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS proveedores CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;

-- OPCIÓN ALTERNATIVA: Eliminar toda la base de datos (más radical)
-- DROP DATABASE IF EXISTS supermercado;

-- MENSAJE DE CONFIRMACIÓN
SELECT 'Todas las tablas del supermercado han sido eliminadas correctamente' AS mensaje;
```