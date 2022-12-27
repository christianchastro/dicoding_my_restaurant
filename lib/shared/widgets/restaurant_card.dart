import 'package:flutter/material.dart';
import 'package:my_restaurant/pages/restaurant_page.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      minVerticalPadding: 0,
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantPage.routeName,
          arguments: restaurant,
        );
      },
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF1D63C8)),
        borderRadius: BorderRadius.circular(10),
      ),
      leading: Hero(
        tag: restaurant.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            restaurant.pictureId,
            fit: BoxFit.cover,
            width: 100,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        style: MyTextStyle.subTitle(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xFF1E96FC),
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                restaurant.city,
                style: MyTextStyle.regular(color: Colors.grey.shade400),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFFAD643),
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                restaurant.rating.toStringAsFixed(1),
                style: MyTextStyle.regular(color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
