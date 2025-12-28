import 'package:flutter/material.dart';
import 'package:lenga_edu/plugins/native/native_simulation_registry.dart';
import 'package:lenga_edu/core/abstractions/simulation_engine.dart';

class NativeSimulationEngine extends SimulationEngine {
  const NativeSimulationEngine(super.sim, {super.key});

  @override
  Widget createSimulation(BuildContext context) {
    final plugin = NativeSimulationRegistry.get(sim.entry);

    if (plugin == null) {
      return const Text('Simulação nativa não encontrada');
    }

    return plugin.build(context, {});
  }
}
