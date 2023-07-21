import 'package:shared_preferences/shared_preferences.dart';

class StoreManager {
  static final StoreManager _instance = StoreManager._internal();

  StoreManager._internal() {
    print("initiali stro manager");
  }
  late SharedPreferences prefs;
}
