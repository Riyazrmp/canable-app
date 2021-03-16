import 'package:bellbirdmvp/Screens/orderSuccess.dart';
import 'package:bellbirdmvp/extras/decorations.dart';
import 'package:bellbirdmvp/models/connectivity_status.dart';
import 'package:bellbirdmvp/models/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderInfo extends StatefulWidget {
  final String coverImage;
  final String productId;
  final String sellerId;
  final String userID;
  final String price;
  final String size;
  final String selectedColor;
  final String seller;
  final String vendorEmail;
  final String category;

  OrderInfo(
      {this.selectedColor,
      this.userID,
      this.sellerId,
      this.productId,
      this.coverImage,
      this.price,
      this.seller,
      this.vendorEmail,
      this.size,
      this.category});

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  Future<Map> future;
  TextEditingController controller = new TextEditingController();
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getdata() async {
    print(widget.userID);

    var user = auth.FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot =
        await firestore.collection('address').doc(widget.userID).get();

    setState(() {
      controller.text = snapshot.data()['name'];
      controller1.text = snapshot.data()['phone'];
      controller2.text = snapshot.data()['address'];
      controller3.text = snapshot.data()['city'];
      isLoading = false;
    });
  }

  adddata() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    await firestore
        .collection('Post')
        .doc(widget.sellerId)
        .collection('Post')
        .doc(widget.productId)
        .update({'stock': FieldValue.increment(-1)});

    await firestore.collection('address').doc(widget.userID).set({
      'name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'city': controller3.text
    });
    await firestore
        .collection('V_orders')
        .doc(widget.sellerId)
        .collection('orders')
        .doc(fileName)
        .set({
      'ProductId': widget.productId,
      'orderId': fileName,
      'UserId': widget.userID,
      'SellerId': widget.sellerId,
      'vendorEmail': widget.vendorEmail,
      'TimeStamp': DateTime.now(),
      'price': widget.price,
      'seller': widget.seller,
      'status': 'In Process',
      'size': widget.size,
      'Name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'city': controller3.text,
      'selectedSuit': widget.category == 'Unstitched with Variety' ||
              widget.category == 'Freesize with Variety' ||
              widget.category == 'AllSize with Variety' ||
              widget.category == 'Semistitched with Variety'
          ? widget.selectedColor
          : widget.coverImage,
      'coverImage': widget.coverImage
    });

    await firestore
        .collection('orders')
        .doc(widget.userID)
        .collection('orders')
        .doc(fileName)
        .set({
      'ProductId': widget.productId,
      'UserId': widget.userID,
      'SellerId': widget.sellerId,
      'orderName': fileName,
      'vendorEmail': widget.vendorEmail,
      'TimeStamp': DateTime.now(),
      'price': widget.price,
      'size': widget.size,
      'seller': widget.seller,
      'status': 'In Process',
      'Name': controller.text,
      'phone': controller1.text,
      'address': controller2.text,
      'city': controller3.text,
      'selectedSuit': widget.category == 'Unstitched with Variety' ||
              widget.category == 'Freesize with Variety' ||
              widget.category == 'AllSize with Variety' ||
              widget.category == 'Semistitched with Variety'
          ? widget.selectedColor
          : widget.coverImage,
      'coverImage': widget.coverImage
    }).whenComplete(() => Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) => OrderSuccess())));
  }

  @override
  void initState() {
    print(widget.userID);

    getdata();

    super.initState();
  }

  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();

  Widget itemCard(itemName, color, price, imgPath, available, i) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 5.0,
            child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 10.0),
                width: MediaQuery.of(context).size.width - 20.0,
                height: 155.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[],
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      height: 125.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(widget.category ==
                                          'Unstitched with Variety' ||
                                      widget.category ==
                                          'Freesize with Variety' ||
                                      widget.category ==
                                          'AllSize with Variety' ||
                                      widget.category ==
                                          'Semistitched with Variety'
                                  ? widget.selectedColor
                                  : widget.coverImage),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(width: 4.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              widget.seller,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    ScreenUtil().setSp(kSpacingUnit * 1.9),
                              ),
                            ),
                          ],
                        ),
                        widget.size == null
                            ? Text('')
                            : Text(
                                'Size:' + widget.size,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      ScreenUtil().setSp(kSpacingUnit * 1.9),
                                ),
                              ),
                        SizedBox(height: 7.0),
                        Text(
                          '\₹' + widget.price,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(kSpacingUnit * 1.4),
                              color: Colors.grey[600]),
                        )
                      ],
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        middle: Text(
          "CONFIRM YOUR ORDER",
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          itemCard('Simple Kurta', 'gray', '248', 'assets/shirt.png', true, 0),
          isLoading == false
              ? Container(
                  padding: EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        SizedBox(height: 30),
                        Text("Name",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            decoration: kBoxDecorationStyle,
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter your name';
                                }

                                return null;
                              },
                              controller: controller,
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Feather.user,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your Name',
                                hintStyle: kHintTextStyle,
                              ),
                            )),
                        SizedBox(height: 30),
                        Text("Phone No.",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            decoration: kBoxDecorationStyle,
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty ||
                                    val.length < 10 ||
                                    val.length > 10) {
                                  return 'Please Enter your number';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.numberWithOptions(),
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500),
                              controller: controller1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Feather.phone,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your Phone No.',
                                hintStyle: kHintTextStyle,
                              ),
                            )),
                        SizedBox(height: 30),
                        Text("Address",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            decoration: kBoxDecorationStyle,
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter your address';
                                }

                                return null;
                              },
                              controller: controller2,
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Feather.home,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your Address',
                                hintStyle: kHintTextStyle,
                              ),
                            )),
                        SizedBox(height: 30),
                        Text("City",
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            decoration: kBoxDecorationStyle,
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please Enter your City';
                                }

                                return null;
                              },
                              controller: controller3,
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  SimpleLineIcons.location_pin,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your City',
                                hintStyle: kHintTextStyle,
                              ),
                            )),
                        CupertinoButton(
                          child: Text('CONFIRM',
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w900)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              adddata();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              : CupertinoActivityIndicator()
        ],
      ),
    );
  }
}
