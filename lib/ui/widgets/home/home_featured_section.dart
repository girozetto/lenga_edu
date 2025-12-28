import 'package:flutter/material.dart';
import 'featured_simulation_card.dart';

class HomeFeaturedSection extends StatelessWidget {
  const HomeFeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            children: [
              FeaturedSimulationCard(
                title: 'Laboratório de Química',
                description:
                    'Misture elementos, observe reações e aprenda estequiometria.',
                icon: Icons.science,
                gradientColors: const [Color(0xFF4F46E5), Color(0xFF3B82F6)],
                badgeText: 'Novo',
                onTap: () {},
              ),
              FeaturedSimulationCard(
                title: 'Célula Vegetal 3D',
                description:
                    'Navegue pelo interior de uma célula vegetal e compreenda a função.',
                icon: Icons.biotech,
                gradientColors: const [Color(0xFF059669), Color(0xFF14B8A6)],
                badgeText: 'Popular',
                onTap: () {},
              ),
              FeaturedSimulationCard(
                title: 'Movimento de Projéteis',
                description:
                    'Simule lançamentos, ajuste ângulos e velocidades.',
                icon: Icons.rocket_launch,
                gradientColors: const [Color(0xFFF97316), Color(0xFFF59E0B)],
                badgeText: 'Física',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
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
