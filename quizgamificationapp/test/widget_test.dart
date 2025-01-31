// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../lib/main.dart';
import '../lib/services/quiz_service.dart';

@GenerateMocks([http.Client])
void main() {
  testWidgets('Quiz app shows initial score of 0', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: QuizApp()));
    
    // Wait for any animations to complete
    await tester.pumpAndSettle();

    // Verify that the score starts at 0
    expect(find.text('Score: 0'), findsOneWidget);
  });

  testWidgets('Quiz app shows loading indicator initially', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: QuizApp()));
    
    // Verify that CircularProgressIndicator is shown while loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}