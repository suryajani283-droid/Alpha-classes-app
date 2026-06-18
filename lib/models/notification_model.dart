class NotificationModel {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;

  NotificationModel({required this.id, required this.title, required this.message, required this.createdAt});

  factory NotificationModel.fromMap(Map<String, dynamic> map) => NotificationModel(
    id: map['id'],
    title: map['title'],
    message: map['message'],
    createdAt: DateTime.parse(map['created_at']),
  );
}
