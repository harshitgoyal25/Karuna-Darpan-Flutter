const mongoose = require('mongoose');

const assistantSchema = new mongoose.Schema({
  name: { type: String, required: true },
  password: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  city: { type: String, required: true },
  state: { type: String, required: true },
  phone: { type: String, required: true },
  assistantId: { type: String, unique: true, required: true },
  assignedTherapist: { type: mongoose.Schema.Types.ObjectId, ref: 'Therapist' }
});

module.exports = mongoose.model('Assistant', assistantSchema);