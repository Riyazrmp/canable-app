import 'dart:io';
import 'dart:ui';

import 'package:bellbirdmvp/Stitching/planSelect.dart';
import 'package:bellbirdmvp/Stitching/planSelect_Pak.dart';
import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class PakistaniSuit extends StatefulWidget {
  @override
  _PakistaniSuitState createState() => _PakistaniSuitState();
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

class _PakistaniSuitState extends State<PakistaniSuit> {
  List<String> imageUrls = <String>[];
  bool isUploading = false;
  File _designImage;
  List<Note> notesData = [];
  List<Map> notesAData = [];
  File _fabricImage;
  String _designImageUrl;
  File _tempNoteImage;

  double deviceHeight;
  double deviceWidth;
  String _fabricImageUrl;
  final picker = ImagePicker();

  var patches = new TextEditingController();

  var notesController = new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  uploadData() async {
    if (notesController.text.trim().length > 0) {
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
    var pakPrices = await firestore.collection('prices').doc('pakistani').get();

    await postImage(_designImage)
        .then((designImageUrl) => {_designImageUrl = designImageUrl});
    await postImage(_fabricImage)
        .then((fabricImageUrl) => {_fabricImageUrl = fabricImageUrl})
        .then((value) => {});
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
    setState(() {
      isUploading = false;
    });
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return PlanSelect_Pak(
        designImageUrl: _designImageUrl,
        basicPrice: pakPrices.data()['basicPrice'],
        premiumPrice: pakPrices.data()['premiumPrice'],
        f1b: pakPrices.data()['f1b'],
        f1p: pakPrices.data()['f1p'],
        f2b: pakPrices.data()['f2b'],
        f2p: pakPrices.data()['f2p'],
        f1bdays: pakPrices.data()['f1bdays'],
        f1pdays: pakPrices.data()['f1pdays'],
        astarPrice: pakPrices.data()['astar'],
        fabricImageUrl: _fabricImageUrl,
        patchesNumber: patches.text,
        bottomAstar: bottomSelected,
        topAstar: topSelected,
        lasesSelect: lasesSelect,
        pearlsSelect: pearlsSelect,
        serviceType: 'Pakistani Suit Stitching',
        notes: notesAData,
      );
    }));
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
                  Navigator.pop(context);

                  final pickedFile = await picker.getImage(
                      source: ImageSource.gallery, imageQuality: 50);

                  setState(() {
                    if (pickedFile != null) {
                      _designImage = File(pickedFile.path);
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
                  Navigator.pop(context);
                  final pickedFile = await CameraPicker.pickFromCamera(context,
                      resolutionPreset: ResolutionPreset.medium);

                  await pickedFile.file.then((value) {
                    setState(() {
                      _designImage = value;
                    });
                  });

                  setState(() {
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
                        .getTranslatedValue("select_design"),
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

  Future getFabricImage() async {
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
                  Navigator.pop(context);
                  final pickedFile = await CameraPicker.pickFromCamera(context,
                      resolutionPreset: ResolutionPreset.medium);

                  await pickedFile.file.then((value) {
                    setState(() {
                      _fabricImage = value;
                    });
                  });

                  setState(() {
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

  String _error = 'No Error Dectected';
  bool topSelected = false;
  bool bottomSelected = false;
  bool patchesSelect = false;
  bool lasesSelect = false;
  bool pearlsSelect = false;

  buildList() {
    return ListView(
      physics: BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            _designImage == null
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5, top: 5, bottom: 5),
                    child: GestureDetector(
                      onTap: getDesignImage,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 0, left: 0, right: 7, bottom: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8, bottom: 3),
                                child: IconButton(
                                    color: Colors.blue,
                                    icon: Icon(
                                      CupertinoIcons.camera_fill,
                                      size: 40,
                                    ),
                                    onPressed: () {}),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, bottom: 7),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              DemoLocalizations.of(context)
                                                  .getTranslatedValue(
                                                      "upload_design"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'CodeProlight',
                                                  fontSize: 19,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 8),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            child: Stack(children: [
                              Image.file(
                                _designImage,
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
                                    _designImage = null;
                                  });
                                },
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
            _fabricImage == null
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 10, top: 5, bottom: 5),
                    child: GestureDetector(
                      onTap: getFabricImage,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 0, left: 0, right: 7, bottom: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8, bottom: 3),
                                child: IconButton(
                                    color: Colors.blue,
                                    icon: Icon(
                                      CupertinoIcons.camera_fill,
                                      size: 40,
                                    ),
                                    onPressed: () {}),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, bottom: 7),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              DemoLocalizations.of(context)
                                                  .getTranslatedValue(
                                                      "upload_fabric"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'CodeProlight',
                                                  fontSize: 19,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
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
        SizedBox(
          height: 15,
        ),
        Align(
          alignment: getalignment(myLocale.languageCode),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
                DemoLocalizations.of(context).getTranslatedValue("patches"),
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CodeProlight',
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: kBoxDecorationStyle,
              child: TextFormField(
                controller: patches,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Please Enter your City';
                  }

                  return null;
                },
                onFieldSubmitted: (j) {
                  FocusScope.of(context).unfocus();
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  setState(() {
                    patches.text = v;
                  });
                },
                style: TextStyle(
                    fontFamily: 'CodeProlight', fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 0.0),
                  hintText: DemoLocalizations.of(context)
                      .getTranslatedValue("patch_number"),
                  hintStyle: kHintTextStyle,
                ),
              )),
        ),
        SizedBox(height: 20),
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
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 9.0, right: 9),
            child: Container(
              height: 40,
              child: Image.asset('assets/bottomSS1.png'),
            ),
          ),
          trailing: CircularCheckBox(
              value: this.bottomSelected,
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
                    this.bottomSelected = !this.bottomSelected;
                  })),
          title:
              Text(DemoLocalizations.of(context).getTranslatedValue("bottom"),
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
            this.bottomSelected = !this.bottomSelected;
          }),
        ),
        SizedBox(height: 20),
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
                DemoLocalizations.of(context).getTranslatedValue("notes_text"),
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
                    padding: EdgeInsets.all(2),
                    height: 60,
                    decoration: kBoxDecorationStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: deviceWidth * .44,
                          child: TextFormField(
                            onEditingComplete: () {
                              if (notesController.text.trim().length > 0) {
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
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'CodeProlight',
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 0.0),
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
                                  ? IconButton(
                                      icon: Icon(
                                        CupertinoIcons.photo_fill,
                                      ),
                                      onPressed: () async {
                                        final pickedFile =
                                            await picker.getImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 50);

                                        setState(() {
                                          if (pickedFile != null) {
                                            _tempNoteImage =
                                                File(pickedFile.path);
                                          } else {
                                            print('No image selected.');
                                          }
                                        });
                                      },
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
                    if (notesController.text.trim().length > 0) {
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
          height: 7,
        ),
        CupertinoButton(
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
          onPressed: _designImage != null &&
                  _fabricImage != null &&
                  patches.text.isNotEmpty
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
                                      .getTranslatedValue("patch_notice"),
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
          height: 50,
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
          trailing: CupertinoButton(
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
            onPressed: _designImage != null &&
                    _fabricImage != null &&
                    patches.text.isNotEmpty
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
                                        .getTranslatedValue("patch_notice"),
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
          backgroundColor: Colors.white,
          middle: Text(
            DemoLocalizations.of(context).getTranslatedValue("patches_suit"),
            style: TextStyle(
                fontFamily: 'CodeProlight',
                fontWeight: FontWeight.w800,
                fontSize: 24),
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
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 20.0),
              //     child: FlatButton(
              //         color:
              //             isUploading == false ? Colors.blue : Colors.white30,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: new BorderRadius.circular(30.0)),
              //         onPressed: _designImage != null &&
              //                 _fabricImage != null &&
              //                 patches.text.isNotEmpty
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
              //                             Text(
              //                                 'Select your design and fabric image\nAnd number of patches',
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
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.only(top: 4.0),
              //                       child: Text(
              //                         'Next',
              //                         style: TextStyle(
              //                             fontFamily: 'CodeProlight',
              //                             fontWeight: FontWeight.w900,
              //                             color: Colors.white,
              //                             fontSize: 20),
              //                       ),
              //                     ),
              //                     Icon(
              //                       CupertinoIcons.chevron_forward,
              //                       color: Colors.white,
              //                     )
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
