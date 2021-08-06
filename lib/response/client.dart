import 'dart:convert';
import 'package:signup_login_demo/model/newsModel.dart';
import 'package:http/http.dart' as http;

class Client {
  Future<NewsModel> fetchUsers({countryName : String}) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=${countryName}&apiKey=adbd07b1062546a69adbc78a25d7292b");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonResponse = json.decode(response.body);
      return NewsModel.fromJson(jsonResponse);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
