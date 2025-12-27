/// Interfaz para el servicio de notificaciones
/// En el futuro, esto se implementará con notificaciones push y locales
abstract class NotificationService {
  /// Solicita permisos de notificación
  Future<bool> requestPermissions();

  /// Programa una notificación
  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  });

  /// Cancela una notificación programada
  Future<void> cancelNotification(String id);

  /// Cancela todas las notificaciones
  Future<void> cancelAllNotifications();

  /// Programa recordatorios de ciclo
  Future<void> scheduleCycleReminders();

  /// Programa recordatorios de ayuno
  Future<void> scheduleFastingReminders();
}

