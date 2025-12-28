import 'package:lenga_edu/core/enums/simulation_type.dart';

class SimulationDescriptor {
  final String name;
  final String description;
  final String id;
  final int grade;
  final String subject;
  final SimulationType type;
  final String entry;
  final String? basePath;
  final List<Map<String, dynamic>>? parameters;

  SimulationDescriptor({
    required this.name,
    required this.description,
    required this.id,
    required this.grade,
    required this.subject,
    required this.type,
    required this.entry,
    this.basePath,
    this.parameters,
  });

  factory SimulationDescriptor.fromMap(Map<String, dynamic> map) {
    final type = map['type'] as String;
    return SimulationDescriptor(
      name: map['name'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      grade: map['grade'] as int,
      subject: map['subject'] as String,
      type: SimulationType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => SimulationType.unknown,
      ),
      entry: map['entry'] as String,
      basePath: map['basePath'] as String?,
      parameters: map['parameters'] != null
          ? List<Map<String, dynamic>>.from(map['parameters'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'id': id,
      'grade': grade,
      'subject': subject,
      'type': type.name, // Enum name string
      'entry': entry,
      'basePath': basePath,
      'parameters': parameters,
    };
  }
}
