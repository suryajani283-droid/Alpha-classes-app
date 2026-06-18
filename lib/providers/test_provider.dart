import 'package:flutter/material.dart';
import '../models/test_model.dart';
import '../models/question_model.dart';
import '../services/database_service.dart';

class TestProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<TestModel> _tests = [];
  List<QuestionModel> _currentQuestions = [];
  bool _loading = false;

  List<TestModel> get tests => _tests;
  List<QuestionModel> get currentQuestions => _currentQuestions;
  bool get loading => _loading;

  Future<void> fetchTests() async {
    _loading = true;
    notifyListeners();
    _tests = await _db.getTests();
    _loading = false;
    notifyListeners();
  }

  Future<void> loadQuestions(int testId) async {
    _loading = true;
    notifyListeners();
    _currentQuestions = await _db.getQuestions(testId);
    _loading = false;
    notifyListeners();
  }

  void selectAnswer(int questionIndex, String option) {
    _currentQuestions[questionIndex].selectedOption = option;
    notifyListeners();
  }

  double calculateScore() {
    double score = 0;
    for (var q in _currentQuestions) {
      if (q.selectedOption == q.answer) {
        score += 1; // default mark
      } else if (q.selectedOption != null) {
        score -= 0.25; // negative marking
      }
    }
    return score;
  }
}
