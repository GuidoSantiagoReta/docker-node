// Importar el módulo express
const express = require('express');

// Crear una instancia de express
const app = express();

// Definir una ruta para el mensaje "Hola Mundo"
app.get('/', (req, res) => {
  res.send('¡Hola Mundo desde un microservicio en Node.js!');
});

// Iniciar el servidor en el puerto 
const PORT = process.env.PORT || 3002;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});