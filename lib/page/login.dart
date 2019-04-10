import 'package:flutter/material.dart';

import 'package:com.yourcompany.memechat/page/page_main.dart';
import 'package:com.yourcompany.memechat/controller/auth.dart';



class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => new _LoginState();
}

PageController pageController;

class _LoginState extends State<Login> {
  int _page = 0;
  bool triedSilentLogin = false;
  bool setupNotifications = false;



  Scaffold buildLoginPage() {
    return new Scaffold(
      body: new Center(
        child: new Padding(
          padding: const EdgeInsets.only(top: 240.0),
          child: new Column(
            children: <Widget>[
              new Text(
                'Lostopf',
                style: new TextStyle(
                    fontSize: 60.0,
                    fontFamily: "Billabong",
                    color: Colors.black),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 100.0)),
              new GestureDetector(
                onTap: (){authService.googleSignIn();},
                child: new Image.asset(
                  "assets/google_signin_button.png",
                  width: 225.0,
                ),
              ),
              new RaisedButton(onPressed: (){
                _goMainPage(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
        return buildLoginPage();
    }

  }

void _goMainPage(BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new MainPage();
      },
    ),
  );
}

