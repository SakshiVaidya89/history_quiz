const express = require('express');
const bcrypt = require('bcryptjs');  // For hashing passwords
const router = express.Router();
const User = require('../models/User');

// Sign Up
router.post('/signup', async (req, res) => {
  const { email, password } = req.body;

  const name = email.split('@')[0].replace(/^\w/, c => c.toUpperCase());

  try {
    // Check if user already exists
    const exists = await User.findOne({ email });
    if (exists) return res.status(400).json({ message: 'User already exists' });

    // Hash the password before saving
    const hashedPassword = await bcrypt.hash(password, 12);

    const newUser = new User({
      email,
      password: hashedPassword,  // Store hashed password
      name,
      totalPoints: 0,
      favoriteEras: [],
      quizHistory: [],
      achievements: [],
    });

    // Save the new user
    await newUser.save();
    res.status(201).json({ ...newUser.toObject(), password: undefined });  // Exclude password from response
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Signup failed' });
  }
});

// Login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Compare the password with the stored hashed password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Exclude password from response and send user data
    const { password: userPassword, ...userWithoutPassword } = user.toObject();
    res.json(userWithoutPassword);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Login failed' });
  }
});

module.exports = router;
