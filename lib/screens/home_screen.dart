import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_grid.dart';
import '../widgets/quick_action_row.dart';
import '../widgets/custom_bottom_nav.dart';
import 'course_list_screen.dart';
import 'test_screen.dart';
import 'store_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const _HomeTab(),
    const CourseListScreen(),
    const TestScreen(), // will show list of tests, later integrate properly
    const StoreScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<CourseProvider>().fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const BannerSlider(),
        const SizedBox(height: 20),
        const CategoryGrid(),
        const SizedBox(height: 20),
        const QuickActionRow(),
        // Announcements etc. can be added
      ]),
    );
  }
}
