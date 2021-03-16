import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Map extends StatefulWidget {

  
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,padding:EdgeInsets.all(0)
      ,child: Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[


 
                    Row(mainAxisSize: MainAxisSize.max,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Expanded(child: Material(color: Colors.white,elevation: 10,child: Image.asset('assets/kandha right.png',))),
                            Expanded(child: Image.asset('assets/gala.png')),
              Expanded(child: Image.asset('assets/kandha left.png')),

              

            ],),
             Row(children: <Widget>[
              Expanded(child: Image.asset('assets/sleeeeve right.png',),),
                            Expanded(child: Image.asset('assets/bottom.png')),
              Expanded(child: Image.asset('assets/sleeve left.png')),

              

            ],),
             
              

            
             Row(children: <Widget>[
              Expanded(child: Image.asset('assets/chaq right.png',fit: BoxFit.fill,)),
              Expanded(child: Image.asset('assets/damann.png',fit: BoxFit.fill,)),
              Expanded(child: Image.asset('assets/chaq left.png',fit: BoxFit.fill,)),
                            

            ],),
            
                  ])

            ,
          
    );
    
    
  }
}


