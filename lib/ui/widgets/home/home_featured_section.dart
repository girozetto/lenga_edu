import 'package:flutter/material.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';
import 'package:lenga_edu/ui/screens/simulation_viewer_screen.dart';
import 'featured_simulation_card.dart';

class HomeFeaturedSection extends StatelessWidget {
  const HomeFeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final simulations =
        ServiceInitializer.repo?.simulations.take(3).toList() ?? [];

    if (simulations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Icon(
                Icons.science_outlined,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              const Text(
                'Simulações em Destaque',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              _buildArrowButton(Icons.arrow_back),
              const SizedBox(width: 8),
              _buildArrowButton(Icons.arrow_forward),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: simulations.length,
            itemBuilder: (context, index) {
              final sim = simulations[index];
              return FeaturedSimulationCard(
                title: sim.name,
                description: sim.description,
                icon: sim.icon != null
                    ? IconData(sim.icon!, fontFamily: 'MaterialIcons')
                    : Icons.science,
                gradientColors: _getGradientForSubject(sim.subject),
                badgeText: sim.subject.toUpperCase(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SimulationViewerScreen(simulation: sim),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<Color> _getGradientForSubject(String subject) {
    switch (subject.toLowerCase()) {
      case 'physics':
        return const [Color(0xFF4F46E5), Color(0xFF3B82F6)];
      case 'biology':
        return const [Color(0xFF059669), Color(0xFF14B8A6)];
      case 'chemistry':
        return const [Color(0xFFF97316), Color(0xFFF59E0B)];
      default:
        return const [Color(0xFF6366F1), Color(0xFF8B5CF6)];
    }
  }

  Widget _buildArrowButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Icon(icon, size: 16, color: const Color(0xFF475569)),
    );
  }
}
