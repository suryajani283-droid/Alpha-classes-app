class CourseModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String teacher;
  final String category;
  bool isPurchased; // mutable for UI

  CourseModel({required this.id, required this.title, required this.description,
    required this.price, required this.thumbnail, required this.teacher,
    required this.category, this.isPurchased = false});

  factory CourseModel.fromMap(Map<String, dynamic> map) => CourseModel(
    id: map['id'],
    title: map['title'],
    description: map['description'] ?? '',
    price: (map['price'] ?? 0).toDouble(),
    thumbnail: map['thumbnail'] ?? '',
    teacher: map['teacher'] ?? '',
    category: map['category'] ?? '',
  );
}
