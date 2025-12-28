import 'package:lenga_edu/core/abstractions/simulation_plugin.dart';
import 'package:lenga_edu/plugins/native/simulations/gravity_simulation.dart';
import 'package:lenga_edu/plugins/native/simulations/pendulum_simulation.dart';

class NativeSimulationRegistry {
  static final Map<String, SimulationPlugin> _registry = {
    'pendulum': PendulumSimulation(),
    'gravity': GravitySimulation(),
  };

  static SimulationPlugin? get(String id) => _registry[id];
}
