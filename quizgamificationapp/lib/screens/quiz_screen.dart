// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:quizgamificationapp/service/quiz_service.dart';
import '../services/quiz_service.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _quizService.fetchQuestions();
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading questions: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Game'),
        backgroundColor: Colors.yellow,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Score: $_score',
                key: Key('score_text'),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          key: Key('loading_indicator'),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Center(
        child: Text(
          'No questions available',
          key: Key('no_questions_text'),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          ),
          SizedBox(height: 20),
          Text(
            'Question ${_currentQuestionIndex + 1}/${_questions.length}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildQuestionCard(),
          SizedBox(height: 20),
          ..._buildOptionButtons(),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          _questions[_currentQuestionIndex].description,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  List<Widget> _buildOptionButtons() {
    return _questions[_currentQuestionIndex].options.map((option) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _showResult
                ? option.isCorrect
                    ? Colors.green
                    : Colors.red
                : Colors.yellow,
            padding: EdgeInsets.all(16),
          ),
          onPressed: () => _checkAnswer(option.description),
          child: Text(
            option.description,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }).toList();
  }

  void _checkAnswer(String selectedAnswer) {
    if (_showResult) return;

    final correctAnswer = _questions[_currentQuestionIndex].correctAnswer;
    final isCorrect = selectedAnswer == correctAnswer;

    setState(() {
      if (isCorrect) _score++;
      _showResult = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _showResult = false;
        });
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your Score: $_score/${_questions.length}'),
              Text(
                'Percentage: ${(_score / _questions.length * 100).toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Restart Quiz'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                  _showResult = false;
                });
              },
            ),
          ],
        );
      },
    );
  }
}