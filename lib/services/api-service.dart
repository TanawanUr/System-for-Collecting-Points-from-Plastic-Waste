import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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
  final String baseUrl = 'http://192.168.196.81:3000';
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

  Future<List<Map<String, dynamic>>> getRewards() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/rewards/stationery"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception("Failed to load rewards");
      }
    } catch (e) {
      print("Error fetching rewards: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getCertificate() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/rewards/certificates"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception("Failed to load rewards");
      }
    } catch (e) {
      print("Error fetching rewards: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getAffectiveScore() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/rewards/affectivescore"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception("Failed to load rewards");
      }
    } catch (e) {
      print("Error fetching rewards: $e");
      throw e;
    }
  }

  Future<bool> requestReward(int userId, int rewardId) async {
    final String apiUrl = "$baseUrl/api/request-reward";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId, "reward_id": rewardId}),
      );

      return response.statusCode == 201; // Success if status 201
    } catch (e) {
      print("Error requesting reward: $e");
      return false;
    }
  }


/*PROFESSOR*/

Future<List<Map<String, dynamic>>> getProffessorAffectiveReqList() async {
    int? userId = await getUserId();
    if (userId == null) {
      throw Exception("User not found");
    }

    final response = await http.get(Uri.parse('$baseUrl/professor/request-list'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reward history');
    }
  }

  Future<List<Map<String, dynamic>>> ProffessorHistory() async {
    int? userId = await getUserId();
    if (userId == null) {
      throw Exception("User not found");
    }

    final response = await http.get(Uri.parse('$baseUrl/professor/affective-hisotry'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reward history');
    }
  }





/*STAFF*/
Future<List<Map<String, dynamic>>> StaffHistoryWidget() async {
    int? userId = await getUserId();
    if (userId == null) {
      throw Exception("User not found");
    }

    final response = await http.get(Uri.parse('$baseUrl/staff/reward-approved'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reward history');
    }
  }

Future<List<Map<String, dynamic>>> getStaffRewardRequestList() async {
    int? userId = await getUserId();
    if (userId == null) {
      throw Exception("User not found");
    }

    final response = await http.get(Uri.parse('$baseUrl/staff/reward-request-list'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reward history');
    }
  }

 // Approve a reward request
  Future<bool> approveReward({
    required int requestId,
    required int approvedBy
  }) async {
    final url = Uri.parse('$baseUrl/api/approve-reward');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "request_id": requestId,
        "approved_by": approvedBy,
        "approval_status": "อนุมัติ"
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Reject a reward request
  Future<bool> rejectReward({
    required int requestId,
    required int approvedBy,
    required String reason,
  }) async {
    final url = Uri.parse('$baseUrl/api/approve-reward');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "request_id": requestId,
        "approved_by": approvedBy,
        "approval_status": "ยกเลิก",
        "reason": reason,
      }),
    );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

  Future<void> addReward({
    required String rewardName,
    required int rewardQuantity,
    required int pointsRequired,
    String? rewardType, // Optional, defaults to "stationery"
    File? imageFile,    // Image file selected by the user
  }) async {
    final uri = Uri.parse('$baseUrl/staff/add-reward');
    var request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['reward_type'] = rewardType ?? "stationery";
    request.fields['reward_name'] = rewardName;
    request.fields['reward_quantity'] = rewardQuantity.toString();
    request.fields['points_required'] = pointsRequired.toString();

    // Add image file if available
    if (imageFile != null) {
      // Determine the MIME type of the file
      final mimeTypeData = lookupMimeType(imageFile.path)?.split('/');
      var file = await http.MultipartFile.fromPath(
        'reward_image', // Must match the backend field name
        imageFile.path,
        contentType: mimeTypeData != null
            ? MediaType(mimeTypeData[0], mimeTypeData[1])
            : null,
      );
      request.files.add(file);
    }

    // Send the request
    final response = await request.send();

    if (response.statusCode == 201) {
      final respStr = await response.stream.bytesToString();
      print("Reward added successfully: $respStr");
    } else {
      print("Failed to add reward. Status code: ${response.statusCode}");
      final respStr = await response.stream.bytesToString();
      print("Response: $respStr");
    }
  }

  Future<void> updateReward({
  required int rewardId,
  required String rewardName,
  required int rewardQuantity,
  required int pointsRequired,
  String? rewardType, // e.g., "stationery"
  File? imageFile,    // optional updated image file
}) async {
  final uri = Uri.parse('$baseUrl/staff/edit-reward/$rewardId');
  var request = http.MultipartRequest('PUT', uri);

  // Add text fields
  request.fields['reward_name'] = rewardName;
  request.fields['reward_quantity'] = rewardQuantity.toString();
  request.fields['points_required'] = pointsRequired.toString();
  request.fields['reward_type'] = rewardType ?? "stationery";

  // Add image file if updated
  if (imageFile != null) {
    var file = await http.MultipartFile.fromPath('reward_image', imageFile.path);
    request.files.add(file);
  }

  final response = await request.send();
  if (response.statusCode == 200) {
    print("Reward updated successfully");
  } else {
    final respStr = await response.stream.bytesToString();
    print("Failed to update reward. Status code: ${response.statusCode}");
    print("Response: $respStr");
    throw Exception('Failed to update reward');
  }
}

  Future<void> deleteReward(int rewardId) async {
  final uri = Uri.parse('$baseUrl/staff/delete-reward/$rewardId');
  final response = await http.delete(uri);

  if (response.statusCode == 200) {
    print("Reward deleted successfully");
  } else {
    print("Failed to delete reward. Status code: ${response.statusCode}");
    throw Exception('Failed to delete reward');
  }
}

  Future<String?> fetchPointExpire() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/staff/point_expire'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming data['setting_value'] is like "2025-12-31"
        DateTime parsedDate = DateTime.parse(data['setting_value']);
        // Format for display as "day/month/year"
        return parsedDate.toString();
      } else {
        print('Failed to load point expire date. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching point expire date: $e');
      return null;
    }
  }

  /// Update the point expiration date on the backend.
  /// Expects [newDate] in "d/M/yyyy" format and converts it to "yyyy-MM-dd".
  /// Returns true if the update was successful, otherwise false.
  Future<bool> updatePointExpire(String newDate) async {
    // Convert the date from "d/M/yyyy" (display) to "yyyy-MM-dd" (API expected)
    DateFormat inputFormat = DateFormat('d/M/yyyy');
    DateFormat apiFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(newDate);
    String formattedDateForApi = apiFormat.format(parsedDate);

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/staff/point_expire'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "setting_value": formattedDateForApi,
        }),
      );
      if (response.statusCode == 200) {
        print('Point expire date updated successfully.');
        return true;
      } else {
        print('Failed to update point expire date. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating point expire date: $e');
      return false;
    }
  }




/*ADMIN*/

}
