import 'package:bellbirdmvp/Stitching/Summary_SS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanSelect extends StatefulWidget {
  final int sleevesPrice;
  final int neckPrice;
  final int sleevesLengthPrice;
  final int damanPrice;
  final int bottomPrice;
  final int astarPrice;
  PlanSelect(
      {this.astarPrice,
      this.bottomPrice,
      this.damanPrice,
      this.neckPrice,
      this.sleevesLengthPrice,
      this.sleevesPrice});
  @override
  _PlanSelectState createState() => _PlanSelectState();
}

class _PlanSelectState extends State<PlanSelect> {
  int sleevesPrice;
  int neckPrice;
  int sleevesLengthPrice;
  int damanPrice;
  int bottomPrice;
  int astarPrice;

  bool isPremium = true;
  int price = 0;
  int basicPrice = 0;
  int premiumPrice = 0;
  Color color = Colors.green;
  String plan = 'Premium';

  void initState() {
    priceLogic();
    super.initState();
  }

  priceLogic() {
    basicPrice = 200 +
        widget.sleevesLengthPrice +
        widget.astarPrice +
        widget.bottomPrice +
        widget.damanPrice +
        widget.sleevesPrice +
        widget.neckPrice;
    premiumPrice = 220 +
        widget.sleevesLengthPrice +
        widget.astarPrice +
        widget.bottomPrice +
        widget.damanPrice +
        widget.sleevesPrice +
        widget.neckPrice;
    price = basicPrice;
    plan = 'Basic';
  }

  infoList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Select a plan",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold))),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPremium = false;
                    price = basicPrice;
                    color = Colors.blue;
                    plan = 'Basic';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4),
                  child: Material(
                    borderRadius: BorderRadius.circular(11.0),
                    elevation: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(100),
                              child: Icon(
                                FontAwesome.circle,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text('Basic',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPremium = true;
                    price = premiumPrice;
                    color = Colors.green;
                    plan = 'Premium';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 8),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(11.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(children: [
                              Material(
                                borderRadius: BorderRadius.circular(100),
                                child: Icon(
                                  FontAwesome.circle,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(100),
                                  elevation: 1,
                                  child: Icon(
                                    FontAwesome.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(
                              width: 7,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text('Premium',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text('Rs ' + price.toString(),
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26)),
          ),
        ),
        SizedBox(height: 15),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(plan,
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30)),
                SizedBox(
                  height: 35,
                ),
                Text('4 days delivery time',
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                Text('6 month warranty',
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 5, top: 5, bottom: 5),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/A1.png'),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 10, top: 5, bottom: 5),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/A4.png'),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          infoList(),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return Summary_SS();
                  }));
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w900, color: color, fontSize: 20),
                )),
          )
        ],
      )),
    );
  }
}
