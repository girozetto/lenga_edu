import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lenga_edu/core/abstractions/simulation_plugin.dart';

class PendulumSimulation implements SimulationPlugin {
  @override
  String get id => 'pendulum_native';

  @override
  String get title => 'Pêndulo Simples';

  @override
  Widget build(BuildContext context, Map<String, dynamic> config) {
    return CustomPaint(painter: _PendulumPainter(), child: Container());
  }
}

class _PendulumPainter extends CustomPainter {
  double angle = 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width / 2, 50);
    final length = 200.0;

    final bob = Offset(
      origin.dx + length * sin(angle),
      origin.dy + length * cos(angle),
    );

    final paint = Paint()
      ..color = const Color(0xFF222222)
      ..strokeWidth = 2;

    canvas.drawLine(origin, bob, paint);
    canvas.drawCircle(bob, 12, paint);
  }

  @override
  bool shouldRepaint(_) => true;
}
