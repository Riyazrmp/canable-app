

import 'package:flutter/material.dart';





class CustomScreen extends StatefulWidget {


final  String imageUrl;
 final  int xvalue;

CustomScreen({this.imageUrl,this.xvalue,});
  
  @override
  CustomScreenState createState() => CustomScreenState();
}


class CustomScreenState extends State<CustomScreen> {

var selectedValue = 3 ;
 

 @override


  Widget build(BuildContext context) {

        
        return  
    
    
               Card(
               child: Radio(
                             
                          groupValue:selectedValue ,
                          value:widget.xvalue ,
                          
                          onChanged: (v){
                            setState(() {
                            selectedValue = v ;
                              
                            });
                              
                           
                          
                         
                            print(
                              selectedValue
                            );
                            print(widget.xvalue);
                          }
                          ,                         

                 
                        ),
       
               
    
         

     
      );
        
      
    
  }
}

