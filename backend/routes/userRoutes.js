const express = require('express');
const router = express.Router();
const { addQuizAttempt } = require('../controllers/userController');

// Your signup and login routes here...

// Add this POST route for saving quiz history
router.post('/:userId/history', addQuizAttempt);

module.exports = router;
