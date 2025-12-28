import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';

class SimulationController extends ChangeNotifier {
  final SimulationDescriptor simulation;

  bool _isPlaying = false;
  bool _isFullscreen = false;
  bool _showSettings = true;
  final Map<String, dynamic> _parameters = {};
  final Map<String, dynamic> _variables = {};

  SimulationController({required this.simulation}) {
    _initializeParameters();
    _initializeVariables();
  }

  bool get isPlaying => _isPlaying;
  bool get isFullscreen => _isFullscreen;
  bool get showSettings => _showSettings;
  Map<String, dynamic> get parameters => _parameters;
  Map<String, dynamic> get variables => _variables;

  void _initializeParameters() {
    if (simulation.parameters != null) {
      for (var param in simulation.parameters!) {
        final id = param['id'] as String;
        final defaultValue = param['default'];
        _parameters[id] = defaultValue;
      }
    }
  }

  void _initializeVariables() {
    if (simulation.variables != null) {
      for (var variable in simulation.variables!) {
        final id = variable['id'] as String;
        final defaultValue = variable['default'];
        _variables[id] = defaultValue;
      }
    }
  }

  void togglePlay() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  void restart() {
    _isPlaying = false;
    _initializeVariables(); // Reset variables to default
    notifyListeners();
  }

  void toggleFullscreen() {
    _isFullscreen = !_isFullscreen;
    notifyListeners();
  }

  void toggleSettings() {
    _showSettings = !_showSettings;
    notifyListeners();
  }

  void setParameter(String id, dynamic value) {
    _parameters[id] = value;
    notifyListeners();
  }

  void setVariable(String id, dynamic value) {
    _variables[id] = value;
    notifyListeners();
  }
}
