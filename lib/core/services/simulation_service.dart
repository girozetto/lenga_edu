import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import 'package:lenga_edu/repositories/simulation_repository.dart';

class SimulationService {
  final SimulationRepository repo;
  const SimulationService(this.repo);

  List<SimulationDescriptor> getSimulations() {
    return repo.simulations;
  }

  List<SimulationDescriptor> getSimulationsForDiscipline(String disciplineId) {
    return repo.simulations
        .where(
          (e) => e.subject.toLowerCase().contains(disciplineId.toLowerCase()),
        )
        .toList();
  }

  List<SimulationDescriptor> searchSimulations(String query) {
    return repo.simulations
        .where(
          (e) =>
              e.name.toLowerCase().contains(query.toLowerCase()) ||
              e.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
