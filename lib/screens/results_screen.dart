import 'package:flutter/material.dart';
import '../models/question.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  String _getFeedback(int score, int total) {
    final percentage = (score / total) * 100;

    if (percentage >= 90) {
      return 'Outstanding! You\'re a history expert!';
    } else if (percentage >= 70) {
      return 'Great job! You know your history well!';
    } else if (percentage >= 50) {
      return 'Good effort! You have a solid understanding of history.';
    } else if (percentage >= 30) {
      return 'Not bad, but there\'s room for improvement.';
    } else {
      return 'Keep studying! History has many fascinating stories to discover.';
    }
  }

  String _getEraName(String eraId) {
    switch (eraId) {
      case 'ancient_world':
        return 'Ancient World';
      case 'medieval':
        return 'Medieval Period';
      case 'renaissance':
        return 'Renaissance & Enlightenment';
      case 'modern':
        return 'Modern History';
      case 'contemporary':
        return 'Contemporary History';
      case 'indian':
        return 'Indian History';
      default:
        return 'History';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final score = args['score'] as int;
    final totalQuestions = args['totalQuestions'] as int;
    final eraId = args['eraId'] as String? ?? 'general';
    final percentage = (score / totalQuestions) * 100;
    final eraName = _getEraName(eraId);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/parchment_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 80,
                    color: Color(0xFFBF8F65),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Quiz Complete!',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    eraName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8D6E63),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your Score',
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: CircularProgressIndicator(
                                value: score / totalQuestions,
                                strokeWidth: 12,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  percentage >= 70
                                      ? Colors.green[700]!
                                      : percentage >= 40
                                          ? Colors.orange[700]!
                                          : Colors.red[700]!,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '$score/$totalQuestions',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5D4037),
                                  ),
                                ),
                                Text(
                                  '${percentage.toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8D6E63),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _getFeedback(score, totalQuestions),
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/era_selection'
                            // arguments: {'eraId': eraId},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8D6E63),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Text('Choose an Era'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5D4037),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Text('View Dashboard'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
