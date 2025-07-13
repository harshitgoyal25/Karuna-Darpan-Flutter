const mongoose = require('mongoose');

const visitSchema = new mongoose.Schema({
  patientName: { type: String, required: true },
  description: { type: String },
  done: { type: Boolean, default: false },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Visit', visitSchema);
