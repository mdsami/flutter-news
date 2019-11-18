// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/api/api.dart';
import 'package:flutter_news/models/top_headline_result.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final Api _api = Api();
  TopHeadlineResult _topHeadlineResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _api.getTopTrendingHeadlines("PH", "business"),
          builder: (
            BuildContext context,
            AsyncSnapshot<TopHeadlineResult> snapshot,
          ) {
            if (snapshot.hasData) {
              _topHeadlineResult = snapshot.data;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _topHeadlineResult.articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(_topHeadlineResult.articles[index].title);
                      },
                    ),
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
