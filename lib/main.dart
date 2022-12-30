import 'package:flutter/material.dart';
import 'package:my_restaurant/pages/home_page.dart';
import 'package:my_restaurant/pages/restaurant_page.dart';

void main() {
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
      home: const HomePage(),
      routes: {
        RestaurantPage.routeName: (context) => RestaurantPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
