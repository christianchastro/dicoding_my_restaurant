import 'package:shared_preferences/shared_preferences.dart';

abstract class MySharedPreferences {
  static const String _prefsReminderNotification = "reminderNotification";

  static Future<SharedPreferences> get _getInstance async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> saveReminderNotification(bool isRemind) async {
    final prefs = await _getInstance;
    return prefs.setBool(_prefsReminderNotification, isRemind);
  }

  static Future<bool> getReminderNotification() async {
    final prefs = await _getInstance;
    return prefs.getBool(_prefsReminderNotification) ?? false;
  }

  static Future<bool> removeReminderNotification() async {
    final prefs = await _getInstance;
    return prefs.remove(_prefsReminderNotification);
  }
}
