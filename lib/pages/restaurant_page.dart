import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_drinks.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_foods.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_image.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_info.dart';

class RestaurantPage extends StatelessWidget {
  final RestaurantModel restaurant;
  static const routeName = "/detail_restaurant";
  const RestaurantPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RestaurantDetailImage(restaurant: restaurant),
                const SizedBox(height: 20),
                RestaurantDetailInfo(restaurant: restaurant),
                if (restaurant.menus.foods.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  RestaurantDetailFoods(
                    foods: restaurant.menus.foods,
                  ),
                ],
                if (restaurant.menus.drinks.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  RestaurantDetailDrinks(
                    drinks: restaurant.menus.drinks,
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
