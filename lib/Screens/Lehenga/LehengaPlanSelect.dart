import 'package:bellbirdmvp/Screens/Frock/FrockSummary.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaSummary.dart';
import 'package:bellbirdmvp/Screens/Lehenga/LehengaSummary.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LehengaPlanSelect extends StatefulWidget {
  final int sleevesPrice;
  final String measurementTopDocId;
  final String sleeveAstar;
  final String measurementImageTopUrl;
  final String measurementImageBottomUrl;
  final String topType;
  final String measurementBottomDocId;
  final int neckPrice;
  final int damanPrice;
  final int bottomPrice;
  final String flippedSleeveD;
  final String neckD;
  final String sleevesLengthD;
  final int neckPatchPrice;
  final bool isMeasurementSelected;
  final int damanPatchPrice;
  final bool neckPatchBool;
  final bool damanPatchBool;
  final bool sleevesPatchBool;
  final bool bottomPatchBool;
  final int sleevesPatchPrice;
  final int bottomPatchPrice;
  final int damanHeight;
  final int neckHeight;
  final int sleeveTopPadding;
  final int basicPrice;
  final int premiumPrice;
  final String f1pdays;
  final int deliveryCharge;
  final String f1bdays;
  final String sleevesD;
  final String damanD;
  final String neckN;
  final String sleevesLengthN;
  final bool topAstar;
  final bool bottomAstar;
  final String sleevesN;
  final String damanN;
  final String bottomN;
  final String bottomD;
  final String fabricImage;
  final List<Map> notesData;
  final String f1b;
  final String f2b;
  final String f1p;
  final String f2p;
  final String f3b;
  final String f3p;
  final int astarPrice;
  LehengaPlanSelect(
      {this.sleeveTopPadding,
      this.neckHeight,
      this.f3b,
      this.f3p,
      this.measurementImageTopUrl,
      this.measurementImageBottomUrl,
      this.deliveryCharge,
      this.measurementTopDocId,
      this.topType,
      this.measurementBottomDocId,
      this.sleeveAstar,
      this.topAstar,
      this.neckPatchBool,
      this.sleevesPatchBool,
      this.damanPatchBool,
      this.bottomPatchBool,
      this.bottomPatchPrice,
      this.neckPatchPrice,
      this.isMeasurementSelected,
      this.sleevesPatchPrice,
      this.damanPatchPrice,
      this.basicPrice,
      this.premiumPrice,
      this.f1b,
      this.astarPrice,
      this.f1p,
      this.f1bdays,
      this.f1pdays,
      this.f2b,
      this.f2p,
      this.bottomAstar,
      this.fabricImage,
      this.notesData,
      this.damanHeight,
      this.bottomPrice,
      this.damanPrice,
      this.flippedSleeveD,
      this.neckN,
      this.bottomN,
      this.sleevesLengthN,
      this.sleevesN,
      this.damanN,
      this.neckPrice,
      this.sleevesPrice,
      this.bottomD,
      this.damanD,
      this.neckD,
      this.sleevesD,
      this.sleevesLengthD});
  @override
  _LehengaPlanSelectState createState() => _LehengaPlanSelectState();
}

class _LehengaPlanSelectState extends State<LehengaPlanSelect> {
  bool isPremium = true;
  int price = 0;
  int basicPrice = 0;
  int premiumPrice = 0;
  Color color = Colors.green;
  String plan = 'Premium';
  String f1;
  String deliveryDays;
  String f2;
  int dPrice;
  String f3;
  void initState() {
    priceLogic(context);
    super.initState();
  }

