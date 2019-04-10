import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cart extends StatefulWidget {

  @override
  _CartSTate createState() => new _CartSTate();
}

class _CartSTate extends State<Cart> {



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
      body: new Container(
         child: buildList()

      ),
    );
  }

  buildList(){
    return
      new ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int position) {
            return new Column(
              children: [



              new Slidable(
                delegate: new SlidableDrawerDelegate(),
                actionExtentRatio: 0.25,
                child: new Container(
                  color: Colors.white,
                  child: new ListTile(
                    leading: new CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: new Text('3'),
                      foregroundColor: Colors.white,
                    ),
                    title: new Text('10 Lose'),
                    subtitle: new Text('Thor\'s Hammer'),
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
              ),
              new Slidable(
                delegate: new SlidableDrawerDelegate(),
                actionExtentRatio: 0.25,
                child: new Container(
                  color: Colors.white,
                  child: new ListTile(
                    leading: new CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: new Text('3'),
                      foregroundColor: Colors.white,
                    ),
                    title: new Text('4 Lose'),
                    subtitle: new Text('Zauberstab'),
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

      );
      
      

}
}
