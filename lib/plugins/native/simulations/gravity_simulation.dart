import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lenga_edu/core/abstractions/simulation_plugin.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';

class GravitySimulation implements SimulationPlugin {
  @override
  String get id => 'gravity_native';

  @override
  String get title => 'Lei da Gravidade';

  @override
  Widget create(BuildContext context, SimulationController controller) {
    return _GravityWidget(controller: controller);
  }
}

class _GravityWidget extends StatefulWidget {
  final SimulationController controller;

  const _GravityWidget({required this.controller});

  @override
  State<_GravityWidget> createState() => _GravityWidgetState();
}

class _GravityWidgetState extends State<_GravityWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _time = 0.0;
  double _velocity = 0.0;
  double _yPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _ticker.start();
  }

  void _tick(Duration elapsed) {
    if (!widget.controller.isPlaying) return;

    final height = (widget.controller.parameters['height'] as num).toDouble();
    final mass = (widget.controller.parameters['mass'] as num).toDouble();
    final airResistance =
        widget.controller.parameters['air_resistance'] as bool;
    final slowMo = widget.controller.parameters['slowmo'] as bool;

    double dt = 0.016; // Approx 60fps
    if (slowMo) dt /= 4;

    const g = 9.8;
    double acceleration = g;

    if (airResistance) {
      // Very simplified air resistance based on mass
      double k = 0.1;
      acceleration -= (k * _velocity) / mass;
    }

    setState(() {
      _velocity += acceleration * dt;
      _yPosition += _velocity * dt;
      _time += dt;

      // Reset when it hits the "ground" (scaled height)
      if (_yPosition > height * 10) {
        _yPosition = 0;
        _velocity = 0;
        _time = 0;
      }
    });

    widget.controller.setVariable('time', _time.toStringAsFixed(2));
    widget.controller.setVariable('velocity', _velocity.toStringAsFixed(2));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade100,
            Colors.blue.shade50,
            Colors.brown.shade200,
          ],
          stops: const [0.0, 0.8, 0.8],
        ),
      ),
      child: Stack(
        children: [
          // Scale
          Positioned(
            right: 40,
            top: 20,
            bottom: 60,
            child: _VerticalScale(
              maxHeight: (widget.controller.parameters['height'] as num)
                  .toDouble(),
            ),
          ),
          // Falling object
          Center(
            child: Transform.translate(
              offset: Offset(0, -200 + _yPosition),
              child: _FallingObject(
                mass: (widget.controller.parameters['mass'] as num).toDouble(),
                showVectors: widget.controller.parameters['vectors'] as bool,
                velocity: _velocity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FallingObject extends StatelessWidget {
  final double mass;
  final bool showVectors;
  final double velocity;

  const _FallingObject({
    required this.mass,
    required this.showVectors,
    required this.velocity,
  });

  @override
  Widget build(BuildContext context) {
    final size = 20.0 + (mass / 10).clamp(0, 40);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showVectors && velocity > 0)
          Icon(Icons.arrow_downward, color: Colors.green, size: velocity * 2),
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
          ),
          child: Center(
            child: Text(
              '${mass.toInt()}kg',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VerticalScale extends StatelessWidget {
  final double maxHeight;

  const _VerticalScale({required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${maxHeight.toInt()}m',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(width: 2, color: Colors.black26, height: 200),
        const Text('0m', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
