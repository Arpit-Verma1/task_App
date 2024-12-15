import 'dart:convert';

import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendURL}/auth/signup'),
          headers: {'Content-Type': 'application/json'},
        body: jsonEncode( {
          'name':name,
          'email':email,
          'password':password
        })
      );
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
      {
        required String email,
        required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendURL}/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode( {

            'email':email,
            'password':password
          })
      );
      print("res body is ${res.body}");
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['error'];
      }
      return UserModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      throw e.toString();
    }
  }
}
