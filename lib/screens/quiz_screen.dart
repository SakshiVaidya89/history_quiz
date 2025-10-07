import 'package:flutter/material.dart';
import 'package:flutter_app1/models/user_model.dart';
import 'package:flutter_app1/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/question.dart';
import '../services/api_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;
  late List<Question> _questions;
  late String _eraId;
  String? _userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    _eraId = args?['eraId'] ?? 'ancient_world';
    _questions = QuizData.getQuestionsByEra(_eraId);

    // Access user ID from provider
    _userId = Provider.of<UserProvider>(context, listen: false).currentUser?.id;
  }

  void _checkAnswer(int selectedIndex, String? userId) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswerIndex = selectedIndex;
      _hasAnswered = true;
      if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () async {
  if (_currentQuestionIndex < _questions.length - 1) {
    setState(() {
      _currentQuestionIndex++;
      _hasAnswered = false;
      _selectedAnswerIndex = null;
    });
  } else {
    // Save quiz history to backend
    final quizId = 'quiz_${_eraId}_${DateTime.now().millisecondsSinceEpoch}';
    await ApiService.saveQuizHistory(
      userId ?? '',
      quizId,
      _eraId,
      _score,
      _questions.length,
    );

    // ✅ Update UserProvider with new score and quiz attempt
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUserPoints(_score);

    userProvider.addQuizAttempt(
      QuizAttempt(
        quizId: quizId,
        quizTitle: _eraId,
        score: _score,
        totalQuestions: _questions.length,
        date: DateTime.now(),
      ),
    );

    // Navigate to results
    Navigator.pushReplacementNamed(
      context,
      '/results',
      arguments: {
        'score': _score,
        'totalQuestions': _questions.length,
        'eraId': _eraId,
      },
    );
  }
});

  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: const Color(0xFF8D6E63),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No questions available for this era yet!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/era_selection');
                },
                child: const Text('Choose Another Era'),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}/${_questions.length}'),
        backgroundColor: const Color(0xFF8D6E63),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/parchment_bg.png'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.period,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        question.questionText,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      bool isCorrect = index == question.correctAnswerIndex;
                      bool isSelected = _selectedAnswerIndex == index;
                      Color? backgroundColor;

                      if (_hasAnswered) {
                        if (isCorrect) {
                          backgroundColor = Colors.green[100];
                        } else if (isSelected) {
                          backgroundColor = Colors.red[100];
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InkWell(
                          onTap: () => _checkAnswer(index, _userId),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: backgroundColor ?? Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF8D6E63)
                                    : Colors.grey.withOpacity(0.3),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? const Color(0xFF8D6E63)
                                        : Colors.grey.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    question.options[index],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_hasAnswered)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedAnswerIndex == question.correctAnswerIndex
                              ? 'Correct!'
                              : 'Incorrect!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: _selectedAnswerIndex == question.correctAnswerIndex
                                ? Colors.green[700]
                                : Colors.red[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question.explanation,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Score: $_score/${_currentQuestionIndex + (_hasAnswered ? 1 : 0)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
