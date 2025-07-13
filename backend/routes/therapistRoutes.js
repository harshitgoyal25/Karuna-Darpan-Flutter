const express = require('express');
const bcrypt = require('bcryptjs');
const router = express.Router();
const Therapist = require('../models/Therapist');

// Create therapist
router.post('/create', async (req, res) => {
  try {
    const {
      therapistId,
      email,
      name,
      city,
      expertise,
      password,
      assignedPatients = []
    } = req.body;

    if (!therapistId || !email || !city || !password || !name) {
      return res.status(400).json({ error: 'therapistId, email, name, city, and password are required' });
    }

    const existing = await Therapist.findOne({ email }).lean();
    if (existing) {
      return res.status(400).json({ message: 'Therapist already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 8); // use saltRounds = 8 for faster hashing

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

    // Send response without password
    const responseTherapist = newTherapist.toObject();
    delete responseTherapist.password;

    res.status(201).json({
      message: 'Therapist created',
      therapist: responseTherapist
    });
  } catch (err) {
    console.error('Error in therapist creation:', err);
    res.status(500).json({ error: 'Server error' });
  }
});


// Therapist Login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'Email and password are required' });
    }

    const therapist = await Therapist.findOne({ email }).lean();
    if (!therapist) {
      return res.status(401).json({ message: 'Invalid email' });
    }

    const isMatch = await bcrypt.compare(password, therapist.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid password' });
    }

    const { _id, password: _, ...rest } = therapist;

    res.status(200).json({
      message: 'Login successful',
      therapist: {
        id: _id,       // ✅ Flutter expects 'id'
        ...rest
      }
    });
  } catch (err) {
    console.error('Error in therapist login:', err);
    res.status(500).json({ error: 'Server error' });
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

// Therapist Reset Password
router.post('/reset-password', async (req, res) => {
  const { email, newPassword } = req.body;

  try {
    const therapist = await Therapist.findOne({ email });
    if (!therapist) {
      return res.status(404).json({ error: 'Therapist not found' });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    therapist.password = hashedPassword;

    await therapist.save();

    res.json({ message: 'Password reset successful' });
  } catch (err) {
    console.error('Error resetting therapist password:', err);
    res.status(500).json({ error: 'Server error' });
  }
});



module.exports = router;