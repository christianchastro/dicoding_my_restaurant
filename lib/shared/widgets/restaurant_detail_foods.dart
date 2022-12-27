import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/food_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/menu_card.dart';

class RestaurantDetailFoods extends StatelessWidget {
  final List<FoodModel> foods;
  const RestaurantDetailFoods({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Foods",
            style: MyTextStyle.subTitle(),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: List.generate(
              foods.length,
              (index) => MenuCard(name: foods[index].name),
            ),
          ),
        ],
      ),
    );
  }
}
