const express = require('express');
const bcrypt = require('bcryptjs');

const router = express.Router();
const Therapist = require('../models/Therapist');

// Create therapist
router.post('/create', async (req, res) => {
  const {
    therapistId, email, name, city, expertise, password, assignedPatients
  } = req.body;

  try {
    if (!therapistId || !email || !city || !password || !name) {
      return res.status(400).json({ error: 'therapistId, email, name, city, and password are required' });
    }

    const existing = await Therapist.findOne({ email });
    if (existing) return res.status(400).json({ message: 'Therapist already exists' });

    const hashedPassword = await bcrypt.hash(password, 10);

    const newTherapist = new Therapist({
      therapistId,
      email,
      name,
      city,
      expertise,
      password: hashedPassword,
      assignedPatients
    });

    await newTherapist.save();
    res.status(201).json({ message: 'Therapist created', therapist: newTherapist });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Therapist Login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const therapist = await Therapist.findOne({ email });
    if (!therapist) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    const isMatch = await bcrypt.compare(password, therapist.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    const therapistData = therapist.toObject();
    delete therapistData.password;

    res.json({ message: 'Login successful', therapist: therapistData });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// Get all therapists
router.get('/getall', async (req, res) => {
  try {
    const therapists = await Therapist.find().select('-password').populate('assignedPatients');
    res.json(therapists);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get therapist by ID
router.get('/:id', async (req, res) => {
  try {
    const therapist = await Therapist.findById(req.params.id).select('-password').populate('assignedPatients');
    if (!therapist) return res.status(404).json({ message: 'Therapist not found' });
    res.json(therapist);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Update therapist
router.put('/:id', async (req, res) => {
  try {
    const updateData = { ...req.body };

    if (updateData.password) {
      updateData.password = await bcrypt.hash(updateData.password, 10);
    }

    const updated = await Therapist.findByIdAndUpdate(req.params.id, updateData, { new: true });
    if (!updated) return res.status(404).json({ message: 'Therapist not found' });

    res.json(updated);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Delete therapist
router.delete('/delete/:id', async (req, res) => {
  try {
    const deleted = await Therapist.findByIdAndDelete(req.params.id);
    if (!deleted) return res.status(404).json({ message: 'Therapist not found' });
    res.json({ message: 'Therapist deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;