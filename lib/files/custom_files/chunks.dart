import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';

Future<ChunksModel> createChunksOfSize(List<TuneInfo> lst,
    {int displayIndex = 0, int chunkSize = pagePerCount}) async {
  var chunks = [];
  int totalPage = 0;
  List<TuneInfo> displayList1 = [];
  for (var i = 0; i < lst.length; i += (chunkSize)) {
    chunks.add(lst.sublist(
        i, i + (chunkSize) > lst.length ? lst.length : i + (chunkSize)));
  }
  for (var _ in chunks) {
    totalPage += 1;
  }
  if (chunks.isEmpty) {
    displayList1 = [];

    return ChunksModel(displayList1, totalPage);
  } else {
    displayList1 = chunks[displayIndex];
    return ChunksModel(displayList1, totalPage);
  }
}

class ChunksModel {
  List<TuneInfo> list = [];
  int pages = 0;
  ChunksModel(this.list, this.pages);
}
