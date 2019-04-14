import 'package:flutter/material.dart';
import 'package:com.yourcompany.memechat/page/login.dart';
import 'package:com.yourcompany.memechat/page/page_main.dart';

import 'package:com.yourcompany.memechat/themes.dart';
import 'package:com.yourcompany.memechat/controller/auth.dart';

void main() => runApp(new FlutterGames());

class FlutterGames extends StatefulWidget {
  @override
  FlutterGamesState createState() => FlutterGamesState();
}

class FlutterGamesState extends State<FlutterGames> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Lostopf',
      theme: defaultTheme,
      home: Scaffold(

          body: new MainPage()
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}