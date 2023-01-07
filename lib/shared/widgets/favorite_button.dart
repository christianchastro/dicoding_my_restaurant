import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final RestaurantModel restaurant;
  const FavoriteButton({super.key, required this.restaurant});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        constraints: const BoxConstraints(),
        onPressed: () {
          Provider.of<RestaurantProvider>(context, listen: false)
              .favoritedRestaurant();
        },
        icon: Icon(
          !widget.restaurant.isFavorite
              ? Icons.favorite_border_rounded
              : Icons.favorite_rounded,
          color:
              !widget.restaurant.isFavorite ? Colors.grey.shade800 : Colors.red,
        ),
      ),
    );
  }
}
