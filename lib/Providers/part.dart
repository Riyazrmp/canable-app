

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Parts with ChangeNotifier{


List <String> partList;
var odata;
void getdada()  async{

http.Response response= await http.get('https://tailorshub-54f41.firebaseio.com/');

if (response.statusCode==200){

print(response.body);

var data = jsonDecode(response.body)[0]['name'];
print(data);



}

else{

print(response.statusCode);

}

}


}