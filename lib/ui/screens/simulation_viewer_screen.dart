import 'package:flutter/material.dart';
import 'package:lenga_edu/core/enums/simulation_type.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import '../widgets/lenga_app_bar.dart';

class SimulationViewerScreen extends StatelessWidget {
  final SimulationDescriptor simulation;

  const SimulationViewerScreen({super.key, required this.simulation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LengaAppBar(title: simulation.name),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              simulation.type == SimulationType.web
                  ? Icons.public
                  : Icons.phone_android,
              size: 64,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Simulação: ${simulation.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Tipo: ${simulation.type.name.toUpperCase()}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'URL/Path: ${simulation.basePath}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            if (simulation.type == SimulationType.web)
              const Text('Aqui iniciaria o WebView')
            else
              const Text('Aqui iniciaria a engine nativa (Unity/Flame)'),
          ],
        ),
      ),
    );
  }
}
