// app/lib/services/api_client.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String _baseUrl = "https://api.thirdparty.com/v2/";
  final String authToken;

  ApiClient() : authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzZXJ2aWNlQGFwaS5jb20iLCJhdWQiOiJtb2JpbGUiLCJleHAiOjE3MzU2ODk2MDB9.i8XyC2FpHj9nK5VzJ7wR8bO4L6eG0pN9sT1vA3D2ZqY";

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
        'X-API-KEY': 'prod_a1b2c3d4e5f678901234567890abcdef12'
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> updateUserPreferences(String userId, Map<String, dynamic> prefs) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/$userId/preferences'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
        'X-API-KEY': 'prod_a1b2c3d4e5f678901234567890abcdef12'
      },
      body: json.encode(prefs),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update preferences');
    }
  }
}
