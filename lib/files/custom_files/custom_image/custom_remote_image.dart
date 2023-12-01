import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class CustomImage extends StatelessWidget {
  final int index;
  final String? url;
  final double? height;
  final Gradient? gradient;
  final double radius;

  const CustomImage(
      {super.key,
      this.url,
      this.index = 1,
      this.gradient,
      this.height,
      this.radius = 0});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            height: height ?? size.height,
            width: size.width,
            imageUrl: url ?? defaultImageUrl,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              return CachedNetworkImage(
                imageUrl: defaultImageUrl,
                height: height ?? size.height,
                width: size.width,
                fit: BoxFit.cover,
              );
              // const Icon(Icons.error);
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
}
