import 'package:flutter/material.dart';

class PlanetRow extends StatefulWidget {
  final String title;
  final String description;
  final String id;
  final String price;
  final String imageUrl;
  final bool auth;
  final Future<bool> tryautologin;

  PlanetRow(this.title, this.description, this.id, this.price, this.imageUrl,
      this.auth, this.tryautologin);

  @override
  _PlanetRowState createState() => _PlanetRowState();
}

class _PlanetRowState extends State<PlanetRow> {
  final int cindex = 1;

  @override
  Widget build(BuildContext context) {
    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            widget.title,
            style: TextStyle(
                fontFamily: 'Graphik',
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
                color: Colors.black),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Row(children: <Widget>[
                  new Image.asset("assets/ic_distance.png", height: 12.0),
                  new Container(width: 8.0),
                  new Text(widget.price,
                      style: TextStyle(
                        fontFamily: 'Graphik',
                        color: Colors.black,
                      ))
                ]),
              ),
              new Expanded(
                child: new Row(children: <Widget>[
                  new Image.asset("assets/ic_gravity.png", height: 12.0),
                  new Container(width: 8.0),
                  new Text(widget.description,
                      style:
                          TextStyle(fontFamily: 'Graphik', color: Colors.black))
                ]),
              )
            ],
          ),
        ],
      ),
    );

    final planetCard = Container(
      height: 124.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: planetCardContent,
    );

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: Image(
        image: new AssetImage(widget.imageUrl),
        height: 120.0,
        width: 120.0,
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          planetCard,
          planetThumbnail,
        ],
      ),
    );
  }
}
