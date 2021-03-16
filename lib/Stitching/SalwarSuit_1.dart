import 'package:bellbirdmvp/Stitching/SalwarSuitEdititingScreen.dart';
import 'package:bellbirdmvp/Stitching/planSelect.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SalwarSuit_1 extends StatefulWidget {
  @override
  _SalwarSuit_1State createState() => _SalwarSuit_1State();
}

class _SalwarSuit_1State extends State<SalwarSuit_1> {
  static const double AnimationWidth = 620.0;
  static const double AnimationHeight = 280.0;

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

  getarrow(languageCode) {
    switch (languageCode) {
      case 'en':
        return CupertinoIcons.chevron_forward;
      case 'hi':
        return CupertinoIcons.chevron_forward;
      case 'ur':
        return CupertinoIcons.chevron_back;
        break;
      default:
    }
  }

  getarrowback(languageCode) {
    switch (languageCode) {
      case 'en':
        return CupertinoIcons.chevron_back;
      case 'hi':
        return CupertinoIcons.chevron_back;
      case 'ur':
        return CupertinoIcons.chevron_forward;
        break;
      default:
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
                return SalwarSuitEditingScreen(myLocale.languageCode);
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
      body: SafeArea(
        child: Column(
          children: [
            Align(
                alignment: getalignment(myLocale.languageCode),
                child: IconButton(
                    icon: Icon(
                      getarrowback(myLocale.languageCode),
                      size: 36,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                Container(
                  width: AnimationWidth,
                  height: AnimationHeight,
                  child: FlareActor(
                    'assets/shavez1.flr',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    animation: 'Aura',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: getalignment(myLocale.languageCode),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 24, right: 5),
                child: Text(
                  DemoLocalizations.of(context)
                      .getTranslatedValue("salwar_suit_h1"),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'CodePro',
                      fontWeight: FontWeight.w800,
                      fontSize: 34),
                ),
              ),
            ),
            Align(
              alignment: getalignment(myLocale.languageCode),
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 5),
                child: Text(
                    DemoLocalizations.of(context)
                        .getTranslatedValue("salwar_suit_h2"),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontFamily: 'CodeProlight', fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
