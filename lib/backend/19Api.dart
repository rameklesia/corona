import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  String url;
  String tambahan;
  Network(this.url, {this.tambahan});

  Future fetchData() async {
    var apiResult;
    if (tambahan == null) {
      try {
        apiResult = await http.get(Uri.parse(url));
      } catch (e) {
        print(e);
      }
    } else if (tambahan != null) {
      try {
        apiResult = await http.get(Uri.parse(url + tambahan));
      } catch (e) {
        print(e);
      }
    }

    if (apiResult.statusCode == 200) {
      return jsonDecode(apiResult.body);
    } else {
      print(apiResult.statusCode);
    }
  }
}
