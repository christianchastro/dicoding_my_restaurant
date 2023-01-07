import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_restaurant/pages/favorites_page.dart';
import 'package:my_restaurant/pages/home_page.dart';
import 'package:my_restaurant/pages/restaurant_page.dart';
import 'package:my_restaurant/pages/settings_page.dart';
import 'package:my_restaurant/shared/helpers/background_service.dart';
import 'package:my_restaurant/shared/helpers/navigation.dart';
import 'package:my_restaurant/shared/helpers/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // * colors
  // primary: FAD643 F4A734 FEF3A1
  // secondary: 1E96FC 1D63C8 E3F2FE
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: const Color(0xFFFAD643),
      ),
      navigatorKey: navigatorKey,
      home: const HomePage(),
      routes: {
        RestaurantPage.routeName: (context) => RestaurantPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        FavoritesPage.routeName: (context) => const FavoritesPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
      },
    );
  }
}
