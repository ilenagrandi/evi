import '../../domain/repositories/fasting_repository.dart';
import '../../domain/entities/fasting_recommendation.dart';
import '../../../../core/services/fasting_service.dart';
import '../../../../core/services/cycle_service.dart';
import '../../../../core/utils/cycle_utils.dart';

/// Implementación del repositorio de ayuno
class FastingRepositoryImpl implements FastingRepository {
  final FastingService _fastingService;
  final CycleService _cycleService;

  FastingRepositoryImpl(this._fastingService, this._cycleService);

  @override
  Future<FastingRecommendation> getFastingRecommendationForToday() async {
    final hours = await _fastingService.getFastingHoursForToday();
    final phase = await _cycleService.getCurrentPhase();
    final phaseName = CycleUtils.getPhaseName(phase);

    String description;
    switch (phase) {
      case CycleUtils.phaseMenstruation:
        description =
            'Durante la menstruación, tu cuerpo necesita más energía. Un ayuno más corto es ideal.';
        break;
      case CycleUtils.phaseFollicular:
        description =
            'En la fase folicular, tu energía aumenta. Puedes mantener un ayuno moderado.';
        break;
      case CycleUtils.phaseOvulation:
        description =
            'Durante la ovulación, tu metabolismo está en su punto máximo. Es el mejor momento para ayunos más largos.';
        break;
      case CycleUtils.phaseLuteal:
        description =
            'En la fase lútea, escucha a tu cuerpo. Un ayuno moderado es recomendable.';
        break;
      default:
        description = 'Recomendación personalizada para tu fase actual.';
    }

    return FastingRecommendation(
      hours: hours,
      phase: phaseName,
      description: description,
    );
  }

  @override
  Future<List<FastingRecord>> getRecentFastingHistory({int days = 7}) async {
    return _fastingService.getRecentFastingHistory(days: days);
  }
}


