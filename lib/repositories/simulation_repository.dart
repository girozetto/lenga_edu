import 'dart:convert';
import 'dart:io';
import 'dart:math';
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
        simulations: [],
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
        simulations: ['sim_gravity', 'sim_pendulum'],
      ),
      SubjectDescriptor(
        name: 'Biologia',
        description: 'Células, Ecossistemas',
        id: 'biology',
        icon: Icons.apple,
        color: Colors.green,
        simulations: [],
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
      version: '2.4.1 LT',
      subjects: subjects.map((e) => e.toMap()).toList(),
    );

    final indexFile = File('${contentDir.path}/${FileConsts.appManifest}');
    await indexFile.writeAsString(jsonEncode(manifest.toMap()));

    // Seed Simulations
    await _seedSimulation(
      SimulationDescriptor(
        id: 'sim_gravity',
        name: 'Lei da Gravidade',
        description: 'Simulação interativa da queda livre e leis de Newton.',
        grade: 10,
        subject: 'physics',
        type: SimulationType.native,
        entry: 'gravity',
        parameters: [
          {
            'id': 'height',
            'label': 'Altura (h)',
            'type': 'range',
            'min': 1,
            'max': 50,
            'default': 10.0,
            'unit': ' m',
          },
          {
            'id': 'mass',
            'label': 'Massa (m)',
            'type': 'range',
            'min': 1,
            'max': 100,
            'default': 10.0,
            'unit': ' kg',
          },
          {
            'id': 'air_resistance',
            'label': 'Resistência do Ar',
            'type': 'boolean',
            'default': false,
          },
          {
            'id': 'vectors',
            'label': 'Vetores de Força',
            'type': 'boolean',
            'default': true,
          },
          {
            'id': 'slowmo',
            'label': 'Câmera Lenta',
            'type': 'boolean',
            'default': false,
          },
        ],
        variables: [
          {
            'id': 'time',
            'label': 't',
            'default': 0.00,
            'unit': 's',
            'color': 'primary',
          },
          {
            'id': 'velocity',
            'label': 'v',
            'default': 0.00,
            'unit': ' m/s',
            'color': 'emerald',
          },
        ],
        icon: 0xe54d, // Icons.science
      ),
    );

    await _seedSimulation(
      SimulationDescriptor(
        id: 'sim_pendulum',
        name: 'Pêndulo Simples',
        description: 'Simulação nativa de um pêndulo oscilante.',
        grade: 11,
        subject: 'physics',
        type: SimulationType.native,
        entry: 'pendulum', // Matches NativeSimulationRegistry key
        parameters: [
          {
            'id': 'length',
            'label': 'Comprimento',
            'type': 'range',
            'min': 100,
            'max': 300,
            'default': 200.0,
            'unit': ' px',
          },
          {
            'id': 'gravity',
            'label': 'Gravidade',
            'type': 'range',
            'min': 1,
            'max': 20,
            'default': 9.8,
            'unit': ' m/s²',
          },
          {
            'id': 'damping',
            'label': 'Amortecimento',
            'type': 'range',
            'min': 0,
            'max': 1,
            'default': 0.01,
            'unit': '',
          },
        ],
        variables: [
          {
            'id': 'angle',
            'label': 'θ',
            'default': 0.0,
            'unit': ' rad',
            'color': 'primary',
          },
          {
            'id': 'omega',
            'label': 'ω',
            'default': 0.0,
            'unit': ' rad/s',
            'color': 'red',
          },
        ],
        icon: 0xe526, // Icons.rotate_right
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
        final descriptor = SimulationDescriptor.fromMap(manifest);

        // Dynamically calculate size
        final sizeInBytes = await _calculateDirSize(simDir);
        final sizeFormatted = _formatSize(sizeInBytes);

        result.add(
          SimulationDescriptor(
            name: descriptor.name,
            description: descriptor.description,
            id: descriptor.id,
            grade: descriptor.grade,
            subject: descriptor.subject,
            type: descriptor.type,
            entry: descriptor.entry,
            basePath: descriptor.basePath ?? simDir.path,
            parameters: descriptor.parameters,
            variables: descriptor.variables,
            size: sizeFormatted,
            icon: descriptor
                .icon, // Keep it if defined, but UI will ignore switch
          ),
        );
      }
    }
    _simulations = result;
  }

  Future<int> _calculateDirSize(Directory dir) async {
    int totalSize = 0;
    try {
      if (await dir.exists()) {
        await for (final entity in dir.list(
          recursive: true,
          followLinks: false,
        )) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }
    } catch (e) {
      debugPrint('Error calculating directory size: $e');
    }
    return totalSize;
  }

  String _formatSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }
}
