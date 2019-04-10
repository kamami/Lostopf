import 'package:com.yourcompany.memechat/model/game.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.yourcompany.memechat/controller/scroll_horizontal_game.dart';
import 'package:com.yourcompany.memechat/page/cart.dart';

class GamesPage extends StatefulWidget {
  GamesPage({Key key}) : super(key: key);

  @override
  _GamesPageState createState() => new _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {




  Future<List<Game>> getGames() async{
    List<Game> newGamesList = [];

    QuerySnapshot result = await Firestore.instance.collection('products').getDocuments();
    List<DocumentSnapshot> documents = result.documents;
    documents.forEach((DocumentSnapshot document) {
      Game game = new Game.fromDocument(document);
      newGamesList.add(game);
    });


     print( newGamesList.length);
    return newGamesList;
  }

  Widget build(BuildContext context) {


    return new Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {_goCartPage(context);},
          icon: Icon(Icons.shopping_cart),
          label: Text("24 Lose"),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      body:  new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            new Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 6.0, 8.0, 8.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      "New Releases",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    new InkWell(
                      onTap: () => {},
                      child: new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: new Text(
                          "Browse All",
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                    ),
                  ]),
            ),
            FutureBuilder<List<Game>>(
              future: getGames(),
              builder: (context, AsyncSnapshot<List<Game>> gamelistSnapshot){
                return (gamelistSnapshot.hasData)? HorizontalGameController(gamelistSnapshot.data) : Container();
              },
            ),
            new Divider(height: 2.0, indent: 8.0),
            new Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 8.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      "Most Popular",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    new InkWell(
                      onTap: () => {},
                      child: new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: new Text(
                          "Browse All",
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                    ),
                  ]),
            ),

          ],

        ),
      )

    );


  }
}

void _goCartPage(BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (c) {
        return new Cart();
      },
    ),
  );
}