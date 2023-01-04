import 'dart:convert';

import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MySharedPreferences {
  static const String _prefsReminderNotification = "reminderNotification";
  static const String _prefsRestaurants = "restaurants";

  static Future<SharedPreferences> get _getInstance async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> saveReminderNotification(bool isRemind) async {
    final prefs = await _getInstance;
    return prefs.setBool(_prefsReminderNotification, isRemind);
  }

  Future<bool> getReminderNotification() async {
    final prefs = await _getInstance;
    return prefs.getBool(_prefsReminderNotification) ?? false;
  }

  Future<bool> removeReminderNotification() async {
    final prefs = await _getInstance;
    return prefs.remove(_prefsReminderNotification);
  }

  Future<bool> saveRestaurants(List<RestaurantModel> restaurant) async {
    final prefs = await _getInstance;
    return prefs.setString(_prefsRestaurants, jsonEncode(restaurant));
  }

  Future<List<RestaurantModel>> getRestaurants() async {
    final prefs = await _getInstance;
    Iterable result = jsonDecode(prefs.getString(_prefsRestaurants) ?? "[]");
    if (result.isEmpty) {
      return [];
    }
    return List<RestaurantModel>.from(
        result.map((e) => RestaurantModel.fromJson(e)));
  }

  Future<bool> removeRestaurants() async {
    final prefs = await _getInstance;
    return prefs.remove(_prefsRestaurants);
  }
}
