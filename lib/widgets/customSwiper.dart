// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';

// class  CustomSwiper extends StatefulWidget {

//   final List images;
// final  coverImage;
//   CustomSwiper(this.images,this.coverImage);
//   @override
//   _CustomSwiperState createState() => _CustomSwiperState();
// }

// class _CustomSwiperState extends State<CustomSwiper> with TickerProviderStateMixin {

//   List <Widget>images=[];
// @override
//   void initState() {
// for(int i = 0;i<widget.images.length;i++){

// images.add(PhotoView(loadingChild: CupertinoActivityIndicator(),maxScale: PhotoViewComputedScale.contained*1,minScale: PhotoViewComputedScale.contained*1,backgroundDecoration: BoxDecoration(color: Colors.white),imageProvider: NetworkImage(widget.images[i])));

// }

//     images.insert(0, PhotoView(loadingChild: CupertinoActivityIndicator(),minScale: PhotoViewComputedScale.contained*1,backgroundDecoration: BoxDecoration(color: Colors.white),maxScale: PhotoViewComputedScale.contained*1,imageProvider: NetworkImage(widget.coverImage)) );   super.initState();
//   }

//   @override

//   Widget build(BuildContext context) {
//     TabController imagesController = TabController(length: images.length, vsync: this);
// return Padding(
//     padding: const EdgeInsets.all(0.0),
//     child: Container(
//       height: MediaQuery.of(context).size.height*.7,
//       child: Center(
//         child: DefaultTabController(
//           length: images.length,
//           child: Stack(
//             children: <Widget>[
//               TabBarView(physics: BouncingScrollPhysics(),
//                 controller: imagesController,
//                 children: images,
//               ),
//               Container(
//                 alignment: FractionalOffset(0.5, 0.95),
//                 child: TabPageSelector(
//                   controller: imagesController,
//                   selectedColor: Colors.grey,
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//   }
// }
