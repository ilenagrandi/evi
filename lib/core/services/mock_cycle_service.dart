import 'cycle_service.dart';
import '../utils/cycle_utils.dart';

/// Implementación mock del servicio de ciclo
/// En producción, esto será reemplazado por una implementación que llame al backend
class MockCycleService implements CycleService {
  // Simulamos que el último período fue hace 10 días
  DateTime? _lastPeriodStart;

  MockCycleService() {
    // Por defecto, simulamos que el último período fue hace 10 días
    _lastPeriodStart = DateTime.now().subtract(const Duration(days: 10));
  }

  @override
  Future<int> getCurrentCycleDay() async {
    if (_lastPeriodStart == null) {
      return 1; // Por defecto, día 1
    }
    return CycleUtils.calculateCycleDay(_lastPeriodStart!, DateTime.now());
  }

  @override
  Future<String> getCurrentPhase() async {
    final cycleDay = await getCurrentCycleDay();
    return CycleUtils.getPhaseByDay(cycleDay);
  }

  @override
  Future<DateTime?> getLastPeriodStart() async {
    return _lastPeriodStart;
  }

  @override
  Future<void> saveLastPeriodStart(DateTime date) async {
    _lastPeriodStart = date;
    // En producción, esto guardaría en el backend
  }

  @override
  Future<int> getAverageCycleLength() async {
    // Por defecto, 28 días
    return 28;
  }
}


