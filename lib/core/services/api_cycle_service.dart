import 'dart:convert';
import 'cycle_service.dart';
import 'http_client.dart';
import '../config/api_config.dart';

/// Implementación real del servicio de ciclo que llama al backend NestJS
class ApiCycleService implements CycleService {
  final HttpClient httpClient;

  ApiCycleService({HttpClient? httpClient})
      : httpClient = httpClient ?? HttpClient();

  @override
  Future<int> getCurrentCycleDay() async {
    try {
      final response = await httpClient.get(ApiConfig.cycleLogsToday);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['cycleDayNumber'] ?? 1;
      }
      return 1;
    } catch (e) {
      return 1;
    }
  }

  @override
  Future<String> getCurrentPhase() async {
    try {
      final response = await httpClient.get(ApiConfig.cycleLogsToday);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['phase'] ?? 'FOLLICULAR';
      }
      return 'FOLLICULAR';
    } catch (e) {
      return 'FOLLICULAR';
    }
  }

  @override
  Future<DateTime?> getLastPeriodStart() async {
    try {
      final response = await httpClient.get(ApiConfig.cycleCurrent);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['startDate'] != null) {
          return DateTime.parse(data['startDate']);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveLastPeriodStart(DateTime date) async {
    try {
      await httpClient.post(
        ApiConfig.cycleCreate,
        body: {
          'startDate': date.toIso8601String(),
        },
      );
    } catch (e) {
      throw Exception('Error al guardar la fecha del período: ${e.toString()}');
    }
  }

  @override
  Future<int> getAverageCycleLength() async {
    try {
      final response = await httpClient.get(ApiConfig.cycleCurrent);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['averageLengthDays'] ?? 28;
      }
      return 28;
    } catch (e) {
      return 28;
    }
  }
}

