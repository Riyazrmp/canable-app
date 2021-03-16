// import 'package:bellbirdmvp/models/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ProductDescription extends StatefulWidget {
//   final String price;
//   final String seller;
//   final String fabric;
//   final List sizes;
//   final String category;

//   ProductDescription(
//       {this.price, this.fabric, this.seller, this.category, this.sizes});

//   @override
//   _ProductDescriptionState createState() => _ProductDescriptionState();
// }

// class _ProductDescriptionState extends State<ProductDescription> {
//   String size;

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//       decoration: decorationGreyBox(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             widget.seller,
//             style: GoogleFonts.ubuntu(
//                 fontSize: ScreenUtil().setSp(kSpacingUnit * 1.9),
//                 fontWeight: FontWeight.w700),
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                   child: Container(
//                       height: 100,
//                       child: Card(
//                         color: Colors.black12,
//                         child: Center(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               widget.fabric,
//                               style: GoogleFonts.quicksand(
//                                   fontSize:
//                                       ScreenUtil().setSp(kSpacingUnit * 2.2),
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             Text(
//                               'Fabric',
//                               style: GoogleFonts.quicksand(
//                                   fontSize:
//                                       ScreenUtil().setSp(kSpacingUnit * 1.9),
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[600]),
//                             ),
//                           ],
//                         )),
//                         elevation: 0,
//                       ))),
//               Expanded(
//                   child: Container(
//                       height: 100,
//                       child: Card(
//                         color: Colors.black12,
//                         child: Center(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               '\₹ ' + widget.price,
//                               style: GoogleFonts.quicksand(
//                                   fontSize:
//                                       ScreenUtil().setSp(kSpacingUnit * 2.2),
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             Text(
//                               'Price',
//                               style: GoogleFonts.quicksand(
//                                   fontSize:
//                                       ScreenUtil().setSp(kSpacingUnit * 1.9),
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[600]),
//                             ),
//                           ],
//                         )),
//                         elevation: 0,
//                       ))),
//               widget.category == 'AllSize'
//                   ? Expanded(
//                       child: Container(
//                           height: 100,
//                           child: Card(
//                             color: Colors.black12,
//                             child: Center(
//                                 child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 DropdownButtonFormField(
//                                     validator: (val) {
//                                       if (val.isEmpty) {
//                                         return 'Please enter the fabric type';
//                                       }
//                                       return null;
//                                     },
//                                     hint: Text('Select Size'),
//                                     value: size,
//                                     items: widget.sizes.map(
//                                       (val) {
//                                         return DropdownMenuItem<String>(
//                                           value: val,
//                                           child: Text(val),
//                                         );
//                                       },
//                                     ).toList(),
//                                     onChanged: (value) {
//                                       setState(() {
//                                         size = value;
//                                       });
//                                     }),
//                                 Text(
//                                   'Size',
//                                   style: GoogleFonts.quicksand(
//                                       fontSize: ScreenUtil()
//                                           .setSp(kSpacingUnit * 1.9),
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey[600]),
//                                 ),
//                               ],
//                             )),
//                             elevation: 0,
//                           )))
//                   : Expanded(
//                       child: Container(
//                           height: 100,
//                           child: Card(
//                             color: Colors.black12,
//                             child: Center(
//                                 child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   widget.category,
//                                   style: GoogleFonts.quicksand(
//                                       fontSize: ScreenUtil()
//                                           .setSp(kSpacingUnit * 2.2),
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 Text(
//                                   'Category',
//                                   style: GoogleFonts.quicksand(
//                                       fontSize: ScreenUtil()
//                                           .setSp(kSpacingUnit * 1.9),
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey[600]),
//                                 ),
//                               ],
//                             )),
//                             elevation: 0,
//                           ))),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   BoxDecoration decorationGreyBox() {
//     return BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(0), topRight: Radius.circular(0)));
//   }
// }
