import 'dart:async';
import 'package:http/http.dart' as http;

class ApiHandler {
  static var client = http.Client();
  static Future<String> hitGetApi(url) async {
    var jsonString;
    try {
      Uri myUri = Uri.parse(url);
      print("api response = " + url.toString());
      var response = await client.get(myUri);
      print("api response = " + response.toString());
      if (response != null) {
        if (response.statusCode == 200) {
          jsonString = response.body;
          return jsonString;
        }
      }
    } finally {
      client.close();
    }
    return jsonString;
  }
}
