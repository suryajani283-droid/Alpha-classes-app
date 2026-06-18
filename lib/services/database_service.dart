import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../models/course_model.dart';
import '../models/lesson_model.dart';
import '../models/test_model.dart';
import '../models/question_model.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final _supabase = SupabaseService().client;

  // Profile
  Future<void> createProfile(UserModel user) async {
    await _supabase.from('profiles').upsert({
      'id': user.id,
      'name': user.name,
      'mobile': user.mobile,
      'class': user.userClass,
      'school': user.school,
      'city': user.city,
      'photo_url': user.photoUrl,
    });
  }

  Future<UserModel?> getProfile(String userId) async {
    final data = await _supabase.from('profiles').select().eq('id', userId).single();
    return UserModel.fromMap(data);
  }

  // Courses
  Future<List<CourseModel>> getCourses({String? category}) async {
    var query = _supabase.from('courses').select();
    if (category != null) query = query.eq('category', category);
    final data = await query.order('created_at');
    return data.map<CourseModel>((e) => CourseModel.fromMap(e)).toList();
  }

  // Lessons
  Future<List<LessonModel>> getLessons(int courseId) async {
    final data = await _supabase.from('lessons').select()
        .eq('course_id', courseId).order('order_index');
    return data.map<LessonModel>((e) => LessonModel.fromMap(e)).toList();
  }

  // Purchases
  Future<bool> hasPurchased(int courseId) async {
    final userId = SupabaseService().client.auth.currentUser?.id;
    if (userId == null) return false;
    final data = await _supabase.from('purchases').select()
        .eq('user_id', userId).eq('course_id', courseId).maybeSingle();
    return data != null;
  }

  Future<void> addPurchase(int courseId, String paymentId, double amount) async {
    final userId = SupabaseService().client.auth.currentUser!.id;
    await _supabase.from('purchases').insert({
      'user_id': userId,
      'course_id': courseId,
      'payment_id': paymentId,
      'amount': amount,
    });
  }

  Future<List<CourseModel>> getPurchasedCourses() async {
    final userId = SupabaseService().client.auth.currentUser?.id;
    if (userId == null) return [];
    final purchases = await _supabase.from('purchases').select('course_id').eq('user_id', userId);
    final ids = purchases.map<int>((p) => p['course_id'] as int).toList();
    if (ids.isEmpty) return [];
    final courses = await _supabase.from('courses').select().in_('id', ids);
    return courses.map<CourseModel>((c) => CourseModel.fromMap(c)..isPurchased = true).toList();
  }

  // Tests
  Future<List<TestModel>> getTests({int? courseId}) async {
    var query = _supabase.from('tests').select();
    if (courseId != null) query = query.eq('course_id', courseId);
    final data = await query;
    return data.map<TestModel>((e) => TestModel.fromMap(e)).toList();
  }

  Future<List<QuestionModel>> getQuestions(int testId) async {
    final data = await _supabase.from('questions').select().eq('test_id', testId);
    return data.map<QuestionModel>((e) => QuestionModel.fromMap(e)).toList();
  }

  // Notifications
  Future<List<NotificationModel>> getNotifications() async {
    final data = await _supabase.from('notifications').select().order('created_at', ascending: false);
    return data.map<NotificationModel>((e) => NotificationModel.fromMap(e)).toList();
  }
}
