import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';

class RestaurantDetailImage extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailImage({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: restaurant.id,
      child: Stack(
        children: [
          Image.network(restaurant.pictureId),
          Positioned(
            top: 16,
            left: 16,
            child: CircleAvatar(
              backgroundColor: const Color(0xFFFAD643).withOpacity(0.8),
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
