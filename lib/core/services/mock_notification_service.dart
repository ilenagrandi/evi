import 'notification_service.dart';

/// Implementación mock del servicio de notificaciones
/// En producción, esto será reemplazado por una implementación real con notificaciones push y locales
class MockNotificationService implements NotificationService {
  @override
  Future<bool> requestPermissions() async {
    // Simulamos que los permisos están otorgados
    return true;
  }

  @override
  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // En producción, esto programaría una notificación real
    print('Mock: Notificación programada - $title: $body en ${scheduledTime.toString()}');
  }

  @override
  Future<void> cancelNotification(String id) async {
    // En producción, esto cancelaría la notificación
    print('Mock: Notificación cancelada - $id');
  }

  @override
  Future<void> cancelAllNotifications() async {
    // En producción, esto cancelaría todas las notificaciones
    print('Mock: Todas las notificaciones canceladas');
  }

  @override
  Future<void> scheduleCycleReminders() async {
    // En producción, esto programaría recordatorios de ciclo
    print('Mock: Recordatorios de ciclo programados');
  }

  @override
  Future<void> scheduleFastingReminders() async {
    // En producción, esto programaría recordatorios de ayuno
    print('Mock: Recordatorios de ayuno programados');
  }
}

