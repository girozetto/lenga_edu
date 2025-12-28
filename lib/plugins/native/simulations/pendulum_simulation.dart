import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lenga_edu/core/abstractions/simulation_plugin.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

class PendulumSimulation implements SimulationPlugin {
  @override
  String get id => 'pendulum_native';

  @override
  String get title => 'Pêndulo Simples';

  @override
  Widget create(BuildContext context, SimulationController controller) {
    return _PendulumWidget(controller: controller);
  }
}

class _PendulumWidget extends StatefulWidget {
  final SimulationController controller;

  const _PendulumWidget({required this.controller});

  @override
  State<_PendulumWidget> createState() => _PendulumWidgetState();
}

class _PendulumWidgetState extends State<_PendulumWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _angle = 0.6;
  double _angularVelocity = 0.0;
  double _angularAcceleration = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _ticker.start();
  }

  void _tick(Duration elapsed) {
    if (!widget.controller.isPlaying) return;

    final length = (widget.controller.parameters['length'] as num).toDouble();
    final gravity = (widget.controller.parameters['gravity'] as num).toDouble();
    final damping = (widget.controller.parameters['damping'] as num).toDouble();

    setState(() {
      _angularAcceleration = (-gravity / length) * sin(_angle);
      _angularVelocity += _angularAcceleration;
      _angularVelocity *= (1 - damping);
      _angle += _angularVelocity;
    });

    // Update Flutter UI stats via the Bridge
    widget.controller.setVariable('angle', _angle.toStringAsFixed(2));
    widget.controller.setVariable('omega', _angularVelocity.toStringAsFixed(3));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PendulumPainter(
        angle: _angle,
        length: (widget.controller.parameters['length'] as num).toDouble(),
      ),
      child: Container(),
    );
  }
}

class _PendulumPainter extends CustomPainter {
  final double angle;
  final double length;

  _PendulumPainter({required this.angle, required this.length});

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width / 2, 50);

    final bob = Offset(
      origin.dx + length * sin(angle),
      origin.dy + length * cos(angle),
    );

    final paint = Paint()
      ..color = const Color(0xFF308ce8)
      ..strokeWidth = 3;

    final linePaint = Paint()
      ..color = Colors.grey.withAlpha(100)
      ..strokeWidth = 2;

    // Draw grid/background-ish
    canvas.drawLine(origin, bob, linePaint);

    // Draw string
    canvas.drawLine(origin, bob, paint);

    // Draw bob with shadow/glow effect
    canvas.drawCircle(
      bob,
      16,
      paint..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2),
    );
    canvas.drawCircle(
      bob,
      16,
      paint
        ..maskFilter = null
        ..color = Colors.white,
    );
    canvas.drawCircle(bob, 14, paint..color = const Color(0xFF308ce8));

    // Draw pivot
    canvas.drawCircle(origin, 6, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(_PendulumPainter oldDelegate) =>
      oldDelegate.angle != angle || oldDelegate.length != length;
}
