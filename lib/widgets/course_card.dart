import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../routes.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  const CourseCard({super.key, required this.course});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: course.thumbnail.isNotEmpty
            ? Image.network(course.thumbnail, width: 60, fit: BoxFit.cover)
            : const Icon(Icons.play_circle, size: 60),
        title: Text(course.title),
        subtitle: Text('by ${course.teacher} • ₹${course.price}'),
        trailing: course.isPurchased
            ? const Icon(Icons.check_circle, color: Colors.green)
            : ElevatedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.courseDetail, arguments: course.id), child: const Text('View')),
        onTap: () => Navigator.pushNamed(context, AppRoutes.courseDetail, arguments: course.id),
      ),
    );
  }
}
