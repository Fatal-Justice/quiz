import 'package:flutter_application_1/models/quiz_option.dart';

class Quiz {
  final String statement;
  final List<QuizOption> options;
  final String correctOptionId;

  Quiz(
      {required this.statement,
      required this.options,
      required this.correctOptionId});
}