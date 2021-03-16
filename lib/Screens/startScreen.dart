import 'package:bellbirdmvp/Screens/Frock/frockEditingDivision.dart';
import 'package:bellbirdmvp/Screens/Garara%20Farara/GararaEditingDivision.dart';
import 'package:bellbirdmvp/Screens/Lehenga/LehengaEditingDivision.dart';
import 'package:bellbirdmvp/Screens/blouse/blouseEditingDivision.dart';
import 'package:bellbirdmvp/Stitching/SalwarSuitEdititingScreen.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreenSelect extends StatefulWidget {
  @override
  _StartScreenSelectState createState() => _StartScreenSelectState();
}

class _StartScreenSelectState extends State<StartScreenSelect> {
  Locale myLocale;

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text(
          DemoLocalizations.of(context).getTranslatedValue("select_category"),
          style: TextStyle(
              fontFamily: 'CodePro', fontWeight: FontWeight.w800, fontSize: 24),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return SalwarSuitEditingScreen(myLocale.languageCode);
                }));
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        DemoLocalizations.of(context)
                            .getTranslatedValue("suit"),
                        style: TextStyle(
                            fontFamily: "CodeProlight",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/suitImage.png'),
                    )
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(context, CupertinoPageRoute(builder: (context) {
          //         return GararaEditingDivision(myLocale.languageCode);
          //       }));
          //     },
          //     child: Container(
          //       height: 80,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: Colors.grey[50],
          //         boxShadow: <BoxShadow>[
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.09),
          //             blurRadius: 4,
          //             offset: Offset(0, 0),
          //           ),
          //         ],
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(left: 10.0),
          //             child: Text(
          //               'Garara/Sharara',
          //               style: TextStyle(
          //                   fontFamily: "CodeProlight",
          //                   fontSize: 25,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(12.0),
          //             child: Image.asset('assets/frockImage.png'),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return BlouseEditingDivision(myLocale.languageCode);
                }));
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        DemoLocalizations.of(context)
                            .getTranslatedValue("blouse"),
                        style: TextStyle(
                            fontFamily: "CodeProlight",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 5, top: 24, bottom: 23),
                      child: Image.asset('assets/blouse.png'),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return FrockEditingDivision(myLocale.languageCode);
                }));
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        DemoLocalizations.of(context)
                            .getTranslatedValue("frock"),
                        style: TextStyle(
                            fontFamily: "CodeProlight",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/frockImage.png'),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return LehengaEditingDivision(myLocale.languageCode);
                }));
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        DemoLocalizations.of(context)
                            .getTranslatedValue("lehenga"),
                        style: TextStyle(
                            fontFamily: "CodeProlight",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Image.asset('assets/lehengaimage.png'),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return GararaEditingDivision(myLocale.languageCode);
                }));
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        DemoLocalizations.of(context)
                            .getTranslatedValue("gararaFarara"),
                        style: TextStyle(
                            fontFamily: "CodeProlight",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Image.asset('assets/gararaImage.png'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
