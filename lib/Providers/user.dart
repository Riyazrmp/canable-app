import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Userdata with ChangeNotifier {
  String userName = " hii";
  String userImage;
  String userId;
  void getUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser;

    userName = currentUser.displayName;
    userImage = currentUser.photoUrl;
    userId = currentUser.email;
    notifyListeners();
  }
}
