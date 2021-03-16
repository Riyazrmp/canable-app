import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
bool _isnew = false;

class Auth2 with ChangeNotifier {
  static Future<auth.User> handleSignIn() async {
    final GoogleSignInAccount googleUser =
        await _googleSignIn.signIn().catchError((e) {
      print(e);
    });
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final result = (await _auth.signInWithCredential(credential).timeout(
        const Duration(seconds: 5),
        onTimeout: () => Future.error(Exception(
            "Unable to sign in. Please check your network connection."))));

    if (result.additionalUserInfo.isNewUser) {
      _isnew = true;

      firestore.collection('Users').doc(result.user.uid).set({
        'id': result.user.uid,
        'email': result.user.email,
        'referralCode': randomAlphaNumeric(9),
        'displayName': result.user.displayName,
        'isNew': true,
        'username': result.user.displayName,
        'photoUrl': result.user.photoURL,
        'bio': 'hello world',
      });
    } else {
      firestore
          .collection('Users')
          .doc(result.user.uid)
          .update({'isNew': false});
    }

    print("signed in " + result.user.displayName);

    return result.user;
  }

  giveNew() {
    return _isnew;
  }

  handleSign() async {
    await auth.FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}
