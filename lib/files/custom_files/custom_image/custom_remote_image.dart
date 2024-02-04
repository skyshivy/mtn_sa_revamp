import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Widget customImage(
    {String? url,
    int index = 1,
    Gradient? gradient,
    double? height,
    double? width,
    double radius = 0}) {
  //Size size = MediaQuery.of(context).size;
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: Stack(
      children: [
        (url == null)
            ? Image.asset(
                defaultTuneImagePng,
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                height: height ?? double.infinity,
                width: width ?? double.infinity,
                imageUrl: url ?? defaultImageUrl,
                memCacheHeight: 20, //add this line
                memCacheWidth: 20,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    defaultTuneImagePng,
                    fit: BoxFit.cover,
                  );
                },
              ),
        gradient == null
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(gradient: gradient!),
              ),
      ],
    ),
  );
}

// class CustomImage extends StatelessWidget {
//   final int index;
//   final String? url;
//   final double? height;
//   final Gradient? gradient;
//   final double radius;

//   const CustomImage(
//       {super.key,
//       this.url,
//       this.index = 1,
//       this.gradient,
//       this.height,
//       this.radius = 0});
//   @override
//   Widget build(BuildContext context) {
    
//     return 
//   }
// }
