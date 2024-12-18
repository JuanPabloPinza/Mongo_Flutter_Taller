# Taller MongoDB con Flutter

Este proyecto integra una API REST en Node.js con MongoDB como base de datos y una aplicación en Flutter como frontend. Sigue estos pasos para configurar y ejecutar el proyecto correctamente.

---

## Requisitos Previos

- Node.js y npm instalados
- Flutter SDK configurado y actualizado
- MongoDB en ejecución (puedes usar MongoDB Atlas o una instancia local)
- Solicitar el archivo `.env` al administrador del taller y copiarlo en la carpeta `api-rest-contactos`

---

## Configuración de la Base de Datos

1. Crear una base de datos en MongoDB con el nombre `contactos_db`.
2. Configurar las credenciales de conexión en el archivo `.env` ubicado en la carpeta `api-rest-contactos`.

---

## Instrucciones para el Backend

1. Abre una terminal.
2. Navega a la carpeta del backend:
   ```bash
   cd ./api-rest-contactos/
   ```
3. Ejecuta el servidor:
   ```bash
   node server.js
   ```

El servidor estará disponible en el puerto configurado en el archivo `.env`.

---

## Instrucciones para el Frontend

1. Abre una nueva terminal.
2. Navega a la carpeta del frontend:
   ```bash
   cd ./taller_mongo_api/
   ```
3. Ejecuta la aplicación en Flutter:
   ```bash
   flutter run
   ```

---

## Notas Adicionales

- Asegúrate de que el servidor del backend esté corriendo antes de iniciar la aplicación Flutter.
- Si encuentras errores al ejecutar Flutter, asegúrate de tener un dispositivo físico o emulador configurado correctamente.
- Verifica que el archivo `.env` tenga las configuraciones correctas para conectarse a la base de datos.

---