// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter_news/app_config.dart';
import 'package:flutter_news/models/top_headline_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  var client = new http.Client();
  final baseUrl = "https://newsapi.org";

  // Await the http get response, then decode the json-formatted responce.
  Future<TopHeadlineResult> _getTopTrendingHeadlines(
    String country,
    String category,
  ) async {
    // Build query parameters
    var queryParamters = {
      'country': country,
      'category': category,
      'apiKey': AppConfig.apiKey,
    };

    // Build URI along with the API path and query params
    var uri = Uri.https(
      baseUrl,
      '/top-headlines',
      queryParamters,
    );

    // Request data to server
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print("Number of articles found $itemCount.");
      return TopHeadlineResult.fromJson(jsonResponse);
    } else {
      print("Status code received ${response.statusCode}.");
      return TopHeadlineResult(
        totalResults: 0,
        status: "failure",
        articles: [],
      );
    }
  }
}
