import 'package:flutter_application_1/models/quiz.dart';
import 'package:flutter_application_1/models/quiz_option.dart';

final quiz = Quiz(
  statement: r'''<h2>\(\frac{4}{11}\) is</h2>''',
  options: [
    QuizOption('a', r'''unit fraction'''),
    QuizOption('b', r'''mixed fraction'''),
QuizOption('c', r'''proper fraction'''),
    QuizOption('d', r'''improper fraction'''),
  ],
  correctOptionId: 'c'

);