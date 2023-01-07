import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/provider/scheduling_provider.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = "/setting_restaurant";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: ChangeNotifierProvider<SchedulingProvider>(
        create: (_) => SchedulingProvider(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("My Settings"),
              backgroundColor: const Color(0xFFFAD643),
              titleTextStyle: MyTextStyle.title(color: Colors.black),
              elevation: 2,
              shadowColor: const Color(0xFFf4A734),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) => ListTile(
                  minVerticalPadding: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF1D63C8)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    "Remind Me",
                    style: MyTextStyle.subTitle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Daily Reminder about Restaurant",
                    style: MyTextStyle.regular(color: Colors.grey.shade400),
                  ),
                  trailing: Switch(
                    value: scheduled.isScheduled,
                    onChanged: (value) {
                      if (Platform.isAndroid) {
                        scheduled.scheduledRestaurant(value);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
