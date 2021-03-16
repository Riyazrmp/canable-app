import 'package:bellbirdmvp/Screens/pakistaniSuit.dart';
import 'package:bellbirdmvp/Stitching/SalwarSuit_1.dart';
import 'package:bellbirdmvp/Stitching/pak_1.dart';
import 'package:bellbirdmvp/Stitching/sendYourDesign_1.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrowseByCategory extends StatefulWidget {
  @override
  _BrowseByCategoryState createState() => _BrowseByCategoryState();
}

class _BrowseByCategoryState extends State<BrowseByCategory> {
  List<String> categories = ['salwar_suit', 'patches_suit', 'send_your_design'];
  List<Widget> screens = [SalwarSuit_1(), Pak_1(), SendYourDesign_1()];
  Locale myLocale;
  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("browse"),
          style: TextStyle(
              fontFamily: 'CodeProlight',
              fontWeight: FontWeight.w800,
              fontSize: 24),
        ),
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return screens[index];
                }));
              },
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                          DemoLocalizations.of(context)
                              .getTranslatedValue(categories[index]),
                          style: TextStyle(
                              fontFamily: 'CodeProlight', fontSize: 18)),
                      trailing: Icon(getarrow(myLocale.languageCode)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 5,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
