import 'package:flutter/material.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';
import 'package:lenga_edu/ui/screens/discipline_simulations_screen.dart';
import 'package:lenga_edu/ui/screens/disciplines_screen.dart';
import 'package:lenga_edu/ui/screens/settings_screen.dart';
import 'package:lenga_edu/ui/widgets/featured_simulation_card.dart';
import 'package:lenga_edu/ui/widgets/hover_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusAndVersion(),
                  const SizedBox(height: 32),
                  _buildFeaturedSection(),
                  const SizedBox(height: 32),
                  _buildDisciplinesSection(context),
                  const SizedBox(height: 32),
                  _buildRecentActivitySection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 16,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.school,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'EduAngola',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              // Profile
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                        color: const Color(0xFF475569),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                              BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Container(height: 40, width: 1, color: Colors.grey[200]),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Prof. Silva',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Ciências',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            'PS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Search Bar
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF94A3B8)),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText:
                          'Pesquisar por tópicos, simulações ou planos...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (val) {
                      // Implement search logic or navigation to search screen
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusAndVersion() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi_off, size: 18, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Modo Offline',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Versão 2.4.0 (Angola Ed.)',
            style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
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

  Widget _buildDisciplinesSection(BuildContext context) {
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
            ...disciplines.take(5).map((d) => _buildDisciplineItem(d)),
            _buildAddContentItem(),
          ],
        ),
      ],
    );
  }

  Widget _buildDisciplineItem(dynamic discipline) {
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
            builder: (context) => DisciplineSimulationsScreen(
              discipline: ServiceInitializer.disciplineService!
                  .searchDisciplines(discipline.name)
                  .first, // mapping back to Discipline model or update screen to take descriptor
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
                color: color.withOpacity(0.1),
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

  Widget _buildAddContentItem() {
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

  Widget _buildRecentActivitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Atividade Recente',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _buildActivityItem(
                  icon: Icons.play_arrow,
                  iconColor: Colors.blue,
                  iconBg: Colors.blue[50]!,
                  title: 'Simulação de Óptica iniciada',
                  subtitle: 'Física • Há 2 horas',
                ),
                const Divider(height: 1),
                _buildActivityItem(
                  icon: Icons.edit_document,
                  iconColor: Colors.amber[700]!,
                  iconBg: Colors.amber[50]!,
                  title: 'Plano de aula "Revolução Industrial" editado',
                  subtitle: 'História • Ontem',
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Ver histórico completo',
                      style: TextStyle(
                        color: Color(0xFF308CE8),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}
