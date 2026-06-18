import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/test_provider.dart';

class TestTakingScreen extends StatefulWidget {
  final int testId;
  final int duration;
  const TestTakingScreen({super.key, required this.testId, required this.duration});
  @override
  State<TestTakingScreen> createState() => _TestTakingScreenState();
}

class _TestTakingScreenState extends State<TestTakingScreen> {
  late Timer _timer;
  int _remainingSeconds = 0;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration * 60;
    context.read<TestProvider>().loadQuestions(widget.testId);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds <= 0) {
        _autoSubmit();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _autoSubmit() {
    if (_submitted) return;
    _submitted = true;
    _timer.cancel();
    final score = context.read<TestProvider>().calculateScore();
    _showResult(score);
  }

  void _submitManually() => _autoSubmit();

  void _showResult(double score) {
    showDialog(context: context, barrierDismissible: false, builder: (_) => AlertDialog(
      title: const Text('Test Submitted'),
      content: Text('Your Score: $score'),
      actions: [TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text('OK'))],
    ));
  }

  @override
  void dispose() {
    if (!_submitted) _timer.cancel();
    super.dispose();
  }

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final questions = context.watch<TestProvider>().currentQuestions;
    if (questions.isEmpty) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text('Time left: ${_formatTime(_remainingSeconds)}'), actions: [
        TextButton(onPressed: _submitManually, child: const Text('Submit', style: TextStyle(color: Colors.white)))
      ]),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (_, i) {
          final q = questions[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Q${i+1}. ${q.question}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ...['A', 'B', 'C', 'D'].map((opt) => RadioListTile<String>(
                  title: Text('$opt) ${opt == 'A' ? q.optionA : opt == 'B' ? q.optionB : opt == 'C' ? q.optionC : q.optionD}'),
                  value: opt,
                  groupValue: q.selectedOption,
                  onChanged: (val) => context.read<TestProvider>().selectAnswer(i, val!),
                )),
              ]),
            ),
          );
        },
      ),
    );
  }
}