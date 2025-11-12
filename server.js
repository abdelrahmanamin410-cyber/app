
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');
const app = express();
app.use(cors());
app.use(express.json());
app.use('/api/auth', authRoutes);
const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => 
  console.log(`Server listening on http://0.0.0.0:${PORT}`)
);

