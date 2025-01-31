// lib/services/quiz_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';  // Add this import

class QuizService {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> questions = jsonData['questions'] as List<dynamic>;
        return questions.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      throw Exception('Error: $e');
    }
  }
}