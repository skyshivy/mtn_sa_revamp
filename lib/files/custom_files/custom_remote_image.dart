import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Widget remoteImageContainer(TuneInfo? item) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: (item?.toneIdpreviewImageUrl == null)
          ? Image.asset(
              defaultTuneImagePng,
              fit: BoxFit.cover,
            )
          : CustomImage(url: item?.toneIdpreviewImageUrl ?? defaultImageUrl)
      // FadeInImage.assetNetwork(
      //     placeholder: placeholderImage,
      //     image: item?.toneIdpreviewImageUrl ?? defaultImageUrl,
      //     fit: BoxFit.cover,
      //     imageErrorBuilder: (context, error, stackTrace) {
      //       return Image.asset(
      //         defaultTuneImagePng,
      //         fit: BoxFit.cover,
      //       );
      //     },
      //   ),
      );
}
