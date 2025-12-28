import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';

abstract class SimulationEngine extends StatelessWidget {
  final SimulationDescriptor sim;

  const SimulationEngine(this.sim, {super.key});

  Widget createSimulation(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return createSimulation(context);
  }
}
