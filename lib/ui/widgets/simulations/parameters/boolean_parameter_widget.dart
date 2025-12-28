import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

class BooleanParameterWidget extends StatelessWidget {
  final Map<String, dynamic> parameter;

  const BooleanParameterWidget({super.key, required this.parameter});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SimulationController>();
    final id = parameter['id'] as String;
    final label = parameter['label'] as String;
    final value = controller.parameters[id] as bool;

    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: (val) => controller.setParameter(id, val),
      contentPadding: EdgeInsets.zero,
    );
  }
}
