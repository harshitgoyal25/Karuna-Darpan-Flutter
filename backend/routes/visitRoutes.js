const express = require('express');
const router = express.Router();
const Visit = require('../models/visit');

// POST: Create visit
router.post('/create', async (req, res) => {
  try {
    const visit = new Visit(req.body);
    await visit.save();
    res.status(201).json(visit);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// GET: All visits
router.get('/', async (req, res) => {
  try {
    const visits = await Visit.find().sort({ createdAt: -1 });
    res.json(visits);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// PATCH: Mark visit done/pending
router.patch('/:id', async (req, res) => {
  try {
    const updated = await Visit.findByIdAndUpdate(req.params.id, { done: req.body.done }, { new: true });
    res.json(updated);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
