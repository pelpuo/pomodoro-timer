import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class persistVals {
  static SharedPreferences? _preferences;

  static const _keyAppVals = "appVals";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAppVals(List<String> v) async =>
      await _preferences?.setStringList(_keyAppVals, v);

  static List<String>? getAppVals() => _preferences?.getStringList(_keyAppVals);
}