  priceLogic(context1) {
    setState(() {
      basicPrice = widget.basicPrice +
          widget.bottomPrice +
          widget.damanPrice +
          widget.sleevesPrice +
          widget.neckPrice;
      premiumPrice = widget.premiumPrice +
          widget.bottomPrice +
          widget.damanPrice +
          widget.sleevesPrice +
          widget.neckPrice;
      widget.topAstar == true
          ? premiumPrice += widget.astarPrice
          : premiumPrice += 0;
      widget.topAstar == true
          ? basicPrice += widget.astarPrice
          : basicPrice += 0;
      widget.bottomAstar == true
          ? premiumPrice += widget.astarPrice
          : premiumPrice += 0;
      widget.bottomAstar == true
          ? basicPrice += widget.astarPrice
          : basicPrice += 0;
      widget.neckPatchBool == true
          ? basicPrice += widget.neckPatchPrice
          : basicPrice += 0;
      widget.neckPatchBool == true
          ? premiumPrice += widget.neckPatchPrice
          : premiumPrice += 0;
      widget.sleevesPatchBool == true
          ? basicPrice += widget.sleevesPatchPrice
          : basicPrice += 0;
      widget.sleevesPatchBool == true
          ? premiumPrice += widget.sleevesPatchPrice
          : premiumPrice += 0;
      widget.damanPatchBool == true
          ? basicPrice += widget.damanPatchPrice
          : basicPrice += 0;
      widget.damanPatchBool == true
          ? premiumPrice += widget.damanPatchPrice
          : premiumPrice += 0;
      widget.bottomPatchBool == true
          ? basicPrice += widget.bottomPatchPrice
          : basicPrice += 0;
      widget.bottomPatchBool == true
          ? premiumPrice += widget.bottomPatchPrice
          : premiumPrice += 0;
      price = basicPrice;
      dPrice = basicPrice - widget.deliveryCharge;
      deliveryDays = widget.f1bdays;
      plan = 'basic';
      color = Colors.blue;
      f1 = widget.f1b;
      f2 = widget.f2b;
      f3 = widget.f3b;
      isPremium = false;
    });
  }

  @override
  void didChangeDependencies() {
    plan = DemoLocalizations.of(context).getTranslatedValue("basic");

    super.didChangeDependencies();
  }

