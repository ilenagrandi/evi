import 'auth_service.dart';

/// Implementación mock del servicio de autenticación
/// En producción, esto será reemplazado por una implementación que llame al backend
class MockAuthService implements AuthService {
  bool _isAuthenticated = false;
  String? _currentUserId;

  @override
  Future<bool> isAuthenticated() async {
    return _isAuthenticated;
  }

  @override
  Future<void> signIn(String email, String password) async {
    // Simulamos un login exitoso
    _isAuthenticated = true;
    _currentUserId = 'mock_user_123';
    // En producción, esto haría una llamada al backend
  }

  @override
  Future<void> signOut() async {
    _isAuthenticated = false;
    _currentUserId = null;
  }

  @override
  Future<void> signUp(String email, String password, Map<String, dynamic> userData) async {
    // Simulamos un registro exitoso
    _isAuthenticated = true;
    _currentUserId = 'mock_user_${DateTime.now().millisecondsSinceEpoch}';
    // En producción, esto haría una llamada al backend
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _currentUserId;
  }
}

