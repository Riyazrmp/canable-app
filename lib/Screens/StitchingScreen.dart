import 'package:bellbirdmvp/Screens/pakistaniSuit.dart';
import 'package:bellbirdmvp/Screens/startScreen.dart';
import 'package:bellbirdmvp/Stitching/SalwarSuitEdititingScreen.dart';
import 'package:bellbirdmvp/Stitching/SalwarSuit_1.dart';
import 'package:bellbirdmvp/Stitching/category.dart';
import 'package:bellbirdmvp/Stitching/measurement.dart';
import 'package:bellbirdmvp/Stitching/pak_1.dart';
import 'package:bellbirdmvp/Stitching/sendYourDesign.dart';
import 'package:bellbirdmvp/Stitching/sendYourDesign_1.dart';
import 'package:bellbirdmvp/Stitching/stitchingServicePage.dart';
import 'package:bellbirdmvp/localization/demolocalization.dart';
import 'package:bellbirdmvp/localization/uiLang.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StitchingScreen extends StatefulWidget {
  @override
  _StitchingScreenState createState() => _StitchingScreenState();
}

class _StitchingScreenState extends State<StitchingScreen> {
  getSalwarImage(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/homeImage2.png';

        break;
      case 'hi':
        return 'assets/homeImage2.png';

        break;
      case 'ur':
        return 'assets/homeImage2.png';
        break;
      default:
        'assets/homeImage2.png';
    }
  }

  getPatchesImage(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/patchesSuitCard.png';

        break;
      case 'hi':
        return 'assets/patchesSuitCard2.png';

        break;
      case 'ur':
        return 'assets/patchesSuitCard1.png';
        break;
      default:
        'assets/patchesSuitCard.png';
    }
  }

  getSendImage(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/sendYourDesignCard.png';

        break;
      case 'hi':
        return 'assets/sendYourDesignCard2.png';

        break;
      case 'ur':
        return 'assets/sendYourDesignCard1.png';
        break;
      default:
        'assets/sendYourDesignCard.png';
    }
  }

  getButton(languageCode) {
    switch (languageCode) {
      case 'en':
        return 'assets/measurementCard.png';

        break;
      case 'hi':
        return 'assets/measurementCard2.png';

        break;
      case 'ur':
        return 'assets/measurementCard1.png';
        break;
      default:
        'assets/measurementCard.png';
    }
  }

  Locale myLocale;
  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading: Image.asset('assets/12.png'),
          backgroundColor: Colors.white,
          transitionBetweenRoutes: false,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                    child: Image.asset(
                  getSalwarImage(myLocale.languageCode),
                  fit: BoxFit.fill,
                )),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                width: 300,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return StartScreenSelect();

                      //SalwarSuitEditingScreen(myLocale.languageCode);
                    }));
                  },
                  child: FlareActor(
                    'assets/play.flr',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    animation: 'play',
                  ),
                ),
              ),
            ),
          ],
        )

        // // Padding(
        // //   padding: const EdgeInsets.all(9.0),
        // //   child: GestureDetector(
        // //       onTap: () {
        // //         Navigator.push(context,
        // //             CupertinoPageRoute(builder: (context) {
        // //           return SalwarSuit_1();
        // //         }));
        // //       },
        // //       child: Container(
        // //           decoration: BoxDecoration(
        // //             borderRadius: BorderRadius.circular(10),
        // //             color: Colors.grey[100],
        // //             boxShadow: <BoxShadow>[
        // //               BoxShadow(
        // //                 color: Colors.black.withOpacity(0.25),
        // //                 blurRadius: 5,
        // //                 offset: Offset(0, 0),
        // //               ),
        // //             ],
        // //           ),
        // //           child: ClipRRect(
        // //               borderRadius: BorderRadius.circular(9),
        // //               child: Container(
        // //                   child: Image.asset(
        // //                       getSalwarImage(myLocale.languageCode),
        // //                       fit: BoxFit.fill))))),
        // // ),
        // // SizedBox(
        // //   height: 7,
        // // ),
        // // Row(
        // //   children: [
        // //     Expanded(
        // //       child: Padding(
        // //         padding: const EdgeInsets.all(8.0),
        // //         child: GestureDetector(
        // //             onTap: () {
        // //               Navigator.push(context,
        // //                   CupertinoPageRoute(builder: (context) {
        // //                 return SendYourDesign_1();
        // //               }));
        // //             },
        // //             child: Container(
        // //                 decoration: BoxDecoration(
        // //                   borderRadius: BorderRadius.circular(10),
        // //                   color: Colors.grey[100],
        // //                   boxShadow: <BoxShadow>[
        // //                     BoxShadow(
        // //                       color: Colors.black.withOpacity(0.25),
        // //                       blurRadius: 5,
        // //                       offset: Offset(0, 0),
        // //                     ),
        // //                   ],
        // //                 ),
        // //                 child: Container(
        // //                     child: Image.asset(
        // //                   getSendImage(myLocale.languageCode),
        // //                 )))),
        // //       ),
        // //     ),
        // //     Expanded(
        // //       child: Padding(
        // //         padding: const EdgeInsets.all(8.0),
        // //         child: GestureDetector(
        // //             onTap: () {
        // //               Navigator.push(context,
        // //                   CupertinoPageRoute(builder: (context) {
        // //                 return Pak_1();
        // //               }));
        // //             },
        // //             child: Container(
        // //                 decoration: BoxDecoration(
        // //                   borderRadius: BorderRadius.circular(20),
        // //                   color: Colors.grey[100],
        // //                   boxShadow: <BoxShadow>[
        // //                     BoxShadow(
        // //                       color: Colors.black.withOpacity(0.25),
        // //                       blurRadius: 5,
        // //                       offset: Offset(0, 0),
        // //                     ),
        // //                   ],
        // //                 ),
        // //                 child: Container(
        // //                     child: Image.asset(
        // //                   getPatchesImage(myLocale.languageCode),
        // //                 )))),
        // //       ),
        // //     ),
        // //   ],
        // // ),
        // // SizedBox(
        // //   height: 7,
        // // ),
        // // Padding(
        // //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // //   child: GestureDetector(
        // //     onTap: () {
        // //       Navigator.push(context,
        // //           CupertinoPageRoute(builder: (context) {
        // //         return BrowseByCategory();
        // //       }));
        // //     },
        // //     child: Container(
        // //       decoration: BoxDecoration(
        // //         borderRadius: BorderRadius.circular(10),
        // //         color: Color(0xFFECECEC),
        // //         boxShadow: <BoxShadow>[
        // //           BoxShadow(
        // //             color: Colors.black.withOpacity(0.2),
        // //             blurRadius: 6,
        // //             offset: Offset(0, 0),
        // //           ),
        // //         ],
        // //       ),
        // //       child: Container(
        // //         padding: EdgeInsets.all(10),
        // //         child: Row(
        // //           mainAxisAlignment: MainAxisAlignment.center,
        // //           children: [
        // //             Image.asset('assets/stack.png'),
        // //             SizedBox(width: 6),
        // //             Text(
        // //               DemoLocalizations.of(context)
        // //                   .getTranslatedValue("browse"),
        // //               style: TextStyle(
        // //                   fontFamily: 'CodeProlight',
        // //                   fontWeight: FontWeight.bold,
        // //                   fontSize: 22),
        // //             ),
        // //           ],
        // //         ),
        // //       ),
        // //     ),
        // //   ),
        // // ),
        // // SizedBox(height: 14),
        // // Align(
        // //   alignment: Alignment.centerRight,
        // //   child: Padding(
        // //     padding: const EdgeInsets.only(right: 8.0),
        // //     child: GestureDetector(
        // //       onTap: () {
        // //         Navigator.push(context,
        // //             CupertinoPageRoute(builder: (context) {
        // //           return MeasurementScreen();
        // //         }));
        // //       },
        // //       child: Container(
        // //         width: MediaQuery.of(context).size.width / 2,
        // //         decoration: BoxDecoration(
        // //           borderRadius: BorderRadius.circular(20),
        // //           boxShadow: <BoxShadow>[
        // //             BoxShadow(
        // //               color: Colors.black.withOpacity(0.2),
        // //               blurRadius: 4,
        // //               offset: Offset(0, 0),
        // //             ),
        // //           ],
        // //         ),
        // //         child: Image.asset(
        // //           getMeasureImage(myLocale.languageCode),
        // //         ),
        // //       ),
        // //     ),
        // //   ),
        // )

        );
  }
}
