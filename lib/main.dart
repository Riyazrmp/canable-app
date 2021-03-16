import 'package:bellbirdmvp/Stitching/SalwarSuitEdititingScreen.dart';
import 'package:bellbirdmvp/Tabs-screens/BottomBar.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/models/connectivity_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';

import 'Providers/auth.dart';
import 'Providers/auth2.dart';
import 'Providers/connectivity.dart';
import 'Providers/customs.dart';
import 'Providers/services.dart';
import 'Providers/user.dart';
import 'Screens/googlesignScreen.dart';
import 'localization/language_constants.dart';
import 'models/const.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TailorsHub());
}

class TailorsHub extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _TailorsHubState state =
        context.findAncestorStateOfType<_TailorsHubState>();
    state.setLocale(locale);
  }

  @override
  _TailorsHubState createState() => _TailorsHubState();
}

class _TailorsHubState extends State<TailorsHub> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setState(() {
          _locale = locale;
        }));

    super.didChangeDependencies();
  }

  @override
  void initState() {
    print("Works!");
    handlePushM();
    super.initState();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  handlePushM() async {
    var token = await FirebaseMessaging().getToken();
    var uid = FirebaseAuth.instance.currentUser;
    await firestore
        .collection('Users')
        .doc(uid.uid)
        .update({'fcmToken': token});
    FirebaseMessaging().configure(onLaunch: (message) async {
      print(message);
    }, onMessage: (message) async {
      print(message);
    }, onResume: (message) async {
      print(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(child: Center(child: CupertinoActivityIndicator()));
    } else {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Auth(),
            ),
            ChangeNotifierProvider.value(
              value: Auth2(),
            ),
            ChangeNotifierProvider.value(
              value: Userdata(),
            ),
            ChangeNotifierProvider(create: (_) => Services()),
            ChangeNotifierProvider(create: (_) => Customs()),
          ],
          child: Consumer<Auth2>(
              builder: (
            ctx,
            auth,
            _,
          ) =>
                  StreamProvider<ConnectivityStatus>(
                    create: (context) =>
                        ConnectivityService().connectionStatusController.stream,
                    child: MaterialApp(
                      locale: _locale,
                      localizationsDelegates: [
                        DemoLocalizations.delegate,
                        // ... app-specific localization delegate[s] here
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      localeResolutionCallback:
                          (deviceLocale, supportedLocales) {
                        for (var locale in supportedLocales) {
                          if (locale.languageCode ==
                                  deviceLocale.languageCode &&
                              locale.countryCode == deviceLocale.countryCode) {
                            return deviceLocale;
                          }
                        }
                        return supportedLocales.first;
                      },
                      supportedLocales: [
                        Locale('en', 'US'),
                        Locale('ur', 'PK'),
                        Locale('hi', 'IN'),
                      ],
                      theme: Constants.lightTheme,
                      title: 'Connectivity Aware UI',
                      home: handleStart(),
                      routes: <String, WidgetBuilder>{
                        '/screen1': (BuildContext context) => new TailorsHub(),
                      },
                      debugShowCheckedModeBanner: false,
                    ),
                  )));
    }
  }
}

Widget handleStart() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SpinKitWave(
                color: Colors.black,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return BottomBar();
        } else {
          return GScreen();
        }
      });
}
