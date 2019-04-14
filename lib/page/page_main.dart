import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:com.yourcompany.memechat/bottom_menu_items.dart';
import 'package:com.yourcompany.memechat/icons.dart';
import 'package:com.yourcompany.memechat/page/page_games.dart';
import 'package:com.yourcompany.memechat/page/page_coming_soon.dart';
import 'package:com.yourcompany.memechat/controller/auth.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomMenu _layoutSelection = BottomMenu.games;
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {


    super.initState();

    // Subscriptions are created here
    authService.profile.listen((state) => setState(() => _profile = state));

    authService.loading.listen((state) => setState(() => _loading = state));


  }

   buildLoginPage() {

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
                onTap: () { authService.googleSignIn();
                            _onSelectMenuItem(0);},
                child: new Image.asset(
                  "assets/google_signin_button.png",
                  width: 225.0,
                ),
              ),
              new RaisedButton(onPressed: (){changeAccount();},
                child: const Text('Account wechseln'),

              )
            ],
          ),
        ),
      ),
    );
  }


  Container loadingPlaceHolder = Container(

    child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [new Center(
          child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),

          )
        )])


  );




  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            return
              _loading ?

    loadingPlaceHolder
                  :

              buildLoginPage();

    } else {





     return new Material(
    borderRadius: new BorderRadius.circular(8.0),
    child: new Scaffold(

    bottomNavigationBar: new CupertinoTabBar(
    activeColor: Colors.lightGreenAccent,
    backgroundColor: Colors.white70,
    items: <BottomNavigationBarItem>[
    _buildMenuItem(
    icon: controllerOutlineIcon,
    iconSelected: controllerIcon,
    bottomMenu: BottomMenu.games),
    _buildMenuItem(
    icon: browseOutlineIcon,
    iconSelected: browseIcon,
    bottomMenu: BottomMenu.browse),
    _buildMenuItem(
    icon: profileOutlineIcon,
    iconSelected: profileIcon,
    bottomMenu: BottomMenu.my),
    _buildMenuItem(
    icon: moreOutlineIcon,
    iconSelected: moreIcon,
    bottomMenu: BottomMenu.more),
    ],
    onTap: _onSelectMenuItem,
    ),
    body: _buildPage(),
    backgroundColor: Colors.white,
    ),
    );
   }});
  }

  Widget _buildPage() {
    switch (_layoutSelection) {
      case BottomMenu.games:
        return GamesPage();
      case BottomMenu.browse:
        return ComingSoonPage(menuIcon(_layoutSelection));
      case BottomMenu.my:
        return ComingSoonPage(menuIcon(_layoutSelection));
      case BottomMenu.more:
        return ComingSoonPage(menuIcon(_layoutSelection));
    }
    return null;
  }

  BottomNavigationBarItem _buildMenuItem(
      {IconData icon, IconData iconSelected, BottomMenu bottomMenu}) {
    String text = menuItemName(bottomMenu);
    IconData setIcon = _setIconSelected(
        bottomMenu: bottomMenu, icon: icon, iconSelected: iconSelected);
    return BottomNavigationBarItem(
      icon: Icon(
        setIcon,
        color: _setMenuItemColor(bottomMenu: bottomMenu),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _setMenuItemColor(bottomMenu: bottomMenu),
        ),
      ),
    );
  }

  IconData _setIconSelected(
      {BottomMenu bottomMenu, IconData icon, IconData iconSelected}) {
    return _layoutSelection == bottomMenu ? iconSelected : icon;
  }

  Color _setMenuItemColor({BottomMenu bottomMenu}) {
    return _layoutSelection == bottomMenu ? Colors.green : Colors.grey;
  }

  void _onSelectMenuItem(int index) {
    switch (index) {
      case 0:
        _onLayoutSelected(BottomMenu.games);
        break;
      case 1:
        _onLayoutSelected(BottomMenu.browse);
        break;
      case 2:
        _onLayoutSelected(BottomMenu.my);
        break;
      case 3:
        _onLayoutSelected(BottomMenu.more);
        break;
    }


  }

  void _onLayoutSelected(BottomMenu selection) {
    setState(() {
      _layoutSelection = selection;
    });
  }

  void changeAccount(){
     authService.googlSignOut();
     authService.googleSignIn();
  }
}




