import 'package:flutter/material.dart';

import 'package:com.yourcompany.memechat/model/game.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GameBoxItem extends StatelessWidget {
  static const IMAGE_RATIO = 1.50;

  GameBoxItem(this.buildContext, this.game, {this.width = 120.0});
  final BuildContext buildContext;
  final Game game;
  final double width;


  Container loadingPlaceHolder = Container(

  height: IMAGE_RATIO * 120,
    width: 120,
    child: new Center(child: new CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) {
    double height = IMAGE_RATIO * width;

    return new Material(
      borderRadius: new BorderRadius.circular(4.0),
      elevation: 8.0,
      shadowColor: new Color(0xCC000000),
      child: new CachedNetworkImage(
        imageUrl: game.box,
        placeholder: (context, url) => loadingPlaceHolder,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
