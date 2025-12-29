import 'dart:convert';
import 'fasting_service.dart';
import 'http_client.dart';
import '../config/api_config.dart';

/// Implementación real del servicio de ayuno que llama al backend NestJS
class ApiFastingService implements FastingService {
  final HttpClient httpClient;

  ApiFastingService({HttpClient? httpClient})
      : httpClient = httpClient ?? HttpClient();

  @override
  Future<int> getFastingHoursForPhase(String phase) async {
    // Este método podría necesitar un endpoint específico en el futuro
    // Por ahora, usamos la recomendación de hoy
    return await getFastingHoursForToday();
  }

  @override
  Future<int> getFastingHoursForToday() async {
    try {
      final response = await httpClient.get(ApiConfig.fastingRecommendationToday);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Retornamos el promedio de las horas recomendadas
        final min = data['recommendedHoursMin'] ?? 14;
        final max = data['recommendedHoursMax'] ?? 16;
        return ((min + max) / 2).round();
      }
      return 14;
    } catch (e) {
      return 14;
    }
  }

  @override
  Future<List<FastingRecord>> getRecentFastingHistory({int days = 7}) async {
    // TODO: Implementar cuando el backend tenga este endpoint
    // Por ahora retornamos lista vacía
    return [];
  }
}

