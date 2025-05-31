---
layout: base
hidden: true
---

# Practica Nro 1

[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)

## Instrucciones

Presentar la siguiente practica hasta el dia lunes 10 de Junio - `10/06/2025`, llenar el siguiente formulario, donde debe presentar las soluciones de las funciones.

- 🔗 [Formulario](xcadaw)

> Recuerda enviar las soluciones y adjuntar un PDF documentado con las capturas de los resultados

## Levantar el proyecto

Para levantar el proyecto, puedes ejecutar el siguiente script para crear la base de datos, con las inserciones

- 📄 [Configuración Base de Datos](./practica2-script)

## Ejercicios

Resolver los ejercicios para la practica

> Recuerda que el resultado debe ser el mismo

### Ejercicio 1

Crear un procedimiento que calcule y muestre la suma total de ventas que ha gestionado cada empleado. El total de cada venta se calcula como la suma de cantidad \* precio_unitario de los productos en cada orden asociada al empleado.

##### Resultado:

[![image.png](https://i.postimg.cc/ncbn1qyj/image.png)](https://postimg.cc/MX5k6fKq)

#### Ejercicio 2

Crear un procedimiento que indique el estado de cada mesa:

- “Ocupada” si tiene alguna orden activa (una orden del día actual)
- “Libre” si no tiene órdenes hoy

##### Resultado:

[![image.png](https://i.postimg.cc/sgGcVzR1/image.png)](https://postimg.cc/HrH52fnC)

#### Ejercicio 3

Utilizar un cursor para mostrar todos los productos cuyo precio sea mayor a un valor dado. Imprimir nombre y precio.

```sql
SELECT fn_descuento(NULL)
```

[![image.png](https://i.postimg.cc/85qQCVRX/image.png)](https://postimg.cc/DJdYCHY1)

Resultado:

[![image.png](https://i.postimg.cc/L5717q5D/image.png)](https://postimg.cc/rR1sRwSR)

#### Ejercicio 4

Utilizar un cursor para calcular el total de cada orden (suma de cantidad \* precio_unitario) y mostrar el ID de la orden y su total.

Resultado:

[![image.png](https://i.postimg.cc/LXqwG6qQ/image.png)](https://postimg.cc/5YVsCJS8)

#### Ejercicio 5

Crear un procedimiento que use un cursor para encontrar y eliminar todos los productos que nunca han sido vendidos (no aparecen en detalle_orden).

Resultado:

[![image.png](https://i.postimg.cc/gjWpWjNh/image.png)](https://postimg.cc/nj0gKF8V)
