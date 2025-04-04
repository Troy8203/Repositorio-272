---
layout: page
---

# Configuración de PostgreSQL con Docker

[![Atras](https://img.shields.io/badge/-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Im03LjgyNSAxM2w0LjkgNC45cS4zLjMuMjg4Ljd0LS4zMTMuN3EtLjMuMjc1LS43LjI4OHQtLjctLjI4OGwtNi42LTYuNnEtLjE1LS4xNS0uMjEzLS4zMjVUNC40MjYgMTJ0LjA2My0uMzc1dC4yMTItLjMyNWw2LjYtNi42cS4yNzUtLjI3NS42ODgtLjI3NXQuNzEyLjI3NXEuMy4zLjMuNzEzdC0uMy43MTJMNy44MjUgMTFIMTlxLjQyNSAwIC43MTMuMjg4VDIwIDEydC0uMjg4LjcxM1QxOSAxM3oiLz48L3N2Zz4=)](../configuracion/configuracion)
[![Inicio](https://img.shields.io/badge/Inicio-232323?style=for-the-badge&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48IS0tIFVwbG9hZGVkIHRvOiBTVkcgUmVwbywgd3d3LnN2Z3JlcG8uY29tLCBHZW5lcmF0b3I6IFNWRyBSZXBvIE1peGVyIFRvb2xzIC0tPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiNmN2Y3ZjciIGQ9Ik00IDE5di05cTAtLjQ3NS4yMTMtLjl0LjU4Ny0uN2w2LTQuNXEuNTI1LS40IDEuMi0uNHQxLjIuNGw2IDQuNXEuMzc1LjI3NS41ODguN1QyMCAxMHY5cTAgLjgyNS0uNTg4IDEuNDEzVDE4IDIxaC0zcS0uNDI1IDAtLjcxMi0uMjg4VDE0IDIwdi01cTAtLjQyNS0uMjg4LS43MTJUMTMgMTRoLTJxLS40MjUgMC0uNzEyLjI4OFQxMCAxNXY1cTAgLjQyNS0uMjg4LjcxM1Q5IDIxSDZxLS44MjUgMC0xLjQxMi0uNTg3VDQgMTkiLz48L3N2Zz4=)](../../)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48ZyBmaWxsPSJub25lIj48cGF0aCBkPSJtMTIuNTkzIDIzLjI1OGwtLjAxMS4wMDJsLS4wNzEuMDM1bC0uMDIuMDA0bC0uMDE0LS4wMDRsLS4wNzEtLjAzNXEtLjAxNi0uMDA1LS4wMjQuMDA1bC0uMDA0LjAxbC0uMDE3LjQyOGwuMDA1LjAybC4wMS4wMTNsLjEwNC4wNzRsLjAxNS4wMDRsLjAxMi0uMDA0bC4xMDQtLjA3NGwuMDEyLS4wMTZsLjAwNC0uMDE3bC0uMDE3LS40MjdxLS4wMDQtLjAxNi0uMDE3LS4wMThtLjI2NS0uMTEzbC0uMDEzLjAwMmwtLjE4NS4wOTNsLS4wMS4wMWwtLjAwMy4wMTFsLjAxOC40M2wuMDA1LjAxMmwuMDA4LjAwN2wuMjAxLjA5M3EuMDE5LjAwNS4wMjktLjAwOGwuMDA0LS4wMTRsLS4wMzQtLjYxNHEtLjAwNS0uMDE4LS4wMi0uMDIybS0uNzE1LjAwMmEuMDIuMDIgMCAwIDAtLjAyNy4wMDZsLS4wMDYuMDE0bC0uMDM0LjYxNHEuMDAxLjAxOC4wMTcuMDI0bC4wMTUtLjAwMmwuMjAxLS4wOTNsLjAxLS4wMDhsLjAwNC0uMDExbC4wMTctLjQzbC0uMDAzLS4wMTJsLS4wMS0uMDF6Ii8+PHBhdGggZmlsbD0iI2Y3ZjdmNyIgZD0iTTIxIDEzdjcuNDM0YTEuNSAxLjUgMCAwIDEtMS41NTMgMS40OTlsLS4xMzMtLjAxMUwxMiAyMS4wMDhWMTN6bS0xMSAwdjcuNzU4bC01LjI0OC0uNjU2QTIgMiAwIDAgMSAzIDE4LjExN1YxM3ptOS4zMTQtMTAuOTIyYTEuNSAxLjUgMCAwIDEgMS42OCAxLjM1NWwuMDA2LjEzM1YxMWgtOVYyLjk5MnpNMTAgMy4yNDJWMTFIM1Y1Ljg4M2EyIDIgMCAwIDEgMS43NTItMS45ODV6Ii8+PC9nPjwvc3ZnPg==)
![Linux](https://img.shields.io/badge/Linux-8B8B8B?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Im0xMi41OTQgMjMuMjU4bC0uMDEyLjAwMmwtLjA3MS4wMzVsLS4wMi4wMDRsLS4wMTQtLjAwNGwtLjA3MS0uMDM2cS0uMDE2LS4wMDQtLjAyNC4wMDZsLS4wMDQuMDFsLS4wMTcuNDI4bC4wMDUuMDJsLjAxLjAxM2wuMTA0LjA3NGwuMDE1LjAwNGwuMDEyLS4wMDRsLjEwNC0uMDc0bC4wMTItLjAxNmwuMDA0LS4wMTdsLS4wMTctLjQyN3EtLjAwNC0uMDE2LS4wMTYtLjAxOG0uMjY0LS4xMTNsLS4wMTQuMDAybC0uMTg0LjA5M2wtLjAxLjAxbC0uMDAzLjAxMWwuMDE4LjQzbC4wMDUuMDEybC4wMDguMDA4bC4yMDEuMDkycS4wMTkuMDA1LjAyOS0uMDA4bC4wMDQtLjAxNGwtLjAzNC0uNjE0cS0uMDA1LS4wMTktLjAyLS4wMjJtLS43MTUuMDAyYS4wMi4wMiAwIDAgMC0uMDI3LjAwNmwtLjAwNi4wMTRsLS4wMzQuNjE0cS4wMDEuMDE4LjAxNy4wMjRsLjAxNS0uMDAybC4yMDEtLjA5M2wuMDEtLjAwOGwuMDAzLS4wMTFsLjAxOC0uNDNsLS4wMDMtLjAxMmwtLjAxLS4wMXoiLz48cGF0aCBmaWxsPSIjZjdmN2Y3IiBkPSJNOC4yNjQgMTUuMjlhMSAxIDAgMCAxIC44MjIuNTIybDEuODkyIDMuNDkzYTEuODA5IDEuODA5IDAgMCAxLTEuODU2IDIuNjVsLTMuOTMtLjU4MmExIDEgMCAwIDEtLjY3Mi0xLjU2M2wuNjIzLS44OWwtLjE3NC0uOTg0YTEgMSAwIDAgMSAuODExLTEuMTU5bC45ODUtLjE3M2wuNjIzLS44OWExIDEgMCAwIDEgLjg3Ni0uNDI1Wm02LjM0Ny0uMDI0YTEgMSAwIDAgMSAuODU4LS4wNDNsLjExNi4wNTdsLjk0LjU0M2wuOTY2LS4yNTlhMSAxIDAgMCAxIDEuMTg4LjU5NmwuMDM3LjExMWwuMjU5Ljk2NmwuOTQuNTQzYTEgMSAwIDAgMSAuMTU0IDEuNjIzbC0uMTAzLjA3OGwtMy4zMTUgMi4xODhhMS44MDkgMS44MDkgMCAwIDEtMi44MDUtMS40NmwuMDAzLS4xNThsLjIzOC0zLjk2NWExIDEgMCAwIDEgLjUyNC0uODJNMTIgMmE0IDQgMCAwIDEgNCA0djFjMCAxLjIxNC41MDIgMi4yNjcgMS4xNjYgMy4zNTRsLjczNiAxLjE2NWMuMS4xNi4xOTUuMzE1LjI4LjQ1N2MuMzIuNTQxLjYyOCAxLjE0Ljc4OCAxLjc4MWE3IDcgMCAwIDEgLjE5NCAxLjM1OGEyIDIgMCAwIDAtMS45MzItLjUxNmwtLjU2NS4xNTFsLS41ODItLjMzNmEyIDIgMCAwIDAtMi45OTYgMS42MTNsLS4yMzggMy45NjVjLS4wMjEuMzQ1LjAyMi42ODQuMTIxIDEuMDAzbC0uMjY5LjAwNWgtLjQwNnEtLjExNCAwLS4yMjYtLjAwNGMuMjItLjcxLjE1Mi0xLjQ5Mi0uMjE0LTIuMTY3bC0xLjg5MS0zLjQ5M2EyIDIgMCAwIDAtMy4zOTctLjE5NWwtLjM4NS41NWwtLjMzLjA1OGE1LjQgNS40IDAgMCAxIC4wMjQtMS4xNmMuMDM3LS4yODUuMDg2LS41NjcuMTUyLS44MzJjLjE5OC0uNzkyLjUzNS0xLjQ1OS44NTctMi4wMmwuNDM3LS43NEM3Ljc0IDEwLjI4IDggOS43MjIgOCA5VjZhNCA0IDAgMCAxIDQtNG0tMS40MzggNS43NzhsLS44MjIuNDFjLjIyNC41OTcuNTcyIDEuMTU2Ljg5NyAxLjZsLjIwNC4yNjlsLjE4NC4yMjVsLjA4MS4wOTRsLjI1LS4xNDFsLjMyOS0uMTk3Yy4xNzYtLjEwOS4zNjgtLjIzMi41NjYtLjM2N2MuNjA0LS40MTIgMS4yMjUtLjkxIDEuNjYyLTEuNDI3bC0yLjMxNi0uNThhMS41IDEuNSAwIDAgMC0xLjAzNS4xMTQiLz48L2c+PC9zdmc+)

Esta documentación describe los pasos para configurar y ejecutar un servidor de base de datos PostgreSQL utilizando **Docker** y **Docker Compose**.

---

## **1. Configuración Manual con Docker**

Para crear y ejecutar un contenedor de PostgreSQL con Docker, utiliza el siguiente comando:

### **Parámetros del Contenedor:**

- **Nombre:** postgres
- **Usuario:** admin
- **Contraseña:** pass
- **Base de datos:** autobus
- **Puerto:** 5432

### **Comando para Crear y Ejecutar el Contenedor:**

```bash
docker run --name mi_postgres \
    -e POSTGRES_USER=admin \
    -e POSTGRES_PASSWORD=pass \
    -e POSTGRES_DB=autobus \
    -p 5432:5432 \
    -d postgres
```

### **Acceder a la Base de Datos dentro del Contenedor:**

```bash
docker exec -it mi_postgres psql -U admin -d autobus
```

### **Mostrar las Tablas Existentes en la Base de Datos:**

```bash
\dt
```

### **Consultar Datos de la Tabla "Autobuses":**

```bash
SELECT * FROM Autobuses;
```

---

## **2. Configuración con Docker Compose**

Para configurar y ejecutar PostgreSQL con Docker Compose, sigue estos pasos:

### **2.1 Acceder a la Carpeta donde se Encuentra el Archivo `docker-compose.yml`:**

```bash
cd base/docker
```

### **2.2 Iniciar los Servicios Definidos en Docker Compose:**

```bash
docker compose up
```

### **2.3 Iniciar Docker Compose en Segundo Plano (sin Mostrar Logs):**

```bash
docker compose up -d
```

### **2.4 Detener y Eliminar los Contenedores de Docker Compose:**

```bash
docker compose down
```

### **2.5 Mostrar las Tablas de la Base de Datos:**

```bash
\dt
```

### **2.6 Consultar Datos de la Tabla "Autobuses":**

```bash
SELECT * FROM Autobuses;
```

---

Con esta guía, ahora sabes cómo configurar y ejecutar PostgreSQL con **Docker** y **Docker Compose** en tu máquina. ¡Listo para gestionar tu base de datos! 🚀
