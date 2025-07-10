const express = require('express');
const bcrypt = require('bcryptjs');

const router = express.Router();
const Admin = require('../models/Admin');

// Create new admin
router.post('/create', async (req, res) => {
  const { username, password } = req.body;
  try {
    const existing = await Admin.findOne({ username });
    if (existing) return res.status(400).json({ message: 'Admin already exists' });

    const hashedPassword = await bcrypt.hash(password, 10);

    const newAdmin = new Admin({ username, password: hashedPassword });
    await newAdmin.save();

    res.status(201).json({ message: 'Admin created successfully', admin: newAdmin });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all admins
router.get('/getall', async (req, res) => {
  try {
    const admins = await Admin.find().select('-password'); // hide passwords
    res.json(admins);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get admin by ID
router.get('/:id', async (req, res) => {
  try {
    const admin = await Admin.findById(req.params.id).select('-password');
    if (!admin) return res.status(404).json({ message: 'Admin not found' });
    res.json(admin);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Update admin
router.put('/:id', async (req, res) => {
  try {
    const updateData = { ...req.body };

    // If updating password, hash it
    if (updateData.password) {
      updateData.password = await bcrypt.hash(updateData.password, 10);
    }

    const updatedAdmin = await Admin.findByIdAndUpdate(req.params.id, updateData, { new: true });
    res.json(updatedAdmin);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Delete admin
router.delete('/delete/:id', async (req, res) => {
  try {
    await Admin.findByIdAndDelete(req.params.id);
    res.json({ message: 'Admin deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;