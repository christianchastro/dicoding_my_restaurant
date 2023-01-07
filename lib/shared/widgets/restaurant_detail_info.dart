import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/favorite_button.dart';

class RestaurantDetailInfo extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: MyTextStyle.title(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFAD643),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toStringAsFixed(1),
                          style: MyTextStyle.regular(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF1E96FC),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.city,
                          style: MyTextStyle.regular(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FavoriteButton(restaurant: restaurant),
            ],
          ),
          if (restaurant.description.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              "Description",
              style: MyTextStyle.subTitle(),
            ),
            const SizedBox(height: 10),
            Text(
              restaurant.description,
              style: MyTextStyle.regular(),
            ),
          ],
        ],
      ),
    );
  }
}
