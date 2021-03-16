import 'package:bellbirdmvp/Tabs-screens/UserP.dart';
import 'package:bellbirdmvp/models/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  _ChatScreenState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }
  auth.User _user;
  getUserDetails() async {
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    _user = user;
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

//  height: 896, width: 414,
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Connect",
                  style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(kSpacingUnit * 3.9),
                          fontWeight: FontWeight.bold))),
              Text(
                _user.email,
                style: GoogleFonts.quicksand(fontSize: 14),
              )
            ],
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(
                Feather.message_square,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Feather.user,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        ProfileScreen(),
      ]),
    );
  }
}
