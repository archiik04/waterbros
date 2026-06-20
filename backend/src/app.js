// Load environment variables
require('dotenv').config();

const express = require('express');
const cors = require('cors');
const connectDB = async () => {
  // We import connectDB from our config
  const db = require('./config/db');
  await db();
};

const authRoutes = require('./routes/authRoutes');
const errorHandler = require('./middleware/errorMiddleware');

const app = express();

// Establish Database Connection
connectDB();

// Global Middlewares
app.use(cors()); // Allow cross-origin requests (e.g. from Flutter Web)
app.use(express.json()); // Parse JSON payloads
app.use(express.urlencoded({ extended: true })); // Parse urlencoded payloads

// Basic Health Check Route
app.get('/health', (req, res) => {
  res.status(200).json({
    success: true,
    status: 'UP',
    timestamp: new Date(),
  });
});

// Mount Routes
app.use('/api/auth', authRoutes);

// Global Error Handler Middleware (must be registered last)
app.use(errorHandler);

const PORT = process.env.PORT || 8000;

app.listen(PORT, () => {
  console.log(`Server running in ${process.env.NODE_ENV || 'development'} mode on port ${PORT}`);
});

module.exports = app; // Export for testing
