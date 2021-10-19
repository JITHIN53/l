import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api/Constants/urls.dart';
import 'package:news_api/models/news_class_model.dart';

class ApiManager {
  Future<NewsModels> getNews() async {
    var client = http.Client();
    var newsModel;

    
      var response = await client.get(UrlStrings.newsUrl);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
         newsModel = NewsModels.fromJson(jsonMap);
      }
   
    return newsModel;
  }
}
