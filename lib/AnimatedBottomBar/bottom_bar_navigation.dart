import 'package:bellbirdmvp/Providers/user.dart';
import 'package:bellbirdmvp/Tabs-screens/UserP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class BottomBarNavigationPatternExample extends StatefulWidget {
  @override
  _BottomBarNavigationPatternExampleState createState() =>
      _BottomBarNavigationPatternExampleState();
}

class _BottomBarNavigationPatternExampleState
    extends State<BottomBarNavigationPatternExample> {
  int selectedBarIndex = 0;
  int ygroup;

  List<Widget> topBar = [
    null,
    null,
    CupertinoNavigationBar(
      middle: Text(
        "PROFILE",
        style: TextStyle(
            fontFamily: 'Graphik',
            fontWeight: FontWeight.w800,
            fontSize: 17.0,
            color: Colors.grey[1000]),
      ),
      backgroundColor: Colors.transparent,
    )
  ];

  PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  void didChangeDependencies() {
    Provider.of<Userdata>(context).getUser();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onTap(int index) {
    pageController.jumpToPage(index);
  }

  onPageChanged(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String userId = Provider.of<Userdata>(context).userId;
    final String userName = Provider.of<Userdata>(context).userName;
    final String userImage = Provider.of<Userdata>(context).userImage;

    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[ProfileScreen()],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [Feather.home, Feather.search, Feather.user],
          activeIndex: currentIndex,
          onTap: (index) => onTap(index),
          activeColor: Colors.blueAccent,
          height: 45,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          splashColor: Colors.grey[100],
        ));
  }
}
