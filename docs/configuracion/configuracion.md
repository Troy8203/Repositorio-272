# Configuración del entorno

[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)

Este documento describe las diferentes formas de configurar la base de datos.

## Métodos de configuración

- [Configuración con Workbench](.)
- [Configuración manual con Docker](/docker#1-configuración-con-docker-compose)
- [Configuración con Docker Compose](/docker#2-configuración-con-docker-compose)

## Conexión con SQLTools (VSCode - Codium)

Se puede utilizar la extensión [SQL Tools](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools) junto con su controlador [SQLTools PostgreSQL/Cockroach Driver](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools-driver-pg) para gestionar la base de datos, acceder a la consola y previsualizar las tablas.

### Archivo de configuración:

```json
{
  "name": "POSTGRES",
  "server": "localhost",
  "driver": "PostgreSQL",
  "port": 5433,
  "database": "autobus",
  "username": "admin",
  "askForPassword": false,
  "password": "pass",
  "connectionTimeout": 15
}
```

Este archivo de configuración permite conectar SQLTools con la base de datos PostgreSQL en `localhost`, usando las credenciales definidas en la configuración del entorno.
