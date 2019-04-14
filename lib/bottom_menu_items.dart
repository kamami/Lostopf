import 'package:flutter/material.dart';
import 'package:com.yourcompany.memechat/icons.dart';

enum BottomMenu {
  games,
  browse,
  my,
  more,
}

String menuItemName(BottomMenu layoutType) {
  switch (layoutType) {
    case BottomMenu.games:
      return 'Lose';
    case BottomMenu.browse:
      return 'Youtuber';
    case BottomMenu.my:
      return 'Profil';
    case BottomMenu.more:
      return 'More';
    default:
      return '';
  }
}

IconData menuIcon(BottomMenu layoutType) {
  switch (layoutType) {
    case BottomMenu.games:
      return controllerIcon;
    case BottomMenu.browse:
      return browseIcon;
    case BottomMenu.my:
      return profileIcon;
    case BottomMenu.more:
      return moreIcon;
    default:
      return null;
  }
}
