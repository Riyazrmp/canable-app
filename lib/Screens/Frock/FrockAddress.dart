import 'package:bellbirdmvp/Screens/orderSuccess.dart';
import 'package:bellbirdmvp/Stitching/SalwarSuitEdititingScreen.dart';
import 'package:bellbirdmvp/Tabs-screens/BottomBar.dart';
import 'package:bellbirdmvp/Tabs-screens/UserP.dart';
import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FrockAddress extends StatefulWidget {
  final int sleevesPrice;
  final String sleevesAstar;
  final int neckPrice;
  final String measurementTopDocId;
  final String measurementBottomDocId;
  final bool isMeasurementSelected;
  final int damanPrice;
  final String coupon;
  final bool neckPatchBool;
  final bool sleevesPatchBool;
  final bool damanPatchBool;
  final bool bottomPatchBool;
  final DocumentSnapshot snapshot;
  final int bottomPrice;
  final bool topAstar;
  final bool bottomAstar;
  final String neckD;
  final String sleevesLengthD;
  final String fabricImage;
  final List<Map> notesData;
  final String designImage;
  final String sleevesD;
  final String damanD;
  final String sleeveFlipped;
  final int damanHeight;
  final int neckHeight;
  final int sleeveTopPadding;
  final String bottomD;
  final String plan;
  final String neckN;
  final String sleevesLengthN;
  final DocumentSnapshot discountSnapshot;
  final String sleevesN;
  final String damanN;
  final String bottomN;
  final int price;
  FrockAddress(
      {this.discountSnapshot,
      this.bottomPrice,
      this.snapshot,
      this.sleeveTopPadding,
      this.neckHeight,
      this.sleevesAstar,
      this.isMeasurementSelected,
      this.measurementBottomDocId,
      this.measurementTopDocId,
      this.damanHeight,
      this.bottomAstar,
      this.topAstar,
      this.plan,
      this.coupon,
      this.neckPatchBool,
      this.sleevesPatchBool,
      this.damanPatchBool,
      this.bottomPatchBool,
      this.fabricImage,
      this.notesData,
      this.designImage,
      this.sleeveFlipped,
      this.price,
      this.neckN,
      this.bottomN,
      this.sleevesLengthN,
      this.sleevesN,
      this.damanN,
      this.damanPrice,
      this.neckPrice,
      this.sleevesPrice,
      this.bottomD,
      this.damanD,
      this.neckD,
      this.sleevesD,
      this.sleevesLengthD});
  @override
  _FrockAddressState createState() => _FrockAddressState();
}

class _FrockAddressState extends State<FrockAddress> {
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

  bool isLoading = false;
  orderPlacement() async {
    setState(() {
      isLoading = true;
    });
    var user = auth.FirebaseAuth.instance.currentUser;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    if (widget.coupon == 'free') {
      if (widget.snapshot.exists) {
        firestore
            .collection('referralStitching')
            .doc(user.uid)
            .collection('coupons')
            .doc(widget.snapshot.id)
            .delete();
      }
    } else if (widget.coupon == 'discount') {
      if (widget.discountSnapshot.exists) {
        firestore
            .collection('Coupons')
            .doc(widget.discountSnapshot.id)
            .delete();
      }
    }
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
      'price': widget.price,
      'coupon': widget.coupon == 'discount' ? widget.discountSnapshot.id : '',
      'topAstar': widget.topAstar,
      'bottomAstar': widget.bottomAstar,
      'isMeasurementSelected': widget.isMeasurementSelected,
      'measurementTopDocId': widget.measurementTopDocId,
      'measurementBottomDocId': widget.measurementBottomDocId,
      'sleevesAstar': widget.sleevesAstar,
      'plan': widget.plan,
      'damanImage': widget.damanD,
      'damanPrice': widget.damanPrice,
      'neckImage': widget.neckD,
      'neckPrice': widget.neckPrice,
      'sleeveFlippedImage': widget.sleeveFlipped,
      'type': 'Frock',
      'typeDisplay': widget.bottomN + 'Frock',
      'name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'orderId': fileName,
      'city': controller3.text,
      'sleeveTopPadding': widget.sleeveTopPadding,
      'neckHeight': widget.neckHeight,
      'damanHeight': widget.damanHeight,
      'sleevesImage': widget.sleevesD,
      'sleevesPrice': widget.sleevesPrice,
      'sleevesLengthImage': widget.sleevesLengthD,
      'notes': widget.notesData,
      'fabricImage': widget.fabricImage,
      'bottomImage': widget.bottomD,
      'bottomPrice': widget.bottomPrice,
      'status': 'In Progress',
      'bottomName': widget.bottomN,
      'neckName': widget.neckN,
      'sleevesLengthName': widget.sleevesLengthN,
      'sleevesName': widget.sleevesN,
      'damanName': widget.damanN,
      'neckPatchBool': widget.neckPatchBool,
      'sleevesPatchBool': widget.sleevesPatchBool,
      'damanPatchBool': widget.damanPatchBool,
      'bottomPatchBool': widget.bottomPatchBool,
      'userId': user.uid,
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
                            keyboardType: TextInputType.phone,
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
                            keyboardType: TextInputType.streetAddress,
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

      // isAddressLoading == false
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
