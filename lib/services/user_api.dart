import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider_task/models/user_model.dart';

class UserApi {
  static Future<List<UserModel>> fetchUsers() async {
    const url = "https://randomuser.me/api/?results=20";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['results'] as List<dynamic>;
    final userData = result.map((e) {
      return UserModel.fromMap(e);
    }).toList();
    return userData;
  }
}
