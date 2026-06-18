import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../models/lesson_model.dart';
import '../services/database_service.dart';

class CourseProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<CourseModel> _allCourses = [];
  List<CourseModel> _purchasedCourses = [];
  bool _loading = false;

  List<CourseModel> get allCourses => _allCourses;
  List<CourseModel> get purchasedCourses => _purchasedCourses;
  bool get loading => _loading;

  Future<void> fetchCourses() async {
    _loading = true;
    notifyListeners();
    _allCourses = await _db.getCourses();
    _purchasedCourses = await _db.getPurchasedCourses();
    // Mark purchased
    for (var course in _allCourses) {
      course.isPurchased = _purchasedCourses.any((p) => p.id == course.id);
    }
    _loading = false;
    notifyListeners();
  }

  List<CourseModel> getCoursesByCategory(String category) =>
      _allCourses.where((c) => c.category == category).toList();

  Future<List<LessonModel>> getLessons(int courseId) => _db.getLessons(courseId);

  Future<void> purchaseCourse(int courseId, String paymentId, double amount) async {
    await _db.addPurchase(courseId, paymentId, amount);
    await fetchCourses();
  }
}
