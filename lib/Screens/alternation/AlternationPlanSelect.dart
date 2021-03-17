import 'package:bellbirdmvp/Screens/Frock/FrockSummary.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaSummary.dart';
import 'package:bellbirdmvp/Screens/blouse/blouseSummary.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AlternationPlanSelect extends StatefulWidget {
  final int backPrice;
  final String measurementTopDocId;
  final String measurementImageTopUrl;
  final String measurementImageBottomUrl;
  final String measurementBottomDocId;
  final int neckPrice;
  final int cutPrice;
  final String neckD;
  final bool isMeasurementSelected;

  final int cutHeight;
  final int neckHeight;
  final int sleeveTopPadding;
  final int basicPrice;
  final int premiumPrice;
  final String f1pdays;
  final int deliveryCharge;
  final String f1bdays;
  final String backD;
  final String cutD;
  final String neckN;
  final bool topAstar;
  final String backN;
  final String cutN;

  final String fabricImage;
  final List<Map> notesData;
  final String f1b;
  final String f2b;
  final String f1p;
  final String f2p;
  final String f3b;
  final String f3p;
  final int astarPrice;
  AlternationPlanSelect({
    this.sleeveTopPadding,
    this.neckHeight,
    this.f3b,
    this.f3p,
    this.measurementImageTopUrl,
    this.measurementImageBottomUrl,
    this.deliveryCharge,
    this.measurementTopDocId,
    this.measurementBottomDocId,
    this.topAstar,
    this.isMeasurementSelected,
    this.basicPrice,
    this.premiumPrice,
    this.f1b,
    this.astarPrice,
    this.f1p,
    this.f1bdays,
    this.f1pdays,
    this.f2b,
    this.f2p,
    this.fabricImage,
    this.notesData,
    this.cutHeight,
    this.cutPrice,
    this.neckN,
    this.backN,
    this.cutN,
    this.neckPrice,
    this.backPrice,
    this.cutD,
    this.neckD,
    this.backD,
  });
  @override
  _AlternationPlanSelectState createState() => _AlternationPlanSelectState();
}

class _AlternationPlanSelectState extends State<AlternationPlanSelect> {
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
          widget.cutPrice +
          widget.backPrice +
          widget.neckPrice;
      premiumPrice = widget.premiumPrice +
          widget.cutPrice +
          widget.backPrice +
          widget.neckPrice;
      widget.topAstar == true
          ? premiumPrice += widget.astarPrice
          : premiumPrice += 0;
      widget.topAstar == true
          ? basicPrice += widget.astarPrice
          : basicPrice += 0;
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
                return BlouseSummary(
                  cutN: widget.cutN,
                  isMeasurementSelected: widget.isMeasurementSelected,
                  measurementBottomDocId: widget.measurementBottomDocId,
                  measurementTopDocId: widget.measurementTopDocId,
                  measurementImageBottomUrl: widget.measurementImageBottomUrl,
                  measurementImageTopUrl: widget.measurementImageTopUrl,
                  neckN: widget.neckN,
                  fabricImage: widget.fabricImage,
                  notesData: widget.notesData,
                  backN: widget.backN,
                  cutPrice: widget.cutPrice,
                  neckPrice: widget.neckPrice,
                  backPrice: widget.backPrice,
                  cutD: widget.cutD,
                  neckD: widget.neckD,
                  deliveryDays: deliveryDays,
                  backD: widget.backD,
                  cutHeight: widget.cutHeight,
                  neckHeight: widget.neckHeight,
                  sleeveTopPadding: widget.sleeveTopPadding,
                  topAstar: widget.topAstar,
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
                      return BlouseSummary(
                        cutN: widget.cutN,
                        isMeasurementSelected: widget.isMeasurementSelected,
                        measurementBottomDocId: widget.measurementBottomDocId,
                        measurementTopDocId: widget.measurementTopDocId,
                        measurementImageBottomUrl:
                            widget.measurementImageBottomUrl,
                        measurementImageTopUrl: widget.measurementImageTopUrl,
                        neckN: widget.neckN,
                        fabricImage: widget.fabricImage,
                        notesData: widget.notesData,
                        backN: widget.backN,
                        cutPrice: widget.cutPrice,
                        neckPrice: widget.neckPrice,
                        backPrice: widget.backPrice,
                        cutD: widget.cutD,
                        neckD: widget.neckD,
                        deliveryDays: deliveryDays,
                        backD: widget.backD,
                        cutHeight: widget.cutHeight,
                        neckHeight: widget.neckHeight,
                        sleeveTopPadding: widget.sleeveTopPadding,
                        topAstar: widget.topAstar,
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
