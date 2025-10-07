// services/user_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<Map<String, dynamic>>> getQuizHistory(String userId) async {
    final url = Uri.parse('$baseUrl/api/quizResults/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load quiz history');
    }
  }
}
