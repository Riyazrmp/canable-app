// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ImageSwiper extends StatefulWidget {
// final List images;
// final  coverImage;
//   ImageSwiper(this.images,this.coverImage);

//   @override
//   _ImageSwiperState createState() => _ImageSwiperState();
// }

// class _ImageSwiperState extends State<ImageSwiper> {
// List images;
// @override
//   void initState() {

// images = widget.images;
//     images.insert(0, widget.coverImage);    super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       child: Swiper(itemHeight: 200,itemWidth: double.infinity,containerHeight: 200,
//         itemCount: images.length,

//         pagination: new SwiperPagination(
//           builder: new DotSwiperPaginationBuilder(
//               color: Colors.grey[300],
//               activeColor: Colors.grey[600],
//               activeSize: 10,
//               size: 8,
//               space: 10
//             )
//         ),

//         itemBuilder: ( BuildContext context, int i) {
//           return CachedNetworkImage( imageUrl:images[i],placeholder: (context,url)=>Center(child: CupertinoActivityIndicator(),),);
//           },

//       ),
//     );

//   }
// }
