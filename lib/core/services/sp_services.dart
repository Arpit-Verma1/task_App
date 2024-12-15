import 'package:shared_preferences/shared_preferences.dart';

class SpService {
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    print("set token");
    prefs.setString('x-auth-token', token);

  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString('x-auth-token');
  }
}
