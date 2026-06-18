import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/video_player_screen.dart';
import 'screens/test_screen.dart';
import 'screens/notifications_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const courseDetail = '/courseDetail';
  static const videoPlayer = '/videoPlayer';
  static const testScreen = '/testScreen';
  static const notifications = '/notifications';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case courseDetail:
        final courseId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => CourseDetailScreen(courseId: courseId));
      case videoPlayer:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => VideoPlayerScreen(
          videoUrl: args['url'], title: args['title'], notesUrl: args['notesUrl']));
      case testScreen:
        final testId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => TestScreen(testId: testId));
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
