import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StitchingScreen extends StatefulWidget {
  @override
  _StitchingScreenState createState() => _StitchingScreenState();
}

class _StitchingScreenState extends State<StitchingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Stitching',
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
