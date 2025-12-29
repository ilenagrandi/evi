import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env_config.dart';
import 'http_client.dart';
import 'auth_service.dart';
import 'cycle_service.dart';
import 'fasting_service.dart';
import 'notification_service.dart';
import 'api_auth_service.dart';
import 'api_cycle_service.dart';
import 'api_fasting_service.dart';
import 'mock_auth_service.dart';
import 'mock_cycle_service.dart';
import 'mock_fasting_service.dart';
import 'mock_notification_service.dart';

/// Factory for creating service instances based on environment configuration.
/// 
/// This factory switches between mock services (when DEV=true) 
/// and real API services (when DEV=false).
class ServiceFactory {
  static HttpClient? _httpClient;

  /// Gets or creates a shared HttpClient instance.
  /// 
  /// The HttpClient is shared across all API services to ensure
  /// authentication tokens are properly propagated.
  static HttpClient getHttpClient() {
    _httpClient ??= HttpClient(baseUrl: EnvConfig.apiBaseUrl);
    return _httpClient!;
  }

  /// Creates an AuthService instance based on the current environment.
  static AuthService createAuthService() {
    if (EnvConfig.dev) {
      return MockAuthService();
    }
    return ApiAuthService(httpClient: getHttpClient());
  }

  /// Creates a CycleService instance based on the current environment.
  static CycleService createCycleService() {
    if (EnvConfig.dev) {
      return MockCycleService();
    }
    return ApiCycleService(httpClient: getHttpClient());
  }

  /// Creates a FastingService instance based on the current environment.
  /// 
  /// Note: MockFastingService requires a CycleService for mock data,
  /// but ApiFastingService gets cycle information from the backend.
  static FastingService createFastingService() {
    if (EnvConfig.dev) {
      // Mock service needs a cycle service to calculate fasting recommendations
      final cycleService = createCycleService();
      return MockFastingService(cycleService);
    }
    // API service gets cycle info from backend, no cycle service needed
    return ApiFastingService(httpClient: getHttpClient());
  }

  /// Creates a NotificationService instance based on the current environment.
  static NotificationService createNotificationService() {
    if (EnvConfig.dev) {
      return MockNotificationService();
    }
    // TODO: Implement real API notification service when backend is ready
    return MockNotificationService();
  }

  /// Resets the shared HttpClient instance.
  /// 
  /// Useful for testing or when switching between environments.
  static void resetHttpClient() {
    _httpClient = null;
  }
}

/// Riverpod providers for services
/// 
/// These providers use the ServiceFactory to create appropriate
/// service instances based on the current environment configuration.

/// Provider for the shared HttpClient instance
final httpClientProvider = Provider<HttpClient>((ref) {
  return ServiceFactory.getHttpClient();
});

/// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return ServiceFactory.createAuthService();
});

/// Provider for CycleService
final cycleServiceProvider = Provider<CycleService>((ref) {
  return ServiceFactory.createCycleService();
});

/// Provider for FastingService
final fastingServiceProvider = Provider<FastingService>((ref) {
  return ServiceFactory.createFastingService();
});

/// Provider for NotificationService
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return ServiceFactory.createNotificationService();
});

