import 'package:flutter/material.dart';
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final categories = ['Class 6', 'Class 7', 'Class 8', 'Class 9', 'Class 10', 'Class 11', 'Class 12', 'B.Sc'];
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1),
      itemCount: categories.length,
      itemBuilder: (_, i) => Card(
        child: Center(child: Text(categories[i], textAlign: TextAlign.center)),
      ),
    );
  }
}
