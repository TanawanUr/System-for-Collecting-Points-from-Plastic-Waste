import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';
  // final String baseUrl = 'http://172.20.10.5:3000';
  // final String baseUrl = 'http://192.168.43.51:3000';

  Future<Map<String, dynamic>> login(String e_passport, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'e_passport': e_passport,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }


Future<Map<String, dynamic>> getUserDetails(String userId) async {
  final url = Uri.parse('$baseUrl/user/$userId');
  final response = await http.get(url, headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    print('User details response: ${response.body}'); // Log the response
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load user details');
  }
  }
}
