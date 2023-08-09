import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget remoteImageContainer(TuneInfo? item) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: FadeInImage.assetNetwork(
      placeholder: placeholderImage,
      image:
          item?.toneIdpreviewImageUrl ?? 'https://picsum.photos/id/237/200/300',
      fit: BoxFit.cover,
    ),
  );
}
