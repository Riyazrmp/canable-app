import 'package:bellbirdmvp/Screens/Frock/FrockPlanSelect.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaPlanSelect.dart';
import 'package:bellbirdmvp/Stitching/PlanSelect_0.dart';
import 'package:bellbirdmvp/Stitching/measurementInfoTop.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class MeasurementSwitcherGarara extends StatefulWidget {
  final int sleevesPrice;
  final int neckPrice;
  final String sleevesAstar;
  final String bottomId;

  final int damanPrice;
  final int bottomPrice;
  final bool isMeasurementProvider;
  final String flippedSleeveD;
  final String neckD;
  final String sleevesLengthD;
  final int neckPatchPrice;
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
  MeasurementSwitcherGarara(
      {this.sleeveTopPadding,
      this.neckHeight,
      this.f3b,
      this.sleevesAstar,
      this.f3p,
      this.bottomId,
      this.deliveryCharge,
      this.topAstar,
      this.isMeasurementProvider,
      this.neckPatchBool,
      this.sleevesPatchBool,
      this.damanPatchBool,
      this.bottomPatchBool,
      this.bottomPatchPrice,
      this.neckPatchPrice,
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
  _MeasurementSwitcherGararaState createState() =>
      _MeasurementSwitcherGararaState();
}

class _MeasurementSwitcherGararaState extends State<MeasurementSwitcherGarara> {
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
              return GararaPlanSelect(
                bottomPrice: widget.bottomPrice,
                sleeveAstar: widget.sleevesAstar,
                damanPrice: widget.damanPrice,
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
                neckPatchPrice: widget.neckPatchPrice,
                damanPatchPrice: widget.damanPatchPrice,
                sleevesPatchPrice: widget.sleevesPatchPrice,
                bottomPatchPrice: widget.bottomPatchPrice,
                deliveryCharge: widget.deliveryCharge,
                sleevesPrice: widget.sleevesPrice,
                bottomD: widget.bottomD,
                neckPatchBool: widget.neckPatchBool,
                damanPatchBool: widget.damanPatchBool,
                sleevesPatchBool: widget.sleevesPatchBool,
                bottomPatchBool: widget.bottomPatchBool,
                damanD: widget.damanD,
                neckD: widget.neckD,
                sleevesD: widget.sleevesD,
                damanHeight: widget.damanHeight,
                neckHeight: widget.neckHeight,
                sleeveTopPadding: widget.sleeveTopPadding,
                bottomN: widget.bottomN,
                damanN: widget.damanN,
                topAstar: widget.topAstar,
                bottomAstar: widget.bottomAstar,
                neckN: widget.neckN,
                sleevesLengthN: widget.sleevesLengthN,
                sleevesN: widget.sleevesN,
                sleevesLengthD: widget.sleevesLengthD,
                flippedSleeveD: widget.flippedSleeveD,
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
                    return GararaPlanSelect(
                      bottomPrice: widget.bottomPrice,
                      sleeveAstar: widget.sleevesAstar,
                      damanPrice: widget.damanPrice,
                      basicPrice: widget.basicPrice,
                      premiumPrice: widget.premiumPrice,
                      measurementImageBottomUrl: measurementImageBottomUrl,
                      measurementImageTopUrl: measurementImageTopUrl,
                      f1b: widget.f1b,
                      f1p: widget.f1p,
                      f2b: widget.f2b,
                      isMeasurementSelected: false,
                      f2p: widget.f2p,
                      measurementTopDocId: docIdTop,
                      measurementBottomDocId: docIdBottom,
                      f3b: widget.f3b,
                      f3p: widget.f3p,
                      f1bdays: widget.f1bdays,
                      f1pdays: widget.f1pdays,
                      astarPrice: widget.astarPrice,
                      neckPrice: widget.neckPrice,
                      neckPatchPrice: widget.neckPatchPrice,
                      damanPatchPrice: widget.damanPatchPrice,
                      sleevesPatchPrice: widget.sleevesPatchPrice,
                      bottomPatchPrice: widget.bottomPatchPrice,
                      deliveryCharge: widget.deliveryCharge,
                      sleevesPrice: widget.sleevesPrice,
                      bottomD: widget.bottomD,
                      neckPatchBool: widget.neckPatchBool,
                      damanPatchBool: widget.damanPatchBool,
                      sleevesPatchBool: widget.sleevesPatchBool,
                      bottomPatchBool: widget.bottomPatchBool,
                      damanD: widget.damanD,
                      neckD: widget.neckD,
                      sleevesD: widget.sleevesD,
                      damanHeight: widget.damanHeight,
                      neckHeight: widget.neckHeight,
                      sleeveTopPadding: widget.sleeveTopPadding,
                      bottomN: widget.bottomN,
                      damanN: widget.damanN,
                      topAstar: widget.topAstar,
                      bottomAstar: widget.bottomAstar,
                      neckN: widget.neckN,
                      sleevesLengthN: widget.sleevesLengthN,
                      sleevesN: widget.sleevesN,
                      sleevesLengthD: widget.sleevesLengthD,
                      flippedSleeveD: widget.flippedSleeveD,
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
          widget.bottomId != 'No Bottom'
              ? Align(
                  alignment: getalignment(myLocale.languageCode),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("bottom"),
                      style: TextStyle(
                          fontFamily: 'CodePro',
                          fontWeight: FontWeight.w800,
                          fontSize: 28),
                    ),
                  ))
              : Container(),
          SizedBox(
            height: 15,
          ),
          widget.bottomId != 'No Bottom'
              ? bottomMeasurementF != null
                  ? Container(
                      height: 280,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bottomMeasurementF.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  docIdBottom =
                                      bottomMeasurementF.docs[index].id;
                                  measurementImageBottomUrl = bottomMeasurementF
                                      .docs[index]
                                      .data()['image'];
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: docIdBottom ==
                                            bottomMeasurementF.docs[index].id
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: bottomMeasurementF
                                                .docs[index]
                                                .data()['image'],
                                            placeholder: (context, url) =>
                                                Container(
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
                  : CupertinoActivityIndicator()
              : Container(),
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
                  return GararaPlanSelect(
                    bottomPrice: widget.bottomPrice,
                    sleeveAstar: widget.sleevesAstar,
                    damanPrice: widget.damanPrice,
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
                    neckPatchPrice: widget.neckPatchPrice,
                    damanPatchPrice: widget.damanPatchPrice,
                    sleevesPatchPrice: widget.sleevesPatchPrice,
                    bottomPatchPrice: widget.bottomPatchPrice,
                    deliveryCharge: widget.deliveryCharge,
                    sleevesPrice: widget.sleevesPrice,
                    bottomD: widget.bottomD,
                    neckPatchBool: widget.neckPatchBool,
                    damanPatchBool: widget.damanPatchBool,
                    sleevesPatchBool: widget.sleevesPatchBool,
                    bottomPatchBool: widget.bottomPatchBool,
                    damanD: widget.damanD,
                    neckD: widget.neckD,
                    sleevesD: widget.sleevesD,
                    damanHeight: widget.damanHeight,
                    neckHeight: widget.neckHeight,
                    sleeveTopPadding: widget.sleeveTopPadding,
                    bottomN: widget.bottomN,
                    damanN: widget.damanN,
                    topAstar: widget.topAstar,
                    bottomAstar: widget.bottomAstar,
                    neckN: widget.neckN,
                    sleevesLengthN: widget.sleevesLengthN,
                    sleevesN: widget.sleevesN,
                    sleevesLengthD: widget.sleevesLengthD,
                    flippedSleeveD: widget.flippedSleeveD,
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
