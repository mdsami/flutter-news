// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/api/api.dart';
import 'package:flutter_news/models/top_headline_result.dart';
import 'package:flutter_news/widgets/featured_articles.dart';
import 'package:flutter_news/widgets/section_header_widget.dart';
import 'package:flutter_news/widgets/top_headlines_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final Api _api = Api();
  TopHeadlineResult _topHeadlineResultFeatured;
  TopHeadlineResult _topHeadlineResultBusiness;
  TopHeadlineResult _topHeadlineResultTech;

  PageController _featuredPageController;

  @override
  void initState() {
    super.initState();
    _featuredPageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Flutter News",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              onPressed: () {
                // TODO
              },
            ),
            IconButton(
              icon: Icon(
                Icons.code,
                color: Colors.red,
              ),
              onPressed: () {
                // TODO
              },
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: _api.getTopTrendingHeadlines("PH", "general"),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<TopHeadlineResult> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      _topHeadlineResultFeatured = snapshot.data;
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                top: 16,
                                left: 16,
                              ),
                              child: SectionHeaderWidget(title: "Featured"),
                            ),
                            FeaturedArticles(
                              pageController: _featuredPageController,
                              articles: _topHeadlineResultFeatured.articles,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: _api.getTopTrendingHeadlines("PH", "business"),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<TopHeadlineResult> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      _topHeadlineResultBusiness = snapshot.data;
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                left: 16,
                              ),
                              child: SectionHeaderWidget(title: "Business"),
                            ),
                            TopHeadlines(
                              articles: _topHeadlineResultBusiness.articles,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: _api.getTopTrendingHeadlines("PH", "technology"),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<TopHeadlineResult> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      _topHeadlineResultTech = snapshot.data;
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                left: 16,
                              ),
                              child: SectionHeaderWidget(title: "Technology"),
                            ),
                            TopHeadlines(
                              articles: _topHeadlineResultTech.articles,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
