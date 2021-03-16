import 'package:flutter/material.dart';



class ImageBox extends StatefulWidget {

  @override
  _ImageBoxState createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {



    return Container(

      child:Center(
        
       child: new ListView.builder(
         itemBuilder: (context, index){
          return new Padding(
            padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child:new Card(
elevation: 10
              ,shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0)
              ),
              child: new Column(
                children: <Widget>[
                  new ClipRRect(
                    child: new Image.asset('assets/img.png'),
                    borderRadius: BorderRadius.circular(4.0
                    ),
                    
                  ),
                   new Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Column(children: <Widget>[
                    new Text('elon musk')
                  ],),
                  ),
                  
                  ],
            ) ,
            ) );
         },
         itemCount: 10,
       ),
      ) 
      
    );
  }
}