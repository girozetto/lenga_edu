abstract class SimulationEvent {
  final String id;
  final dynamic value;

  SimulationEvent(this.id, this.value);
}

class ParameterChangedEvent extends SimulationEvent {
  ParameterChangedEvent(super.id, super.value);
}

class VariableChangedEvent extends SimulationEvent {
  VariableChangedEvent(super.id, super.value);
}
