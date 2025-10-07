import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../components/app_drawer.dart';
import '../providers/user_provider.dart';
import '../models/user_model.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(context, user),
            const SizedBox(height: 24),
            _buildStatsSection(context, user),
            const SizedBox(height: 24),
            _buildRecentQuizzesSection(context, userProvider),
            const SizedBox(height: 24),
            _buildAchievementsSection(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, UserModel user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF8D6E63),
              child: Text(
                user.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, ${user.name}!',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ready to test your historical knowledge today?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/era_selection');
                    },
                    child: const Text('Start a New Quiz'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, UserModel user) {
    double averageScore = 0;
    if (user.quizHistory.isNotEmpty) {
      averageScore = user.quizHistory.map((q) => q.percentage).reduce((a, b) => a + b) / user.quizHistory.length;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Stats', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard(context, 'Quizzes Taken', user.quizHistory.length.toString(), Icons.quiz)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(context, 'Avg. Score', '${averageScore.toStringAsFixed(1)}%', Icons.analytics)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF8D6E63)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF8D6E63)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentQuizzesSection(BuildContext context, UserProvider userProvider) {
    final quizHistory = userProvider.quizHistory;

    if (quizHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    final sortedHistory = List<QuizAttempt>.from(quizHistory)
      ..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Quizzes', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedHistory.length > 3 ? 3 : sortedHistory.length,
          itemBuilder: (context, index) {
            final quiz = sortedHistory[index];
            final score = quiz.score;
            final total = quiz.totalQuestions;
            final percentage = (score / total) * 100;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  quiz.quizTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Score: $score/$total (${percentage.toStringAsFixed(0)}%)'),
                    Text(
                      'Date: ${DateFormat('MMM d, yyyy').format(quiz.date)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (quizHistory.length > 3)
          Center(
            child: TextButton(
              onPressed: () {
                // Navigate to full history page
              },
              child: const Text('View All Quizzes'),
            ),
          ),
      ],
    );
  }

  Widget _buildAchievementsSection(BuildContext context, UserModel user) {
    if (user.achievements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Achievements', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: user.achievements.length,
          itemBuilder: (context, index) {
            final achievement = user.achievements[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      achievement.icon == 'trophy' ? Icons.emoji_events : Icons.star,
                      size: 36,
                      color: const Color(0xFFD4AC0D),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      achievement.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D4037),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8D6E63),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
