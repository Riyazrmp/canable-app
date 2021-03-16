import 'package:bellbirdmvp/models/custom.dart';
import 'package:flutter/material.dart';

class Customs with ChangeNotifier{

    List <Custom>  _items= [
  Custom(
    value : 1,
    title: 'Red Shirt',
    
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),

  Custom(
    value:0,
    title: 'Blue Shirt',
    price : '255',
imageUrl:'assets/img.png'
), 
  Custom(
    value: 2,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
    value: 3,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 4,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 5,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/parts/nck.png'
),Custom(
  value: 6,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 7,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 8,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 9,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 10,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 11,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),Custom(
  value: 12,
    title: 'white Shirt',
    price: '29.99',
imageUrl:'assets/Sshirt.jpg'
),  ];

var xGroupvalue=3;
 void changeHandler(int e){

  xGroupvalue = e;
notifyListeners();
}
    List <Custom> get items {

     


      return [..._items];
      }
    }

