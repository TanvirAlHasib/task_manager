import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  // save user data
  static Future saveUserData(String token, Map<String, dynamic> user) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setString("user", jsonEncode(user));
  }
}