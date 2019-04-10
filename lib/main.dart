import 'package:flutter/material.dart';
import 'package:com.yourcompany.memechat/page/login.dart';

import 'package:com.yourcompany.memechat/themes.dart';

void main() => runApp(new FlutterGames());

class FlutterGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Lostopf',
      theme: defaultTheme,
      home: new Login(),
      debugShowCheckedModeBanner: false,

    );
  }
}

