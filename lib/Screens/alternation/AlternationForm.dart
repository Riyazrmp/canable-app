import 'dart:io';

import 'package:bellbirdmvp/Screens/Frock/FrockPlanSelect.dart';
import 'package:bellbirdmvp/Screens/Frock/MeasurementSwitcherFrock.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaPlanSelect.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/MeasurementSwitcherGarara.dart';
import 'package:bellbirdmvp/Screens/alternation/AlternationPlanSelect.dart';
import 'package:bellbirdmvp/Screens/blouse/MeasurementSwitcherblouse.dart';
import 'package:bellbirdmvp/Stitching/PlanSelect_0.dart';
import 'package:bellbirdmvp/Stitching/measurementSwitcher.dart';
import 'package:bellbirdmvp/Stitching/planSelect.dart';
import 'package:bellbirdmvp/Stitching/planSelect_Pak.dart';
import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class AddressForm extends StatefulWidget {
  final int backPrice;
  final int neckPrice;
  final int cutPrice;
  final String neckD;
  final int cutHeight;
  final int neckHeight;
  final int sleeveTopPadding;

  final String backD;
  final String cutD;
  final String neckN;
  final String backN;
  final String cutN;
  AddressForm({
    this.sleeveTopPadding,
    this.neckHeight,
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
  _AddressFormState createState() => _AddressFormState();
}

class Note {
  File image;
  String note;

  Note(this.image, this.note);

  @override
  String toString() {
    return '{ ${this.image}, ${this.note} }';
  }
}

class _AddressFormState extends State<AddressForm> {
  @override
  void initState() {
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

  List<String> imageUrls = <String>[];
  bool isUploading = false;
  File _designImage;
  File _fabricImage;
  File _tempNoteImage;
  double deviceHeight;
  double deviceWidth;
  String _designImageUrl;
  List<File> noteImages = [];
  bool patchBool = false;
  bool neckPatch = false;
  bool sleevesPatch = false;
  bool damanPatch = false;
  bool bottomPatch = false;

  String _fabricImageUrl;
  final picker = ImagePicker();
  List<Note> notesData = [];
  List<Map> notesAData = [];
  var patches = new TextEditingController();
  String sleevesAstar = 'No astar on Sleeves----';
  var notesController = new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  uploadData() async {
    if (sleevesAstarAboveElbow == true) {
      sleevesAstar = 'above Elbow';
    }
    if (sleevesAstarBelowElbow == true) {
      sleevesAstar = 'Below Elbow';
    }
    if (sleevesAstarBelowShoulder == true) {
      sleevesAstar = 'Below Shoulder';
    }
    if (sleevesAstarFull == true) {
      sleevesAstar = 'Full Length';
    }
    if (sleevesAstarNoAstar == true) {
      sleevesAstar = 'No Astar on Sleeves';
    }

    if (notesController.text.trim().length > 0 || _tempNoteImage != null) {
      setState(() {
        notesData.add(Note(_tempNoteImage != null ? _tempNoteImage : null,
            notesController.text.trim()));
        _tempNoteImage = null;
        notesController.clear();
      });
    }
    setState(() {
      isUploading = true;
    });
    var priceResult = await firestore.collection('prices').doc('SS').get();
    var user = auth.FirebaseAuth.instance.currentUser;

    QuerySnapshot topMeasurement = await firestore
        .collection('measurements')
        .doc(user.uid)
        .collection('top')
        .get();
    await postImage(_fabricImage)
        .then((fabricImageUrl) => {_fabricImageUrl = fabricImageUrl});

    for (int i = 0; i < notesData.length; i++) {
      String tempImage;

      if (notesData[i].image == null) {
        notesAData.add({'note': notesData[i].note, 'image': 'null'});
      } else {
        await postImage(notesData[i].image).then((value) => {
              notesAData.add({'note': notesData[i].note, 'image': value})
            });
      }
    }
    if (topMeasurement.docs.isNotEmpty) {
      bool isMeasurementSelected = true;
      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return MeasurementSwitcherBlouse(
          cutPrice: widget.cutPrice,
          basicPrice: priceResult.data()['basicBlouse'],
          premiumPrice: priceResult.data()['premiumBlouse'],
          f1b: priceResult.data()['f1b'],
          f1p: priceResult.data()['f1p'],
          f2b: priceResult.data()['f2b'],
          f2p: priceResult.data()['f2p'],
          f3b: priceResult.data()['f3b'],
          f3p: priceResult.data()['f3p'],
          f1bdays: priceResult.data()['f1bdays'],
          f1pdays: priceResult.data()['f1pdays'],
          astarPrice: priceResult.data()['astar'],
          neckPrice: widget.neckPrice,
          deliveryCharge: priceResult.data()['deliveryCharge'],
          backPrice: widget.backPrice,
          cutD: widget.cutD,
          neckD: widget.neckD,
          backD: widget.backD,
          cutHeight: widget.cutHeight,
          neckHeight: widget.neckHeight,
          sleeveTopPadding: widget.sleeveTopPadding,
          cutN: widget.cutN,
          topAstar: topSelected,
          neckN: widget.neckN,
          backN: widget.backN,
          notesData: notesAData,
          fabricImage: _fabricImageUrl,
        );
      }));
    } else {
      bool isMeasurementSelected = false;

      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return AlternationPlanSelect(
          cutPrice: widget.cutPrice,
          basicPrice: priceResult.data()['basicGarara'],
          premiumPrice: priceResult.data()['premiumGarara'],
          f1b: priceResult.data()['f1b'],
          f1p: priceResult.data()['f1p'],
          f2b: priceResult.data()['f2b'],
          isMeasurementSelected: false,
          f2p: priceResult.data()['f2p'],
          f3b: priceResult.data()['f3b'],
          f3p: priceResult.data()['f3p'],
          f1bdays: priceResult.data()['f1bdays'],
          f1pdays: priceResult.data()['f1pdays'],
          astarPrice: priceResult.data()['astar'],
          neckPrice: widget.neckPrice,
          deliveryCharge: priceResult.data()['deliveryCharge'],
          backPrice: widget.backPrice,
          cutD: widget.cutD,
          neckD: widget.neckD,
          backD: widget.backD,
          cutHeight: widget.cutHeight,
          neckHeight: widget.neckHeight,
          sleeveTopPadding: widget.sleeveTopPadding,
          cutN: widget.cutN,
          topAstar: topSelected,
          neckN: widget.neckN,
          backN: widget.backN,
          notesData: notesAData,
          fabricImage: _fabricImageUrl,
        );
      }));
    }

    setState(() {
      isUploading = false;
    });
  }

  Future<dynamic> postImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    firebase_storage.Reference reference =
        FirebaseStorage.instance.ref().child(fileName);
    firebase_storage.UploadTask uploadTask = reference.putFile((imageFile));
    firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  List<String> notes = [];
  Future getDesignImage() async {
    FocusScope.of(context).unfocus();

    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _designImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  getFabricPhoto(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/uploadFabric.png';

        break;
      case 'hi':
        return 'assets/uploadFabric1.png';

        break;
      case 'ur':
        return 'assets/uploadFabric2.png';
        break;
      default:
        'assets/uploadFabric.png';
    }
  }

  Future getNotesImage() async {
    FocusScope.of(context).unfocus();

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoButton(
                child: Text(
                    DemoLocalizations.of(context).getTranslatedValue("gallery"),
                    style: TextStyle(
                      fontFamily: 'CodeProlight',
                      fontWeight: FontWeight.w700,
                    )),
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  Navigator.pop(context);

                  final pickedFile = await picker.getImage(
                      source: ImageSource.gallery, imageQuality: 50);

                  setState(() {
                    if (pickedFile != null) {
                      _tempNoteImage = File(pickedFile.path);
                    } else {
                      print('No image selected.');
                    }
                  });
                },
              ),
              CupertinoButton(
                child: Text(
                    DemoLocalizations.of(context).getTranslatedValue("camera"),
                    style: TextStyle(
                      fontFamily: 'CodeProlight',
                      fontWeight: FontWeight.w700,
                    )),
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  Navigator.pop(context);

                  final pickedFile = await CameraPicker.pickFromCamera(context,
                      resolutionPreset: ResolutionPreset.medium);

                  await pickedFile.file.then((value) {
                    setState(() {
                      _tempNoteImage = value;
                    });
                  });
//  await picker.getImage(
//                       source: ImageSource.camera, imageQuality: 50);
                  setState(() async {
                    if (pickedFile != null) {
                    } else {
                      print('No image selected.');
                    }
                  });
                },
              )
            ],
            title: Column(
              children: [
                Text(
                    DemoLocalizations.of(context)
                        .getTranslatedValue("notes_image"),
                    style: TextStyle(
                        fontFamily: 'CodeProlight',
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
            ),
          );
        });
  }

  Future getFabricImage() async {
    FocusScope.of(context).unfocus();

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoButton(
                child: Text(
                    DemoLocalizations.of(context).getTranslatedValue("gallery"),
                    style: TextStyle(
                      fontFamily: 'CodeProlight',
                      fontWeight: FontWeight.w700,
                    )),
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  Navigator.pop(context);

                  final pickedFile = await picker.getImage(
                      source: ImageSource.gallery, imageQuality: 50);

                  setState(() {
                    if (pickedFile != null) {
                      _fabricImage = File(pickedFile.path);
                    } else {
                      print('No image selected.');
                    }
                  });
                },
              ),
              CupertinoButton(
                child: Text(
                    DemoLocalizations.of(context).getTranslatedValue("camera"),
                    style: TextStyle(
                      fontFamily: 'CodeProlight',
                      fontWeight: FontWeight.w700,
                    )),
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  Navigator.pop(context);

                  final pickedFile = await CameraPicker.pickFromCamera(context,
                      resolutionPreset: ResolutionPreset.medium);

                  await pickedFile.file.then((value) {
                    setState(() {
                      _fabricImage = value;
                    });
                  });
//  await picker.getImage(
//                       source: ImageSource.camera, imageQuality: 50);
                  setState(() async {
                    if (pickedFile != null) {
                    } else {
                      print('No image selected.');
                    }
                  });
                },
              )
            ],
            title: Column(
              children: [
                Text(
                    DemoLocalizations.of(context)
                        .getTranslatedValue("select_fabric"),
                    style: TextStyle(
                        fontFamily: 'CodeProlight',
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
            ),
          );
        });
  }

  additionNoteContainer(File image, String note, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  notesData.removeAt(index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Feather.x_circle),
                ),
              ),
            ),
            Container(
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: deviceWidth * .5,
                        child: Text(note,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'CodeProlight', fontSize: 15)),
                      ),
                      image == null
                          ? Container()
                          : Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    if (wasSynchronouslyLoaded) {
                                      return child;
                                    } else {
                                      return AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: frame != null
                                            ? child
                                            : Container(
                                                height: 100,
                                                child: Center(
                                                    child:
                                                        CupertinoActivityIndicator())),
                                      );
                                    }
                                  },
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _error = 'No Error Dectected';
  bool topSelected = false;
  bool bottomSelected = false;
  bool patchesSelect = false;
  bool lasesSelect = false;
  bool pearlsSelect = false;
  bool sleevesAstarFull = false;
  bool sleevesAstarBelowElbow = false;
  bool sleevesAstarAboveElbow = false;
  bool sleevesAstarBelowShoulder = false;
  bool sleevesAstarNoAstar = false;
  buildList() {
    return ListView(
      physics: BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _fabricImage == null
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0, top: 5, bottom: 5),
                    child: GestureDetector(
                      onTap: getFabricImage,
                      child: Container(
                          height: 150,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.13),
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            getFabricPhoto(myLocale.languageCode),
                            fit: BoxFit.cover,
                          )),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            child: Stack(children: [
                              Image.file(
                                _fabricImage,
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded) {
                                    return child;
                                  } else {
                                    return AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: frame != null
                                          ? child
                                          : Container(
                                              height: 150,
                                              child: Center(
                                                  child:
                                                      CupertinoActivityIndicator())),
                                    );
                                  }
                                },
                                fit: BoxFit.contain,
                              ),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Entypo.circle_with_cross,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _fabricImage = null;
                                  });
                                },
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        SizedBox(height: 40),
        Align(
          alignment: getalignment(myLocale.languageCode),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
                DemoLocalizations.of(context).getTranslatedValue("astar"),
                style: TextStyle(
                    fontFamily: 'CodeProlight',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Align(
          alignment: getalignment(myLocale.languageCode),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
                DemoLocalizations.of(context).getTranslatedValue("astar_text"),
                style: TextStyle(
                  fontFamily: 'CodeProlight',
                  color: Colors.black,
                  fontSize: 16,
                )),
          ),
        ),
        ListTile(
          leading: Container(
            height: 30,
            child: Image.asset('assets/topSS.png'),
          ),
          trailing: CircularCheckBox(
              value: this.topSelected,
              checkColor: Colors.white,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueAccent,
              disabledColor: Colors.grey,
              onChanged: (val) => this.setState(() {
                    // if (selected == false) {
                    //   price += 20;
                    // } else {
                    //   price -= 20;
                    // }
                    this.topSelected = !this.topSelected;
                  })),
          title: Text(DemoLocalizations.of(context).getTranslatedValue("top"),
              style: TextStyle(
                fontFamily: 'CodeProlight',
                color: Colors.black,
                fontSize: 22,
              )),
          onTap: () => this.setState(() {
            // if (selected == false) {
            //   price += 20;
            // } else {
            //   price -= 20;
            // }

            this.topSelected = !this.topSelected;
          }),
        ),
        // topSelected == true
        //     ? Align(
        //         alignment: getalignment(myLocale.languageCode),
        //         child: Padding(
        //           padding:
        //               const EdgeInsets.only(left: 30.0, right: 15, top: 10),
        //           child: Text("Sleeve's Astar",
        //               style: TextStyle(
        //                   fontFamily: 'CodeProlight',
        //                   color: Colors.black,
        //                   fontSize: 25,
        //                   fontWeight: FontWeight.bold)),
        //         ),
        //       )
        //     : Container(),
        // topSelected == true
        //     ? Padding(
        //         padding: const EdgeInsets.only(left: 15.0),
        //         child: ListTile(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 40),
        //           trailing: CircularCheckBox(
        //               value: this.sleevesAstarFull,
        //               checkColor: Colors.white,
        //               activeColor: Colors.blueAccent,
        //               inactiveColor: Colors.blueAccent,
        //               disabledColor: Colors.grey,
        //               onChanged: (val) => this.setState(() {
        //                     // if (selected == false) {
        //                     //   price += 20;
        //                     // } else {
        //                     //   price -= 20;
        //                     // }
        //                     sleevesAstarAboveElbow = false;
        //                     sleevesAstarBelowElbow = false;
        //                     sleevesAstarNoAstar = false;
        //                     sleevesAstarBelowShoulder = false;
        //                     this.sleevesAstarFull = !this.sleevesAstarFull;
        //                   })),
        //           title: Text("Full",
        //               style: TextStyle(
        //                 fontFamily: 'CodeProlight',
        //                 color: Colors.black,
        //                 fontSize: 22,
        //               )),
        //           onTap: () => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             sleevesAstarAboveElbow = false;
        //             sleevesAstarNoAstar = false;
        //             sleevesAstarBelowElbow = false;
        //             sleevesAstarBelowShoulder = false;
        //             this.sleevesAstarFull = !this.sleevesAstarFull;
        //           }),
        //         ),
        //       )
        //     : Container(),
        // topSelected == true
        //     ? Padding(
        //         padding: const EdgeInsets.only(left: 15.0),
        //         child: ListTile(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 40),
        //           trailing: CircularCheckBox(
        //               value: this.sleevesAstarAboveElbow,
        //               checkColor: Colors.white,
        //               activeColor: Colors.blueAccent,
        //               inactiveColor: Colors.blueAccent,
        //               disabledColor: Colors.grey,
        //               onChanged: (val) => this.setState(() {
        //                     // if (selected == false) {
        //                     //   price += 20;
        //                     // } else {
        //                     //   price -= 20;
        //                     // }
        //                     sleevesAstarFull = false;
        //                     sleevesAstarNoAstar = false;
        //                     sleevesAstarBelowElbow = false;
        //                     sleevesAstarBelowShoulder = false;
        //                     this.sleevesAstarAboveElbow =
        //                         !this.sleevesAstarAboveElbow;
        //                   })),
        //           title: Text("Above Elbow",
        //               style: TextStyle(
        //                 fontFamily: 'CodeProlight',
        //                 color: Colors.black,
        //                 fontSize: 22,
        //               )),
        //           onTap: () => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             sleevesAstarFull = false;
        //             sleevesAstarNoAstar = false;
        //             sleevesAstarBelowElbow = false;
        //             sleevesAstarBelowShoulder = false;
        //             this.sleevesAstarAboveElbow = !this.sleevesAstarAboveElbow;
        //           }),
        //         ),
        //       )
        //     : Container(),
        // topSelected == true
        //     ? Padding(
        //         padding: const EdgeInsets.only(left: 15.0),
        //         child: ListTile(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 40),
        //           trailing: CircularCheckBox(
        //               value: this.sleevesAstarBelowElbow,
        //               checkColor: Colors.white,
        //               activeColor: Colors.blueAccent,
        //               inactiveColor: Colors.blueAccent,
        //               disabledColor: Colors.grey,
        //               onChanged: (val) => this.setState(() {
        //                     // if (selected == false) {
        //                     //   price += 20;
        //                     // } else {
        //                     //   price -= 20;
        //                     // }
        //                     sleevesAstarFull = false;
        //                     sleevesAstarAboveElbow = false;
        //                     sleevesAstarNoAstar = false;
        //                     sleevesAstarBelowShoulder = false;
        //                     this.sleevesAstarBelowElbow =
        //                         !this.sleevesAstarBelowElbow;
        //                   })),
        //           title: Text("Below Elbow",
        //               style: TextStyle(
        //                 fontFamily: 'CodeProlight',
        //                 color: Colors.black,
        //                 fontSize: 22,
        //               )),
        //           onTap: () => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             sleevesAstarFull = false;
        //             sleevesAstarAboveElbow = false;
        //             sleevesAstarNoAstar = false;
        //             sleevesAstarBelowShoulder = false;
        //             this.sleevesAstarBelowElbow = !this.sleevesAstarBelowElbow;
        //           }),
        //         ),
        //       )
        //     : Container(),
        // topSelected == true
        //     ? Padding(
        //         padding: const EdgeInsets.only(left: 15.0),
        //         child: ListTile(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 40),
        //           trailing: CircularCheckBox(
        //               value: this.sleevesAstarBelowShoulder,
        //               checkColor: Colors.white,
        //               activeColor: Colors.blueAccent,
        //               inactiveColor: Colors.blueAccent,
        //               disabledColor: Colors.grey,
        //               onChanged: (val) => this.setState(() {
        //                     // if (selected == false) {
        //                     //   price += 20;
        //                     // } else {
        //                     //   price -= 20;
        //                     // }
        //                     sleevesAstarFull = false;
        //                     sleevesAstarAboveElbow = false;
        //                     sleevesAstarBelowElbow = false;
        //                     sleevesAstarNoAstar = false;
        //                     this.sleevesAstarBelowShoulder =
        //                         !this.sleevesAstarBelowShoulder;
        //                   })),
        //           title: Text("Below Shoulder",
        //               style: TextStyle(
        //                 fontFamily: 'CodeProlight',
        //                 color: Colors.black,
        //                 fontSize: 22,
        //               )),
        //           onTap: () => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             sleevesAstarFull = false;
        //             sleevesAstarAboveElbow = false;
        //             sleevesAstarBelowElbow = false;
        //             sleevesAstarNoAstar = false;
        //             this.sleevesAstarBelowShoulder =
        //                 !this.sleevesAstarBelowShoulder;
        //           }),
        //         ),
        //       )
        //     : Container(),
        // topSelected == true
        //     ? Padding(
        //         padding: const EdgeInsets.only(left: 15.0, bottom: 10),
        //         child: ListTile(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 40),
        //           trailing: CircularCheckBox(
        //               value: this.sleevesAstarNoAstar,
        //               checkColor: Colors.white,
        //               activeColor: Colors.blueAccent,
        //               inactiveColor: Colors.blueAccent,
        //               disabledColor: Colors.grey,
        //               onChanged: (val) => this.setState(() {
        //                     // if (selected == false) {
        //                     //   price += 20;
        //                     // } else {
        //                     //   price -= 20;
        //                     // }
        //                     sleevesAstarAboveElbow = false;
        //                     sleevesAstarBelowElbow = false;
        //                     sleevesAstarBelowShoulder = false;
        //                     sleevesAstarFull = false;

        //                     this.sleevesAstarNoAstar =
        //                         !this.sleevesAstarNoAstar;
        //                   })),
        //           title: Text("No Astar",
        //               style: TextStyle(
        //                 fontFamily: 'CodeProlight',
        //                 color: Colors.black,
        //                 fontSize: 22,
        //               )),
        //           onTap: () => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             sleevesAstarAboveElbow = false;
        //             sleevesAstarBelowElbow = false;
        //             sleevesAstarBelowShoulder = false;
        //             sleevesAstarFull = false;

        //             this.sleevesAstarNoAstar = !this.sleevesAstarNoAstar;
        //           }),
        //         ),
        //       )
        //     : Container(),
        // ListTile(
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 9.0, right: 9),
        //     child: Container(
        //       height: 40,
        //       child: Image.asset('assets/bottomSS1.png'),
        //     ),
        //   ),
        //   trailing: CircularCheckBox(
        //       value: this.bottomSelected,
        //       checkColor: Colors.white,
        //       activeColor: Colors.blueAccent,
        //       inactiveColor: Colors.blueAccent,
        //       disabledColor: Colors.grey,
        //       onChanged: (val) => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             this.bottomSelected = !this.bottomSelected;
        //           })),
        //   title:
        //       Text(DemoLocalizations.of(context).getTranslatedValue("bottom"),
        //           style: TextStyle(
        //             fontFamily: 'CodeProlight',
        //             color: Colors.black,
        //             fontSize: 22,
        //           )),
        //   onTap: () => this.setState(() {
        //     // if (selected == false) {
        //     //   price += 20;
        //     // } else {
        //     //   price -= 20;
        //     // }
        //     this.bottomSelected = !this.bottomSelected;
        //   }),
        // ),
        // SizedBox(height: 40),
        // Align(
        //   alignment: getalignment(myLocale.languageCode),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 15.0, right: 15),
        //     child: Text(
        //         DemoLocalizations.of(context).getTranslatedValue("patches"),
        //         style: TextStyle(
        //             fontFamily: 'CodeProlight',
        //             color: Colors.black,
        //             fontSize: 30,
        //             fontWeight: FontWeight.bold)),
        //   ),
        // ),
        // ListTile(
        //   trailing: CircularCheckBox(
        //       value: this.patchBool,
        //       checkColor: Colors.white,
        //       activeColor: Colors.blueAccent,
        //       inactiveColor: Colors.blueAccent,
        //       disabledColor: Colors.grey,
        //       onChanged: (val) => this.setState(() {
        //             // if (selected == false) {
        //             //   price += 20;
        //             // } else {
        //             //   price -= 20;
        //             // }
        //             this.neckPatch = false;
        //             this.damanPatch = false;
        //             this.sleevesPatch = false;
        //             this.bottomPatch = false;
        //             this.patchBool = !this.patchBool;
        //           })),
        //   title: Text(
        //       DemoLocalizations.of(context).getTranslatedValue("patch?_garara"),
        //       style: TextStyle(
        //         fontFamily: 'CodeProlight',
        //         color: Colors.black,
        //         fontSize: 18,
        //       )),
        //   onTap: () => this.setState(() {
        //     // if (selected == false) {
        //     //   price += 20;
        //     // } else {
        //     //   price -= 20;
        //     // }
        //     this.neckPatch = false;
        //     this.damanPatch = false;
        //     this.sleevesPatch = false;
        //     this.bottomPatch = false;
        //     this.patchBool = !this.patchBool;
        //   }),
        // ),
        // patchBool == true
        //     ? ListView(
        //         physics: NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         children: [
        //           ListTile(
        //             trailing: CircularCheckBox(
        //                 value: this.neckPatch,
        //                 checkColor: Colors.white,
        //                 activeColor: Colors.blueAccent,
        //                 inactiveColor: Colors.blueAccent,
        //                 disabledColor: Colors.grey,
        //                 onChanged: (val) => this.setState(() {
        //                       // if (selected == false) {
        //                       //   price += 20;
        //                       // } else {
        //                       //   price -= 20;
        //                       // }
        //                       this.neckPatch = !this.neckPatch;
        //                     })),
        //             title: Text(
        //                 DemoLocalizations.of(context)
        //                     .getTranslatedValue("neckPatch"),
        //                 style: TextStyle(
        //                   fontFamily: 'CodeProlight',
        //                   color: Colors.black,
        //                   fontSize: 22,
        //                 )),
        //             onTap: () => this.setState(() {
        //               // if (selected == false) {
        //               //   price += 20;
        //               // } else {
        //               //   price -= 20;
        //               // }
        //               this.neckPatch = !this.neckPatch;
        //             }),
        //           ),
        //           ListTile(
        //             trailing: CircularCheckBox(
        //                 value: this.sleevesPatch,
        //                 checkColor: Colors.white,
        //                 activeColor: Colors.blueAccent,
        //                 inactiveColor: Colors.blueAccent,
        //                 disabledColor: Colors.grey,
        //                 onChanged: (val) => this.setState(() {
        //                       // if (selected == false) {
        //                       //   price += 20;
        //                       // } else {
        //                       //   price -= 20;
        //                       // }
        //                       this.sleevesPatch = !this.sleevesPatch;
        //                     })),
        //             title: Text(
        //                 DemoLocalizations.of(context)
        //                     .getTranslatedValue("sleevesPatch"),
        //                 style: TextStyle(
        //                   fontFamily: 'CodeProlight',
        //                   color: Colors.black,
        //                   fontSize: 22,
        //                 )),
        //             onTap: () => this.setState(() {
        //               // if (selected == false) {
        //               //   price += 20;
        //               // } else {
        //               //   price -= 20;
        //               // }
        //               this.sleevesPatch = !this.sleevesPatch;
        //             }),
        //           ),
        //           ListTile(
        //             trailing: CircularCheckBox(
        //                 value: this.damanPatch,
        //                 checkColor: Colors.white,
        //                 activeColor: Colors.blueAccent,
        //                 inactiveColor: Colors.blueAccent,
        //                 disabledColor: Colors.grey,
        //                 onChanged: (val) => this.setState(() {
        //                       // if (selected == false) {
        //                       //   price += 20;
        //                       // } else {
        //                       //   price -= 20;
        //                       // }
        //                       this.damanPatch = !this.damanPatch;
        //                     })),
        //             title: Text(
        //                 DemoLocalizations.of(context)
        //                     .getTranslatedValue("damanPatch"),
        //                 style: TextStyle(
        //                   fontFamily: 'CodeProlight',
        //                   color: Colors.black,
        //                   fontSize: 22,
        //                 )),
        //             onTap: () => this.setState(() {
        //               // if (selected == false) {
        //               //   price += 20;
        //               // } else {
        //               //   price -= 20;
        //               // }
        //               this.damanPatch = !this.damanPatch;
        //             }),
        //           ),
        //           ListTile(
        //             trailing: CircularCheckBox(
        //                 value: this.bottomPatch,
        //                 checkColor: Colors.white,
        //                 activeColor: Colors.blueAccent,
        //                 inactiveColor: Colors.blueAccent,
        //                 disabledColor: Colors.grey,
        //                 onChanged: (val) => this.setState(() {
        //                       // if (selected == false) {
        //                       //   price += 20;
        //                       // } else {
        //                       //   price -= 20;
        //                       // }
        //                       this.bottomPatch = !this.bottomPatch;
        //                     })),
        //             title: Text(
        //                 DemoLocalizations.of(context)
        //                     .getTranslatedValue("bottomPatch"),
        //                 style: TextStyle(
        //                   fontFamily: 'CodeProlight',
        //                   color: Colors.black,
        //                   fontSize: 22,
        //                 )),
        //             onTap: () => this.setState(() {
        //               // if (selected == false) {
        //               //   price += 20;
        //               // } else {
        //               //   price -= 20;
        //               // }
        //               this.bottomPatch = !this.bottomPatch;
        //             }),
        //           ),
        //         ],
        //       )
        //     : Container(),
        SizedBox(height: 40),
        Align(
          alignment: getalignment(myLocale.languageCode),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
                DemoLocalizations.of(context).getTranslatedValue("notes"),
                style: TextStyle(
                    fontFamily: 'CodeProlight',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Align(
          alignment: getalignment(myLocale.languageCode),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
                DemoLocalizations.of(context)
                    .getTranslatedValue("notes_text_blouse"),
                style: TextStyle(
                  fontFamily: 'CodeProlight',
                  color: Colors.black,
                  fontSize: 16,
                )),
          ),
        ),
        SizedBox(height: 20),
        notesData.length > 0
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notesData.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: additionNoteContainer(notesData[index].image,
                          notesData[index].note, index));
                })
            : Container(),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 60,
                    decoration: kBoxDecorationStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: deviceWidth * .52,
                          child: TextFormField(
                            onEditingComplete: () {
                              if (notesController.text.trim().length > 0 ||
                                  _tempNoteImage != null) {
                                setState(() {
                                  notesData.add(Note(
                                      _tempNoteImage != null
                                          ? _tempNoteImage
                                          : null,
                                      notesController.text.trim()));
                                  _tempNoteImage = null;
                                  notesController.clear();
                                });
                              }
                            },
                            controller: notesController,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'CodeProlight',
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 30.0),
                              hintText: DemoLocalizations.of(context)
                                  .getTranslatedValue("add_a_note"),
                              hintStyle: kHintTextStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                final pickedFile = await picker.getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50);

                                setState(() {
                                  if (pickedFile != null) {
                                    _tempNoteImage = File(pickedFile.path);
                                  } else {
                                    print('No image selected.');
                                  }
                                });
                              },
                              child: _tempNoteImage == null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: IconButton(
                                          icon: Icon(
                                            CupertinoIcons.photo_camera_solid,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: getNotesImage
                                          //() async {
                                          //   // FilePickerResult result =
                                          //   //     await FilePicker.platform
                                          //   //         .pickFiles();

                                          //   // if (result != null) {
                                          //   //   File file =
                                          //   //       File(result.files.single.path);
                                          //   // } else {
                                          //   //   // User canceled the picker
                                          //   // }
                                          //   final pickedFile =
                                          //       await picker.getImage(
                                          //           source: ImageSource.gallery,
                                          //           imageQuality: 50);

                                          //   setState(() {
                                          //     if (pickedFile != null) {
                                          //       _tempNoteImage =
                                          //           File(pickedFile.path);
                                          //     } else {
                                          //       print('No image selected.');
                                          //     }
                                          //   });
                                          // },
                                          ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.file(
                                        _tempNoteImage,
                                        fit: BoxFit.contain,
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
                                                      child: Center(
                                                          child:
                                                              CupertinoActivityIndicator())),
                                            );
                                          }
                                        },
                                      ),
                                    )),
                        )
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: FlatButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    if (notesController.text.trim().length > 0 ||
                        _tempNoteImage != null) {
                      setState(() {
                        notesData.add(Note(
                            _tempNoteImage != null ? _tempNoteImage : null,
                            notesController.text.trim()));
                        _tempNoteImage = null;
                        notesController.clear();
                      });
                    }
                    print(notesData[0]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      DemoLocalizations.of(context).getTranslatedValue("add"),
                      style: TextStyle(
                          fontFamily: 'CodeProlight',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CupertinoButton(
          padding: EdgeInsets.all(0),
          child: isUploading == false
              ? Text(
                  DemoLocalizations.of(context).getTranslatedValue("next"),
                  style: TextStyle(
                      fontFamily: 'CodePro',
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                )
              : CupertinoActivityIndicator(),
          onPressed: _fabricImage != null
              ? isUploading == false
                  ? () {
                      uploadData();
                    }
                  : () {}
              : () {
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          actions: [
                            CupertinoButton(
                              child: Text(
                                DemoLocalizations.of(context)
                                    .getTranslatedValue("ok"),
                              ),
                              onPressed: () {
                                return Navigator.pop(context);
                              },
                            )
                          ],
                          title: Column(
                            children: [
                              Icon(CupertinoIcons.exclamationmark_triangle),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  DemoLocalizations.of(context)
                                      .getTranslatedValue("salwar_notice"),
                                  style: TextStyle(
                                      fontFamily: 'Graphik',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ],
                          ),
                        );
                      });
                },
        ),
        SizedBox(
          height: 70,
        )
      ],
    );
  }

  Locale myLocale;

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(
            DemoLocalizations.of(context).getTranslatedValue("blouse"),
            style: TextStyle(
                fontFamily: 'CodeProlight',
                fontWeight: FontWeight.w800,
                fontSize: 24),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: isUploading == false
                  ? Text(
                      DemoLocalizations.of(context).getTranslatedValue("next"),
                      style: TextStyle(
                          fontFamily: 'CodePro',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    )
                  : CupertinoActivityIndicator(),
              onPressed: _fabricImage != null
                  ? isUploading == false
                      ? () {
                          uploadData();
                        }
                      : () {}
                  : () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              actions: [
                                CupertinoButton(
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .getTranslatedValue("ok"),
                                  ),
                                  onPressed: () {
                                    return Navigator.pop(context);
                                  },
                                )
                              ],
                              title: Column(
                                children: [
                                  Icon(CupertinoIcons.exclamationmark_triangle),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      DemoLocalizations.of(context)
                                          .getTranslatedValue("salwar_notice"),
                                      style: TextStyle(
                                          fontFamily: 'Graphik',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ],
                              ),
                            );
                          });
                    },
            ),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
              child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: buildList(),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 20.0),
              //     child: FlatButton(
              //         color:
              //             isUploading == false ? Colors.blue : Colors.white30,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: new BorderRadius.circular(30.0)),
              //         onPressed: _fabricImage != null
              //             ? isUploading == false
              //                 ? () {
              //                     uploadData();
              //                   }
              //                 : () {}
              //             : () {
              //                 showCupertinoDialog(
              //                     context: context,
              //                     builder: (BuildContext context) {
              //                       return CupertinoAlertDialog(
              //                         actions: [
              //                           CupertinoButton(
              //                             child: Text('Ok'),
              //                             onPressed: () {
              //                               return Navigator.pop(context);
              //                             },
              //                           )
              //                         ],
              //                         title: Column(
              //                           children: [
              //                             Icon(CupertinoIcons
              //                                 .exclamationmark_triangle),
              //                             SizedBox(
              //                               height: 8,
              //                             ),
              //                             Text('Select Your Fabric Image',
              //                                 style: TextStyle(
              //                                     fontFamily: 'Graphik',
              //                                     fontWeight: FontWeight.w700,
              //                                     color: Colors.black)),
              //                           ],
              //                         ),
              //                       );
              //                     });
              //               },
              //         child: Padding(
              //           padding: const EdgeInsets.only(top: 0.0),
              //           child: isUploading == false
              //               ? Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.only(top: 4.0),
              //                       child: Text(
              //                         'Next',
              //                         style: TextStyle(
              //                             fontFamily: 'CodePro',
              //                             color: Colors.white,
              //                             fontWeight: FontWeight.w800,
              //                             fontSize: 20),
              //                       ),
              //                     ),
              //                     Icon(CupertinoIcons.chevron_forward,
              //                         size: 22, color: Colors.white)
              //                   ],
              //                 )
              //               : CupertinoActivityIndicator(),
              //         )),
              //   ),
              // )
            ],
          )),
        ));
  }
}
