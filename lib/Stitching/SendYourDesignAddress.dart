import 'package:bellbirdmvp/Screens/orderSuccess.dart';
import 'package:bellbirdmvp/Stitching/sendYourDesign.dart';
import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SendYourDesignAddress extends StatefulWidget {
  final String fabricImage;
  final String designImage;

  final List<Map> notesData;

  final int price;
  SendYourDesignAddress({
    this.notesData,
    this.fabricImage,
    this.designImage,
    this.price,
  });
  @override
  _SendYourDesignAddressState createState() => _SendYourDesignAddressState();
}

class _SendYourDesignAddressState extends State<SendYourDesignAddress> {
  TextEditingController controller = new TextEditingController();
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isAddressLoading = true;
  Future<dynamic> getdata() async {
    var user = auth.FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot =
        await firestore.collection('address').doc(user.email).get();
    controller.text = snapshot.data()['name'];
    controller1.text = snapshot.data()['phone'];
    controller2.text = snapshot.data()['address'];
    controller3.text = snapshot.data()['city'];

    return snapshot;
  }

  List<Map> notesData = [];
  bool isLoading = false;
  orderPlacement() async {
    setState(() {
      isLoading = true;
    });
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    var user = auth.FirebaseAuth.instance.currentUser;

    await firestore.collection('address').doc(user.email).set({
      'name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'city': controller3.text
    });
    await firestore
        .collection('order_stitching')
        .doc(user.uid)
        .collection('orders_stitching')
        .doc(fileName)
        .set({
      'name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'city': controller3.text,
      'fabricImage': widget.fabricImage,
      'designImage': widget.designImage,
      'orderId': fileName,
      'type': 'Send Your Design',
      'userId': user.uid,
      'notes': widget.notesData,
      'status': 'Pending Approval',
      'userDisplayName': user.displayName,
      'userEmail': user.email,
      'timeStamp': Timestamp.now()
    }).whenComplete(() => Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => OrderSuccess()),
                (Route<dynamic> route) {
              print(route);
              return route.isFirst;
            }));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    for (int i = 0; i < widget.notesData.length; i++) {
      notesData.add({
        'image': widget.notesData[i]['image'],
        'note': widget.notesData[i]['note']
      });
    }

    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: isLoading == false
      //     ? FlatButton(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: new BorderRadius.circular(30.0)),
      //         color: Colors.blue,
      //         onPressed: () {
      //           if (_formKey.currentState.validate()) {
      //             orderPlacement();
      //           }
      //         },
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.only(top: 3.0),
      //               child: Text(
      //                 'Confirm Booking',
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     fontFamily: 'CodePro'),
      //               ),
      //             ),
      //             Icon(
      //               CupertinoIcons.location_fill,
      //               size: 20,
      //               color: Colors.white,
      //             )
      //           ],
      //         ))
      //     : CupertinoActivityIndicator(),
      appBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text(
            DemoLocalizations.of(context).getTranslatedValue("book"),
            style: TextStyle(
                fontFamily: 'CodePro',
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              orderPlacement();
            }
          },
        ),
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("shipping_address"),
          style: TextStyle(
              fontFamily: 'CodePro', fontWeight: FontWeight.w800, fontSize: 24),
        ),
      ),
      body: FutureBuilder(
          future: getdata(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue("name"),
                          style: TextStyle(
                              fontFamily: 'CodePro',
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500),
                            controller: controller,
                            validator: (val) {
                              if (val.isEmpty) {
                                return DemoLocalizations.of(context)
                                    .getTranslatedValue("enter_name");
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixStyle: GoogleFonts.quicksand(),
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Feather.user,
                                color: Colors.black,
                              ),
                              hintText: DemoLocalizations.of(context)
                                  .getTranslatedValue("enter_name"),
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(height: 30),
                      Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue("phone"),
                          style: TextStyle(
                              fontFamily: 'CodePro',
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500),
                            controller: controller1,
                            validator: (val) {
                              if (val.isEmpty ||
                                  val.length < 10 ||
                                  val.length > 10) {
                                return DemoLocalizations.of(context)
                                    .getTranslatedValue("enter_phone");
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Feather.phone,
                                color: Colors.black,
                              ),
                              hintText: DemoLocalizations.of(context)
                                  .getTranslatedValue("enter_phone"),
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(height: 30),
                      Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue("adress"),
                          style: TextStyle(
                              fontFamily: 'CodePro',
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500),
                            controller: controller2,
                            validator: (val) {
                              if (val.isEmpty) {
                                return DemoLocalizations.of(context)
                                    .getTranslatedValue("enter_address");
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Feather.home,
                                color: Colors.black,
                              ),
                              hintText: DemoLocalizations.of(context)
                                  .getTranslatedValue("enter_address"),
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(height: 30),
                      Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue("city"),
                          style: TextStyle(
                              fontFamily: 'CodePro',
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500),
                            controller: controller3,
                            validator: (val) {
                              if (val.isEmpty) {
                                return DemoLocalizations.of(context)
                                    .getTranslatedValue("enter_city");
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                SimpleLineIcons.location_pin,
                                color: Colors.black,
                              ),
                              hintText: DemoLocalizations.of(context)
                                  .getTranslatedValue("enter_city"),
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      isLoading == false
                          ? FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.blue,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  orderPlacement();
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      DemoLocalizations.of(context)
                                          .getTranslatedValue(
                                              "confirm_booking"),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'CodePro'),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.location_fill,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                ],
                              ))
                          : CupertinoActivityIndicator(),
                    ],
                  ),
                ),
              );
            }
          }),
      // body: isAddressLoading == false
      //     ? Container(
      //         padding: EdgeInsets.all(15),
      //         child: Form(
      //           key: _formKey,
      //           child: ListView(
      //             physics: AlwaysScrollableScrollPhysics(),
      //             children: <Widget>[
      //               SizedBox(height: 30),
      //               Text("Name",
      //                   style: TextStyle(
      //                       fontFamily: 'CodePro',
      //                       color: Colors.black,
      //                       fontSize: 35,
      //                       fontWeight: FontWeight.bold)),
      //               Container(
      //                   decoration: kBoxDecorationStyle,
      //                   child: TextFormField(
      //                     validator: (val) {
      //                       if (val.isEmpty) {
      //                         return 'Please Enter your name';
      //                       }

      //                       return null;
      //                     },
      //                     controller: controller,
      //                     style: TextStyle(
      //                         fontFamily: 'CodeProlight',
      //                         fontWeight: FontWeight.w500),
      //                     decoration: InputDecoration(
      //                       border: InputBorder.none,
      //                       contentPadding: EdgeInsets.only(top: 14.0),
      //                       prefixIcon: Icon(
      //                         Feather.user,
      //                         color: Colors.black,
      //                       ),
      //                       hintText: 'Enter your Name',
      //                       hintStyle: kHintTextStyle,
      //                     ),
      //                   )),
      //               SizedBox(height: 30),
      //               Text("Phone No.",
      //                   style: TextStyle(
      //                       fontFamily: 'CodePro',
      //                       color: Colors.black,
      //                       fontSize: 35,
      //                       fontWeight: FontWeight.bold)),
      //               Container(
      //                   decoration: kBoxDecorationStyle,
      //                   child: TextFormField(
      //                     validator: (val) {
      //                       if (val.isEmpty ||
      //                           val.length < 10 ||
      //                           val.length > 10) {
      //                         return 'Please Enter your number';
      //                       }

      //                       return null;
      //                     },
      //                     keyboardType: TextInputType.numberWithOptions(),
      //                     style: TextStyle(
      //                         fontFamily: 'CodeProlight',
      //                         fontWeight: FontWeight.w500),
      //                     controller: controller1,
      //                     decoration: InputDecoration(
      //                       border: InputBorder.none,
      //                       contentPadding: EdgeInsets.only(top: 14.0),
      //                       prefixIcon: Icon(
      //                         Feather.phone,
      //                         color: Colors.black,
      //                       ),
      //                       hintText: 'Enter your Phone No.',
      //                       hintStyle: kHintTextStyle,
      //                     ),
      //                   )),
      //               SizedBox(height: 30),
      //               Text("Address",
      //                   style: TextStyle(
      //                       fontFamily: 'CodePro',
      //                       color: Colors.black,
      //                       fontSize: 35,
      //                       fontWeight: FontWeight.bold)),
      //               Container(
      //                   decoration: kBoxDecorationStyle,
      //                   child: TextFormField(
      //                     validator: (val) {
      //                       if (val.isEmpty) {
      //                         return 'Please Enter your address';
      //                       }

      //                       return null;
      //                     },
      //                     controller: controller2,
      //                     style: TextStyle(
      //                         fontFamily: 'CodeProlight',
      //                         fontWeight: FontWeight.w500),
      //                     decoration: InputDecoration(
      //                       border: InputBorder.none,
      //                       contentPadding: EdgeInsets.only(top: 14.0),
      //                       prefixIcon: Icon(
      //                         Feather.home,
      //                         color: Colors.black,
      //                       ),
      //                       hintText: 'Enter your Address',
      //                       hintStyle: kHintTextStyle,
      //                     ),
      //                   )),
      //               SizedBox(height: 30),
      //               Text("City",
      //                   style: TextStyle(
      //                       fontFamily: 'CodePro',
      //                       color: Colors.black,
      //                       fontSize: 35,
      //                       fontWeight: FontWeight.bold)),
      //               Container(
      //                   decoration: kBoxDecorationStyle,
      //                   child: TextFormField(
      //                     validator: (val) {
      //                       if (val.isEmpty) {
      //                         return 'Please Enter your City';
      //                       }

      //                       return null;
      //                     },
      //                     controller: controller3,
      //                     style: TextStyle(
      //                         fontFamily: 'CodeProlight',
      //                         fontWeight: FontWeight.w500),
      //                     decoration: InputDecoration(
      //                       border: InputBorder.none,
      //                       contentPadding: EdgeInsets.only(top: 14.0),
      //                       prefixIcon: Icon(
      //                         SimpleLineIcons.location_pin,
      //                         color: Colors.black,
      //                       ),
      //                       hintText: 'Enter your City',
      //                       hintStyle: kHintTextStyle,
      //                     ),
      //                   )),
      //               SizedBox(
      //                 height: 30,
      //               ),
      //               isLoading == false
      //                   ? FlatButton(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: new BorderRadius.circular(30.0)),
      //                       color: Colors.blue,
      //                       onPressed: () {
      //                         if (_formKey.currentState.validate()) {
      //                           orderPlacement();
      //                         }
      //                       },
      //                       child: Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.only(top: 3.0),
      //                             child: Text(
      //                               'Confirm Booking',
      //                               style: TextStyle(
      //                                   color: Colors.white,
      //                                   fontSize: 20,
      //                                   fontWeight: FontWeight.bold,
      //                                   fontFamily: 'CodePro'),
      //                             ),
      //                           ),
      //                           Icon(
      //                             CupertinoIcons.location_fill,
      //                             size: 20,
      //                             color: Colors.white,
      //                           )
      //                         ],
      //                       ))
      //                   : CupertinoActivityIndicator(),
      //             ],
      //           ),
      //         ),
      //       )
      //     : Center(child: CupertinoActivityIndicator()),
    );
  }
}
