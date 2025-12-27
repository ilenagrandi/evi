import 'package:equatable/equatable.dart';

/// Entidad que representa la información del ciclo actual
class CycleInfo extends Equatable {
  const CycleInfo({
    required this.currentDay,
    required this.phase,
    required this.phaseDescription,
  });

  final int currentDay;
  final String phase;
  final String phaseDescription;

  @override
  List<Object> get props => [currentDay, phase, phaseDescription];
}

