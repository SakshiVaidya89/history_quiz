const mongoose = require('mongoose');

const AchievementSchema = new mongoose.Schema({
  id: String,
  title: String,
  description: String,
  icon: String,
  dateEarned: Date,
});

const QuizAttemptSchema = new mongoose.Schema({
  quizId: String,
  quizTitle: String,
  score: Number,
  totalQuestions: Number,
  date: Date,
});

const UserSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  name: String,
  photoUrl: String,
  quizHistory: [QuizAttemptSchema],
  favoriteEras: [String],
  totalPoints: { type: Number, default: 0 },
  achievements: [AchievementSchema],
});

module.exports = mongoose.model('User', UserSchema);
