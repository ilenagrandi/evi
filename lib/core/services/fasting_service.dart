/// Interfaz para el servicio de recomendaciones de ayuno
/// En el futuro, esto se implementará con llamadas al backend NestJS
abstract class FastingService {
  /// Obtiene la recomendación de horas de ayuno para la fase actual
  Future<int> getFastingHoursForPhase(String phase);

  /// Obtiene la recomendación de ayuno para hoy
  Future<int> getFastingHoursForToday();

  /// Obtiene el historial de ayunos recientes
  Future<List<FastingRecord>> getRecentFastingHistory({int days = 7});
}

/// Modelo para un registro de ayuno
class FastingRecord {
  final DateTime date;
  final int hours;
  final bool completed;

  const FastingRecord({
    required this.date,
    required this.hours,
    required this.completed,
  });
}

