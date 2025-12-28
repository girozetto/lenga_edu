import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

class SimulationStats extends StatelessWidget {
  const SimulationStats({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SimulationController>();
    final variables = controller.simulation.variables;

    if (variables == null || variables.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: variables.map((variable) {
        final id = variable['id'] as String;
        final label = variable['label'] as String;
        final unit = variable['unit'] as String? ?? '';
        final value = controller.variables[id] ?? variable['default'];
        final color = _getColorForVariable(variable['color'] as String?);

        return _StatCard(
          label: label,
          value: value.toString(),
          unit: unit,
          color: color,
        );
      }).toList(),
    );
  }

  Color _getColorForVariable(String? colorStr) {
    if (colorStr == null) return Colors.blue;
    // Basic color mapping for hex or common names
    if (colorStr.startsWith('#')) {
      return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
    }
    switch (colorStr.toLowerCase()) {
      case 'primary':
        return Colors.blue;
      case 'emerald':
        return Colors.green;
      case 'red':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 14,
          ),
          children: [
            TextSpan(text: '$label = '),
            TextSpan(
              text: value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: unit),
          ],
        ),
      ),
    );
  }
}
