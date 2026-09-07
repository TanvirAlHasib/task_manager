import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String ? userToken;
  // save user data
  static Future saveUserData(String token, Map<String, dynamic> user) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setString("user", jsonEncode(user));

    // storing token if userToken  is null
    userToken ??= preferences.getString("token");
  }
}