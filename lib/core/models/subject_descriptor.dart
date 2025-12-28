import 'package:flutter/material.dart';

class SubjectDescriptor {
  final String name;
  final String description;
  final String id;
  final IconData icon;
  final Color color;
  final List<String> simulations;

  SubjectDescriptor({
    required this.name,
    required this.description,
    required this.id,
    required this.icon,
    required this.color,
    required this.simulations,
  });

  factory SubjectDescriptor.fromMap(Map<String, dynamic> map) {
    final icon = IconData(
      int.parse(map['icon'], radix: 16),
      fontFamily: 'MaterialIcons',
    );
    final color = Color(int.parse(map['color'], radix: 16));
    final simulations = List<String>.from(map['simulations']);
    return SubjectDescriptor(
      name: map['name'],
      description: map['description'],
      id: map['id'],
      icon: icon,
      color: color,
      simulations: simulations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'id': id,
      'icon': icon.codePoint.toRadixString(16),
      'color': color.toARGB32().toRadixString(16),
      'simulations': simulations,
    };
  }
}
