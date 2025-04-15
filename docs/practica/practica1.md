---
layout: base
hidden: true
---

# Practica Nro 1

[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)

## Instrucciones

Presentar la siguiente practica hasta el dia lunes 28 de Abril - `28/04/2025`, llenar el siguiente formulario, donde debe presentar las soluciones de las funciones.

- 🔗 [Formulario](https://forms.gle/Rjqqssms1sBUiSQK9)

> Recuerda enviar las soluciones y adjuntar un PDF documentado con las capturas de los resultados

## Levantar el proyecto

Para levantar el proyecto, puedes ejecutar el siguiente script para crear la base de datos, con las inserciones

- 📄 [Configuración Base de Datos](./practica1-script)

## Ejercicios

Resolver los ejercicios para la practica

> Recuerda que el resultado debe ser el mismo

#### 1. Crear una función que calcule el 10% de de cualquier numero decimal x

> No debe aceptar valores nulos, negativo, solo numeros positvos decimales

```sql
SELECT fn_porcentaje10(100.10) AS resultado;
-- Debería devolver 10.010
```

[![image.png](https://i.postimg.cc/ncbn1qyj/image.png)](https://postimg.cc/MX5k6fKq)

```sql
SELECT fn_porcentaje10(100) AS resultado;
-- Debería devolver 10.0
```

[![image.png](https://i.postimg.cc/YS97SRWV/image.png)](https://postimg.cc/K1dwqnQr)

```sql
SELECT fn_porcentaje10(0) AS resultado;
-- Debería devolver 0.0
```

[![image.png](https://i.postimg.cc/8kWSsj71/image.png)](https://postimg.cc/7bxcWP1c)

```sql
SELECT fn_porcentaje10(-50) AS resultado;
-- Debería mostrar un NOTICE con el error y devolver NULL
```

[![image.png](https://i.postimg.cc/GpNWmCr8/image.png)](https://postimg.cc/hJLy2NXc)

```sql
SELECT fn_porcentaje10(NULL) AS resultado;
-- Debería lanzar una excepción visible
```

[![image.png](https://i.postimg.cc/GpNWmCr8/image.png)](https://postimg.cc/hJLy2NXc)

#### 2. Dado el id del cliente mostrar cuanto fue su consumo en total (sin descuento, sin sub total, sin iva)

> tomar en cuenta que el calculo se realiza en base a detalle_ventas
> si no se encuentra el valor, retornar 0

```sql
SELECT fn_total(1)
```

[![image.png](https://i.postimg.cc/3xrjd0JV/image.png)](https://postimg.cc/WhKqy3Zw)

```sql
SELECT fn_total(999)
```

[![image.png](https://i.postimg.cc/JnXZ9bPD/image.png)](https://postimg.cc/JD1sXBwM)

Resultado:

[![image.png](https://i.postimg.cc/sgGcVzR1/image.png)](https://postimg.cc/HrH52fnC)

#### 3. Realizar una funcion que me permita calcular el descuento de cada cliente, el descuento que se realiza al cliente es del 10% y solo si su compra es mayor igual a 50 Bs.

> si no se aplica el descuento mostrar 0
> usar las 2 funciones anteriores
> si el valor de entrada es null, retornar un -1

```sql
SELECT fn_descuento(NULL)
```

[![image.png](https://i.postimg.cc/85qQCVRX/image.png)](https://postimg.cc/DJdYCHY1)

Resultado:

[![image.png](https://i.postimg.cc/L5717q5D/image.png)](https://postimg.cc/rR1sRwSR)

#### 4. El dueño de la empresa ha notado que a los trabajadores que lleven mas de x años en la empresa, se les debe aumentar el sueldo en un 10% por cada año de antiguedad, listar cuanto se salario con el aumento de cada empleado

> usar la funcion calculadora del 10%

Resultado:

[![image.png](https://i.postimg.cc/LXqwG6qQ/image.png)](https://postimg.cc/5YVsCJS8)

#### 5. El dueño de la empresa ha decidido realizar un descuento del 10 porciento en los productos de categoria 'Bebidas' y 'Carnicería' comprados

Resultado

[![image.png](https://i.postimg.cc/gjWpWjNh/image.png)](https://postimg.cc/nj0gKF8V)
