import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api/auth'; // or your IP on device

  static Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
  }

  static Future<UserModel?> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
print("Why not ${response}");
    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      print('Signup failed: ${response.body}');
      return null;
    }
  }

  static Future<void> saveQuizHistory(String userId, String quizId, String quizTitle, int score, int totalQuestions) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/users/$userId/history'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'userId': userId,
      'quizId': quizId,
      'quizTitle': quizTitle,
      'score': score,
      'totalQuestions': totalQuestions,
    }),
  );

  if (response.statusCode == 200) {
    print('Quiz history saved!');
  } else {
    print('Failed to save quiz history: ${response.body}');
  }
}


  static Future<List<QuizAttempt>> getQuizHistory(String userId) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/history'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => QuizAttempt.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load history');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
}
