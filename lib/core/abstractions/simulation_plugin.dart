import 'package:flutter/material.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

abstract class SimulationPlugin {
  String get id;
  String get title;

  Widget create(BuildContext context, SimulationController controller);
}
