import 'dart:convert';
import 'dart:io';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MyTunePlayingVM {
  getPlayingTuneList() async {
    var result = await ServiceCall().get(getPlayingTunesUrl);
  }
}
