import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    if (provider.loading) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.allCourses.length,
      itemBuilder: (_, i) => CourseCard(course: provider.allCourses[i]),
    );
  }
}
