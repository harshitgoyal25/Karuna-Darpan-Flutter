const express = require('express');
const router = express.Router();
const Visit = require('../models/visit');

router.get('/', async (req, res) => {
  try {
    const visitsCompleted = await Visit.countDocuments({ done: true });
    const uniquePatients = await Visit.distinct('patientName', { done: true });

    res.json({
      visitsCompleted,
      patientsTreated: uniquePatients.length,
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error });
  }
});

module.exports = router;
