import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/helpers/my_shared_preferences.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/setting_restaurant";
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isRemind = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (mounted) {
      isRemind = await MySharedPreferences.getReminderNotification();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Settings"),
          backgroundColor: const Color(0xFFFAD643),
          titleTextStyle: MyTextStyle.title(color: Colors.black),
          elevation: 2,
          shadowColor: const Color(0xFFf4A734),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ListTile(
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
              value: isRemind,
              onChanged: (value) async {
                if (mounted) {
                  isRemind = value;
                  await MySharedPreferences.saveReminderNotification(isRemind);
                  setState(() {});
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
