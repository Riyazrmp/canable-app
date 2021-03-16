import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class MeasurementScreen extends StatefulWidget {
  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  DocumentSnapshot rdoc;
  getImage() async {
    var user = auth.FirebaseAuth.instance.currentUser;

    var doc = await firestore.collection('measurement').doc(user.uid).get();
    setState(() {
      rdoc = doc;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getImage();

    super.initState();
  }

  getFabricPhoto(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/noMeasurement.png';

        break;
      case 'hi':
        return 'assets/noMeasurement1.png';

        break;
      case 'ur':
        return 'assets/noMeasurement2.png';
        break;
      default:
        'assets/noMeasurement.png';
    }
  }

  Locale myLocale;
  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text(
          'Measurements',
          style: TextStyle(
              fontFamily: 'CodeProlight',
              fontWeight: FontWeight.w800,
              fontSize: 24),
        ),
      ),
      body: isLoading == false
          ? rdoc.exists
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(rdoc.data()['image']),
                ))
              : Center(
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(getFabricPhoto(myLocale.languageCode)),
                ))
          : CupertinoActivityIndicator(),
    );
  }
}
