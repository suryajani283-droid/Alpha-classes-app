class TestModel {
  final int id;
  final int courseId;
  final String title;
  final int durationMinutes;
  final bool isFree;

  TestModel({required this.id, required this.courseId, required this.title,
    required this.durationMinutes, required this.isFree});

  factory TestModel.fromMap(Map<String, dynamic> map) => TestModel(
    id: map['id'],
    courseId: map['course_id'],
    title: map['title'],
    durationMinutes: map['duration_minutes'],
    isFree: map['is_free'] ?? false,
  );
}
