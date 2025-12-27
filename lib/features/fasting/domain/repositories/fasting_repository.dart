import '../entities/fasting_recommendation.dart';
import '../../../../core/services/fasting_service.dart';

/// Repositorio para el ayuno intermitente
abstract class FastingRepository {
  /// Obtiene la recomendación de ayuno para hoy
  Future<FastingRecommendation> getFastingRecommendationForToday();

  /// Obtiene el historial de ayunos recientes
  Future<List<FastingRecord>> getRecentFastingHistory({int days = 7});
}

