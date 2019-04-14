import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:com.yourcompany.memechat/model/game.dart';
import 'package:com.yourcompany.memechat/component/item_header_game.dart';
import 'package:com.yourcompany.memechat/component/item_description.dart';
import 'package:com.yourcompany.memechat/controller/scroll_horizontal_screenshots.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:com.yourcompany.memechat/controller/auth.dart';

class GameDetailsPage extends StatefulWidget {
  GameDetailsPage(this.game, {Key key}) : super(key: key);

  final Game game;

  @override
  _GameDetailsPageState createState() => new _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
    String activeCart;

   addToCart() async{

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    final uid = user.uid;

   Firestore.instance.collection('users').document(uid).get().then((DocumentSnapshot ds) async{
      List keys =  ds["carts"].keys.toList();
      List values =  ds["carts"].values.toList();

      for (var i = 0; i < keys.length; i++) {
          if(values[i] == true){
            setState(() {
               activeCart = keys[i];
            });
          }
      }

      if(keys.length == 0){
        QuerySnapshot data = await Firestore.instance
            .collection("carts")
            .where('owner', isEqualTo: uid)
            .where('active', isEqualTo: true)
            .getDocuments();

        data.documents.forEach((DocumentSnapshot ds){
          Firestore.instance.collection('users').document(uid).updateData({'carts.${ds.documentID}': true});


        });

      } else {
        print(activeCart);
        Firestore.instance.collection('carts').document(activeCart).updateData(
            {'products.${widget.game.id}': '1'});
      }});
    }


  @override
  Widget build(BuildContext context) {
      print(widget.game.id);
    return new Material(
      borderRadius: new BorderRadius.circular(8.0),
      child: new SingleChildScrollView(
        child: new Column(
          children: [
            new GameDetailHeader(widget.game),
            new Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: new SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: new RaisedButton(
                  onPressed: () {},
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: new Icon(
                          Icons.adjust,
                          color: Colors.white,
                        ),
                      ),
                      new Text(
                        "Rent",
                        style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                      ),
                    ],
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius:
                      new BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(12.0),
                  color: Colors.green,
                  highlightColor: Colors.green.shade400,
                  splashColor: Colors.green.shade400,
                  elevation: 8.0,
                  highlightElevation: 10.0,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: new SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: new OutlineButton(
                  onPressed: () {addToCart();},
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: new Icon(
                          Icons.archive,
                          color: Colors.green,
                        ),
                      ),
                      new Text(
                        "Buy",
                        style: Theme.of(context).textTheme.subhead.apply(color: Colors.green),
                      ),
                    ],
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius:
                      new BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(12.0),
                  borderSide: new BorderSide(color: Colors.green, width: 4.0),
                  color: Colors.white,
                  highlightColor: Colors.white70,
                  splashColor: Colors.green.shade200,
                  highlightElevation: 0.0,
                  highlightedBorderColor: Colors.green.shade400,
                ),
              ),
            ),
            new Padding(padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: new DescriptionText(widget.game.description)),
            new Padding(padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: new HorizontalScreenshotController(widget.game.screenshots)),
          ],
        ),
      ),
    );
  }
}

