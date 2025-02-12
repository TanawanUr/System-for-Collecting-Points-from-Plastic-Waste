import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ePassport {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('https://api.rmutsv.ac.th/elogin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes)); // Decode with UTF-8
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }
}


class ApiService {
  // final String baseUrl = 'http://localhost:3000';
  final String baseUrl = 'http://192.168.1.107:3000';
  // final String baseUrl = 'http://172.20.10.4:3000';
  // final String baseUrl = 'http://192.168.43.51:3000';
  // final String baseUrl = 'http://192.168.1.106:3000';

  Future saveUser(String e_passport, String firstname, String lastname, String email, String token, String facname, String depname) async {
    final url = Uri.parse('$baseUrl/saveUser');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'e_passport': e_passport,
        'firstname': firstname,
        'lastname' : lastname,
        'email' : email,
        'token': token,
        'facname': facname,
        'depname': depname,
      }),
    );

    if (response.statusCode == 200) {
      // Success
      print('User saved successfully');
      return json.decode(response.body);
    } else {
      // Error handling
      throw Exception('Failed to save user: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserDetails(String ePassport) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$ePassport'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<int?> getUserId() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ePassport = prefs.getString('username');
    if (ePassport == null) {
      throw Exception('ePassport not found in SharedPreferences');
    }
    final response = await http.get(Uri.parse('$baseUrl/api/user/$ePassport'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      return data['user_id'] as int?;
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<List<Map<String, dynamic>>> getRewardHistory() async {
    int? userId = await getUserId();
    if (userId == null) {
      throw Exception("User not found");
    }

    final response = await http.get(Uri.parse('$baseUrl/api/reward-history/$userId'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reward history');
    }
  }

  // Future<Map<String, dynamic>> getUserDetails(String userId) async {
  //   final url = Uri.parse('$baseUrl/user/$userId');
  //   final response =
  //       await http.get(url, headers: {'Content-Type': 'application/json'});

  //   if (response.statusCode == 200) {
  //     print('User details response: ${response.body}'); // Log the response
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to load user details');
  //   }
  // }
}
