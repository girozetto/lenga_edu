import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';
import 'package:lenga_edu/core/factories/simulation_engine_factory.dart';
import 'package:lenga_edu/ui/widgets/lenga_app_bar.dart';
import 'package:lenga_edu/ui/widgets/simulations/simulation_controls.dart';
import 'package:lenga_edu/ui/widgets/simulations/simulation_stats.dart';
import 'package:lenga_edu/ui/widgets/simulations/simulation_settings_panel.dart';

class SimulationViewerScreen extends StatelessWidget {
  final SimulationDescriptor simulation;

  const SimulationViewerScreen({super.key, required this.simulation});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SimulationController(simulation: simulation),
      child: const _SimulationViewerContent(),
    );
  }
}

class _SimulationViewerContent extends StatelessWidget {
  const _SimulationViewerContent();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SimulationController>();
    final isFullscreen = controller.isFullscreen;

    return Scaffold(
      appBar: isFullscreen
          ? null
          : LengaAppBar(title: controller.simulation.name),
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Simulation Engine Content
                SimulationEngineFactory.create(controller.simulation),

                // Stats Overlay
                const Positioned(top: 24, left: 24, child: SimulationStats()),

                // Controls Overlay
                const Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Center(child: SimulationControls()),
                ),

                // Floating Settings Toggle (Only if sidebar is hidden)
                if (!controller.showSettings)
                  Positioned(
                    top: 24,
                    right: 24,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: controller.toggleSettings,
                      child: const Icon(Icons.tune),
                    ),
                  ),

                // Fullscreen Exit Button
                if (isFullscreen)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: controller.toggleFullscreen,
                      icon: const Icon(Icons.close_fullscreen),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Dynamic Settings Sidebar
          const SimulationSettingsPanel(),
        ],
      ),
    );
  }
}
