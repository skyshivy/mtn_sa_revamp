import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

Widget remoteImageContainer(TuneInfo? item) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: FadeInImage.assetNetwork(
      placeholder: 'images/placeholderImage.png',
      image:
          item?.toneIdpreviewImageUrl ?? 'https://picsum.photos/id/237/200/300',
      fit: BoxFit.cover,
    ),
  );
}
