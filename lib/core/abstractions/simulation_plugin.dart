import 'package:flutter/material.dart';

abstract class SimulationPlugin {
  String get id;
  String get title;

  Widget build(BuildContext context, Map<String, dynamic> config);
}
