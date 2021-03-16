import 'package:flutter/material.dart';



class CustomAppBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only( top: 0),
        padding: EdgeInsets.symmetric(horizontal: 20),
        
      ),
    );
  }
}