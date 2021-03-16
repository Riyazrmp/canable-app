
import 'package:bellbirdmvp/imageBox.dart';
import 'package:flutter/material.dart';

class NavigationDawer extends StatefulWidget {
  @override
  _NavigationDawerState createState() => _NavigationDawerState();
}

class _NavigationDawerState extends State<NavigationDawer> {
  
  int maxWidth= 230;
  int minWidth= 80;
  
  @override
  Widget build(BuildContext context) {
     double width = MediaQuery. of(context). size.width;

    return Container(
width: width/2.3,
color:Colors.grey[200]
      ,child: Column(
children: <Widget>[

SizedBox(height: 20,)
,Expanded(
  child:   ImageBox()
)






],

        
      ),
    );
  }
}