import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';


class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  List<QuizAttempt> _quizHistory = [];

  UserModel? get currentUser => _currentUser;
  List<QuizAttempt> get quizHistory => _quizHistory;

  void setUser(UserModel user) {
    _currentUser = user;
    fetchQuizHistory();
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    _quizHistory = [];
    notifyListeners();
  }

  Future<void> fetchQuizHistory() async {
    if (_currentUser != null) {
      try {
        _quizHistory = await ApiService.getQuizHistory(_currentUser!.id);
        notifyListeners();
      } catch (e) {
        print('Error fetching quiz history: $e');
      }
    }
  }

  void updateUserPoints(int points) {
    if (_currentUser != null) {
      final updatedUser = UserModel(
        id: _currentUser!.id,
        email: _currentUser!.email,
        name: _currentUser!.name,
        photoUrl: _currentUser!.photoUrl,
        quizHistory: _currentUser!.quizHistory,
        favoriteEras: _currentUser!.favoriteEras,
        totalPoints: _currentUser!.totalPoints + points,
        achievements: _currentUser!.achievements,
      );
      _currentUser = updatedUser;
      notifyListeners();
    }
  }

  void addQuizAttempt(QuizAttempt attempt) {
    if (_currentUser != null) {
      final updatedHistory = List<QuizAttempt>.from(_currentUser!.quizHistory)..add(attempt);
      final updatedUser = UserModel(
        id: _currentUser!.id,
        email: _currentUser!.email,
        name: _currentUser!.name,
        photoUrl: _currentUser!.photoUrl,
        quizHistory: updatedHistory,
        favoriteEras: _currentUser!.favoriteEras,
        totalPoints: _currentUser!.totalPoints,
        achievements: _currentUser!.achievements,
      );
      _currentUser = updatedUser;
      notifyListeners();
    }
  }
}
