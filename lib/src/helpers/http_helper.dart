import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wom_package/src/utils/config.dart';

class HttpHelper {
  static const int TIMEOUT_SECONDS = 10;

  static Future<String> genericHttpPost(
      String url, Map<String, dynamic> map) async {
    final http.Response response = await http.post(
      url,
      body: json.encode(map),
      headers: {"content-type": "application/json"},
    );
    print(response.request.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    }
    final Map<String, dynamic> jsonError = json.decode(response.body);
    throw Exception(jsonError['title']);
  }

  static Future<String> authenticate(String auth, String type) async {
    final response = await http.get(
      '${Config.authBaseUrl}auth/$type',
      headers: {
        "authorization": "Basic $auth",
        "content-type": "application/json"
      },
    ).timeout(Duration(seconds: TIMEOUT_SECONDS), onTimeout: _onTimeout);
    print(response.request.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    }
    final Map<String, dynamic> jsonError = json.decode(response.body);
    throw Exception(jsonError['title']);
  }

  static Future<http.Response> _onTimeout() {
    throw Exception("Timeout during request");
  }
}
