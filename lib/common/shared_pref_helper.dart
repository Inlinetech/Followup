import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? '';
    if (value.isEmpty) {
      return null;
    }
    return json.decode(value);
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}