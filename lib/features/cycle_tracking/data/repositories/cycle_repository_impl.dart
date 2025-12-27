import '../../domain/repositories/cycle_repository.dart';
import '../../domain/entities/cycle_info.dart';
import '../../../../core/services/cycle_service.dart';
import '../../../../core/utils/cycle_utils.dart';

/// Implementación del repositorio de ciclo
class CycleRepositoryImpl implements CycleRepository {
  final CycleService _cycleService;

  CycleRepositoryImpl(this._cycleService);

  @override
  Future<CycleInfo> getCurrentCycleInfo() async {
    final cycleDay = await _cycleService.getCurrentCycleDay();
    final phase = await _cycleService.getCurrentPhase();
    final phaseDescription = CycleUtils.getPhaseDescription(phase);

    return CycleInfo(
      currentDay: cycleDay,
      phase: phase,
      phaseDescription: phaseDescription,
    );
  }

  @override
  Future<void> saveLastPeriodStart(DateTime date) async {
    await _cycleService.saveLastPeriodStart(date);
  }
}

