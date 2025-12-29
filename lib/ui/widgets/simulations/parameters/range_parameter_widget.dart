import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

class RangeParameterWidget extends StatelessWidget {
  final Map<String, dynamic> parameter;

  const RangeParameterWidget({super.key, required this.parameter});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SimulationController>();
    final stepValue = parameter['step'];
    final id = parameter['id'] as String;
    final label = parameter['label'] as String;
    final step = (stepValue as num?)?.toDouble();
    final min = (parameter['min'] as num).toDouble();
    final max = (parameter['max'] as num).toDouble();
    final unit = parameter['unit'] as String? ?? '';
    final currentValue = (controller.parameters[id] as num).toDouble();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${currentValue.toStringAsFixed(1)}$unit',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: currentValue,
            min: min,
            max: max,
            divisions: stepValue == null ? null : ((max - min) / step!).toInt(),
            onChanged: (value) => controller.setParameter(id, value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toInt()}$unit',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text(
                '${max.toInt()}$unit',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
