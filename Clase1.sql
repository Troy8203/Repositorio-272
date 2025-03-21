--Crear un tabla
CREATE TABLE empleados (
    id_empleado NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    fecha_contratacion DATE,
    salario NUMBER(10,2),
    activo CHAR(1)
);

--Insert
INSERT INTO empleados VALUES (1, 'Juan', 'Pérez', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 3500.50, 'S');
INSERT INTO empleados VALUES (2, 'Ana', 'López', TO_DATE('2021-05-10', 'YYYY-MM-DD'), 4200.75, 'N');
INSERT INTO empleados VALUES (3, 'Carlos', 'Ramírez', TO_DATE('2020-07-20', 'YYYY-MM-DD'), 2800.00, 'S');
COMMIT;

--Select
SELECT * FROM empleados;

-- Select with WHERE
SELECT nombre, apellido, salario FROM empleados WHERE activo = 'S';

-- Update
UPDATE empleados 
SET salario = salario * 1.10 WHERE id = 1;
COMMIT;

-- Delete
DELETE FROM empleados 
WHERE id = 2;
COMMIT;

-- Crear otra tabla y establecer una relación N:M con la anterior
-- 1. Crear tabla de proyectos
CREATE TABLE proyectos (
    id_proyecto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100)
);

-- Insert table
INSERT INTO proyectos VALUES (1, 'Sistema de Ventas');
INSERT INTO proyectos VALUES (2, 'Plataforma Web');
COMMIT;

-- 2. Crear tabla intermedia para la relación N:M
CREATE TABLE empleado_proyecto (
    id_empleado NUMBER,
    id_proyecto NUMBER,
    PRIMARY KEY (id_empleado, id_proyecto),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto)
);


-- 4. Relacionar empleados con proyectos
INSERT INTO empleado_proyecto VALUES (1, 1);
INSERT INTO empleado_proyecto VALUES (1, 2);
INSERT INTO empleado_proyecto VALUES (2, 1);
COMMIT;

-- Consultas con COUNT, SUM, AVG, GROUP BY y HAVING

-- 1. Contar empleados activos
SELECT COUNT(*) AS total_empleados_activos
FROM empleados WHERE activo = 'S';

-- 2. Sumar salarios por departamento (suponiendo que se agregara una columna departamento)
-- ALTER TABLE empleados ADD departamento VARCHAR2(50);
-- UPDATE empleados SET departamento = 'Ventas' WHERE id_empleado = 1;
-- UPDATE empleados SET departamento = 'TI' WHERE id_empleado = 2;
-- COMMIT;
SELECT departamento, SUM(salario) AS total_salarios FROM empleados GROUP BY departamento;

-- 3. Promedio de salario por departamento
SELECT departamento, AVG(salario) AS salario_promedio FROM empleados GROUP BY departamento HAVING AVG(salario) > 3000;

-- 4. Uso de JOINs
SELECT e.nombre, p.nombre AS proyecto
FROM empleados e
JOIN empleado_proyecto ep ON e.id_empleado = ep.id_empleado
JOIN proyectos p ON ep.id_proyecto = p.id_proyecto;