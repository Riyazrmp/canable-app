import 'package:bellbirdmvp/Providers/auth2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class GScreen extends StatefulWidget {
  @override
  _GScreenState createState() => _GScreenState();
}

class _GScreenState extends State<GScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  Future<bool> _loginUser() async {
    final api = await Auth2.handleSignIn();

    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading: Image.asset('assets/12.png'),
          backgroundColor: Colors.white,
          transitionBetweenRoutes: false,
          border: Border(bottom: BorderSide(width: 0, color: Colors.white)),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Welcome,',
                                style: TextStyle(
                                    fontFamily: 'CodePro',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 45),
                              ),
                            )),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'SignIn to continue',
                                style: TextStyle(
                                    fontFamily: 'CodePro',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black.withOpacity(0.2),
                                    fontSize: 35),
                              ),
                            )),
                      ])),
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _isLoading
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          child: SpinKitWave(
                            color: Colors.grey,
                            size: 70,
                          ),
                        )
                      : Container(
                          alignment: Alignment.bottomCenter,
                          child: GoogleSignInButton(
                            borderRadius: 20,
                            darkMode: true,
                            onPressed: () async {
                              setState(() => _isLoading = true);

                              bool b = await _loginUser().whenComplete(() {
                                _isLoading = false;
                              });
                              setState(() => _isLoading = false);
                              if (b == true) {
                                setState(() => _isLoading = false);
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("Wrong email or")));
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                          ),
                        ),
                ),
              )
            ],
          ),
        ));
  }
}
