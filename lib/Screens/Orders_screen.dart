import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orderscreen extends StatefulWidget {
  final userId;
  Orderscreen(this.userId);
  @override
  _OrderscreenState createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  QuerySnapshot querySnapshot;

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  getOrders() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('orders')
        .document(widget.userId)
        .collection('orders')
        .orderBy('TimeStamp', descending: true)
        .getDocuments();
    setState(() {
      this.querySnapshot = querySnapshot;
      print(querySnapshot);
    });
  }

  buildList() {
    if (querySnapshot == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (querySnapshot.documents.isEmpty) {
      return Center(
        child: Image.asset('assets/2.png'),
      );
    } else {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: querySnapshot.documents.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10.0),
                      shadowColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 1, 50, 50),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          querySnapshot.documents[index]
                                              .data()['seller'],
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            '\₹ ' +
                                                querySnapshot.documents[index]
                                                    .data()['price'],
                                            style: GoogleFonts.quicksand(
                                                color: Colors.black,
                                                fontSize: 15.0)),
                                        SizedBox(height: 19),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 100, 0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.check, color: Colors.green),
                                        Text(
                                            querySnapshot.documents[index]
                                                .data()['status'],
                                            style: GoogleFonts.quicksand(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.green))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(10.0),
                              child: Image(
                                filterQuality: FilterQuality.low,
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight,
                                image: NetworkImage(querySnapshot.docs[index]
                                    .data()['coverImage']),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(
            'My Orders',
            style: GoogleFonts.quicksand(),
          ),
        ),
        body: buildList());
  }
}
