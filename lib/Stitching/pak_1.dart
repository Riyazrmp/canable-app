import 'package:bellbirdmvp/Screens/pakistaniSuit.dart';
import 'package:bellbirdmvp/Stitching/sendYourDesign.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pak_1 extends StatefulWidget {
  @override
  _Pak_1State createState() => _Pak_1State();
}

class _Pak_1State extends State<Pak_1> {
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

  getFlr(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/pakistaniSuit.flr';

        break;
      case 'hi':
        return 'assets/pakistaniSuit2.flr';

        break;
      case 'ur':
        return 'assets/pakistaniSuit1.flr';
        break;
      default:
        'assets/pakistaniSuit.flr';
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FlatButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) {
                return PakistaniSuit();
              }));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    DemoLocalizations.of(context)
                        .getTranslatedValue("continue"),
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
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
      ),
      body: FlareActor(
        getFlr(myLocale.languageCode),
        fit: BoxFit.contain,
        alignment: Alignment.center,
        animation: 'Untitled',
      ),
    );
  }
}
