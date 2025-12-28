import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/discipline.dart';

class DisciplineCard extends StatelessWidget {
  final Discipline discipline;
  final VoidCallback onTap;

  const DisciplineCard({
    super.key,
    required this.discipline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: discipline.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(discipline.icon, size: 40, color: Colors.blueGrey),
            const SizedBox(height: 8),
            Text(
              discipline.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              discipline.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
