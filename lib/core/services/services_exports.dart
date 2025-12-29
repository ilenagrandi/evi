// Exportaciones centralizadas de servicios
// Para facilitar el cambio entre servicios mock y reales

export 'auth_service.dart';
export 'cycle_service.dart';
export 'fasting_service.dart';
export 'notification_service.dart';

// Servicios Mock (para desarrollo/UI)
export 'mock_auth_service.dart';
export 'mock_cycle_service.dart';
export 'mock_fasting_service.dart';
export 'mock_notification_service.dart';

// Servicios API (conexión real al backend)
export 'api_auth_service.dart';
export 'api_cycle_service.dart';
export 'api_fasting_service.dart';
export 'http_client.dart';

// Service Factory (factory para crear servicios basado en configuración)
export 'service_factory.dart';

