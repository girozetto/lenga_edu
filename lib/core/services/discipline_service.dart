import 'package:lenga_edu/core/models/discipline.dart';
import 'package:lenga_edu/core/models/subject_descriptor.dart';
import 'package:lenga_edu/repositories/simulation_repository.dart';

class DisciplineService {
  final SimulationRepository repo;
  const DisciplineService(this.repo);

  List<SubjectDescriptor> getDisciplines() {
    return repo.subjects;
  }

  List<SubjectDescriptor> search(String query) {
    return repo.subjects
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Discipline> searchDisciplines(String query) {
    return repo.subjects
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .map(
          (e) => Discipline(
            id: e.id,
            name: e.name,
            description: e.description,
            icon: e.icon,
            color: e.color,
          ),
        )
        .toList();
  }
}
