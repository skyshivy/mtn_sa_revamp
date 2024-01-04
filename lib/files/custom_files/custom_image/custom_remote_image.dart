import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class CustomImage extends StatelessWidget {
  final int index;
  final String? url;
  final double? height;
  final Gradient? gradient;

  const CustomImage(
      {super.key, this.url, this.index = 1, this.gradient, this.height});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        (url == null)
            ? Image.asset(
                defaultZainImg,
                fit: BoxFit.fill,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                height: height ?? size.height,
                width: size.width,
                imageUrl: url ?? "https://picsum.photos/id/1${index}/400/500",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  //print("\n Image url is $url \n");
                  // print(
                  //     "\n Image error string loading===== ${error.toString()}\n");

                  // print("\n Image error loading===== $error\n");
                  return Image.asset(
                    defaultZainImg,
                    fit: BoxFit.fill,
                  );
                },
              ),
        gradient == null
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(gradient: gradient!),
              ),
      ],
    );
  }
}
