import 'fasting_service.dart';
import 'cycle_service.dart';
import '../utils/cycle_utils.dart';

/// Implementación mock del servicio de ayuno
/// En producción, esto será reemplazado por una implementación que llame al backend
class MockFastingService implements FastingService {
  final CycleService _cycleService;

  MockFastingService(this._cycleService);

  // Recomendaciones de ayuno por fase (en horas)
  static const Map<String, int> _fastingHoursByPhase = {
    CycleUtils.phaseMenstruation: 12, // Menos horas durante menstruación
    CycleUtils.phaseFollicular: 14, // Aumenta gradualmente
    CycleUtils.phaseOvulation: 16, // Máximo durante ovulación
    CycleUtils.phaseLuteal: 14, // Se mantiene moderado
  };

  @override
  Future<int> getFastingHoursForPhase(String phase) async {
    return _fastingHoursByPhase[phase] ?? 14;
  }

  @override
  Future<int> getFastingHoursForToday() async {
    final phase = await _cycleService.getCurrentPhase();
    return getFastingHoursForPhase(phase);
  }

  @override
  Future<List<FastingRecord>> getRecentFastingHistory({int days = 7}) async {
    // Simulamos un historial de ayunos
    final today = DateTime.now();
    final records = <FastingRecord>[];

    for (int i = days - 1; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final cycleDay = CycleUtils.calculateCycleDay(
        date.subtract(const Duration(days: 10)),
        date,
      );
      final phase = CycleUtils.getPhaseByDay(cycleDay);
      final hours = await getFastingHoursForPhase(phase);

      records.add(
        FastingRecord(
          date: date,
          hours: hours,
          completed: i % 2 == 0, // Simulamos que se completó cada dos días
        ),
      );
    }

    return records;
  }
}

