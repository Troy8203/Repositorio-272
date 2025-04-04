---
layout: page
title: ""
---

# Configuración de PostgreSQL con Workbench

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../configuracion/configuracion)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)
![pgAdmin](https://img.shields.io/badge/pgAdmin-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48ZyBmaWxsPSJub25lIj48cGF0aCBkPSJtMTIuNTkzIDIzLjI1OGwtLjAxMS4wMDJsLS4wNzEuMDM1bC0uMDIuMDA0bC0uMDE0LS4wMDRsLS4wNzEtLjAzNXEtLjAxNi0uMDA1LS4wMjQuMDA1bC0uMDA0LjAxbC0uMDE3LjQyOGwuMDA1LjAybC4wMS4wMTNsLjEwNC4wNzRsLjAxNS4wMDRsLjAxMi0uMDA0bC4xMDQtLjA3NGwuMDEyLS4wMTZsLjAwNC0uMDE3bC0uMDE3LS40MjdxLS4wMDQtLjAxNi0uMDE3LS4wMThtLjI2NS0uMTEzbC0uMDEzLjAwMmwtLjE4NS4wOTNsLS4wMS4wMWwtLjAwMy4wMTFsLjAxOC40M2wuMDA1LjAxMmwuMDA4LjAwN2wuMjAxLjA5M3EuMDE5LjAwNS4wMjktLjAwOGwuMDA0LS4wMTRsLS4wMzQtLjYxNHEtLjAwNS0uMDE4LS4wMi0uMDIybS0uNzE1LjAwMmEuMDIuMDIgMCAwIDAtLjAyNy4wMDZsLS4wMDYuMDE0bC0uMDM0LjYxNHEuMDAxLjAxOC4wMTcuMDI0bC4wMTUtLjAwMmwuMjAxLS4wOTNsLjAxLS4wMDhsLjAwNC0uMDExbC4wMTctLjQzbC0uMDAzLS4wMTJsLS4wMS0uMDF6Ii8+PHBhdGggZmlsbD0iI2Y3ZjdmNyIgZD0iTTIxIDEzdjcuNDM0YTEuNSAxLjUgMCAwIDEtMS41NTMgMS40OTlsLS4xMzMtLjAxMUwxMiAyMS4wMDhWMTN6bS0xMSAwdjcuNzU4bC01LjI0OC0uNjU2QTIgMiAwIDAgMSAzIDE4LjExN1YxM3ptOS4zMTQtMTAuOTIyYTEuNSAxLjUgMCAwIDEgMS42OCAxLjM1NWwuMDA2LjEzM1YxMWgtOVYyLjk5MnpNMTAgMy4yNDJWMTFIM1Y1Ljg4M2EyIDIgMCAwIDEgMS43NTItMS45ODV6Ii8+PC9nPjwvc3ZnPg==)

Aquí tienes un **README** con el mismo estilo, pero para la descarga e instalación de **pgAdmin en Windows**.

---

# **Instalación de pgAdmin en Windows**

Esta documentación describe los pasos para descargar, instalar y ejecutar **pgAdmin** en Windows.

---

## **1. Descarga de pgAdmin**

Para obtener la última versión de pgAdmin, sigue estos pasos:

1. Abre tu navegador y accede a la página oficial de descargas:  
   [https://www.pgadmin.org/](https://www.pgadmin.org/)

2. Selecciona la versión de **Windows** y descarga el archivo `.exe`.

---

## **2. Instalación de pgAdmin**

Una vez descargado el instalador, sigue estos pasos para instalarlo:

1. **Ejecuta el archivo descargado** (`pgadmin4-x64.exe`).
2. Si Windows muestra una advertencia, haz clic en **"Ejecutar de todos modos"**.
3. Sigue las instrucciones del instalador, aceptando los valores por defecto.
4. Haz clic en **"Install"** y espera a que finalice el proceso.
5. Una vez instalado, haz clic en **"Finish"** para completar la instalación.

---

## **3. Ejecutar pgAdmin**

Para abrir pgAdmin en Windows:

1. Ve al menú de inicio y busca **pgAdmin 4**.
2. Ábrelo y espera a que cargue en el navegador.

---

## **4. Conectar pgAdmin a un Servidor PostgreSQL**

Si deseas conectarte a un servidor PostgreSQL, sigue estos pasos:

1. En pgAdmin, haz clic en **"Add New Server"**.
2. En la pestaña **General**, ingresa un nombre para el servidor.
3. En la pestaña **Connection**, introduce los siguientes datos:
   - **Host:** `localhost` (si PostgreSQL está en tu máquina)
   - **Puerto:** `5432`
   - **Usuario:** `postgres`
   - **Contraseña:** _(la que configuraste en PostgreSQL)_
4. Haz clic en **"Save"** y el servidor aparecerá en la lista.

---

## **5. Consultar la Base de Datos desde pgAdmin**

Para ejecutar consultas en PostgreSQL desde pgAdmin:

1. Abre el servidor y selecciona tu base de datos.
2. Haz clic en **"Query Tool"**.
3. Ingresa la consulta SQL y presiona **"Run"**.

Ejemplo:

```sql
SELECT * FROM pg_database;
```
