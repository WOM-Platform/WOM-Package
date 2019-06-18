import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper{

  Future<String> genericHttpPost(
      String url, Map<String, dynamic> map) async {
    final resp = await http.post(
      url,
      body: json.encode(map),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (resp.statusCode == 200) {
      print(resp.body);
      return resp.body;
    }
    final Map<String, dynamic> jsonError = json.decode(resp.body);
    throw Exception(jsonError['title']);
  }


  static Future<String> authenticate(String auth)async{

    final response = await http.get(
      'https://wom.social/api/v1/auth/sources',
      headers: {
        HttpHeaders.authorizationHeader: "Basic $auth",
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    }
    final Map<String, dynamic> jsonError = json.decode(response.body);
    throw Exception(jsonError['title']);
  }
}