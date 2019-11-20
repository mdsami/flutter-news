// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_news/home_screen.dart';

class HomeScreenCode extends StatefulWidget {
  static String routeName = "/home-screen-code";
  @override
  State<StatefulWidget> createState() {
    return HomeScreenCodeState();
  }
}

class HomeScreenCodeState extends State<HomeScreenCode> {
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
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.code,
                color: Colors.blue,
              ),
              onPressed: () {
                // TODO
              },
            )
          ],
        ),
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
