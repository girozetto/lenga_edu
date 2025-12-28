import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import 'package:lenga_edu/ui/screens/simulation_viewer_screen.dart';

class SimulationListItem extends StatelessWidget {
  final SimulationDescriptor simulation;

  const SimulationListItem({super.key, required this.simulation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;
          return Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: isSmall
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              // Icon & Info
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF308CE8).withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        simulation.icon != null
                            ? IconData(
                                simulation.icon!,
                                fontFamily: 'MaterialIcons',
                              )
                            : Icons.science,
                        color: const Color(0xFF308CE8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            simulation.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildTag(Icons.category, simulation.subject),
                              const SizedBox(width: 12),
                              if (simulation.size != null)
                                _buildTag(Icons.sd_storage, simulation.size!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (isSmall) const SizedBox(height: 16),

              // Actions
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SimulationViewerScreen(simulation: simulation),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Detalhes'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SimulationViewerScreen(simulation: simulation),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF308CE8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Iniciar'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // slate-100
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