  infoList() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: getalignment(myLocale.languageCode),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 15),
            child: Text(
              DemoLocalizations.of(context).getTranslatedValue("select_plan"),
              style: TextStyle(
                  fontFamily: 'CodePro',
                  fontWeight: FontWeight.w800,
                  fontSize: 38),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPremium = false;
                      price = basicPrice;
                      dPrice = basicPrice - widget.deliveryCharge;
                      color = Colors.blue;
                      plan = DemoLocalizations.of(context)
                          .getTranslatedValue("basic");
                      deliveryDays = widget.f1bdays;
                      f3 = widget.f3b;
                      f1 = widget.f1b;
                      f2 = widget.f2b;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 4),
                    child: Material(
                      borderRadius: BorderRadius.circular(11.0),
                      elevation: 3,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4),
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
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 8),
                                  child: Text(
                                      DemoLocalizations.of(context)
                                          .getTranslatedValue("basic"),
                                      style: TextStyle(
                                          fontFamily: 'CodeProlight',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                )
                              ],
                            ),
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
                      dPrice = premiumPrice;
                      color = Colors.green;
                      plan = DemoLocalizations.of(context)
                          .getTranslatedValue("premium");
                      deliveryDays = widget.f1pdays;

                      f1 = widget.f1p;
                      f2 = widget.f2p;
                      f3 = widget.f3p;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(11.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4),
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
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 8),
                                  child: Text(
                                      DemoLocalizations.of(context)
                                          .getTranslatedValue("premium"),
                                      style: TextStyle(
                                          fontFamily: 'CodeProlight',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('\u{20B9} ' + price.toString(),
                style: TextStyle(
                    fontFamily: 'CodeProlight',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28)),
          ),
        ),
        SizedBox(height: 60),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(plan,
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 37)),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(f3,
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              color: Colors.white,
                              fontSize: 24)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(f1,
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              color: Colors.white,
                              fontSize: 24)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(f2,
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              color: Colors.white,
                              fontSize: 24)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //         child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 10.0, right: 5, top: 5, bottom: 5),
                  //       child: Container(
                  //         height: 100,
                  //         padding: EdgeInsets.only(top: 3),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.white,
                  //         ),
                  //         child: Image.asset('assets/A1.png'),
                  //       ),
                  //     )),
                  //     Expanded(
                  //         child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 5.0, right: 10, top: 5, bottom: 5),
                  //       child: Container(
                  //         height: 100,
                  //         padding: EdgeInsets.only(bottom: 5),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.white,
                  //         ),
                  //         child: Image.asset('assets/A4.png'),
                  //       ),
                  //     )),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Locale myLocale;
  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        trailing: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Text(
              DemoLocalizations.of(context).getTranslatedValue("next"),
              style: TextStyle(
                  fontFamily: 'CodePro',
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return LehengaSummary(
                  bottomPrice: widget.bottomPrice,
                  sleevesAstar: widget.sleeveAstar,
                  bottomN: widget.bottomN,
                  topType: widget.topType,
                  damanN: widget.damanN,
                  isMeasurementSelected: widget.isMeasurementSelected,
                  measurementBottomDocId: widget.measurementBottomDocId,
                  measurementTopDocId: widget.measurementTopDocId,
                  measurementImageBottomUrl: widget.measurementImageBottomUrl,
                  measurementImageTopUrl: widget.measurementImageTopUrl,
                  neckN: widget.neckN,
                  sleevesLengthN: widget.sleevesLengthN,
                  fabricImage: widget.fabricImage,
                  notesData: widget.notesData,
                  sleevesN: widget.sleevesN,
                  damanPrice: widget.damanPrice,
                  neckPatchBool: widget.neckPatchBool,
                  sleevesPatchBool: widget.sleevesPatchBool,
                  damanPatchBool: widget.damanPatchBool,
                  bottomPatchBool: widget.bottomPatchBool,
                  neckPrice: widget.neckPrice,
                  sleevesPrice: widget.sleevesPrice,
                  bottomD: widget.bottomD,
                  damanD: widget.damanD,
                  neckD: widget.neckD,
                  deliveryDays: deliveryDays,
                  sleevesD: widget.sleevesD,
                  damanHeight: widget.damanHeight,
                  neckHeight: widget.neckHeight,
                  sleeveTopPadding: widget.sleeveTopPadding,
                  flippedSleeveD: widget.flippedSleeveD,
                  sleevesLengthD: widget.sleevesLengthD,
                  topAstar: widget.topAstar,
                  bottomAstar: widget.bottomAstar,
                  price: price,
                  plan: plan,
                );
              }));
            },
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          infoList(),
          Align(
            alignment: getalignmentStackButtons(myLocale.languageCode),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 20, left: 20),
              child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return LehengaSummary(
                        bottomPrice: widget.bottomPrice,
                        sleevesAstar: widget.sleeveAstar,
                        bottomN: widget.bottomN,
                        topType: widget.topType,
                        damanN: widget.damanN,
                        isMeasurementSelected: widget.isMeasurementSelected,
                        measurementBottomDocId: widget.measurementBottomDocId,
                        measurementTopDocId: widget.measurementTopDocId,
                        measurementImageBottomUrl:
                            widget.measurementImageBottomUrl,
                        measurementImageTopUrl: widget.measurementImageTopUrl,
                        neckN: widget.neckN,
                        sleevesLengthN: widget.sleevesLengthN,
                        fabricImage: widget.fabricImage,
                        notesData: widget.notesData,
                        sleevesN: widget.sleevesN,
                        damanPrice: widget.damanPrice,
                        neckPatchBool: widget.neckPatchBool,
                        sleevesPatchBool: widget.sleevesPatchBool,
                        damanPatchBool: widget.damanPatchBool,
                        bottomPatchBool: widget.bottomPatchBool,
                        neckPrice: widget.neckPrice,
                        sleevesPrice: widget.sleevesPrice,
                        bottomD: widget.bottomD,
                        damanD: widget.damanD,
                        neckD: widget.neckD,
                        deliveryDays: deliveryDays,
                        sleevesD: widget.sleevesD,
                        damanHeight: widget.damanHeight,
                        neckHeight: widget.neckHeight,
                        sleeveTopPadding: widget.sleeveTopPadding,
                        flippedSleeveD: widget.flippedSleeveD,
                        sleevesLengthD: widget.sleevesLengthD,
                        topAstar: widget.topAstar,
                        bottomAstar: widget.bottomAstar,
                        price: price,
                        plan: plan,
                      );
                    }));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue("next"),
                          style: TextStyle(
                              fontFamily: 'CodeProlight',
                              fontWeight: FontWeight.w800,
                              color: color,
                              fontSize: 20),
                        ),
                      ),
                      Icon(getarrow(myLocale.languageCode),
                          size: 22, color: color)
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}
