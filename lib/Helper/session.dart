



import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var value;

  static Future<String> getEmail() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("email");
  }
  static Future<String> getPartyid() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("partyid");
  }
  static Future<String> getCustName() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_name");
  }
  static Future<String> getCustPhone() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_phone");
  }
  static Future<String> getCustAddress() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_address");
  }
  static Future<String> getCustBirthday() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_birthday");
  }
  static Future<String> getCustBirthMonth() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_birthmonth");
  }
  static Future<String> getCustPersonality() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_personality");
  }
  static Future<String> getCustCreatedDate() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_createddate");
  }
  static Future<String> getCustStatus() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_status");
  }
  static Future<String> getCustModified() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("cust_modified");
  }

}