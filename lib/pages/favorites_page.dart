import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/helpers/database/database_helper.dart';
import 'package:my_restaurant/shared/provider/restaurants_provider.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  static const routeName = "/favorite_restaurant";
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Widget _buildListRestaurant() {
    return Consumer<RestaurantsProvider>(builder: (_, value, __) {
      switch (value.state) {
        case ApiResultState.loading:
          return const Center(child: CircularProgressIndicator());
        case ApiResultState.hasData:
          return _buildFavoritesRestaurant(value);
        case ApiResultState.noData:
        case ApiResultState.error:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              value.message,
              style: MyTextStyle.subTitle(),
            ),
          );
        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildFavoritesRestaurant(RestaurantsProvider value) {
    switch (value.stateFavorite) {
      case DatabaseResultState.loading:
        return const Center(child: CircularProgressIndicator());
      case DatabaseResultState.hasData:
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: value.favoriteRestaurants.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) => RestaurantCard(
            restaurant: value.favoriteRestaurants[index],
            onReturn: () {
              value.getFavoritesRestaurant();
            },
          ),
        );
      case DatabaseResultState.noData:
      case DatabaseResultState.error:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value.message,
            style: MyTextStyle.subTitle(),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantsProvider(
          apiService: ApiService(), databaseHelper: DatabaseHelper()),
      builder: (context, _) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("My Favorites"),
            backgroundColor: const Color(0xFFFAD643),
            titleTextStyle: MyTextStyle.title(color: Colors.black),
            elevation: 2,
            shadowColor: const Color(0xFFf4A734),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildListRestaurant(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
