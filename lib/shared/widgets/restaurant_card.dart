import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Image.network(
          restaurant.pictureId,
          fit: BoxFit.cover,
        ),
        title: Text(
          restaurant.name,
          style: MyTextStyle.subTitle(),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_city_rounded,
                  color: Colors.grey.shade400,
                ),
                Text(
                  restaurant.city,
                  style: MyTextStyle.regular(color: Colors.grey.shade400),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.stars_rounded,
                  color: Colors.grey.shade400,
                ),
                Text(
                  restaurant.rating.toStringAsFixed(1),
                  style: MyTextStyle.regular(color: Colors.grey.shade400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
