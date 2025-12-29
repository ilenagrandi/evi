import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cycle_info.dart';
import '../../domain/repositories/cycle_repository.dart';
import '../../data/repositories/cycle_repository_impl.dart';
import '../../../../core/services/service_factory.dart';

/// Provider del repositorio de ciclo
final cycleRepositoryProvider = Provider<CycleRepository>((ref) {
  final cycleService = ref.watch(cycleServiceProvider);
  return CycleRepositoryImpl(cycleService);
});

/// Provider que obtiene la información del ciclo actual
final currentCycleInfoProvider = FutureProvider<CycleInfo>((ref) async {
  final repository = ref.watch(cycleRepositoryProvider);
  return repository.getCurrentCycleInfo();
});

