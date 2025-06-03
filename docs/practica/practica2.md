---
layout: base
hidden: true
---

# Practica Nro 2

[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)

## Instrucciones

Presentar la siguiente practica hasta el dia lunes 9 de Junio - `9/06/2025`, llenar el siguiente formulario, donde debe presentar las soluciones de las funciones.

- 🔗 [Formulario](https://forms.gle/ApZXxvpdMeCgaKSL8)

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

[![image.png](https://i.postimg.cc/vBLF7Vxt/image.png)](https://postimg.cc/PpxRTN4C)

#### Ejercicio 2

Crear un procedimiento que indique el estado de cada mesa dado una fecha:

- “Ocupada” si tiene alguna orden activa (una orden del día actual)
- “Libre” si no tiene órdenes el xfecha

> Valores de entrada id_mesa, fecha

##### Resultado con `2025-05-28`:

[![image.png](https://i.postimg.cc/3Nvb9NB9/image.png)](https://postimg.cc/7JqVZxjT)

##### Resultado con `2025-05-30`:

[![image.png](https://i.postimg.cc/nryNtBz6/image.png)](https://postimg.cc/ctcFRKfm)

#### Ejercicio 3

Utilizar un cursor para mostrar todos los productos cuyo precio sea mayor a un valor dado. Imprimir nombre y precio.

##### Resultado con precio limite de `20000`:

[![image.png](https://i.postimg.cc/5y9vsRb0/image.png)](https://postimg.cc/VrTd64SQ)

##### Resultado con precio limite de `7000`:

[![image.png](https://i.postimg.cc/zf1ydckr/image.png)](https://postimg.cc/WdXpzSKW)

#### Ejercicio 4

Utilizar un cursor para calcular el total de cada orden (suma de cantidad \* precio_unitario) y mostrar el ID de la orden y su total.

##### Resultado:

[![image.png](https://i.postimg.cc/Kjrb80Mn/image.png)](https://postimg.cc/kR4zjFw4)

#### Ejercicio 5

Crear un cursor que mustre el detalle producto con sus productos, cantidad y precio

##### Resultado:

[![image.png](https://i.postimg.cc/SQTwbZKF/image.png)](https://postimg.cc/hhmC91xp)
