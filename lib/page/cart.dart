import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

_CartState({this.owner, this.products, this.name});


 Widget buildList()   {

   return new FutureBuilder <List<CartItem>>(
       future: getCartItems(),
       builder: (context, snapshot) {

         print(snapshot.data);

         switch (snapshot.connectionState) {
           case ConnectionState.none:
           case ConnectionState.waiting:
             return new Text('loading...');
           default:
             if (snapshot.hasError)
               return new Text('Error: ${snapshot.error}');
             else
               return new ListView(


                      children: snapshot.data


               );
         }

         });

 }

 Future<List<CartItem>> getCartItems() async {
   final FirebaseUser user = await FirebaseAuth.instance.currentUser();

   final uid = user.uid;
   QuerySnapshot data = await Firestore.instance
       .collection("carts")
       .where('owner', isEqualTo: uid)
       .where('active', isEqualTo: true)
       .getDocuments();

   return await _fetchDocumentData(data);
 }

 Future<List<CartItem>> _fetchDocumentData(QuerySnapshot data) async {
   List<CartItem> cartItems = []; // your collection.
   data.documents.forEach((DocumentSnapshot doc) {
// iterating synchronously.
     var keys = doc["products"].keys.toList(); // keys from current document.
     var values = doc["products"].values.toList(); // values from current document.

// initializing index that will be used to fetch key and value
     int index = 0;

     keys.forEach((key) async {
// start iterating asynchronously so that we can fetch data from Future.

// getting snapshot synchronously.
       DocumentSnapshot ds = await Firestore.instance
           .collection('products')
           .document(keys[index])
           .get();
// adding item to cart synchronously.
       cartItems.add(new CartItem.fromDocument(ds, values[index]));
// incrementing index synchronously.
       index++;
     });
   });

// all of the data will be in the collection as we added it synchronously.
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


    return new Column(
        children: <Widget>[

          new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: new Container(
        color: Colors.white,
        child: new ListTile(
          leading:  new CircleAvatar(
            radius: 40.0,
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
    )]);
  }
}
