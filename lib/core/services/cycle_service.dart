/// Interfaz para el servicio de ciclo menstrual
/// En el futuro, esto se implementará con llamadas al backend NestJS
abstract class CycleService {
  /// Obtiene el día actual del ciclo
  Future<int> getCurrentCycleDay();

  /// Obtiene la fase actual del ciclo
  Future<String> getCurrentPhase();

  /// Obtiene la fecha del último período
  Future<DateTime?> getLastPeriodStart();

  /// Guarda la fecha del último período
  Future<void> saveLastPeriodStart(DateTime date);

  /// Obtiene la duración promedio del ciclo
  Future<int> getAverageCycleLength();
}

