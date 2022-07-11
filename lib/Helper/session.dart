



import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var value;

  static Future<String> getPhone() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("phone");
  }


}