const express = require('express');
const bcrypt = require('bcryptjs');

const router = express.Router();
const Patient = require('../models/Patient');

// @route   POST /api/patients/create
// @desc    Create a new patient
router.post('/create', async (req, res) => {
  const {
    abhaId, email, name, age, phone, password,
    gender, aadhar, village, state, district,
    medicalHistory, currentproblems, allergies, currentmedications
  } = req.body;

  try {
    const existing = await Patient.findOne({ email });
    if (existing) return res.status(400).json({ message: 'Patient already exists' });

    const hashedPassword = await bcrypt.hash(password, 10);

    const newPatient = new Patient({
      abhaId,
      email,
      name,
      age,
      phone,
      password: hashedPassword,
      gender,
      aadhar,
      village,
      state,
      district,
      medicalHistory,
      currentproblems,
      allergies,
      currentmedications
    });

    await newPatient.save();
    console.log("🧾 Full saved patient:", newPatient.toObject());
  res.status(203).json(newPatient.toObject());

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// @route   GET /api/patients/getAll
// @desc    Get all patients
router.get('/getAll', async (req, res) => {
  try {
    const patients = await Patient.find();
    res.json(patients);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// @route   GET /api/patients/:id
// @desc    Get patient by ID
router.get('/:id', async (req, res) => {
  try {
    const patient = await Patient.findById(req.params.id);
    if (!patient) return res.status(404).json({ message: 'Patient not found' });
    res.json(patient);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// @route   PUT /api/patients/update/:id
// @desc    Update patient info
router.put('/update/:id', async (req, res) => {
  try {
    const updateFields = { ...req.body };

    if (updateFields.password) {
      updateFields.password = await bcrypt.hash(updateFields.password, 10);
    }

    const updated = await Patient.findByIdAndUpdate(req.params.id, updateFields, { new: true });
    if (!updated) return res.status(404).json({ message: 'Patient not found' });

    res.json(updated);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// @route   DELETE /api/patients/delete/:id
// @desc    Delete a patient
router.delete('/delete/:id', async (req, res) => {
  try {
    const deleted = await Patient.findByIdAndDelete(req.params.id);
    if (!deleted) return res.status(404).json({ message: 'Patient not found' });

    res.json({ message: 'Patient deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;