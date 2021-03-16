import 'package:bellbirdmvp/Stitching/Summary_SS.dart';
import 'package:bellbirdmvp/Stitching/pakSummary.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PlanSelect_Pak extends StatefulWidget {
  final String designImageUrl;
  final String fabricImageUrl;
  final bool lasesSelect;
  final bool pearlsSelect;
  final String serviceType;
  final List<Map> notes;
  final String designImage;
  final String fabricImage;
  final bool topAstar;
  final int basicPrice;
  final String f1b;
  final String f1pdays;
  final String f1bdays;
  final String patchesNumber;
  final String f2b;
  final String f1p;
  final String f2p;
  final int astarPrice;
  final int premiumPrice;

  final bool bottomAstar;

  PlanSelect_Pak(
      {this.designImageUrl,
      this.basicPrice,
      this.premiumPrice,
      this.f1b,
      this.f1p,
      this.patchesNumber,
      this.f1bdays,
      this.f1pdays,
      this.f2b,
      this.astarPrice,
      this.f2p,
      this.serviceType,
      this.topAstar,
      this.bottomAstar,
      this.designImage,
      this.fabricImage,
      this.notes,
      this.fabricImageUrl,
      this.lasesSelect,
      this.pearlsSelect});
  @override
  _PlanSelect_PakState createState() => _PlanSelect_PakState();
}

class _PlanSelect_PakState extends State<PlanSelect_Pak> {
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
  String f1;
  String f2;
  String deliveryDays;

  void initState() {
    priceLogic();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    plan = DemoLocalizations.of(context).getTranslatedValue("premium");

    super.didChangeDependencies();
  }

  priceLogic() {
    basicPrice = widget.basicPrice;

    premiumPrice = widget.premiumPrice;
    widget.topAstar == true
        ? premiumPrice += widget.astarPrice
        : premiumPrice += 0;
    widget.topAstar == true ? basicPrice += widget.astarPrice : basicPrice += 0;
    widget.bottomAstar == true
        ? premiumPrice += widget.astarPrice
        : premiumPrice += 0;
    widget.bottomAstar == true
        ? basicPrice += widget.astarPrice
        : basicPrice += 0;
    deliveryDays = widget.f1pdays;

    price = premiumPrice;
    f1 = widget.f1p;
    f2 = widget.f2p;
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
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Text(
              DemoLocalizations.of(context).getTranslatedValue("select_plan"),
              style: TextStyle(
                  fontFamily: 'CodeProlight',
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
                      color = Colors.blue;
                      plan = DemoLocalizations.of(context)
                          .getTranslatedValue("basic");
                      deliveryDays = widget.f1bdays;

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
                      color = Colors.green;
                      plan = DemoLocalizations.of(context)
                          .getTranslatedValue("premium");
                      f1 = widget.f1p;
                      deliveryDays = widget.f1pdays;

                      f2 = widget.f2p;
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
                    fontSize: 26)),
          ),
        ),
        SizedBox(height: 60),
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
                return PakistanSummary(
                  notesData: widget.notes,
                  plan: plan,
                  price: price,
                  patchesNumber: widget.patchesNumber,
                  designImage: widget.designImageUrl,
                  fabricImage: widget.fabricImageUrl,
                  deliveryDays: deliveryDays,
                  topAstar: widget.topAstar,
                  bottomAstar: widget.bottomAstar,
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
            alignment: Alignment.bottomCenter,
            child: FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return PakistanSummary(
                        notesData: widget.notes,
                        plan: plan,
                        price: price,
                        designImage: widget.designImageUrl,
                        fabricImage: widget.fabricImageUrl,
                        topAstar: widget.topAstar,
                        deliveryDays: deliveryDays,
                        patchesNumber: widget.patchesNumber,
                        bottomAstar: widget.bottomAstar);
                  }));
                },
                child: Text(
                  DemoLocalizations.of(context).getTranslatedValue("next"),
                  style: TextStyle(
                      fontFamily: 'CodeProlight',
                      fontWeight: FontWeight.w800,
                      color: color,
                      fontSize: 20),
                )),
          )
        ],
      )),
    );
  }
}
