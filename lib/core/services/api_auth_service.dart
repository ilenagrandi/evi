import 'dart:convert';
import 'auth_service.dart';
import 'http_client.dart';
import '../config/api_config.dart';

/// Implementación real del servicio de autenticación que llama al backend NestJS
class ApiAuthService implements AuthService {
  final HttpClient httpClient;
  String? _authToken;
  String? _currentUserId;

  ApiAuthService({HttpClient? httpClient})
      : httpClient = httpClient ?? HttpClient();

  @override
  Future<bool> isAuthenticated() async {
    if (_authToken == null) return false;

    try {
      // Verificar si el token es válido haciendo una petición al endpoint protegido
      final response = await httpClient.get(ApiConfig.usersMe);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _currentUserId = data['id'];
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final response = await httpClient.post(
        ApiConfig.authLogin,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _authToken = data['accessToken'];
        _currentUserId = data['user']['id'];
        httpClient.setAuthToken(_authToken);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Error al iniciar sesión');
      }
    } catch (e) {
      throw Exception('Error de conexión: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    _authToken = null;
    _currentUserId = null;
    httpClient.setAuthToken(null);
  }

  @override
  Future<void> signUp(
    String email,
    String password,
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await httpClient.post(
        ApiConfig.authRegister,
        body: {
          'email': email,
          'password': password,
          'displayName': userData['displayName'],
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _authToken = data['accessToken'];
        _currentUserId = data['user']['id'];
        httpClient.setAuthToken(_authToken);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Error al registrarse');
      }
    } catch (e) {
      throw Exception('Error de conexión: ${e.toString()}');
    }
  }

  @override
  Future<String?> getCurrentUserId() async {
    if (_currentUserId != null) return _currentUserId;
    if (await isAuthenticated()) return _currentUserId;
    return null;
  }
}

