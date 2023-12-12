import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<bool?> darkMode = ValueNotifier(null);

class SharedPreferenceInstance {
  late SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    darkMode.value = theme;
  }

  Future<void> clear() async {
    prefs.clear();
  }

  Future<void> reload() async {
    await prefs.reload();
  }

  // dark modes
  bool? get theme {
    darkMode.value = prefs.getBool('darkMode');
    return darkMode.value;
  }

  set theme(bool? value) {
    darkMode.value = value;
    if (value != null) {
      prefs.setBool('darkMode', value);
    } else {
      prefs.remove('darkMode');
    }
  }
}
