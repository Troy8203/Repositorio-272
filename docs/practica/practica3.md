---
layout: base
hidden: true
---

# Practica Nro 3

[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)

## Instrucciones

Presentar la siguiente practica hasta el dia lunes 16 de Junio - `16/06/2025`, llenar el siguiente formulario, donde debe presentar las soluciones de las funciones.

- 🔗 [Formulario](https://forms.gle/zbvQeYFtYRwrRwsSA)

> Recuerda enviar las soluciones y adjuntar un PDF documentado con las capturas de los resultados

## Levantar el proyecto

Para levantar el proyecto, puedes ejecutar el siguiente script para crear la base de datos, con las inserciones

- 📄 [Configuración Base de Datos](../../base/base.md)

## Ejercicios

Resolver los ejercicios para la practica

> Recuerda que el resultado debe ser el mismo

### Ejercicio 1

Dado un id de conductor mostrar su nombre conpleto y la cantidad total de pasajeros que a transportado usando un procedimiento almacenado.

##### Resultado id=1:

[![image.png](https://i.postimg.cc/Nj7Z6nYx/image.png)](https://postimg.cc/jD28KZDW)

##### Resultado id=2:

[![image.png](https://i.postimg.cc/7Zsnr1Nk/image.png)](https://postimg.cc/WdZkMkKW)

#### Ejercicio 2

Usando cursores recorrer todos los autobuses y mostrar su id y su matricula solo aquellos que están activos.

##### Resultado:

[![image.png](https://i.postimg.cc/cHjBvP1h/image.png)](https://postimg.cc/xJvz7xzN)

#### Ejercicio 3

Crear un tabla historial de horarios y cada que se modifique el horario de un autobus, se debe almacenar el antiguo y nuevo horario en la tabla (usar triggers).

##### Resultado:

Despues de ejecutar una actualización

```sql
UPDATE horarios
SET hora_salida = '2022-01-01 18:00:00', hora_llegada = '2022-01-01 20:00:00'
WHERE horario_id = 1;
```

se deberia mostrar de la siguiente manera

[![image.png](https://i.postimg.cc/3xCyp2Rv/image.png)](https://postimg.cc/sMxDCQ5j)
