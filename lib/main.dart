import 'package:flutter/material.dart';

import 'package:com.yourcompany.memechat/page/page_main.dart';
import 'package:com.yourcompany.memechat/themes.dart';

void main() => runApp(new FlutterGames());

class FlutterGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Games',
      theme: defaultTheme,
      home: new MainPage(),
    );
  }
}
