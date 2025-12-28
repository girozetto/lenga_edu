import 'package:flutter/material.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';
import '../../core/models/discipline.dart';
import '../widgets/lenga_app_bar.dart';
import 'simulation_viewer_screen.dart';

class DisciplineSimulationsScreen extends StatelessWidget {
  final Discipline discipline;

  const DisciplineSimulationsScreen({super.key, required this.discipline});

  @override
  Widget build(BuildContext context) {
    final simulations = ServiceInitializer.simulationService!
        .getSimulationsForDiscipline(discipline.id);

    return Scaffold(
      appBar: LengaAppBar(title: discipline.name),
      body: simulations.isEmpty
          ? Center(
              child: Text(
                'Nenhuma simulação disponível.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: simulations.length,
              itemBuilder: (context, index) {
                final sim = simulations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey[200]!),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.science,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text(
                      sim.name,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        sim.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SimulationViewerScreen(simulation: sim),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
