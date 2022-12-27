import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/drink_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/menu_card.dart';

class RestaurantDetailDrinks extends StatelessWidget {
  final List<DrinkModel> drinks;
  const RestaurantDetailDrinks({super.key, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Drinks",
            style: MyTextStyle.subTitle(),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: List.generate(
              drinks.length,
              (index) => MenuCard(name: drinks[index].name),
            ),
          ),
        ],
      ),
    );
  }
}
