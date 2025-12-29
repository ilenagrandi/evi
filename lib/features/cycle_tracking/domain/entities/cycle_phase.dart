import 'package:equatable/equatable.dart';

/// Entidad que representa una fase del ciclo menstrual
class CyclePhase extends Equatable {
  const CyclePhase({
    required this.name,
    required this.description,
    required this.dayRange,
  });

  final String name;
  final String description;
  final String dayRange;

  @override
  List<Object> get props => [name, description, dayRange];
}


