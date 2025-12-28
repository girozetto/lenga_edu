import 'package:flutter/material.dart';
import 'package:lenga_edu/ui/screens/disciplines_screen.dart';
import 'package:lenga_edu/ui/screens/settings_screen.dart';
import 'package:lenga_edu/ui/widgets/hover_card.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';

class HomeDisciplinesSection extends StatelessWidget {
  const HomeDisciplinesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final disciplines = ServiceInitializer.disciplineService!.getDisciplines();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Minhas Disciplinas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DisciplinesScreen(),
                    ),
                  );
                },
                child: const Text('Ver grade completa'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 600
              ? 5
              : 2, // Responsive col count
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            ...disciplines.take(5).map((d) => _buildDisciplineItem(context, d)),
            _buildAddContentItem(context),
          ],
        ),
      ],
    );
  }

  Widget _buildDisciplineItem(BuildContext context, dynamic discipline) {
    // Assuming discipline matches SubjectDescriptor from repo
    // Helper to force vibrant colors regardless of cached data
    Color getDisciplineColor(String id, Color fallback) {
      switch (id) {
        case 'math':
          return Colors.blue;
        case 'portuguese':
          return Colors.amber;
        case 'physics':
          return Colors.purple;
        case 'biology':
          return Colors.green;
        case 'chemistry':
          return Colors.teal;
        case 'history':
          return Colors.orange;
        case 'geography':
          return Colors.indigo;
        case 'english':
          return Colors.pink;
        default:
          return fallback;
      }
    }

    // Using color from descriptor but adapting to layout
    final baseColor = discipline.color as Color;
    final color = getDisciplineColor(discipline.id, baseColor);

    return HoverCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisciplinesScreen(
              initialDiscipline: ServiceInitializer.disciplineService!
                  .searchDisciplines(discipline.name)
                  .first,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[100]!),
          // Shadow handled by HoverCard
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withAlpha(60),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(discipline.icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              discipline.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${discipline.simulations.length} Módulos',
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddContentItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[300]!,
            style: BorderStyle.solid,
            // Dashed border is complex in standard Flutter, solid is fine or use package
            // Keeping solid grey for simplicity or custom painter if needed
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.add, color: Color(0xFF94A3B8), size: 28),
            ),
            const SizedBox(height: 12),
            const Text(
              'Adicionar',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
