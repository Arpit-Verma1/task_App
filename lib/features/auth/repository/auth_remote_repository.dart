import 'dart:convert';

import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/services/sp_services.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  final spService = SpService();

  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendURL}/auth/signup'),
          headers: {'Content-Type': 'application/json'},
          body:
              jsonEncode({'name': name, 'email': email, 'password': password}));
      print("res body is ${res.body}");
      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['error'];
      }
      return UserModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendURL}/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      print("res body is ${res.body}");
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['error'];
      }
      return UserModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final token = await spService.getToken();
      if (token == null) {
        return null;
      }
      print("token $token");

      final res = await http.post(
        Uri.parse('${Constants.backendURL}/auth/tokenIsValid'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      if (res.statusCode != 200 || jsonDecode(res.body) == false ) {
        return null;
      }

      final userResponse = await http.get(
        Uri.parse('${Constants.backendURL}/auth/'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      print("res is ${userResponse.body}");
      if (userResponse.statusCode != 200) {
        throw jsonDecode(userResponse.body)['error'];
      }


      return UserModel.fromJson(jsonDecode(userResponse.body));
    } catch (e) {
     return null;
    }
  }
}
