import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart';

class Cart extends StatefulWidget {
  final String name;

  final String owner;
  final products;
  const Cart(
      {this.owner,
        this.products,
        this.name
        });

  @override
  _CartState createState() => new _CartState(owner: this.owner, products: this.products, name: this.name);
}

class _CartState extends State<Cart> {
 final String owner;
 final String name;
Map products;
 List<CartItem> cartItems = [];

_CartState({this.owner, this.products, this.name});

 @override
 void initState(){
   super.initState();
   Future.delayed(const Duration(milliseconds: 350), ()
   {
     _refresh();
   });
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


 Widget buildList()   {

   return new FutureBuilder <List<CartItem>>(
       future: getCartItems(),
       builder: (context, snapshot) {

         switch (snapshot.connectionState) {
           case ConnectionState.none:
           case ConnectionState.waiting:
             return loadingPlaceHolder;
           default:
             if (snapshot.hasError)
               return new Text('Error: ${snapshot.error}');
             else
               return ListView(
                 children: snapshot.data
               );
         }

         });

 }


 Future<List<CartItem>> getCartItems() async {
 final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
 final uid = user.uid;
 QuerySnapshot data = await Firestore.instance
     .collection("carts")
     .where('owner', isEqualTo: uid)
     .where('active', isEqualTo: true)
     .getDocuments();
 data.documents.forEach((DocumentSnapshot doc) {
 var keys =  doc["products"].keys.toList();
 var values =  doc["products"].values.toList();
 for (var i = 0; i < keys.length; i++){

   Firestore.instance.collection('products').document(keys[i]).get().then((DocumentSnapshot ds) {
     cartItems.removeWhere((item) => item.name == ds["name"]);

     cartItems.add( new CartItem.fromDocument(ds, values[i]));
 });
 }
 });


   return cartItems;

}





  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Repair it',
            onPressed: (){},
          ),
    Padding(
    padding: EdgeInsets.all(10.0),
          child: Center(

            child: new Text(
              "12 €",
              textAlign: TextAlign.center,
            ),
          ))
        ],
      ),
      body:  RefreshIndicator(
        onRefresh: _refresh,
        child: buildPage(),

      )
    );
  }

 Future<Null> _refresh() async {
   await getCartItems();

   setState(() {

   });

   return;
 }
  buildPage() {
    return  new Column(
     children: [
        new Expanded(
         child:
            buildList(),
       ),

     ],
   );

 }


}

class CartItem extends StatelessWidget {
  final String loseAnzahl;
  final String name;
  final String photoUrl;

  CartItem(
      {this.loseAnzahl,
        this.name,
          this.photoUrl
        });

  factory CartItem.fromDocument(DocumentSnapshot ds, String value) {

    return new CartItem(
      loseAnzahl: value,
      name: ds["name"],
      photoUrl: ds["box"],

    );

  }

  @override
  Widget build(BuildContext context) {
    return  new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: new Container(
        color: Colors.white,
        child: new ListTile(
          leading:  new CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: new CachedNetworkImageProvider(photoUrl),
          ),
          title: new Text('$loseAnzahl Los'),
          subtitle: new Text(name),
        ),
      ),
      actions: <Widget>[
        new IconSlideAction(
          caption: '5',
          color: Colors.green[800],
          icon: Icons.add,
          onTap: (){},
        ),
        new IconSlideAction(
          caption: '1',
          color: Colors.green[500],
          icon: Icons.add,
          onTap: () {},
        ),
      ],
      secondaryActions: <Widget>[

        new IconSlideAction(
          caption: '1',
          color: Colors.red[500],
          icon: Icons.remove,
          onTap: () {},
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red[800],
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}
