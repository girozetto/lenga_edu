import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';
import 'package:lenga_edu/ui/widgets/simulations/parameters/simulation_parameter_factory.dart';

class SimulationSettingsPanel extends StatelessWidget {
  const SimulationSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SimulationController>();
    final parameters = controller.simulation.parameters;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: controller.showSettings ? 320 : 0,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withAlpha(230),
        border: Border(left: BorderSide(color: Theme.of(context).dividerColor)),
        boxShadow: [
          if (controller.showSettings)
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 30,
              offset: const Offset(-10, 0),
            ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Configurações',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: controller.toggleSettings,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (parameters != null)
                ...parameters.map(
                  (param) => SimulationParameterFactory.create(param),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
