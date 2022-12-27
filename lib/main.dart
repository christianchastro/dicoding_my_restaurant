import 'package:flutter/material.dart';
import 'package:my_restaurant/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // primary: FAD643 f4a734 fef3a1
  // secondary: 1E96FC 1d63c8 e3f2fe
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
    );
  }
}
