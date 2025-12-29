import 'package:equatable/equatable.dart';

/// Entidad que representa una recomendación de ayuno
class FastingRecommendation extends Equatable {
  const FastingRecommendation({
    required this.hours,
    required this.phase,
    required this.description,
  });

  final int hours;
  final String phase;
  final String description;

  @override
  List<Object> get props => [hours, phase, description];
}


