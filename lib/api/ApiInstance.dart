import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/controllers/authController.dart';

class ApiInstance {
  //get request is here
  static Future<Response> getData(String url) async{
    // we need to retrieve the the token from shared pref
    // because we are going to use api from work manager
    // and the work manager will work periodically while the app is closed
    // so the static variable can be null
    SharedPreferences pref = await SharedPreferences.getInstance();
    String ? token = pref.getString("token");

    Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token" : token ?? "",
      }
    );
    return response;
  }

  // post resuest is here
  static Future<Response> postData(String url, Map<String, dynamic> body) async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    String ? token = pref.getString("token");

    Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token" : token ?? "",
      }
    );
    return response;
  }
}