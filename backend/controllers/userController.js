const User = require('../models/User'); // Import your User model

// Add a new quiz attempt to the user's history
const addQuizAttempt = async (req, res) => { 
    console.log(1)
  const { userId, quizId, quizTitle, score, totalQuestions } = req.body;

  if (!userId || !quizId || !quizTitle || score == null || totalQuestions == null) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const newAttempt = {
      quizId,
      quizTitle,
      score,
      totalQuestions,
      date: new Date(),
    };

    user.quizHistory.push(newAttempt);
    await user.save();

    res.status(200).json({ message: 'Quiz attempt added successfully', quizHistory: user.quizHistory });
  } catch (error) {
    console.error('Error adding quiz attempt:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = { addQuizAttempt };
