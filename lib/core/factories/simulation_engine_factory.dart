import 'package:flutter/material.dart';
import 'package:lenga_edu/core/enums/simulation_type.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import 'package:lenga_edu/plugins/native/native_simulation_engine.dart';
import 'package:lenga_edu/plugins/web/web_simulation_engine.dart';
import 'package:lenga_edu/plugins/asset_web/asset_web_simulation_engine.dart';

class SimulationEngineFactory {
  static Widget create(SimulationDescriptor sim) {
    switch (sim.type) {
      case SimulationType.web:
        return WebSimulationEngine(sim);
      case SimulationType.assetWeb:
        return AssetWebSimulationEngine(sim);
      case SimulationType.native:
        return NativeSimulationEngine(sim);
      default:
        return const Text('Tipo de simulação não suportado');
    }
  }
}
