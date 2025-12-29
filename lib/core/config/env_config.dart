/// Environment configuration for the EVI app
/// 
/// Controls whether to use mock services (for development/testing) 
/// or real API services (for production).
class EnvConfig {
  /// Whether to use mock data instead of real backend connections
  /// 
  /// - `true`: Uses mock services (no backend required)
  /// - `false`: Uses real API services (requires backend connection)
  /// 
  /// Can be set via environment variable:
  /// ```bash
  /// flutter run --dart-define=DEV=true
  /// ```
  static const bool dev = bool.fromEnvironment(
    'DEV',
    defaultValue: true, // Default to true for development
  );

  /// API base URL for backend connections
  /// 
  /// Can be set via environment variable:
  /// ```bash
  /// flutter run --dart-define=API_BASE_URL=http://192.168.1.100:3000
  /// ```
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  /// Whether the app is in development mode
  static bool get isDevelopment => dev;

  /// Whether the app is in production mode
  static bool get isProduction => !dev;
}


