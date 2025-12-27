/// Interfaz para el servicio de autenticación
/// En el futuro, esto se implementará con llamadas al backend NestJS
abstract class AuthService {
  /// Verifica si el usuario está autenticado
  Future<bool> isAuthenticated();

  /// Inicia sesión
  Future<void> signIn(String email, String password);

  /// Cierra sesión
  Future<void> signOut();

  /// Registra un nuevo usuario
  Future<void> signUp(String email, String password, Map<String, dynamic> userData);

  /// Obtiene el ID del usuario actual
  Future<String?> getCurrentUserId();
}

