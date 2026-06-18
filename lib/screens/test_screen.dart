import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/test_provider.dart';
import 'test_taking_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    if (provider.loading) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.tests.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(provider.tests[i].title),
        subtitle: Text('${provider.tests[i].durationMinutes} mins • ${provider.tests[i].isFree ? "Free" : "Paid"}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => TestTakingScreen(testId: provider.tests[i].id, duration: provider.tests[i].durationMinutes)));
        },
      ),
    );
  }
}
