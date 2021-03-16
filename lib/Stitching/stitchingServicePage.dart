import 'package:bellbirdmvp/Stitching/planSelect.dart';
import 'package:bellbirdmvp/models/constants.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StitchingServicePage extends StatefulWidget {
  @override
  _StitchingServicePageState createState() => _StitchingServicePageState();
}

class _StitchingServicePageState extends State<StitchingServicePage> {
  final List finaladditionalInfoNt = [
    'Neck',
    'Sleeves',
    'daman',
  ];
  final List finaladditionalInfoND = [
    'Round',
    'Plain',
    'Simple',
  ];
  GlobalKey<FormState> formkey;
  _StitchingServicePageState() {
    formkey = GlobalKey<FormState>();
  }
  bool selected = false;
  int price = 170;
  List<String> sleeveLength = [
    'Full Length',
    'Half Length',
    '3/4 Length',
  ];
  List<String> bottomType = [
    'Salwar',
    'Patiala Salwar',
    'Plazo',
    'Loose Plazo',
    'Pants',
    'Flapper'
  ];
  List<String> neckType = ['Round', 'Square', 'Boat Shape', 'V Shape'];
  List<String> sleeveType = [
    'Umbrella Sleeves',
    'Balloon Sleeves',
    'Front Cut Sleeves'
  ];

  List<String> damanType = ['A Shape', 'Straight'];
  String xsleeveLength;
  String xbottomType;
  String xneckType;
  String xsleeveType;
  String xdamanType;
  double deviceHeight;
  double deviceWidth;
  Widget messageField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.04, vertical: deviceHeight * 0.03),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          child: Form(
            key: formkey,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Total: Rs ' + price.toString(),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(
                        kSpacingUnit * 1.7,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    child: FlatButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                        child: Text(
                          'Book',
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
          height: deviceHeight * .08,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }

  serviceBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: Colors.white,
              child: Image.asset(
                'assets/suit.png',
                fit: BoxFit.contain,
              )),
          ListTile(
            leading: CircularCheckBox(
                value: this.selected,
                checkColor: Colors.white,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.blueAccent,
                disabledColor: Colors.grey,
                onChanged: (val) => this.setState(() {
                      if (selected == false) {
                        price += 20;
                      } else {
                        price -= 20;
                      }
                      this.selected = !this.selected;
                    })),
            title: Text("Astar Stitching?",
                style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
            onTap: () => this.setState(() {
              if (selected == false) {
                price += 20;
              } else {
                price -= 20;
              }
              this.selected = !this.selected;
            }),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 2),
            child: Text("Sleeve\'s Length",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 6, top: 0, bottom: 0),
                child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    hint: Text(
                      'Select Sleeve\'s Length',
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    value: xsleeveLength,
                    items: sleeveLength.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        xsleeveLength = value;
                      });
                    }),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 2),
            child: Text("Sleeve Type",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 6, top: 0, bottom: 0),
                child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    hint: Text(
                      'Select sleeve Type',
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    value: xsleeveType,
                    items: sleeveType.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        xsleeveType = value;
                      });
                    }),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 2),
            child: Text("Bottom Type",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 6, top: 0, bottom: 0),
                child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    hint: Text(
                      'Select Bottom Type',
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    value: xbottomType,
                    items: bottomType.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        xbottomType = value;
                      });
                    }),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 2),
            child: Text("Neck Type",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 6, top: 0, bottom: 0),
                child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    hint: Text(
                      'Select Neck Type',
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    value: xneckType,
                    items: neckType.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        xneckType = value;
                      });
                    }),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 2),
            child: Text("Daman Type",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 6, top: 0, bottom: 0),
                child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    hint: Text(
                      'Select Daman Type',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    value: xdamanType,
                    items: damanType.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        xdamanType = value;
                      });
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 20,
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
                      color: Colors.grey[200]),
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
                      color: Colors.grey[200]),
                  child: Image.asset('assets/A4.png'),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(
            'Plain Suit',
            style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              serviceBody(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return PlanSelect();
                        }));
                      },
                      child: Text(
                        'Next',
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 20),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
