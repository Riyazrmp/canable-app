import 'package:bellbirdmvp/Stitching/ApprovedOrders.dart';
import 'package:bellbirdmvp/Stitching/DeliveredOrders.dart';
import 'package:bellbirdmvp/Stitching/pendingOrdrers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StitchingOrders extends StatefulWidget {
  @override
  _StitchingOrdersState createState() => _StitchingOrdersState();
}

class _StitchingOrdersState extends State<StitchingOrders> {
  int selectedIndex = 1;

  List<Widget> childWidgets;

  Widget getChildWidget() => childWidgets[selectedIndex];
  void loadChildWidgets() {
    childWidgets = [PendingOrders(), ApprovedOrders(), DeliveredOrders()];
  }

  Map<int, Widget> map = new Map();
  void loadCupertinoTabs() {
    List tempTabs = ['Pending', 'Approved', 'Delivered'];

    map = new Map();
    for (int i = 0; i < 3; i++) {
      map.putIfAbsent(
          i,
          () => Text(
                tempTabs[i],
                style: TextStyle(
                    fontFamily: 'CodeProlight',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ));
    }
  }

  @override
  void initState() {
    loadChildWidgets();
    loadCupertinoTabs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text(
          'My Orders',
          style: TextStyle(
              fontFamily: 'CodePro', fontWeight: FontWeight.w800, fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CupertinoSlidingSegmentedControl(
                  children: map,
                  onValueChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  groupValue: selectedIndex,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              getChildWidget()
            ],
          ),
        ),
      ),
    );
  }
}
