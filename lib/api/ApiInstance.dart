import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiInstance {
  //get request is here
  static Future<Response> getData(String url) async{
    Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
    );
    return response;
  }

  // post resuest is here
  static Future<Response> postData(String url, Map<String, dynamic> body) async{
    Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
    );
    return response;
  }
}