import 'dart:convert';

import 'package:http/http.dart';

class API {
  Future fetchImageUrl() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    Response response = await get(
      Uri.parse("http://perceptiondraft.com/api/gbas00721-cat.php"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res);
      return res;
    }
  }

  Future fetchQuestion(url) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    Response response = await get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res);
      return res;
    }
  }
}
