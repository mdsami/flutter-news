// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/models/article.dart';
import 'package:timeago/timeago.dart' as timeago;

class TopHeadlines extends StatelessWidget {
  final List<Article> articles;

  const TopHeadlines({
    Key key,
    @required this.articles,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return TopHeadlineItem(
            article: articles[index],
          );
        },
      ),
    );
  }
}

class TopHeadlineItem extends StatelessWidget {
  final Article article;
  final double itemHeight = 240;
  final double itemWidth = 240;

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
        bottom: 50,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 20,
            spreadRadius: 10,
            offset: Offset(0.0, 0.75),
          )
        ],
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                article.urlToImage != null
                    ? Container(
                        height: itemHeight / 2,
                        width: itemWidth,
                        child: Image.network(
                          article.urlToImage,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                Container(
                  height: itemHeight / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.0),
                        Colors.black45,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.title,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "${article.source.name}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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
