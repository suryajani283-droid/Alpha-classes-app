class LessonModel {
  final int id;
  final int courseId;
  final String title;
  final String videoUrl;
  final String? notesUrl;
  final int orderIndex;

  LessonModel({required this.id, required this.courseId, required this.title,
    required this.videoUrl, this.notesUrl, required this.orderIndex});

  factory LessonModel.fromMap(Map<String, dynamic> map) => LessonModel(
    id: map['id'],
    courseId: map['course_id'],
    title: map['title'],
    videoUrl: map['video_url'],
    notesUrl: map['notes_url'],
    orderIndex: map['order_index'] ?? 0,
  );
}
