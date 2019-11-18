// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/api/api.dart';
import 'package:flutter_news/models/article.dart';
import 'package:flutter_news/models/top_headline_result.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      height: 200,
      decoration: BoxDecoration(
        image: article.urlToImage != null
            ? DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(article.urlToImage),
              )
            : null,
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            article.urlToImage != null
                ? FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(
                      article.urlToImage,
                    ),
                  )
                : Container(),
            Text(article.title),
          ],
        ),
      ),
    );
  }
}
