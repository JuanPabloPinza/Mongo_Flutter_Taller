const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const connectDB = require('./config/database');
const personaRoutes = require('./routes/personaRoutes');

dotenv.config();
connectDB();

const app = express();

// Middlewares
app.use(cors());
app.use(morgan('dev'));
app.use(bodyParser.json());

// Rutas
app.use('/api/personas', personaRoutes);

// Iniciar servidor
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});


//El controlador con future para fetchear la API
//En el modelo se define la clase para fetchear la API
//En la vista debe mostrar todo
// En los widgets debe ser un diálogo que muestre que se ingresó con éxito.
