import 'package:bellbirdmvp/Screens/Frock/FrockPlanSelect.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaPlanSelect.dart';
import 'package:bellbirdmvp/Screens/blouse/blousePlanSelect.dart';
import 'package:bellbirdmvp/Stitching/PlanSelect_0.dart';
import 'package:bellbirdmvp/Stitching/measurementInfoTop.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class MeasurementSwitcherAlternation extends StatefulWidget {
  final int backPrice;
  final int neckPrice;

  final int cutPrice;
  final bool isMeasurementProvider;
  final String neckD;

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
  MeasurementSwitcherAlternation(
      {this.sleeveTopPadding,
      this.neckHeight,
      this.f3b,
      this.f3p,
      this.deliveryCharge,
      this.topAstar,
      this.isMeasurementProvider,
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
      this.backD});
  @override
  _MeasurementSwitcherAlternationState createState() =>
      _MeasurementSwitcherAlternationState();
}

class _MeasurementSwitcherAlternationState
    extends State<MeasurementSwitcherAlternation> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot topMeasurementF;
  QuerySnapshot bottomMeasurementF;
  String measurementImageTopUrl;
  String measurementImageBottomUrl;
  var user = auth.FirebaseAuth.instance.currentUser;
  var docIdTop;
  var docIdBottom;
  getData() async {
    var user = auth.FirebaseAuth.instance.currentUser;

    QuerySnapshot topMeasurement = await firestore
        .collection('measurements')
        .doc(user.uid)
        .collection('top')
        .get();
    setState(() {
      topMeasurementF = topMeasurement;
      measurementImageTopUrl = topMeasurementF.docs[0].data()['image'];
      docIdTop = topMeasurementF.docs[0].id;
    });
    QuerySnapshot bottomMeasurement = await firestore
        .collection('measurements')
        .doc(user.uid)
        .collection('bottom')
        .get();
    setState(() {
      bottomMeasurementF = bottomMeasurement;
      measurementImageBottomUrl = bottomMeasurementF.docs[0].data()['image'];

      docIdBottom = bottomMeasurementF.docs[0].id;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
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
              return BlousePlanSelect(
                cutPrice: widget.cutPrice,
                measurementImageTopUrl: measurementImageTopUrl,
                measurementImageBottomUrl: measurementImageBottomUrl,
                basicPrice: widget.basicPrice,
                premiumPrice: widget.premiumPrice,
                f1b: widget.f1b,
                f1p: widget.f1p,
                f2b: widget.f2b,
                isMeasurementSelected: true,
                f2p: widget.f2p,
                f3b: widget.f3b,
                measurementTopDocId: docIdTop,
                measurementBottomDocId: docIdBottom,
                f3p: widget.f3p,
                f1bdays: widget.f1bdays,
                f1pdays: widget.f1pdays,
                astarPrice: widget.astarPrice,
                neckPrice: widget.neckPrice,
                deliveryCharge: widget.deliveryCharge,
                backPrice: widget.backPrice,
                cutD: widget.cutD,
                neckD: widget.neckD,
                backD: widget.backD,
                cutHeight: widget.cutHeight,
                neckHeight: widget.neckHeight,
                sleeveTopPadding: widget.sleeveTopPadding,
                cutN: widget.cutN,
                topAstar: widget.topAstar,
                neckN: widget.neckN,
                backN: widget.backN,
                notesData: widget.notesData,
                fabricImage: widget.fabricImage,
              );
            }));
          },
        ),
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("measurements"),
          style: TextStyle(
              fontFamily: 'CodePro', fontWeight: FontWeight.w800, fontSize: 24),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: getalignment(myLocale.languageCode),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      DemoLocalizations.of(context).getTranslatedValue("top"),
                      style: TextStyle(
                          fontFamily: 'CodePro',
                          fontWeight: FontWeight.w800,
                          fontSize: 28),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return BlousePlanSelect(
                      cutPrice: widget.cutPrice,
                      measurementImageTopUrl: measurementImageTopUrl,
                      measurementImageBottomUrl: measurementImageBottomUrl,
                      basicPrice: widget.basicPrice,
                      premiumPrice: widget.premiumPrice,
                      f1b: widget.f1b,
                      f1p: widget.f1p,
                      f2b: widget.f2b,
                      isMeasurementSelected: false,
                      f2p: widget.f2p,
                      f3b: widget.f3b,
                      measurementTopDocId: docIdTop,
                      measurementBottomDocId: docIdBottom,
                      f3p: widget.f3p,
                      f1bdays: widget.f1bdays,
                      f1pdays: widget.f1pdays,
                      astarPrice: widget.astarPrice,
                      neckPrice: widget.neckPrice,
                      deliveryCharge: widget.deliveryCharge,
                      backPrice: widget.backPrice,
                      cutD: widget.cutD,
                      neckD: widget.neckD,
                      backD: widget.backD,
                      cutHeight: widget.cutHeight,
                      neckHeight: widget.neckHeight,
                      sleeveTopPadding: widget.sleeveTopPadding,
                      cutN: widget.cutN,
                      topAstar: widget.topAstar,
                      neckN: widget.neckN,
                      backN: widget.backN,
                      notesData: widget.notesData,
                      fabricImage: widget.fabricImage,
                    );
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withOpacity(.13),
                          blurRadius: 6,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Text('New Measurement',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'CodeProlight',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.5),
                              child: Icon(
                                CupertinoIcons.add_circled_solid,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          topMeasurementF != null
              ? Container(
                  height: 280,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: topMeasurementF.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              docIdTop = topMeasurementF.docs[index].id;
                              measurementImageTopUrl =
                                  topMeasurementF.docs[index].data()['image'];
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    docIdTop == topMeasurementF.docs[index].id
                                        ? Border(
                                            bottom: BorderSide(
                                              width: 5,
                                              color: Colors.blue,
                                            ),
                                            top: BorderSide(
                                                width: 5, color: Colors.blue),
                                            left: BorderSide(
                                                width: 5, color: Colors.blue),
                                            right: BorderSide(
                                                width: 5, color: Colors.blue))
                                        : Border(),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 250,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: topMeasurementF.docs[index]
                                            .data()['image'],
                                        placeholder: (context, url) => Container(
                                            height: 250,
                                            width: 100,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                )
              : CupertinoActivityIndicator(),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
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
                  return BlousePlanSelect(
                    cutPrice: widget.cutPrice,
                    measurementImageTopUrl: measurementImageTopUrl,
                    measurementImageBottomUrl: measurementImageBottomUrl,
                    basicPrice: widget.basicPrice,
                    premiumPrice: widget.premiumPrice,
                    f1b: widget.f1b,
                    f1p: widget.f1p,
                    f2b: widget.f2b,
                    isMeasurementSelected: true,
                    f2p: widget.f2p,
                    f3b: widget.f3b,
                    measurementTopDocId: docIdTop,
                    measurementBottomDocId: docIdBottom,
                    f3p: widget.f3p,
                    f1bdays: widget.f1bdays,
                    f1pdays: widget.f1pdays,
                    astarPrice: widget.astarPrice,
                    neckPrice: widget.neckPrice,
                    deliveryCharge: widget.deliveryCharge,
                    backPrice: widget.backPrice,
                    cutD: widget.cutD,
                    neckD: widget.neckD,
                    backD: widget.backD,
                    cutHeight: widget.cutHeight,
                    neckHeight: widget.neckHeight,
                    sleeveTopPadding: widget.sleeveTopPadding,
                    cutN: widget.cutN,
                    topAstar: widget.topAstar,
                    neckN: widget.neckN,
                    backN: widget.backN,
                    notesData: widget.notesData,
                    fabricImage: widget.fabricImage,
                  );
                }));
              },
            ),
          )
        ],
      ),
    );
  }
}
