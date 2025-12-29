import 'env_config.dart';

/// Configuración de la API del backend
/// 
/// Esta clase centraliza todos los endpoints de la API.
/// El baseUrl se obtiene de EnvConfig para mantener consistencia.
class ApiConfig {
  // Para Android emulator: usa 10.0.2.2:3000
  // Para iOS simulator: usa localhost:3000
  // Para Flutter web: usa localhost:3000
  // Para dispositivo físico: usa la IP de tu máquina (ej: 192.168.1.100:3000)
  
  /// Base URL de la API
  /// 
  /// Se obtiene de EnvConfig para mantener consistencia con la configuración
  /// de entorno del proyecto.
  static String get apiBaseUrl => EnvConfig.apiBaseUrl;

  // Endpoints
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String usersMe = '/users/me';
  static const String cycleCurrent = '/cycle/current';
  static const String cycleCreate = '/cycle';
  static const String cycleLogs = '/cycle/logs';
  static const String cycleLogsToday = '/cycle/logs/today';
  static const String fastingRecommendationToday = '/fasting/recommendation/today';
  static const String fastingSessions = '/fasting/sessions';
  static const String fastingSessionComplete = '/fasting/sessions';
  static const String gamificationProfile = '/gamification/profile';
}

