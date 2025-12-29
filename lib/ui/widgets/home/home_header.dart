import 'package:flutter/material.dart';
import 'package:lenga_edu/ui/screens/settings_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/branding/logo_cut.jpg',
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
              // Settings Button (Generic)
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings_outlined),
                color: const Color(0xFF475569),
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
}
