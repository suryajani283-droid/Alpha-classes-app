import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../providers/payment_provider.dart';
import '../models/course_model.dart';
import '../routes.dart';

class CourseDetailScreen extends StatelessWidget {
  final int courseId;
  const CourseDetailScreen({super.key, required this.courseId});
  @override
  Widget build(BuildContext context) {
    final course = context.read<CourseProvider>().allCourses.firstWhere((c) => c.id == courseId);
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (course.thumbnail.isNotEmpty) Image.network(course.thumbnail, height: 200, width: double.infinity, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text(course.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          if (!course.isPurchased)
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open),
              label: Text('Buy Now • ₹${course.price}'),
              onPressed: () {
                context.read<PaymentProvider>().initiatePayment(course.price, course.title, (paymentId) async {
                  await context.read<CourseProvider>().purchaseCourse(course.id, paymentId, course.price);
                  Navigator.pop(context);
                });
              },
            )
          else
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Learning'),
              onPressed: () async {
                final lessons = await context.read<CourseProvider>().getLessons(course.id);
                if (lessons.isNotEmpty) {
                  Navigator.pushNamed(context, AppRoutes.videoPlayer, arguments: {
                    'url': lessons.first.videoUrl,
                    'title': lessons.first.title,
                    'notesUrl': lessons.first.notesUrl ?? '',
                  });
                }
              },
            ),
        ]),
      ),
    );
  }
}
