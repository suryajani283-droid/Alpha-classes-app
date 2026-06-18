import 'package:flutter/material.dart';
class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView(
        children: [
          Container(color: Colors.indigo.shade100, child: const Center(child: Text('New Batches Starting Soon!'))),
          Container(color: Colors.orange.shade100, child: const Center(child: Text('Scholarship Test on 25th June'))),
          Container(color: Colors.green.shade100, child: const Center(child: Text('Download Free PYQ Papers'))),
        ],
      ),
    );
  }
}
