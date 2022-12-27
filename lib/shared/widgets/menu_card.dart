import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';

class MenuCard extends StatelessWidget {
  final String name;
  const MenuCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1D63C8),
        ),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE3F2FE),
      ),
      child: Text(
        name,
        style: MyTextStyle.subTitle(),
      ),
    );
  }
}
