import 'package:flutter/material.dart';
import 'package:lenga_edu/ui/widgets/simulations/parameters/boolean_parameter_widget.dart';
import 'package:lenga_edu/ui/widgets/simulations/parameters/range_parameter_widget.dart';

class SimulationParameterFactory {
  static Widget create(Map<String, dynamic> parameter) {
    final type = parameter['type'] as String;

    switch (type) {
      case 'range':
        return RangeParameterWidget(parameter: parameter);
      case 'boolean':
        return BooleanParameterWidget(parameter: parameter);
      default:
        return const SizedBox.shrink();
    }
  }
}
