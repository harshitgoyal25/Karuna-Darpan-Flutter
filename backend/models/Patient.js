const mongoose = require('mongoose');

const patientSchema = new mongoose.Schema({
  name: { type: String, required: true },
  password: { type: String, required: true },
  age: Number,
  gender: String,
  aadhar: String,
  village: String,
  state: String,
  district: String,
  email: { type: String, required: true, unique: true },
  abhaId: { type: String, required: true, unique: true },
  phone: String,
  medicalHistory: String,
  currentproblems: String,
  allergies: String,
  currentmedications: String,
  assignedTherapist: { type: String, default: 'NA' },

  // ✅ New field: array of health records
  healthRecords: [
    {
      description: { type: String, required: true },
      createdAt: { type: Date, default: Date.now }
    }
  ]
});

module.exports = mongoose.model('Patient', patientSchema);
