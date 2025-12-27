import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/fasting_recommendation.dart';
import '../../domain/repositories/fasting_repository.dart';
import '../../data/repositories/fasting_repository_impl.dart';
import '../../../../core/services/mock_fasting_service.dart';
import '../../../../core/services/mock_cycle_service.dart';
import '../../../../core/services/fasting_service.dart';

/// Provider del servicio de ayuno
final fastingServiceProvider = Provider<FastingService>((ref) {
  final cycleService = MockCycleService();
  return MockFastingService(cycleService);
});

/// Provider del servicio de ciclo (para fasting)
final cycleServiceForFastingProvider = Provider((ref) {
  return MockCycleService();
});

/// Provider del repositorio de ayuno
final fastingRepositoryProvider = Provider<FastingRepository>((ref) {
  final fastingService = ref.watch(fastingServiceProvider);
  final cycleService = ref.watch(cycleServiceForFastingProvider);
  return FastingRepositoryImpl(fastingService, cycleService);
});

/// Provider que obtiene las horas de ayuno para hoy
final fastingHoursForTodayProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(fastingRepositoryProvider);
  final recommendation = await repository.getFastingRecommendationForToday();
  return recommendation.hours;
});

/// Provider que obtiene la recomendación completa de ayuno para hoy
final fastingRecommendationProvider =
    FutureProvider<FastingRecommendation>((ref) async {
  final repository = ref.watch(fastingRepositoryProvider);
  return repository.getFastingRecommendationForToday();
});

/// Provider que obtiene el historial de ayunos
final fastingHistoryProvider = FutureProvider.family<List<FastingRecord>, int>(
  (ref, days) async {
    final repository = ref.watch(fastingRepositoryProvider);
    return repository.getRecentFastingHistory(days: days);
  },
);

