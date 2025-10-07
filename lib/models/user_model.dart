class UserModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final List<QuizAttempt> quizHistory;
  final List<String> favoriteEras;
  final int totalPoints;
  final List<Achievement> achievements;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.quizHistory = const [],
    this.favoriteEras = const [],
    this.totalPoints = 0,
    this.achievements = const [],
  });

  factory UserModel.mock(String email) {
    final name = email.split('@').first;
    final capitalizedName = name[0].toUpperCase() + name.substring(1);

    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: capitalizedName,
      quizHistory: [
        QuizAttempt(
          quizId: '1',
          quizTitle: 'Ancient Egypt',
          score: 8,
          totalQuestions: 10,
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        QuizAttempt(
          quizId: '2',
          quizTitle: 'World War II',
          score: 7,
          totalQuestions: 10,
          date: DateTime.now().subtract(const Duration(days: 5)),
        ),
        QuizAttempt(
          quizId: '3',
          quizTitle: 'Renaissance',
          score: 9,
          totalQuestions: 10,
          date: DateTime.now().subtract(const Duration(days: 7)),
        ),
      ],
      favoriteEras: ['Ancient Egypt', 'Renaissance', 'Industrial Revolution'],
      totalPoints: 240,
      achievements: [
        Achievement(
          id: '1',
          title: 'First Quiz',
          description: 'Completed your first quiz',
          icon: 'trophy',
          dateEarned: DateTime.now().subtract(const Duration(days: 7)),
        ),
        Achievement(
          id: '2',
          title: 'History Buff',
          description: 'Scored 80% or higher on 3 quizzes',
          icon: 'star',
          dateEarned: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      totalPoints: json['totalPoints'] ?? 0,
      favoriteEras: List<String>.from(json['favoriteEras'] ?? []),
      quizHistory: (json['quizHistory'] ?? [])
          .map<QuizAttempt>((item) => QuizAttempt.fromJson(item))
          .toList(),
      achievements: (json['achievements'] ?? [])
          .map<Achievement>((item) => Achievement.fromJson(item))
          .toList(),
    );
  }
}

class QuizAttempt {
  final String quizId;
  final String quizTitle;
  final int score;
  final int totalQuestions;
  final DateTime date;

  QuizAttempt({
    required this.quizId,
    required this.quizTitle,
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  double get percentage => (score / totalQuestions) * 100;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      quizId: json['quizId'],
      quizTitle: json['quizTitle'],
      score: json['score'],
      totalQuestions: json['totalQuestions'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final DateTime dateEarned;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.dateEarned,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      dateEarned: DateTime.parse(json['dateEarned']),
    );
  }
}
