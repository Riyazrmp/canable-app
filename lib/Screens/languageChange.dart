import 'package:bellbirdmvp/language/language.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/language_constants.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:bellbirdmvp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageChange extends StatefulWidget {
  @override
  _LanguageChangeState createState() => _LanguageChangeState();
}

class _LanguageChangeState extends State<LanguageChange> {
  Language tempLang;
  void changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);

    TailorsHub.setLocale(context, _temp);
  }

  void changeLanguagelist(languageCode) async {
    Locale _temp = await setLocale(languageCode);

    TailorsHub.setLocale(context, _temp);
  }

  List<String> langName = ['English', 'اردو', 'हिंदी'];
  List<String> langugaeCode = ['en', 'ur', 'hi'];
  Locale myLocale;
  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("Language"),
          style: TextStyle(
              fontFamily: 'CodeProlight',
              fontWeight: FontWeight.w800,
              fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: getalignment(myLocale.languageCode),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    DemoLocalizations.of(context)
                        .getTranslatedValue("select_language1"),
                    style: TextStyle(
                        fontFamily: 'CodePro',
                        fontWeight: FontWeight.w800,
                        fontSize: 45),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: getalignment(myLocale.languageCode),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    DemoLocalizations.of(context)
                        .getTranslatedValue("select_language2"),
                    style: TextStyle(
                        fontFamily: 'CodePro',
                        fontWeight: FontWeight.w800,
                        color: Colors.black.withOpacity(0.2),
                        fontSize: 25),
                  ),
                )),
            SizedBox(height: 25),
            GridView.builder(
                shrinkWrap: true,
                itemCount: Language.languageList().length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      changeLanguagelist(langugaeCode[index]);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            height: 10,
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  myLocale.languageCode == langugaeCode[index]
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                          ),
                                          top: BorderSide(
                                              width: 3, color: Colors.blue),
                                          left: BorderSide(
                                              width: 3, color: Colors.blue),
                                          right: BorderSide(
                                              width: 3, color: Colors.blue))
                                      : Border(),
                              color: Colors.grey[200],
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.13),
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              langName[index],
                              style: TextStyle(
                                  fontFamily: 'CodePro',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  fontSize: 25),
                            )))),
                  );
                }),
            // DropdownButton(
            //   underline: SizedBox(),
            //   onChanged: (Language lang) {
            //     changeLanguage(lang);
            //   },
            //   hint: Text(
            //     'Select Language',
            //     style: TextStyle(
            //         fontFamily: 'CodePro',
            //         fontWeight: FontWeight.w800,
            //         fontSize: 22),
            //   ),
            //   icon: Icon(Icons.language),
            //   items: Language.languageList()
            //       .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
            //           value: lang,
            //           child: Text(
            //             lang.name,
            //             style: TextStyle(
            //                 fontFamily: 'CodeProlight',
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 22),
            //           )))
            //       .toList(),
            // ),
          ],
        ),
      ),
    );
  }
}

class Language {
  final int id;
  final String name;
  final String languageCode;
  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'English', 'en'),
      Language(2, 'Urdu', 'ur'),
      Language(3, 'हिंदी', 'hi')
    ];
  }
}
