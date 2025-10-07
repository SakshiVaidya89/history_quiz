const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRoutes = require('./routes/auth');
// const { addQuizAttempt } = require('../controllers/userController');
const userRoutes = require('./routes/userRoutes');
const app = express();
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/users', userRoutes);
// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/historyApp', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  console.log('✅ MongoDB connected');
  app.listen(3000, () => console.log('🚀 Server running at http://localhost:3000'));
}).catch(err => {
  console.error('❌ MongoDB connection error:', err);
});

// const corsOptions = {
//   origin: 'http://localhost:3000',  // If you're making requests from your web frontend
//   methods: ['GET', 'POST'],
//   allowedHeaders: ['Content-Type', 'Authorization'],
// };

// app.use(cors(corsOptions));