// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/api/api.dart';
import 'package:flutter_news/models/article.dart';
import 'package:flutter_news/models/top_headline_result.dart';
import 'package:timeago/timeago.dart' as timeago;


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
                    child: TopHeadlines(
                      articles: _topHeadlineResult.articles,
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

class TopHeadlines extends StatelessWidget {
  final List<Article> articles;

  const TopHeadlines({
    Key key,
    @required this.articles,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return TopHeadlineItem(
          article: articles[index],
        );
      },
    );
  }
}

class TopHeadlineItem extends StatelessWidget {
  final Article article;

  const TopHeadlineItem({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: article.urlToImage != null
            ? DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(article.urlToImage),
              )
            : null,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black87,
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    article.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    timeago.format(DateTime.parse(article.publishedAt)),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
