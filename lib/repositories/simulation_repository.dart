import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart'; // Needed for Icons and Colors in seeding
import 'package:lenga_edu/core/consts/file_consts.dart';
import 'package:lenga_edu/core/enums/simulation_type.dart';
import 'package:lenga_edu/core/models/app_manifest.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import 'package:lenga_edu/core/models/subject_descriptor.dart';

class SimulationRepository {
  final Directory contentDir;
  late String _appVersion;
  late List<SimulationDescriptor> _simulations;
  late List<SubjectDescriptor> _subjects;

  SimulationRepository(this.contentDir);

  String get appVersion => _appVersion;
  List<SimulationDescriptor> get simulations => _simulations;
  List<SubjectDescriptor> get subjects => _subjects;

  Future<void> loadAll() async {
    final indexFile = File('${contentDir.path}/${FileConsts.appManifest}');
    if (!await indexFile.exists()) {
      await _seedDefaultData();
    }
    await _loadAllSimulations();
  }

  Future<void> _seedDefaultData() async {
    if (!await contentDir.exists()) {
      await contentDir.create(recursive: true);
    }

    final subjects = [
      SubjectDescriptor(
        name: 'Matemática',
        description: 'Álgebra, Geometria',
        id: 'math',
        icon: Icons.calculate,
        color: Colors.blue,
        simulations: ['sim_algebra'],
      ),
      SubjectDescriptor(
        name: 'Língua Portuguesa',
        description: 'Gramática, Literatura',
        id: 'portuguese',
        icon: Icons.book,
        color: Colors.amber,
        simulations: [],
      ),
      SubjectDescriptor(
        name: 'Física',
        description: 'Mecânica, Óptica',
        id: 'physics',
        icon: Icons.speed,
        color: Colors.purple,
        simulations: ['sim_gravity'],
      ),
      SubjectDescriptor(
        name: 'Biologia',
        description: 'Células, Ecossistemas',
        id: 'biology',
        icon: Icons.apple,
        color: Colors.green,
        simulations: ['sim_cells'],
      ),
      SubjectDescriptor(
        name: 'Química',
        description: 'Orgânica, Inorgânica',
        id: 'chemistry',
        icon: Icons.science,
        color: Colors.teal,
        simulations: [],
      ),
    ];

    final manifest = AppManifest(
      version: '1.0.0',
      subjects: subjects.map((e) => e.toMap()).toList(),
    );

    final indexFile = File('${contentDir.path}/${FileConsts.appManifest}');
    await indexFile.writeAsString(jsonEncode(manifest.toMap()));

    // Seed Simulations
    await _seedSimulation(
      SimulationDescriptor(
        id: 'sim_gravity',
        name: 'Força da Gravidade',
        description: 'Simulação interativa de gravidade e órbitas.',
        grade: 10,
        subject: 'physics',
        type: SimulationType.web,
        entry: 'index.html',
        basePath:
            'https://phet.colorado.edu/sims/html/gravity-force-lab/latest/gravity-force-lab_en.html',
      ),
    );

    await _seedSimulation(
      SimulationDescriptor(
        id: 'sim_cells',
        name: 'Estrutura Celular',
        description: 'Explore a célula animal e vegetal em 3D.',
        grade: 11,
        subject: 'biology',
        type: SimulationType.native,
        entry: 'main.prof', // Fictitious native entry
      ),
    );

    await _seedSimulation(
      SimulationDescriptor(
        id: 'sim_algebra',
        name: 'Equações de 2º Grau',
        description: 'Visualizador de parábolas.',
        grade: 9,
        subject: 'math',
        type: SimulationType.web,
        entry: 'index.html',
        basePath:
            'https://phet.colorado.edu/sims/html/graphing-quadratics/latest/graphing-quadratics_en.html',
      ),
    );
  }

  Future<void> _seedSimulation(SimulationDescriptor sim) async {
    final simDir = Directory('${contentDir.path}/${sim.subject}/${sim.id}');
    if (!await simDir.exists()) {
      await simDir.create(recursive: true);
    }

    final manifestFile = File(
      '${simDir.path}/${FileConsts.simulationManifest}',
    );
    await manifestFile.writeAsString(jsonEncode(sim.toMap()));
  }

  Future<void> _loadAllSubjects() async {
    final indexFile = File('${contentDir.path}/${FileConsts.appManifest}');
    final index = jsonDecode(await indexFile.readAsString());

    final appManifest = AppManifest.fromMap(index);
    final List<SubjectDescriptor> result = [];

    for (final subject in appManifest.subjects) {
      result.add(SubjectDescriptor.fromMap(subject));
    }

    _subjects = result;
    _appVersion = appManifest.version;
  }

  Future<void> _loadAllSimulations() async {
    await _loadAllSubjects();

    final List<SimulationDescriptor> result = [];

    for (final subject in _subjects) {
      for (final simId in subject.simulations) {
        final simDir = Directory('${contentDir.path}/${subject.id}/$simId');

        // Safety check if simulation folder is missing despite being in index
        if (!await simDir.exists()) continue;

        final manifestFile = File(
          '${simDir.path}/${FileConsts.simulationManifest}',
        );
        if (!await manifestFile.exists()) continue;

        final manifest = jsonDecode(await manifestFile.readAsString());

        result.add(SimulationDescriptor.fromMap(manifest));
      }
    }
    _simulations = result;
  }
}
