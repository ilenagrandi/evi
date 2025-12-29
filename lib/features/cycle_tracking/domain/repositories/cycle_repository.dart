import '../entities/cycle_info.dart';

/// Repositorio para el ciclo menstrual
abstract class CycleRepository {
  /// Obtiene la información del ciclo actual
  Future<CycleInfo> getCurrentCycleInfo();

  /// Guarda la fecha del último período
  Future<void> saveLastPeriodStart(DateTime date);
}


