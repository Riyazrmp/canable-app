import 'package:bellbirdmvp/Stitching/OrderInfo.dart';
import 'package:bellbirdmvp/Stitching/OrderInfo_SYD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:time_formatter/time_formatter.dart';

import 'orderInfo_Pak.dart';

class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  QuerySnapshot snapshot;
  var user = auth.FirebaseAuth.instance.currentUser;

  List<QueryDocumentSnapshot> data;
  getOrders() async {
    QuerySnapshot _snapshot = await firestore
        .collection('order_stitching')
        .doc(user.uid)
        .collection('orders_stitching')
        .orderBy('timeStamp', descending: true)
        .get();
    data = _snapshot.docs;

    setState(() {
      data.removeWhere(
          (element) => element.data()['status'] != "Pending Approval");
      print(data);
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  Widget salwarSuit(DocumentSnapshot snapshot) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return OrderInfoSS(
            damanImage: snapshot.data()['damanImage'],
            neckImage: snapshot.data()['neckImage'],
            sleeveFlippedImage: snapshot.data()['sleeveFlippedImage'],
            sleeveImage: snapshot.data()['sleevesImage'],
            snapshot: snapshot,
            bottomImage: snapshot.data()['bottomImage'],
          );
        }));
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.13),
                blurRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 120,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: snapshot
                                                      .data()[
                                                          'sleeveTopPadding']
                                                      .toDouble()),
                                              height: 50,
                                              child: Image.network(
                                                snapshot.data()[
                                                    'sleeveFlippedImage'],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: snapshot
                                                  .data()['neckHeight']
                                                  .toDouble(),
                                              child: Image.network(
                                                snapshot.data()['neckImage'],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: snapshot
                                                      .data()[
                                                          'sleeveTopPadding']
                                                      .toDouble()),
                                              height: 50,
                                              child: Image.network(
                                                snapshot.data()['sleevesImage'],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: snapshot
                                          .data()['damanHeight']
                                          .toDouble(),
                                      child: Image.network(
                                        snapshot.data()['damanImage'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            'Booked on: ',
                            style: TextStyle(
                                fontFamily: 'CodeProlight',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            '20 October 2020',
                            style: TextStyle(
                                fontFamily: 'CodeProlight', fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.clock,
                        size: 20,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          'Pending Approval',
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pakistan(DocumentSnapshot snapshot) {
    Timestamp time = snapshot.data()['timeStamp'];

    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return OrderInfoPak(
            designImage: snapshot.data()['designImage'],
            fabricImage: snapshot.data()['fabricImage'],
            snapshot: snapshot,
            notes: snapshot.data()['notes'],
          );
        }));
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.13),
                blurRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 120,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            child: Image.network(
                              snapshot.data()['fabricImage'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Booked on: ',
                                style: TextStyle(
                                    fontFamily: 'CodeProlight',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                time.toDate().day.toString() +
                                    '-' +
                                    time.toDate().month.toString() +
                                    '-' +
                                    time.toDate().year.toString(),
                                style: TextStyle(
                                    fontFamily: 'CodeProlight', fontSize: 15),
                              )
                            ],
                          ),
                          Text(
                            snapshot.data()['type'],
                            style: TextStyle(
                                fontFamily: 'CodeProlight',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.clock,
                        size: 20,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          'Pending Approval',
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget syd(DocumentSnapshot snapshot) {
    Timestamp time = snapshot.data()['timeStamp'];

    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return OrderInfoSYD(
            designImage: snapshot.data()['designImage'],
            fabricImage: snapshot.data()['fabricImage'],
            snapshot: snapshot,
            notes: snapshot.data()['notes'],
          );
        }));
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.13),
                blurRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 120,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            child: Image.network(
                              snapshot.data()['fabricImage'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Booked on: ',
                                style: TextStyle(
                                    fontFamily: 'CodeProlight',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                time.toDate().day.toString() +
                                    '-' +
                                    time.toDate().month.toString() +
                                    '-' +
                                    time.toDate().year.toString(),
                                style: TextStyle(
                                    fontFamily: 'CodeProlight', fontSize: 15),
                              )
                            ],
                          ),
                          Text(
                            snapshot.data()['type'],
                            style: TextStyle(
                                fontFamily: 'CodeProlight',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.clock,
                        size: 20,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          'Pending Approval',
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  widgetSelector(DocumentSnapshot snapshot) {
    switch (snapshot.data()['type']) {
      case 'salwarSuit':
        return salwarSuit(snapshot);
        break;

      case 'Pakistani Stitching':
        return pakistan(snapshot);
        break;

      case 'Send Your Design':
        return syd(snapshot);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading == true
            ? Center(child: CupertinoActivityIndicator())
            : data.isNotEmpty
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: widgetSelector(data[index]));
                    })
                : Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset('assets/hanger.png')),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'No Pending Orders',
                              style: TextStyle(
                                  fontFamily: 'CodePro',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 21),
                            ),
                          )),
                    ],
                  ));
  }
}
