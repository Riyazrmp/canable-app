import 'package:bellbirdmvp/AnimatedBottomBar/profile_list_item.dart';
import 'package:bellbirdmvp/Providers/auth2.dart';
import 'package:bellbirdmvp/Screens/languageChange.dart';
import 'package:bellbirdmvp/Screens/personal_info.dart';
import 'package:bellbirdmvp/Stitching/measurementSwitcher.dart';
import 'package:bellbirdmvp/Stitching/orders_stitching.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:bellbirdmvp/models/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

auth.User currentUser;

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
    });
    getcode();

    super.initState();
  }

  String code;
  getcode() async {
    DocumentSnapshot snapshot =
        await firestore.collection('Users').doc(currentUser.uid).get();
    setState(() {
      code = snapshot.data()['referralCode'];
    });
  }

  Locale myLocale;

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    final userID = currentUser.uid;
    final userName = currentUser.displayName;
    final userImage = currentUser.photoURL;

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          code != null
              ? Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                      onPressed: () async {
                        final Size size = MediaQuery.of(context).size;

                        await Share.share(
                            'Premium women stitching at the push of a button.\nDownload the Canable App\nhttps://play.google.com/store/apps/details?id=com.change.canable\nUse my code $code',
                            sharePositionOrigin: Rect.fromLTWH(
                                0, 0, size.width, size.height / 2));
                      },
                      child: Icon(
                        CupertinoIcons.share,
                        color: Colors.black,
                      )),
                )
              : CupertinoActivityIndicator(),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundImage: NetworkImage(userImage)),
          ),
          SizedBox(height: 10),
          Text(
            userName,
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit * 2.0),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        profileInfo,
      ],
    );
    final auth = Provider.of<Auth2>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            header,
            ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return StitchingOrders();
                    }));
                  },
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.opencart,
                    text: DemoLocalizations.of(context)
                        .getTranslatedValue("Orders"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return LanguageChange();
                    }));
                  },
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.language,
                    text: DemoLocalizations.of(context)
                        .getTranslatedValue("Language"),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context,
                //         CupertinoPageRoute(builder: (context) {
                //       return MeasurementSwitcherSS();
                //     }));
                //   },
                //   child: ProfileListItem(
                //     icon: LineAwesomeIcons.language,
                //     text: 'Measurement',
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return PersonalInfo(userID);
                    }));
                  },
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.info,
                    text: DemoLocalizations.of(context)
                        .getTranslatedValue("Personal Info"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('Logout?',
                                style: TextStyle(
                                    fontFamily: 'CodeProlight',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('YES',
                                    style: TextStyle(
                                      fontFamily: 'Graphik',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0,
                                    )),
                                onPressed: () {
                                  setState(() {
                                    auth.handleSign();
                                    Navigator.pop(context);
                                  });
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.sign_out,
                    text: DemoLocalizations.of(context)
                        .getTranslatedValue("Logout"),
                    hasNavigation: false,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 10, left: 9, right: 9),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(60)),
                  color: Colors.blue.withOpacity(0.04),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, left: 0, right: 9),
                          child: Text(
                              DemoLocalizations.of(context)
                                  .getTranslatedValue("discount_coupon_50"),
                              style: TextStyle(
                                  fontFamily: 'CodePro',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Align(
                      alignment: getalignment(myLocale.languageCode),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                            DemoLocalizations.of(context)
                                .getTranslatedValue("invite"),
                            style: TextStyle(
                                fontFamily: 'CodeProlight',
                                fontWeight: FontWeight.w800,
                                fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: getalignment(myLocale.languageCode),
                              child: Text(
                                  DemoLocalizations.of(context)
                                      .getTranslatedValue("inviteText"),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'CodeProlight',
                                      fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment:
                                      getalignment(myLocale.languageCode),
                                  child: Text(
                                      DemoLocalizations.of(context)
                                          .getTranslatedValue("share_code"),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'CodeProlight',
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                            code != null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: getalignment(
                                              myLocale.languageCode),
                                          child: Text(code,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'CodeProlight',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: IconButton(
                                            icon: Icon(
                                              CupertinoIcons.share,
                                              color: Colors.black,
                                            ),
                                            onPressed: () async {
                                              final Size size =
                                                  MediaQuery.of(context).size;

                                              await Share.share(
                                                  'Premium women stitching at the push of a button\nDownload the Canable App\nhttps://play.google.com/store/apps/details?id=com.change.canable\nUse my code $code',
                                                  sharePositionOrigin:
                                                      Rect.fromLTWH(
                                                          0,
                                                          0,
                                                          size.width,
                                                          size.height / 2));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : CupertinoActivityIndicator(),
                          ],
                        ),
                        Container(
                            height: 120,
                            child: ClipRRect(
                                child: Image.asset('assets/referralImage.png')))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
