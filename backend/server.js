require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');

// Route files
const patientRoutes = require('./routes/patientRoutes');
const therapistRoutes = require('./routes/therapistRoutes');
const assistantRoutes = require('./routes/assistantRoutes');
const adminRoutes = require('./routes/adminRoutes');
const visitRoutes = require('./routes/visitRoutes');
const performanceRoutes = require('./routes/performance');


dotenv.config();
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/patients', patientRoutes);
app.use('/api/therapists', therapistRoutes);
app.use('/api/assistants', assistantRoutes);
app.use('/api/admins', adminRoutes);
app.use('/api/visits', visitRoutes);
app.use('/api/performance', performanceRoutes);


// Health check route
app.get('/', (req, res) => {
  res.send('🚀 Karuna Backend is Live');
});

// Connect to DB and start server
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('✅ MongoDB connected');
    app.listen(process.env.PORT || 5000, () =>
      console.log(`✅ Server running on port ${process.env.PORT || 5000}`)
    );
  })
  .catch((err) => console.error('❌ MongoDB connection error:', err));
