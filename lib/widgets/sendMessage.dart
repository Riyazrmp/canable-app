import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final formkey = GlobalKey<FormState>();
final emailController =  TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class SendMessage extends StatefulWidget {

  final currentUserId;
  final conversationID;
  SendMessage({this.conversationID,this.currentUserId});
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {

  double deviceHeight;
  double deviceWidth;

  String messageText;
List<DocumentSnapshot> lastmessage=[];
  _SendMessageState() {
    messageText = "";
  }


  Future sendMessage(String conversationId, message) {
    var ref = Firestore.instance
        .collection('conversations')
        .document('yskWUp7xadxnjWiUHkxF')
        .collection('conversations');
    var timestamp = DateTime.now();
    return ref.document(timestamp.toString()).setData({
      'message': message,
      'timeStamp': Timestamp.now(),
      'senderId': widget.currentUserId,
      'type': 'text'
    });
  }

  Widget imageMessageButton() {
    return Container(
      height: deviceHeight * .06,
      width: deviceWidth * .06,
      child: IconButton(
          color: Colors.blue,
          icon: Icon(
            CupertinoIcons.photo_camera_solid,
            color: Colors.blue,
          ),
          onPressed: null),
    );
  }

  Widget messageField() {
    return Container(
      child: Form(
        key: formkey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            messageTextField(),
            sendMessageButton(),
            imageMessageButton()
          ],
        ),
      ),
      height: deviceHeight * .08,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(100)),
      margin: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.04, vertical: deviceHeight * 0.03),
    );
  }

  Widget messageTextField() {
    return SizedBox(
      width: deviceWidth * 0.55,
      child: TextFormField(controller: emailController,
        validator: (_input) {
          if (_input.length == 0) {
            return 'Please Enter Some Text';
          }
          return null;
        },
        onChanged: (_input) {
          formkey.currentState.save();
           messageText = _input;
        },
        onSaved: (_input) {
          messageText = _input;
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Type a Message",
        ),
        autocorrect: false,
      ),
    );
  }

  Widget sendMessageButton() {
    return Container(
      height: deviceHeight * 0.06,
      width: deviceWidth * 0.06,
      child: IconButton(
          color: Colors.blue,
          icon: Icon(CupertinoIcons.up_arrow),
          onPressed: () {
            if (formkey.currentState.validate()) {
              sendMessage(widget.conversationID, messageText);
            }
          }),
    );
  }
  @override
  Widget build(BuildContext context) {
     deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return messageField();
  }
}