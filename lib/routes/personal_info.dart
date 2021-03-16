import 'dart:convert';

import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class PersonalInfo extends StatefulWidget {

final String userID;

PersonalInfo(this.userID);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController controller = new TextEditingController();
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();


adddata () async{

    final url1 =  "http://bellbird.xyz/add.php";
await http.post(url1,body: {

'id': widget.userID,
'name': controller.text,
'phone':controller1.text,
'address': controller2.text,
'city': controller3.text

});
print('kjgkgugguygugygugy');


}


  Future<Map> getdata() async {

    final url =  "http://bellbird.xyz/get2.php";
    http.Response response = await http.post(
        url,body: {

          'id': widget.userID
        });
        
    var data = jsonDecode(response.body);
controller.text = data['name'];
controller1.text= data['phone'];
controller2.text = data['address'];
controller3.text = data['city'];
    print(data);

    return data;
  }

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "SETUP YOUR PROFILE",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontFamily: 'Graphik'),
        ),
      ),
      body: FutureBuilder(
          future: getdata(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitChasingDots(
                color: Colors.black,
              );
            } 
            
            else if(snapshot.connectionState==ConnectionState.none){

return CupertinoActivityIndicator();
            }
            
            
            else {
              return Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(
                        'Name',
                        style: TextStyle(
                            fontFamily: 'Graphik', color: Colors.black),
                      ),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.portrait,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your Name',
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(height: 30),
                      Text(
                        'Phone No.',
                        style: TextStyle(
                            fontFamily: 'Graphik', color: Colors.black),
                      ),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            controller: controller1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.phone_paused,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your Phone No.',
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(height: 30),
                      Text(
                        'Address',
                        style: TextStyle(
                            fontFamily: 'Graphik', color: Colors.black),
                      ),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            controller: controller2,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your Address',
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                      SizedBox(height: 30),
                      Text(
                        'City',
                        style: TextStyle(
                            fontFamily: 'Graphik', color: Colors.black),
                      ),
                      Container(
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            controller: controller3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your City',
                              hintStyle: kHintTextStyle,
                            ),
                          )),
                          CupertinoButton(child: Text('SAVE',style:TextStyle(fontFamily: 'Graphik')), onPressed: (){

                            adddata();
                          })
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
