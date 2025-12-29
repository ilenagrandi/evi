import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

/// Cliente HTTP para comunicarse con el backend
/// 
/// Este cliente maneja todas las peticiones HTTP al backend,
/// incluyendo la gestión de tokens de autenticación.
class HttpClient {
  final String baseUrl;
  String? _authToken;

  /// Crea una instancia de HttpClient
  /// 
  /// Si no se proporciona baseUrl, usa la configuración de ApiConfig.
  HttpClient({String? baseUrl}) : baseUrl = baseUrl ?? ApiConfig.apiBaseUrl;

  /// Establece el token de autenticación
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// Obtiene el token de autenticación
  String? get authToken => _authToken;

  /// Headers comunes para las peticiones
  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  /// Realiza una petición GET
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.get(url, headers: _headers);
  }

  /// Realiza una petición POST
  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.post(
      url,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// Realiza una petición PATCH
  Future<http.Response> patch(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.patch(
      url,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// Realiza una petición PUT
  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.put(
      url,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  /// Realiza una petición DELETE
  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.delete(url, headers: _headers);
  }

  /// Maneja errores HTTP comunes
  /// 
  /// Lanza una excepción con el mensaje de error si el código de estado
  /// indica un error (>= 400).
  void handleError(http.Response response) {
    if (response.statusCode >= 400) {
      try {
        final errorBody = jsonDecode(response.body);
        final message = errorBody['message'] ?? 'Error desconocido';
        throw Exception(message);
      } catch (e) {
        // Si no se puede parsear el body, usar el status code
        throw Exception('Error ${response.statusCode}: ${response.reasonPhrase ?? 'Error desconocido'}');
      }
    }
  }
}

