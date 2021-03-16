import 'dart:convert';

import 'package:bellbirdmvp/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/service.dart';
class Services with ChangeNotifier{

    List <Service>  _items= [
  
  ];
  var odata;

 void getdada()  async{

Response response= await get('https://raw.githubusercontent.com/Riyazrmp/json/master/data.json');


print("datadatadata");

odata = jsonDecode(response.body);
notifyListeners();



}
Stream getConversation(String conversationId) {
    var ref = Firestore.instance
        .collection('conversations')
        .document('yskWUp7xadxnjWiUHkxF')
        .collection('conversations');

    return ref.snapshots();
  }
  


Future<void> fetchAndSetProducts() async {
    const url = 'https://tailorshub-54f41.firebaseio.com/';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Service> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Service(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

    List <Service> get items {

     


      return [..._items];
      }
    }

