import 'package:flutter/material.dart';

class Myorders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Card(
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage('https://i.ibb.co/R4Cb5M9/shirt.png')),
        ),
     
      ),
    ) ,
      
    );
  }
}