import 'package:bellbirdmvp/models/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class OrderInfoSYD extends StatefulWidget {
  final String designImage;
  final String fabricImage;
  final List<dynamic> notes;

  final DocumentSnapshot snapshot;
  OrderInfoSYD({
    this.designImage,
    this.fabricImage,
    this.notes,
    this.snapshot,
  });
  @override
  _OrderInfoSYDState createState() => _OrderInfoSYDState();
}

class _OrderInfoSYDState extends State<OrderInfoSYD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text(
          'My Orders',
          style: TextStyle(
              fontFamily: 'CodePro', fontWeight: FontWeight.w800, fontSize: 24),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {}),
                  Text(
                    'Info',
                    style: TextStyle(
                        fontFamily: 'CodeProlight',
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                  CupertinoButton(
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontFamily: 'CodePro',
                            fontWeight: FontWeight.w800,
                            fontSize: 22),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Divider(
                  height: 5,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: Image.network(
                          widget.designImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 100,
                        child: Image.network(
                          widget.fabricImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Divider(
                  height: 5,
                ),
              ),
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Information',
                      style: TextStyle(
                          fontFamily: 'CodeProlight',
                          fontWeight: FontWeight.w800,
                          fontSize: 28),
                    ),
                  )),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Type',
                              style: TextStyle(
                                  fontFamily: 'CodeProlight',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22)),
                          Text(widget.snapshot.data()['type'],
                              style: TextStyle(
                                  fontFamily: 'CodeProlight', fontSize: 22)),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('OrderId',
                              style: TextStyle(
                                  fontFamily: 'CodeProlight',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22)),
                          Text(widget.snapshot.data()['orderId'],
                              style: TextStyle(
                                  fontFamily: 'CodeProlight', fontSize: 22)),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Status',
                              style: TextStyle(
                                  fontFamily: 'CodeProlight',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22)),
                          Text(widget.snapshot.data()['status'],
                              style: TextStyle(
                                  fontFamily: 'CodeProlight', fontSize: 22)),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Booked on: ',
                          style: TextStyle(
                            fontFamily: 'CodeProlight',
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(kSpacingUnit * 2.1),
                          ),
                        ),
                        Text(
                          widget.snapshot
                                  .data()['timeStamp']
                                  .toDate()
                                  .day
                                  .toString() +
                              '-' +
                              widget.snapshot
                                  .data()['timeStamp']
                                  .toDate()
                                  .month
                                  .toString() +
                              '-' +
                              widget.snapshot
                                  .data()['timeStamp']
                                  .toDate()
                                  .year
                                  .toString(),
                          style: TextStyle(
                            fontFamily: 'CodeProlight',
                            fontSize: ScreenUtil().setSp(kSpacingUnit * 2.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              widget.notes.length > 0
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Notes',
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              fontWeight: FontWeight.w800,
                              fontSize: 28),
                        ),
                      ))
                  : Container(),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.notes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                child: widget.notes[index]['image'] != 'null'
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: Image.network(
                                          widget.notes[index]['image'],
                                          frameBuilder: (context, child, frame,
                                              wasSynchronouslyLoaded) {
                                            if (wasSynchronouslyLoaded) {
                                              return child;
                                            } else {
                                              return AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: frame != null
                                                    ? child
                                                    : Container(
                                                        height: 80,
                                                        child: Center(
                                                            child:
                                                                CupertinoActivityIndicator())),
                                              );
                                            }
                                          },
                                        ))
                                    : Container(),
                              ),
                            ),
                            Expanded(
                              child: Text(widget.notes[index]['note'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'CodeProlight',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
