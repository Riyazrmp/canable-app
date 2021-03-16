import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bellbirdmvp/Screens/StitchingScreen.dart';
import 'package:bellbirdmvp/Screens/langSignup.dart';
import 'package:bellbirdmvp/Tabs-screens/UserP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:random_string/random_string.dart';

class BottomBar extends StatefulWidget {
  final bool isnew;
  BottomBar({this.isnew});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  auth.User currentUser;
  TextEditingController controller = new TextEditingController();

  showSheet(context) {
    showCupertinoModalBottomSheet(
        enableDrag: false,
        useRootNavigator: true,
        isDismissible: false,
        context: context,
        builder: (context) => Scaffold(
              backgroundColor: Colors.white,
              appBar: CupertinoNavigationBar(
                leading: Text(''),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontFamily: 'CodePro',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      firestore
                          .collection('Users')
                          .doc(currentUser.uid)
                          .update({'isNew': false});
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 40,
                              right: 40,
                            ),
                            child: Image.asset('assets/referralCodeImage.png'),
                          ),
                        ),
                        SizedBox(height: 50),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Have a Friends Referral Code?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'CodePro',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28),
                              ),
                            )),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 0),
                          child: Row(
                            children: [
                              Container(
                                  width: deviceWidth / 1.3,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.09),
                                        blurRadius: 6,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: controller,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Please Enter your name';
                                      }

                                      return null;
                                    },
                                    onFieldSubmitted: (bhb) async {
                                      var result = await firestore
                                          .collection('Users')
                                          .where('referralCode', isEqualTo: bhb)
                                          .get();
                                      if (result.docs.isNotEmpty) {
                                        await firestore
                                            .collection('referralStitching')
                                            .doc(result.docs[0].data()['id'])
                                            .collection('coupons')
                                            .doc()
                                            .set({
                                          'senderId': currentUser.uid,
                                          'senderName': currentUser.displayName,
                                          'price': 50,
                                          'referralCode': bhb,
                                          'timeStamp': Timestamp.now()
                                        });
                                        firestore
                                            .collection('Users')
                                            .doc(currentUser.uid)
                                            .update({'isNew': false});
                                        Navigator.pop(context);
                                      } else {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                actions: [
                                                  CupertinoButton(
                                                    child: Text('Ok',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'CodeProlight',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        )),
                                                    onPressed: () {
                                                      return Navigator.pop(
                                                          context);
                                                    },
                                                  )
                                                ],
                                                title: Text(
                                                    'Wrong referralCode',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'CodeProlight',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black)),
                                              );
                                            });
                                      }
                                    },
                                    style: TextStyle(
                                        fontFamily: 'CodeProlight',
                                        fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(top: 0.0, left: 20),
                                      hintText: 'enter here',
                                      hintStyle: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: 'CodeProlight',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Expanded(
                                child: FlatButton(
                                    height: 40,
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    onPressed: () async {
                                      var result = await firestore
                                          .collection('Users')
                                          .where('referralCode',
                                              isEqualTo: controller.text)
                                          .get();
                                      if (result.docs.isNotEmpty) {
                                        await firestore
                                            .collection('referralStitching')
                                            .doc(result.docs[0].data()['id'])
                                            .collection('coupons')
                                            .doc()
                                            .set({
                                          'senderId': currentUser.uid,
                                          'senderName': currentUser.displayName,
                                          'price': 100,
                                          'referralCode': controller.text,
                                          'timeStamp': Timestamp.now()
                                        });
                                        firestore
                                            .collection('Users')
                                            .doc(currentUser.uid)
                                            .update({'isNew': false});
                                        Navigator.pop(context);
                                      } else {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                actions: [
                                                  CupertinoButton(
                                                    child: Text('Ok',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'CodeProlight',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        )),
                                                    onPressed: () {
                                                      return Navigator.pop(
                                                          context);
                                                    },
                                                  )
                                                ],
                                                title: Text(
                                                    'Wrong referralCode',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'CodeProlight',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black)),
                                              );
                                            });
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Icon(
                                        CupertinoIcons.arrow_right_circle_fill,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 95,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              onPressed: () {
                                firestore
                                    .collection('Users')
                                    .doc(currentUser.uid)
                                    .update({'isNew': false});
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'I Don\'t have a code',
                                      style: TextStyle(
                                          fontFamily: 'CodePro',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  functionTrigger(c) async {
    var result = await firestore.collection('Users').doc(currentUser.uid).get();
    if (result.exists != true) {
      await firestore.collection('Users').doc(currentUser.uid).set({
        'id': currentUser.uid,
        'email': currentUser.email,
        'referralCode': randomAlphaNumeric(9),
        'displayName': currentUser.displayName,
        'isNew': true,
        'username': currentUser.displayName,
        'photoUrl': currentUser.photoURL,
        'bio': 'hello world',
      });
    }
    if (result.data()['isNew'] == true) {
      Navigator.push(c, CupertinoPageRoute(builder: (c) {
        return LangChangeSignUp();
      }));
      await firestore
          .collection('Users')
          .doc(currentUser.uid)
          .update({'isNew': false});
    }
  }

  void initState() {
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => functionTrigger(context));
  }

  double deviceHeight;
  double deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: IndexedStack(
          children: [
            StitchingScreen(),
            ProfileScreen(),
          ],
          index: currentIndex,
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [Feather.home, Feather.user],
          activeIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          activeColor: Colors.blueAccent,
          height: 45,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          splashColor: Colors.grey[100],
        ));
  }
}
