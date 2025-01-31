// lib/models/question.dart
import 'package:flutter/material.dart';

class Question {
  final int id;
  final String description;
  final List<Option> options;
  final String? detailedSolution;

  Question({
    required this.id,
    required this.description,
    required this.options,
    this.detailedSolution,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      description: json['description'] as String,
      detailedSolution: json['detailed_solution'] as String?,
      options: (json['options'] as List<dynamic>)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }

  String get correctAnswer {
    return options.firstWhere((option) => option.isCorrect).description;
  }
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] as int,
      description: json['description'] as String,
      isCorrect: json['is_correct'] as bool,
    );
  }
}