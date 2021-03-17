import 'package:bellbirdmvp/Screens/Frock/frockForm.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaForm.dart';
import 'package:bellbirdmvp/Screens/blouse/blouseForm.dart';
import 'package:bellbirdmvp/Stitching/planSelect.dart';
import 'package:bellbirdmvp/Tabs-screens/BottomBar.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:random_string/random_string.dart';

class AlternationEditingDivision extends StatefulWidget {
  final String languageCode;
  AlternationEditingDivision(this.languageCode);
  @override
  _AlternationEditingDivisionState createState() =>
      _AlternationEditingDivisionState();
}

class _AlternationEditingDivisionState
    extends State<AlternationEditingDivision> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot neckSnapshots;
  QuerySnapshot damanSnapshots;
  QuerySnapshot sleevesLengthSnapshots;
  QuerySnapshot sleevesSnapshots;
  QuerySnapshot bottomSnapshots;
  QuerySnapshot ghair_choli;
  QuerySnapshot ghair_withoutCholi;
  QuerySnapshot angrakha;

  String neckD;
  String sleevesLengthD;
  String sleevesD;
  String damanD;
  String bottomD;
  int sleevesPrice;
  int neckPrice;
  int sleevesLengthPrice;
  int damanPrice;
  int bottomPrice;

  String neckId;
  String sleevesId;
  String flippedSleeveD;
  String sleevesLengthId;
  String damanId;
  String sleevesName;
  String bottomId;
  String bottomName;
  String damanName;
  String neckName;
  String sleevesLengthName;
  QuerySnapshot _sleevesAboveElbow;
  QuerySnapshot _sleevesBelowElbow;
  QuerySnapshot _sleevesFullLength;
  QuerySnapshot ghairTypeImages;
  int neckHeight;
  int damanHeight;
  int sleeveTopPadding;
  String ghairId;
  int ghairHeight;
  String ghairD;
  String ghairName;
  int ghairPrice;

  QuerySnapshot cutSnapshots;
  String cutId;
  String cutD;
  String cutName;
  int cutPrice;
  int cutHeight;

  String backId;
  String backName;
  int backHeight;

  int backPrice;

  QuerySnapshot backSnapshots;

  String backD;

  @override
  void initState() {
    loadNeckData();
    loadCutData();
    loadBackData();
    _updateAppbar();

    super.initState();
  }

  void _updateAppbar() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
            .copyWith(
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark)));
  }

  loadNeckData() async {
    QuerySnapshot neck = await firestore
        .collection('salwarSuitParts')
        .doc('neck')
        .collection('designs')
        .orderBy('rank')
        .get();
    setState(() {
      neckSnapshots = neck;
      neckId = neckSnapshots.docs[0].data()['id'];
      neckHeight = neckSnapshots.docs[0].data()['height'];
      sleeveTopPadding = neckSnapshots.docs[0].data()['sleevePadding'];
      neckD = neckSnapshots.docs[0].data()['image'];
      neckName = neckSnapshots.docs[0].data()['${widget.languageCode}name'];

      neckPrice = neckSnapshots.docs[0].data()['price'];
    });
  }

  loadCutData() async {
    QuerySnapshot cut = await firestore
        .collection('salwarSuitParts')
        .doc('cut_blouse')
        .collection('designs')
        .orderBy('rank')
        .get();
    setState(() {
      cutSnapshots = cut;
      cutId = cutSnapshots.docs[0].data()['id'];
      cutHeight = cutSnapshots.docs[0].data()['height'];
      cutD = cutSnapshots.docs[0].data()['image'];
      cutName = cutSnapshots.docs[0].data()['${widget.languageCode}name'];
      cutPrice = cutSnapshots.docs[0].data()['price'];
    });
  }

  loadBackData() async {
    QuerySnapshot back = await firestore
        .collection('salwarSuitParts')
        .doc('back')
        .collection('designs')
        .orderBy('rank')
        .get();
    setState(() {
      backSnapshots = back;
      backId = backSnapshots.docs[0].data()['id'];
      backHeight = backSnapshots.docs[0].data()['height'];
      sleeveTopPadding = backSnapshots.docs[0].data()['sleevePadding'];
      backD = backSnapshots.docs[0].data()['image'];
      backName = backSnapshots.docs[0].data()['${widget.languageCode}name'];

      backPrice = backSnapshots.docs[0].data()['price'];
    });
  }

  showbacksheet(context, QuerySnapshot designList) {
    String backTempId = backId;

    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("selectBack"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: Container(
                  color: Colors.white,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    physics: BouncingScrollPhysics(),
                    itemCount: designList.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              backId = designList.docs[index].data()['id'];
                              backTempId = designList.docs[index].data()['id'];
                              backHeight =
                                  designList.docs[index].data()['height'];
                              sleeveTopPadding = designList.docs[index]
                                  .data()['sleevePadding'];
                              backName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              backD = designList.docs[index].data()['image'];
                              backPrice =
                                  designList.docs[index].data()['price'];
                            });
                            sheetSetState(() {
                              backId = designList.docs[index].data()['id'];
                              backTempId = designList.docs[index].data()['id'];
                              backHeight =
                                  designList.docs[index].data()['height'];
                              sleeveTopPadding = designList.docs[index]
                                  .data()['sleevePadding'];
                              backName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              backD = designList.docs[index].data()['image'];
                              backPrice =
                                  designList.docs[index].data()['price'];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: backTempId ==
                                      designList.docs[index].data()['id']
                                  ? 6
                                  : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: backTempId ==
                                          designList.docs[index].data()['id']
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                          ),
                                          top: BorderSide(
                                              width: 3, color: Colors.blue),
                                          left: BorderSide(
                                              width: 3, color: Colors.blue),
                                          right: BorderSide(
                                              width: 3, color: Colors.blue))
                                      : Border(),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: designList.docs[index]
                                            .data()['image'],
                                        placeholder: (context, url) => Container(
                                            height: 250,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 3.0),
                                      child: Center(
                                        child: Text(
                                          designList.docs[index].data()[
                                              '${widget.languageCode}name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'CodeProlight',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            }));
  }

  showCutSheet(context, QuerySnapshot designList) {
    String cutTempId = cutId;
    showCupertinoModalBottomSheet(
        context: context,
        builder: (
          context,
        ) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("selectCut"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: Container(
                  color: Colors.white70,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    physics: BouncingScrollPhysics(),
                    itemCount: designList.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              cutId = designList.docs[index].data()['id'];
                              cutTempId = designList.docs[index].data()['id'];
                              cutD = designList.docs[index].data()['image'];
                              cutHeight =
                                  designList.docs[index].data()['height'];
                              cutName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              cutPrice = designList.docs[index].data()['price'];
                            });
                            sheetSetState(() {
                              cutId = designList.docs[index].data()['id'];
                              cutTempId = designList.docs[index].data()['id'];
                              cutD = designList.docs[index].data()['image'];
                              cutHeight =
                                  designList.docs[index].data()['height'];
                              cutName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              cutPrice = designList.docs[index].data()['price'];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: cutTempId ==
                                      designList.docs[index].data()['id']
                                  ? 6
                                  : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: cutTempId ==
                                          designList.docs[index].data()['id']
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                          ),
                                          top: BorderSide(
                                              width: 3, color: Colors.blue),
                                          left: BorderSide(
                                              width: 3, color: Colors.blue),
                                          right: BorderSide(
                                              width: 3, color: Colors.blue))
                                      : Border(),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: designList.docs[index]
                                            .data()['image'],
                                        placeholder: (context, url) => Container(
                                            height: 250,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 3.0),
                                      child: Center(
                                        child: Text(
                                          designList.docs[index].data()[
                                              '${widget.languageCode}name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'CodeProlight',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            }));
  }

  shownecksheet(context, QuerySnapshot designList) {
    String neckTempId = neckId;

    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("selectNeck"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: Container(
                  color: Colors.white,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    physics: BouncingScrollPhysics(),
                    itemCount: designList.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              neckId = designList.docs[index].data()['id'];
                              neckTempId = designList.docs[index].data()['id'];
                              neckHeight =
                                  designList.docs[index].data()['height'];
                              sleeveTopPadding = designList.docs[index]
                                  .data()['sleevePadding'];
                              neckName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              neckD = designList.docs[index].data()['image'];
                              neckPrice =
                                  designList.docs[index].data()['price'];
                            });
                            sheetSetState(() {
                              neckId = designList.docs[index].data()['id'];
                              neckTempId = designList.docs[index].data()['id'];
                              neckHeight =
                                  designList.docs[index].data()['height'];
                              sleeveTopPadding = designList.docs[index]
                                  .data()['sleevePadding'];
                              neckName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              neckD = designList.docs[index].data()['image'];
                              neckPrice =
                                  designList.docs[index].data()['price'];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: neckTempId ==
                                      designList.docs[index].data()['id']
                                  ? 6
                                  : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: neckTempId ==
                                          designList.docs[index].data()['id']
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                          ),
                                          top: BorderSide(
                                              width: 3, color: Colors.blue),
                                          left: BorderSide(
                                              width: 3, color: Colors.blue),
                                          right: BorderSide(
                                              width: 3, color: Colors.blue))
                                      : Border(),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: designList.docs[index]
                                            .data()['image'],
                                        placeholder: (context, url) => Container(
                                            height: 250,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 3.0),
                                      child: Center(
                                        child: Text(
                                          designList.docs[index].data()[
                                              '${widget.languageCode}name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'CodeProlight',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            }));
  }

  showSleevesLengthSheet(context, QuerySnapshot designList) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => Scaffold(
              appBar: CupertinoNavigationBar(
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'CodePro',
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                middle: Text("Select SleevesLength",
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
              ),
              body: Container(
                color: Colors.white70,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                  physics: BouncingScrollPhysics(),
                  itemCount: sleevesLengthSnapshots.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            sleevesLengthId =
                                designList.docs[index].data()['id'];

                            sleevesLengthD =
                                designList.docs[index].data()['image'];
                            sleevesLengthPrice =
                                designList.docs[index].data()['price'];
                            Navigator.pop(context);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: sleevesLengthSnapshots.docs[index]
                                  .data()['image'],
                              placeholder: (context, url) => Container(
                                  height: 250,
                                  child: new CupertinoActivityIndicator()),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ));
  }

  showSleevesSheet(context, QuerySnapshot designList) {
    String sleevesLengthTempId = sleevesLengthId;
    String sleevesTempId = sleevesId;
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("selectSleeves"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              DemoLocalizations.of(context)
                                  .getTranslatedValue("selectLength"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'CodeProlight',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28),
                            ),
                          )),
                      Container(
                        color: Colors.white70,
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          physics: BouncingScrollPhysics(),
                          itemCount: sleevesLengthSnapshots.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    switch (sleevesLengthSnapshots.docs[index]
                                        .data()['id']) {
                                      case 'aboveElbow':
                                        sleevesSnapshots = _sleevesAboveElbow;
                                        sleevesId = _sleevesAboveElbow.docs[0]
                                            .data()['id'];
                                        sleevesTempId = _sleevesAboveElbow
                                            .docs[0]
                                            .data()['id'];
                                        sleevesName =
                                            _sleevesAboveElbow.docs[0].data()[
                                                '${widget.languageCode}name'];

                                        flippedSleeveD = _sleevesAboveElbow
                                            .docs[0]
                                            .data()['flipped'];

                                        sleevesD = _sleevesAboveElbow.docs[0]
                                            .data()['image'];
                                        sleevesPrice = _sleevesAboveElbow
                                            .docs[0]
                                            .data()['price'];
                                        break;
                                      case 'belowElbow':
                                        sleevesSnapshots = _sleevesBelowElbow;
                                        sleevesId = _sleevesBelowElbow.docs[0]
                                            .data()['id'];
                                        flippedSleeveD = _sleevesBelowElbow
                                            .docs[0]
                                            .data()['flipped'];
                                        sleevesTempId = _sleevesBelowElbow
                                            .docs[0]
                                            .data()['id'];
                                        sleevesName =
                                            _sleevesBelowElbow.docs[0].data()[
                                                '${widget.languageCode}name'];
                                        sleevesD = _sleevesBelowElbow.docs[0]
                                            .data()['image'];
                                        sleevesPrice = _sleevesBelowElbow
                                            .docs[0]
                                            .data()['price'];
                                        break;
                                      case 'fullLength':
                                        sleevesSnapshots = _sleevesFullLength;
                                        sleevesId = _sleevesFullLength.docs[0]
                                            .data()['id'];
                                        flippedSleeveD = _sleevesFullLength
                                            .docs[0]
                                            .data()['flipped'];
                                        sleevesTempId = _sleevesFullLength
                                            .docs[0]
                                            .data()['id'];
                                        sleevesName =
                                            _sleevesFullLength.docs[0].data()[
                                                '${widget.languageCode}name'];

                                        sleevesD = _sleevesFullLength.docs[0]
                                            .data()['image'];
                                        sleevesPrice = _sleevesFullLength
                                            .docs[0]
                                            .data()['price'];
                                        break;
                                    }
                                    sleevesLengthD = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['id'];
                                    sleevesLengthTempId = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['id'];
                                    sleevesLengthId = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['id'];

                                    sleevesLengthD = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['image'];
                                    sleevesLengthName = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['${widget.languageCode}name'];
                                  });
                                  sheetSetState(() {
                                    sleevesLengthId = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['id'];
                                    sleevesLengthName = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['${widget.languageCode}name'];

                                    switch (sleevesLengthSnapshots.docs[index]
                                        .data()['id']) {
                                      case 'aboveElbow':
                                        sleevesSnapshots = _sleevesAboveElbow;
                                        sleevesId = _sleevesAboveElbow.docs[0]
                                            .data()['id'];
                                        flippedSleeveD = _sleevesAboveElbow
                                            .docs[0]
                                            .data()['flipped'];
                                        sleevesTempId = _sleevesAboveElbow
                                            .docs[0]
                                            .data()['id'];
                                        sleevesName =
                                            _sleevesAboveElbow.docs[0].data()[
                                                '${widget.languageCode}name'];

                                        sleevesD = _sleevesAboveElbow.docs[0]
                                            .data()['image'];
                                        sleevesPrice = _sleevesAboveElbow
                                            .docs[0]
                                            .data()['price'];
                                        break;
                                      case 'belowElbow':
                                        sleevesSnapshots = _sleevesBelowElbow;
                                        sleevesId = _sleevesBelowElbow.docs[0]
                                            .data()['id'];
                                        flippedSleeveD = _sleevesBelowElbow
                                            .docs[0]
                                            .data()['flipped'];
                                        sleevesTempId = _sleevesBelowElbow
                                            .docs[0]
                                            .data()['id'];
                                        sleevesName =
                                            _sleevesBelowElbow.docs[0].data()[
                                                '${widget.languageCode}name'];
                                        sleevesD = _sleevesBelowElbow.docs[0]
                                            .data()['image'];
                                        sleevesPrice = _sleevesBelowElbow
                                            .docs[0]
                                            .data()['price'];
                                        break;
                                      case 'fullLength':
                                        sleevesSnapshots = _sleevesFullLength;
                                        sleevesId = _sleevesFullLength.docs[0]
                                            .data()['id'];
                                        flippedSleeveD = _sleevesFullLength
                                            .docs[0]
                                            .data()['flipped'];
                                        sleevesTempId = _sleevesFullLength
                                            .docs[0]
                                            .data()['id'];
                                        sleevesName =
                                            _sleevesFullLength.docs[0].data()[
                                                '${widget.languageCode}name'];
                                        sleevesD = _sleevesFullLength.docs[0]
                                            .data()['image'];
                                        sleevesPrice = _sleevesFullLength
                                            .docs[0]
                                            .data()['price'];
                                        break;
                                    }
                                    sleevesLengthD = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['id'];
                                    sleevesLengthTempId = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['id'];
                                    sleevesLengthD = sleevesLengthSnapshots
                                        .docs[index]
                                        .data()['image'];
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: sleevesLengthTempId ==
                                            sleevesLengthSnapshots.docs[index]
                                                .data()['id']
                                        ? 6
                                        : 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: sleevesLengthTempId ==
                                                sleevesLengthSnapshots
                                                    .docs[index]
                                                    .data()['id']
                                            ? Border(
                                                bottom: BorderSide(
                                                  width: 3,
                                                  color: Colors.blue,
                                                ),
                                                top: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                left: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                right: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue))
                                            : Border(),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                height: 80,
                                                imageUrl: sleevesLengthSnapshots
                                                    .docs[index]
                                                    .data()['image'],
                                                placeholder: (context, url) =>
                                                    Container(
                                                        height: 250,
                                                        child:
                                                            new CupertinoActivityIndicator()),
                                              ),
                                              // child: Image.network(
                                              //   sleevesLengthSnapshots
                                              //       .docs[index]
                                              //       .data()['image'],
                                              //   height: 80,
                                              //   frameBuilder: (context,
                                              //       child,
                                              //       frame,
                                              //       wasSynchronouslyLoaded) {
                                              //     if (wasSynchronouslyLoaded) {
                                              //       return child;
                                              //     } else {
                                              //       return AnimatedSwitcher(
                                              //         duration: const Duration(
                                              //             milliseconds: 500),
                                              //         child: frame != null
                                              //             ? child
                                              //             : Container(
                                              //                 height: 80,
                                              //                 child: Center(
                                              //                     child:
                                              //                         CupertinoActivityIndicator())),
                                              //       );
                                              //     }
                                              //   },
                                              // ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Center(
                                              child: Text(
                                                sleevesLengthSnapshots
                                                        .docs[index]
                                                        .data()[
                                                    '${widget.languageCode}name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'CodeProlight',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              DemoLocalizations.of(context)
                                  .getTranslatedValue("selectDesign"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'CodeProlight',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28),
                            ),
                          )),
                      Container(
                        color: Colors.white70,
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          physics: BouncingScrollPhysics(),
                          itemCount: sleevesSnapshots.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sleevesId = sleevesSnapshots.docs[index]
                                        .data()['id'];
                                    sleevesTempId = sleevesSnapshots.docs[index]
                                        .data()['id'];
                                    sleevesD = sleevesSnapshots.docs[index]
                                        .data()['image'];
                                    sleevesName = sleevesSnapshots.docs[index]
                                        .data()['${widget.languageCode}name'];
                                    flippedSleeveD = sleevesSnapshots
                                        .docs[index]
                                        .data()['flipped'];

                                    sleevesPrice = sleevesSnapshots.docs[index]
                                        .data()['price'];
                                  });
                                  sheetSetState(() {
                                    sleevesId = sleevesSnapshots.docs[index]
                                        .data()['id'];
                                    sleevesTempId = sleevesSnapshots.docs[index]
                                        .data()['id'];
                                    sleevesName = sleevesSnapshots.docs[index]
                                        .data()['${widget.languageCode}name'];
                                    sleevesD = sleevesSnapshots.docs[index]
                                        .data()['image'];
                                    flippedSleeveD = sleevesSnapshots
                                        .docs[index]
                                        .data()['flipped'];
                                    sleevesPrice = sleevesSnapshots.docs[index]
                                        .data()['price'];
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: sleevesTempId ==
                                            sleevesSnapshots.docs[index]
                                                .data()['id']
                                        ? 6
                                        : 0,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: sleevesTempId ==
                                                sleevesSnapshots.docs[index]
                                                    .data()['id']
                                            ? Border(
                                                bottom: BorderSide(
                                                  width: 3,
                                                  color: Colors.blue,
                                                ),
                                                top: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                left: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                right: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue))
                                            : Border(),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: sleevesSnapshots
                                                  .docs[index]
                                                  .data()['image'],
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: 250,
                                                      child:
                                                          new CupertinoActivityIndicator()),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Center(
                                              child: Text(
                                                sleevesSnapshots.docs[index]
                                                        .data()[
                                                    '${widget.languageCode}name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'CodeProlight',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  List ghairType = ['Choli', 'withoutCholi'];
  String ghairTypeId;
  QuerySnapshot ghairSnapshots;
  showGhairSheet(context, QuerySnapshot designList) {
    String ghairTempId = ghairId;
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("select_ghair"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        color: Colors.white70,
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          physics: BouncingScrollPhysics(),
                          itemCount: ghairTypeImages.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ghairTypeId = ghairType[index];

                                    switch (ghairType[index]) {
                                      case 'Choli':
                                        ghairSnapshots = ghair_choli;
                                        ghairId =
                                            ghair_choli.docs[0].data()['id'];
                                        ghairTempId =
                                            ghair_choli.docs[0].data()['id'];
                                        ghairName = ghair_choli.docs[0].data()[
                                            '${widget.languageCode}name'];

                                        ghairD =
                                            ghair_choli.docs[0].data()['image'];
                                        ghairPrice =
                                            ghair_choli.docs[0].data()['price'];
                                        break;
                                      case 'withoutCholi':
                                        ghairSnapshots = ghair_withoutCholi;
                                        ghairId = ghair_withoutCholi.docs[0]
                                            .data()['id'];

                                        ghairTempId = ghair_withoutCholi.docs[0]
                                            .data()['id'];
                                        ghairName =
                                            ghair_withoutCholi.docs[0].data()[
                                                '${widget.languageCode}name'];
                                        ghairD = ghair_withoutCholi.docs[0]
                                            .data()['image'];
                                        ghairPrice = ghair_withoutCholi.docs[0]
                                            .data()['price'];
                                        break;
                                    }
                                  });
                                  sheetSetState(() {
                                    ghairTypeId = ghairType[index];

                                    switch (ghairType[index]) {
                                      case 'Choli':
                                        ghairSnapshots = ghair_choli;
                                        ghairId =
                                            ghair_choli.docs[0].data()['id'];
                                        ghairTempId =
                                            ghair_choli.docs[0].data()['id'];
                                        ghairName = ghair_choli.docs[0].data()[
                                            '${widget.languageCode}name'];

                                        ghairD =
                                            ghair_choli.docs[0].data()['image'];
                                        ghairPrice =
                                            ghair_choli.docs[0].data()['price'];
                                        break;
                                      case 'withoutCholi':
                                        ghairSnapshots = ghair_withoutCholi;
                                        ghairId = ghair_withoutCholi.docs[0]
                                            .data()['id'];
                                        ghairTempId = ghair_withoutCholi.docs[0]
                                            .data()['id'];

                                        ghairName =
                                            ghair_withoutCholi.docs[0].data()[
                                                '${widget.languageCode}name'];
                                        ghairD = ghair_withoutCholi.docs[0]
                                            .data()['image'];
                                        ghairPrice = ghair_withoutCholi.docs[0]
                                            .data()['price'];
                                        break;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation:
                                        ghairTypeId == ghairType[index] ? 6 : 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: ghairTypeId == ghairType[index]
                                            ? Border(
                                                bottom: BorderSide(
                                                  width: 3,
                                                  color: Colors.blue,
                                                ),
                                                top: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                left: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                right: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue))
                                            : Border(),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl: ghairTypeImages
                                                      .docs[index]
                                                      .data()['image'],
                                                  height: 120,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          height: 150,
                                                          child:
                                                              new CupertinoActivityIndicator()),
                                                )
                                                //       .data()['image'],),
                                                // child: Image.network(
                                                //   ghairTypeImages.docs[index]
                                                //       .data()['image'],
                                                //   height: 80,
                                                //   frameBuilder: (context,
                                                //       child,
                                                //       frame,
                                                //       wasSynchronouslyLoaded) {
                                                //     if (wasSynchronouslyLoaded) {
                                                //       return child;
                                                //     } else {
                                                //       return AnimatedSwitcher(
                                                //         duration: const Duration(
                                                //             milliseconds: 500),
                                                //         child: frame != null
                                                //             ? child
                                                //             : Container(
                                                //                 height: 80,
                                                //                 child: Center(
                                                //                     child:
                                                //                         CupertinoActivityIndicator())),
                                                //       );
                                                //     }
                                                //   },
                                                // ),
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Center(
                                              child: Text(
                                                ghairTypeImages.docs[index]
                                                        .data()[
                                                    '${widget.languageCode}name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'CodeProlight',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                DemoLocalizations.of(context)
                                    .getTranslatedValue("selectDesign"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'CodeProlight',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28),
                              ),
                            )),
                      ),
                      Container(
                        color: Colors.white70,
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          physics: BouncingScrollPhysics(),
                          itemCount: ghairSnapshots.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ghairId =
                                        ghairSnapshots.docs[index].data()['id'];
                                    ghairTempId =
                                        ghairSnapshots.docs[index].data()['id'];
                                    ghairD = ghairSnapshots.docs[index]
                                        .data()['image'];
                                    ghairName = ghairSnapshots.docs[index]
                                        .data()['${widget.languageCode}name'];

                                    ghairPrice = ghairSnapshots.docs[index]
                                        .data()['price'];
                                  });
                                  sheetSetState(() {
                                    ghairId =
                                        ghairSnapshots.docs[index].data()['id'];
                                    ghairTempId =
                                        ghairSnapshots.docs[index].data()['id'];
                                    ghairName = ghairSnapshots.docs[index]
                                        .data()['${widget.languageCode}name'];
                                    ghairD = ghairSnapshots.docs[index]
                                        .data()['image'];

                                    ghairPrice = ghairSnapshots.docs[index]
                                        .data()['price'];
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: ghairTempId ==
                                            ghairSnapshots.docs[index]
                                                .data()['id']
                                        ? 6
                                        : 0,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: ghairTempId ==
                                                ghairSnapshots.docs[index]
                                                    .data()['id']
                                            ? Border(
                                                bottom: BorderSide(
                                                  width: 3,
                                                  color: Colors.blue,
                                                ),
                                                top: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                left: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue),
                                                right: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue))
                                            : Border(),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: ghairSnapshots
                                                  .docs[index]
                                                  .data()['image'],
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: 250,
                                                      child:
                                                          new CupertinoActivityIndicator()),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Center(
                                              child: Text(
                                                ghairSnapshots.docs[index]
                                                        .data()[
                                                    '${widget.languageCode}name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'CodeProlight',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  showDamanSheet(context, QuerySnapshot designList) {
    String damanTempId = damanId;
    showCupertinoModalBottomSheet(
        context: context,
        builder: (
          context,
        ) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("selectDaman"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: Container(
                  color: Colors.white70,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    physics: BouncingScrollPhysics(),
                    itemCount: designList.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              damanId = designList.docs[index].data()['id'];
                              damanTempId = designList.docs[index].data()['id'];
                              damanD = designList.docs[index].data()['image'];
                              damanHeight =
                                  designList.docs[index].data()['height'];
                              damanName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              damanPrice =
                                  designList.docs[index].data()['price'];
                            });
                            sheetSetState(() {
                              damanId = designList.docs[index].data()['id'];
                              damanTempId = designList.docs[index].data()['id'];
                              damanD = designList.docs[index].data()['image'];
                              damanHeight =
                                  designList.docs[index].data()['height'];
                              damanName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];

                              damanPrice =
                                  designList.docs[index].data()['price'];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: damanTempId ==
                                      designList.docs[index].data()['id']
                                  ? 6
                                  : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: damanTempId ==
                                          designList.docs[index].data()['id']
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                          ),
                                          top: BorderSide(
                                              width: 3, color: Colors.blue),
                                          left: BorderSide(
                                              width: 3, color: Colors.blue),
                                          right: BorderSide(
                                              width: 3, color: Colors.blue))
                                      : Border(),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: designList.docs[index]
                                            .data()['image'],
                                        placeholder: (context, url) => Container(
                                            height: 250,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 3.0),
                                      child: Center(
                                        child: Text(
                                          designList.docs[index].data()[
                                              '${widget.languageCode}name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'CodeProlight',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            }));
  }

  showBottomSheet(context, QuerySnapshot designList) {
    String bottomtempId = bottomId;

    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, sheetSetState) {
              return Scaffold(
                appBar: CupertinoNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CodePro',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  middle: Text(
                      DemoLocalizations.of(context)
                          .getTranslatedValue("selectBottom"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CodeProlight')),
                ),
                body: Container(
                  color: Colors.white70,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    physics: BouncingScrollPhysics(),
                    itemCount: designList.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              bottomId = designList.docs[index].data()['id'];
                              bottomtempId =
                                  designList.docs[index].data()['id'];
                              bottomD = designList.docs[index].data()['image'];
                              bottomPrice =
                                  designList.docs[index].data()['price'];
                              bottomName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];
                            });
                            sheetSetState(() {
                              bottomId = designList.docs[index].data()['id'];
                              bottomtempId =
                                  designList.docs[index].data()['id'];
                              bottomD = designList.docs[index].data()['image'];
                              bottomName = designList.docs[index]
                                  .data()['${widget.languageCode}name'];
                              bottomPrice =
                                  designList.docs[index].data()['price'];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: bottomtempId ==
                                      designList.docs[index].data()['id']
                                  ? 6
                                  : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: bottomtempId ==
                                          designList.docs[index].data()['id']
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                          ),
                                          top: BorderSide(
                                              width: 3, color: Colors.blue),
                                          left: BorderSide(
                                              width: 3, color: Colors.blue),
                                          right: BorderSide(
                                              width: 3, color: Colors.blue))
                                      : Border(),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: designList.docs[index]
                                            .data()['image'],
                                        placeholder: (context, url) => Container(
                                            height: 250,
                                            child:
                                                new CupertinoActivityIndicator()),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 3.0),
                                      child: Center(
                                        child: Text(
                                          designList.docs[index].data()[
                                              '${widget.languageCode}name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'CodeProlight',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            }));
  }

//  QuerySnapshot neckSnapshots;
//   QuerySnapshot damanSnapshots;
//   QuerySnapshot sleevesLengthSnapshots;
//   QuerySnapshot sleevesSnapshots;
//   QuerySnapshot bottomSnapshots;
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        trailing: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Text(
              DemoLocalizations.of(context).getTranslatedValue("next"),
              style: TextStyle(
                  fontFamily: 'CodePro',
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            onPressed: neckSnapshots != null &&
                    cutSnapshots != null &&
                    backSnapshots != null
                ? () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return BlouseForm(
                        cutPrice: cutPrice,
                        neckPrice: neckPrice,
                        backPrice: backPrice,
                        cutD: cutD,
                        neckD: neckD,
                        backD: backD,
                        cutHeight: cutHeight,
                        neckHeight: neckHeight,
                        sleeveTopPadding: sleeveTopPadding,
                        cutN: cutName,
                        neckN: neckName,
                        backN: backName,
                      );
                    }));
                  }
                : () {},
          ),
        ),
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("blouse"),
          style: TextStyle(
              fontFamily: 'CodeProlight',
              fontWeight: FontWeight.w800,
              fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 15,
                ),
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
                SizedBox(
                  height: 15,
                ),
                StaggeredGridView.count(
                  mainAxisSpacing: 4,
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  staggeredTiles: [
                    StaggeredTile.fit(2),
                    StaggeredTile.fit(2),
                    StaggeredTile.fit(2),
                    StaggeredTile.fit(2),
                  ],
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    neckSnapshots != null
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () {
                                  shownecksheet(context, neckSnapshots);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: ClipRRect(
                                            child: CachedNetworkImage(
                                              imageUrl: neckD,
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: 150,
                                                      child:
                                                          new CupertinoActivityIndicator()),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                neckName,
                                                style: TextStyle(
                                                    fontFamily: 'CodeProlight',
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          )
                        : CupertinoActivityIndicator(),
                    backSnapshots != null
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () {
                                  showbacksheet(context, backSnapshots);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ClipRRect(
                                            child: CachedNetworkImage(
                                              imageUrl: backD,
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: 150,
                                                      child:
                                                          new CupertinoActivityIndicator()),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              backName,
                                              style: TextStyle(
                                                  fontFamily: 'CodeProlight',
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          )
                        : CupertinoActivityIndicator(),
                    cutSnapshots != null
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () {
                                  showCutSheet(context, cutSnapshots);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            child: CachedNetworkImage(
                                              imageUrl: cutD,
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: 150,
                                                      child:
                                                          new CupertinoActivityIndicator()),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              cutName,
                                              style: TextStyle(
                                                  fontFamily: 'CodeProlight',
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          )
                        : CupertinoActivityIndicator(),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 20, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DemoLocalizations.of(context)
                                  .getTranslatedValue("select_and_change"),
                              style: TextStyle(
                                  fontFamily: 'CodeProlight',
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              CupertinoIcons.color_filter,
                              size: 32,
                            )
                          ],
                        ),
                      ),
                    ),
                    // bottomSnapshots != null
                    // ? Column(
                    //     children: [
                    //       Align(
                    //           alignment:
                    //               getalignment(myLocale.languageCode),
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 15, left: 15.0, right: 15),
                    //             child: Text(
                    //               DemoLocalizations.of(context)
                    //                   .getTranslatedValue("bottom"),
                    //               style: TextStyle(
                    //                   fontFamily: 'CodePro',
                    //                   fontWeight: FontWeight.w800,
                    //                   fontSize: 28),
                    //             ),
                    //           )),
                    //       Padding(
                    //         padding: const EdgeInsets.all(4.0),
                    //         child: Material(
                    //           elevation: 0,
                    //           borderRadius: BorderRadius.circular(10),
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               showBottomSheet(context, bottomSnapshots);
                    //             },
                    //             child: Container(
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.grey[100],
                    //                   shape: BoxShape.rectangle,
                    //                   borderRadius:
                    //                       BorderRadius.circular(10.0),
                    //                 ),
                    //                 child: Column(
                    //                   children: [
                    //                     Padding(
                    //                       padding:
                    //                           const EdgeInsets.all(8.0),
                    //                       child: ClipRRect(
                    //                         child: CachedNetworkImage(
                    //                           imageUrl: bottomD,
                    //                           placeholder: (context, url) =>
                    //                               Container(
                    //                                   height: 150,
                    //                                   child:
                    //                                       new CupertinoActivityIndicator()),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         Text(
                    //                           bottomName,
                    //                           style: TextStyle(
                    //                               fontFamily:
                    //                                   'CodeProlight',
                    //                               fontWeight:
                    //                                   FontWeight.w300,
                    //                               fontSize: 20),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 )),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    // : CupertinoActivityIndicator()
                  ],
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
            Align(
              alignment: getalignmentStackButtons(myLocale.languageCode),
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, bottom: 20, left: 20),
                child: FlatButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: neckSnapshots != null &&
                            damanSnapshots != null &&
                            sleevesLengthSnapshots != null &&
                            sleevesSnapshots != null &&
                            bottomSnapshots != null
                        ? () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return BlouseForm(
                                cutPrice: cutPrice,
                                neckPrice: neckPrice,
                                backPrice: backPrice,
                                cutD: cutD,
                                neckD: neckD,
                                backD: backD,
                                cutHeight: cutHeight,
                                neckHeight: neckHeight,
                                sleeveTopPadding: sleeveTopPadding,
                                cutN: cutName,
                                neckN: neckName,
                                backN: backName,
                              );
                            }));
                          }
                        : () {},
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
                                fontFamily: 'CodePro',
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                        ),
                        Icon(getarrow(myLocale.languageCode),
                            size: 22, color: Colors.white)
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
