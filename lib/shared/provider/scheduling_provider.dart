import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/helpers/background_service.dart';
import 'package:my_restaurant/shared/helpers/date_time_helper.dart';
import 'package:my_restaurant/shared/helpers/my_shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  SchedulingProvider() {
    setDefaultScheduled();
  }

  Future<void> setDefaultScheduled() async {
    _isScheduled = await MySharedPreferences.getReminderNotification();
    notifyListeners();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    MySharedPreferences.saveReminderNotification(_isScheduled);
    notifyListeners();
    if (_isScheduled) {
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
