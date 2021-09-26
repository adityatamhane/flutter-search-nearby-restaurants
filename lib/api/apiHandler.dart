import 'dart:async';
import 'package:http/http.dart';

class ApiHandler {
  static Future<String> hitGetApi(url) async {
    var jsonString;
    try {
      Uri myUri = Uri.parse(url);
      print("api url = " + url.toString());
      var response = await get(myUri);
      print("api response = " + response.toString());
      if (response.statusCode == 200) {
        jsonString = response.body;
        return jsonString;
      }
    } finally {}
    return jsonString;
  }
}
