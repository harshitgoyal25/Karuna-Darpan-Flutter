const express = require("express")
const bcrypt = require("bcryptjs")

const router = express.Router()
const Patient = require("../models/Patient")

// @route   POST /api/patients/create
// @desc    Create a new patient
router.post("/create", async (req, res) => {
  console.log("📝 Creating new patient with data:", req.body)

  const {
    abhaId,
    email,
    name,
    age,
    phone,
    password,
    gender,
    aadhar,
    village,
    state,
    district,
    medicalHistory,
    currentproblems,
    allergies,
    currentmedications,
  } = req.body

  try {
    // Check if patient already exists
    const existing = await Patient.findOne({
      $or: [{ email }, { abhaId }],
    })

    if (existing) {
      console.log("❌ Patient already exists with email or ABHA ID")
      return res.status(400).json({
        message: "Patient already exists with this email or ABHA ID",
      })
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10)

    // Create new patient
    const now = new Date();

const newPatient = new Patient({
  abhaId,
  email,
  name,
  age: age || 0,
  phone,
  password: hashedPassword,
  gender,
  aadhar,
  village,
  state,
  district,
  medicalHistory: medicalHistory || "",
  currentproblems: currentproblems || "",
  allergies: allergies || "",
  currentmedications: currentmedications || "",
  healthRecords: [
    { description: `Medical History: ${medicalHistory || "N/A"}`, createdAt: now },
    { description: `Current Problems: ${currentproblems || "N/A"}`, createdAt: now },
    { description: `Allergies: ${allergies || "N/A"}`, createdAt: now },
    { description: `Current Medications: ${currentmedications || "N/A"}`, createdAt: now }
  ]
});


    await newPatient.save()
    console.log("✅ Patient created successfully:", newPatient._id)

    res.status(201).json({
      message: "Patient created successfully",
      patient: {
        id: newPatient._id,
        name: newPatient.name,
        email: newPatient.email,
        abhaId: newPatient.abhaId,
        age: newPatient.age,
        gender: newPatient.gender,
      },
    })
  } catch (err) {
    console.error("❌ Error creating patient:", err)
    res.status(500).json({ error: err.message })
  }
})

// @route   POST /api/patients/login
// @desc    Login patient
router.post("/login", async (req, res) => {
  console.log("🔐 Login attempt received for:", req.body.email)

  const { email, password } = req.body

  try {
    // Validate input
    if (!email || !password) {
      console.log("❌ Missing email or password")
      return res.status(400).json({ message: "Email and password are required" })
    }

    // Find patient by email
    const patient = await Patient.findOne({ email: email.toLowerCase() })
    if (!patient) {
      console.log("❌ Patient not found with email:", email)
      return res.status(400).json({ message: "Invalid email or password" })
    }

    console.log("👤 Patient found:", patient.name)

    // Check password
    const isMatch = await bcrypt.compare(password, patient.password)
    if (!isMatch) {
      console.log("❌ Password mismatch for email:", email)
      return res.status(400).json({ message: "Invalid email or password" })
    }

    console.log("✅ Login successful for:", email)

    // Return success with patient info (excluding password)
    res.status(200).json({
      message: "Login successful",
      patient: {
        id: patient._id,
        name: patient.name,
        email: patient.email,
        abhaId: patient.abhaId,
        age: patient.age,
        gender: patient.gender,
        phone: patient.phone,
        village: patient.village,
        district: patient.district,
        state: patient.state,
      },
    })
  } catch (err) {
    console.error("💥 Login error:", err)
    res.status(500).json({ error: "Internal server error" })
  }
})

// @route   GET /api/patients/getAll
// @desc    Get all patients
router.get("/getAll", async (req, res) => {
  try {
    const patients = await Patient.find().select("-password") // Exclude passwords
    console.log(`📋 Retrieved ${patients.length} patients`)
    res.json(patients)
  } catch (err) {
    console.error("❌ Error fetching patients:", err)
    res.status(500).json({ error: err.message })
  }
})

// @route   GET /api/patients/:id
// @desc    Get patient by ID
router.get("/:id", async (req, res) => {
  try {
    const patient = await Patient.findById(req.params.id).select("-password")
    if (!patient) {
      return res.status(404).json({ message: "Patient not found" })
    }
    res.json(patient)
  } catch (err) {
    console.error("❌ Error fetching patient:", err)
    res.status(500).json({ error: err.message })
  }
})

// @route   PUT /api/patients/update/:id
// @desc    Update patient info
router.put("/update/:id", async (req, res) => {
  console.log(`📝 Updating patient ${req.params.id} with:`, req.body)

  try {
    const updateFields = { ...req.body }

    // Hash password if provided
    if (updateFields.password) {
      updateFields.password = await bcrypt.hash(updateFields.password, 10)
    }

    const updated = await Patient.findByIdAndUpdate(req.params.id, updateFields, { new: true }).select("-password")

    if (!updated) {
      return res.status(404).json({ message: "Patient not found" })
    }

    console.log("✅ Patient updated successfully")
    res.json({
      message: "Patient updated successfully",
      patient: updated,
    })
  } catch (err) {
    console.error("❌ Error updating patient:", err)
    res.status(500).json({ error: err.message })
  }
})

// DELETE /api/patients/:id
// NEW — correct relative route
router.delete('/delete/:id', async (req, res) => {
  try {
    const result = await Patient.findByIdAndDelete(req.params.id);
    if (!result) {
      return res.status(404).json({ error: 'Patient not found' });
    }
    res.json({ message: 'Patient deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});


// @route   POST /api/patients/reset-password
// @desc    Reset password using email and new password
router.post("/reset-password", async (req, res) => {
  const { email, newPassword } = req.body;

  if (!email || !newPassword) {
    return res.status(400).json({ message: "Email and new password are required" });
  }

  try {
    const patient = await Patient.findOne({ email: email.toLowerCase() });

    if (!patient) {
      return res.status(404).json({ message: "Patient not found" });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    patient.password = hashedPassword;
    await patient.save();

    console.log(`🔐 Password reset successful for: ${email}`);
    res.status(200).json({ message: "Password reset successful" });
  } catch (err) {
    console.error("❌ Error resetting password:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});


module.exports = router
