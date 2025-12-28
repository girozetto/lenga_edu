import 'dart:io';

import 'package:lenga_edu/core/consts/directory_consts.dart';
import 'package:lenga_edu/core/services/discipline_service.dart';
import 'package:lenga_edu/core/services/simulation_service.dart';
import 'package:lenga_edu/repositories/simulation_repository.dart';

class ServiceInitializer {
  static SimulationRepository? repo;
  static DisciplineService? disciplineService;
  static SimulationService? simulationService;

  static Future<void> init() async {
    final contentDir = Directory(DirectoryConsts.contentDir);
    repo = SimulationRepository(contentDir);
    await repo!.loadAll();
    disciplineService = DisciplineService(repo!);
    simulationService = SimulationService(repo!);
  }
}
