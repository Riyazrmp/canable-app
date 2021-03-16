import 'dart:convert';
import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/models/connectivity_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  final String userID;

  PersonalInfo(this.userID);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController controller = new TextEditingController();
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  adddata() async {
    auth.User currentUser = auth.FirebaseAuth.instance.currentUser;
    await firestore.collection('address').doc(currentUser.email).set({
      'name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'city': controller3.text
    }).whenComplete(() {
      Navigator.pop(context);
    });
    print('kjgkgugguygugygugy');
  }

  Future<dynamic> getdata() async {
    auth.User currentUser = auth.FirebaseAuth.instance.currentUser;

    final url = "http://bellbird.xyz/get2.php";
    final DocumentSnapshot snapshot =
        await firestore.collection('address').doc(currentUser.email).get();

    controller.text = snapshot.data()['name'];
    controller1.text = snapshot.data()['phone'];
    controller2.text = snapshot.data()['address'];
    controller3.text = snapshot.data()['city'];

    return snapshot;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
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
                      CupertinoButton(
                          child: Text('SAVE',
                              style: TextStyle(
                                  fontFamily: 'Graphik',
                                  fontWeight: FontWeight.w700)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              adddata();
                            }
                          })
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
