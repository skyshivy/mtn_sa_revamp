import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final int index;
  final String? url;
  final Gradient? gradient;

  const CustomImage({super.key, this.url, this.index = 1, this.gradient});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          height: size.height,
          width: size.width,
          imageUrl: url ?? "https://picsum.photos/id/6${index * 9}/400/500",
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
