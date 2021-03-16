import 'package:bellbirdmvp/Screens/orderSuccess.dart';
import 'package:bellbirdmvp/Stitching/SendYourDesignAddress.dart';
import 'package:bellbirdmvp/Stitching/address_SS.dart';
import 'package:bellbirdmvp/Stitching/sendYourDesign.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SendYourDesignSummary extends StatefulWidget {
  final int sleevesPrice;
  final int neckPrice;
  final int sleevesLengthPrice;
  final int damanPrice;
  final int bottomPrice;
  final int astarPrice;
  final String neckN;
  final String sleevesLengthN;
  final String sleevesN;
  final String damanN;
  final String bottomN;
  final String fabricImage;
  final String designImage;
  final String neckD;
  final String sleevesLengthD;
  final String sleevesD;
  final String damanD;
  final String bottomD;
  final String plan;
  final List<Map> notesData;

  final int price;

  SendYourDesignSummary(
      {this.astarPrice,
      this.neckN,
      this.fabricImage,
      this.notesData,
      this.designImage,
      this.bottomN,
      this.sleevesLengthN,
      this.sleevesN,
      this.damanN,
      this.bottomPrice,
      this.plan,
      this.price,
      this.damanPrice,
      this.neckPrice,
      this.sleevesLengthPrice,
      this.sleevesPrice,
      this.bottomD,
      this.damanD,
      this.neckD,
      this.sleevesD,
      this.sleevesLengthD});
  @override
  _SendYourDesignSummaryState createState() => _SendYourDesignSummaryState();
}

class _SendYourDesignSummaryState extends State<SendYourDesignSummary> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  double deviceHeight;
  double deviceWidth;

  getFabricPhoto(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/measurementCloth.png';

        break;
      case 'hi':
        return 'assets/measurementCloth1.png';

        break;
      case 'ur':
        return 'assets/measurementCloth2.png';
        break;
      default:
        'assets/measurementCloth.png';
    }
  }

  Locale myLocale;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    myLocale = Localizations.localeOf(context);

    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        trailing: Padding(
          padding: const EdgeInsets.only(top: 8.0),
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
                return SendYourDesignAddress(
                  designImage: widget.designImage,
                  fabricImage: widget.fabricImage,
                  notesData: widget.notesData,
                );
              }));
            },
          ),
        ),
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("order_summary"),
          style: TextStyle(
              fontFamily: 'CodePro', fontWeight: FontWeight.w800, fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Plan',
                      style: TextStyle(
                          fontFamily: 'CodePro',
                          fontWeight: FontWeight.w800,
                          fontSize: 28),
                    ),
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text("Pickup will be after approval",
                      style: TextStyle(
                        fontFamily: 'CodeProlight',
                        color: Colors.black,
                        fontSize: 16,
                      )),
                ),
              ),
              StaggeredGridView.count(
                mainAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 10,
                crossAxisSpacing: 4,
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                staggeredTiles: [
                  StaggeredTile.count(4, 6),
                  StaggeredTile.count(3, 3),
                  StaggeredTile.count(3, 3),
                  StaggeredTile.count(6, 3),
                ],
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 2, top: 8, bottom: 8),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 8, bottom: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '4',
                              style: TextStyle(
                                  fontFamily: 'CodePro', fontSize: 105),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'day delivery',
                              style: TextStyle(
                                  fontFamily: 'CodeProlight', fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, bottom: 2, top: 8, right: 2),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 14, bottom: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset('assets/COD.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, bottom: 2, top: 8, right: 8),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 8, bottom: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset('assets/QC.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, right: 8, top: 4, bottom: 8),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 0, bottom: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset('assets/Group 17.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          Image.asset(getFabricPhoto(myLocale.languageCode))),
                ),
              ),
              SizedBox(height: 10),
              Align(
                  alignment: getalignment(myLocale.languageCode),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("fabric_&_design"),
                      style: TextStyle(
                          fontFamily: 'CodePro',
                          fontWeight: FontWeight.w800,
                          fontSize: 28),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              widget.fabricImage,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded) {
                                  return child;
                                } else {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: frame != null
                                        ? child
                                        : Container(
                                            height: 160,
                                            child: Center(
                                                child:
                                                    CupertinoActivityIndicator())),
                                  );
                                }
                              },
                            ))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                              child: Image.network(
                            widget.designImage,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) {
                                return child;
                              } else {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: frame != null
                                      ? child
                                      : Container(
                                          height: 160,
                                          child: Center(
                                              child:
                                                  CupertinoActivityIndicator())),
                                );
                              }
                            },
                          ))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              widget.notesData.length > 0
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue("notes"),
                          style: TextStyle(
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w800,
                              fontSize: 28),
                        ),
                      ))
                  : Container(),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.notesData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                child: widget.notesData[index]['image'] !=
                                        'null'
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: Image.network(
                                          widget.notesData[index]['image'],
                                          frameBuilder: (context, child, frame,
                                              wasSynchronouslyLoaded) {
                                            if (wasSynchronouslyLoaded) {
                                              return child;
                                            } else {
                                              return AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: frame != null
                                                    ? child
                                                    : Container(
                                                        height: 80,
                                                        child: Center(
                                                            child:
                                                                CupertinoActivityIndicator())),
                                              );
                                            }
                                          },
                                        ))
                                    : Container(),
                              ),
                            ),
                            Expanded(
                              child: Text(widget.notesData[index]['note'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'CodeProlight',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              Container(
                height: 110,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.04,
                  vertical: deviceHeight * 0.03),
              child: Material(
                color: Colors.white60,
                elevation: 0,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  child: Form(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isLoading == false
                            ? FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return SendYourDesignAddress(
                                      designImage: widget.designImage,
                                      fabricImage: widget.fabricImage,
                                      notesData: widget.notesData,
                                    );
                                  }));
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        DemoLocalizations.of(context)
                                            .getTranslatedValue("next"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CodePro'),
                                      ),
                                    ),
                                    Icon(
                                      getarrow(myLocale.languageCode),
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ],
                                ))
                            : CupertinoActivityIndicator()
                      ],
                    ),
                  ),
                  height: deviceHeight * .07,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
