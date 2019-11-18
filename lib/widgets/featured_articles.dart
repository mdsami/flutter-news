// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/models/article.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeaturedArticles extends StatelessWidget {
  final List<Article> articles;
  final PageController pageController;

  const FeaturedArticles({
    Key key,
    @required this.pageController,
    @required this.articles,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        pageSnapping: true,
        itemBuilder: (BuildContext context, int index) {
          return FeaturedArticleItem(
            article: articles[index],
          );
        },
      ),
    );
  }
}

class FeaturedArticleItem extends StatelessWidget {
  final Article article;
  final double itemHeight = 300;
  final double itemWidth = 240;

  const FeaturedArticleItem({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      width: itemWidth,
      margin: EdgeInsets.only(
        left: 32,
        right: 32,
        top: 30,
        bottom: 50,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[600],
            blurRadius: 25,
            spreadRadius: 5,
            offset: Offset(0.0, 0.75),
          )
        ],
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Stack(
          children: <Widget>[
            article.urlToImage != null
                ? Container(
                    height: 350,
                    width: 350,
                    child: Image.network(
                      article.urlToImage,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 350,
                    width: 350,
                    color: Colors.black,
                    child: Center(
                      child: Icon(Icons.photo_album),
                    ),
                  ),
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
              child: Container(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      article.title,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
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
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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
      ),
    );
  }
}
