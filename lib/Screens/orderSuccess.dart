import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class OrderSuccess extends StatefulWidget {
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FlareActor('assets/ani1.flr',fit: BoxFit.contain,alignment: Alignment.center,animation: 'Untitled',),
      
    );
  }
}