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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 350,
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
      scrollDirection: Axis.horizontal,
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
  final double itemHeight = 250;
  final double itemWidth = 250;

  const TopHeadlineItem({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      width: itemWidth,
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 30,
        bottom: 70,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 15,
            spreadRadius: 15,
            offset: Offset(0.0, 0.75),
          )
        ],
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Stack(
          children: <Widget>[
            Container(
              height: itemHeight / 2,
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
              alignment: Alignment.topCenter,
              child: article.urlToImage != null
                  ? Container(
                      height: itemHeight / 2,
                      width: itemWidth,
                      child: Image.network(
                        article.urlToImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: itemHeight / 2,
                color: Colors.white,
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
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeago.format(DateTime.parse(article.publishedAt)),
                      style: TextStyle(
                        color: Colors.black54,
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
      ),
    );
  }
}
