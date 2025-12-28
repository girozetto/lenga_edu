import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

class SimulationControls extends StatelessWidget {
  const SimulationControls({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SimulationController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withAlpha(220),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ControlButton(
            icon: controller.isPlaying ? Icons.pause : Icons.play_arrow,
            label: controller.isPlaying ? 'Pausar' : 'Iniciar',
            isPrimary: !controller.isPlaying,
            onPressed: controller.togglePlay,
          ),
          const SizedBox(width: 8),
          _Divider(),
          _IconButton(
            icon: Icons.restart_alt,
            onPressed: controller.restart,
            tooltip: 'Reiniciar',
          ),
          _IconButton(
            icon: controller.isFullscreen
                ? Icons.fullscreen_exit
                : Icons.fullscreen,
            onPressed: controller.toggleFullscreen,
            tooltip: 'Tela Cheia',
          ),
          _IconButton(
            icon: controller.showSettings ? Icons.tune : Icons.settings,
            onPressed: controller.toggleSettings,
            tooltip: 'Configurações',
          ),
          _IconButton(
            icon: Icons.help_outline,
            onPressed: () => _showHints(context, controller),
            tooltip: 'Dicas',
          ),
        ],
      ),
    );
  }

  void _showHints(BuildContext context, SimulationController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Dicas da Simulação: ${controller.simulation.name}'),
        content: Text(controller.simulation.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Theme.of(context).primaryColor : null,
        foregroundColor: isPrimary ? Colors.white : null,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: isPrimary ? 4 : 0,
      ),
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _IconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon),

      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).dividerColor,
    );
  }
}
