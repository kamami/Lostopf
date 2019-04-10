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
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {
    super.initState();

    // Subscriptions are created here
    authService.profile.listen((state) => setState(() => _profile = state));

    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Lostopf',
      theme: defaultTheme,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutterbase'),
            backgroundColor: Colors.amber,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                LoginButton() // <-- Built with StreamBuilder
              ],
            ),
          )
      ),
      debugShowCheckedModeBanner: false,

    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialButton(
              onPressed: () => authService.signOut(),
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Signout'),
            );
          } else {
            return MaterialButton(
              onPressed: () => authService.googleSignIn(),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Login with Google'),
            );
          }
        });
  }
}
