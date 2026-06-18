import 'package:flutter/material.dart';
class QuickActionRow extends StatelessWidget {
  const QuickActionRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _ActionChip(icon: Icons.live_tv, label: 'Live'),
      _ActionChip(icon: Icons.ondemand_video, label: 'Recorded'),
      _ActionChip(icon: Icons.assignment, label: 'Tests'),
      _ActionChip(icon: Icons.download, label: 'Notes'),
    ]);
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionChip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: Colors.indigo),
      Text(label),
    ]);
  }
}
