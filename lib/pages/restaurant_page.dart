import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/provider/restaurant_provider.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_drinks.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_foods.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_image.dart';
import 'package:my_restaurant/shared/widgets/restaurant_detail_info.dart';
import 'package:my_restaurant/shared/widgets/restaurant_list_review.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatelessWidget {
  final String id;
  static const routeName = "/detail_restaurant";
  const RestaurantPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: ApiService(), id: id),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Consumer<RestaurantProvider>(
              builder: (context, value, child) {
                switch (value.state) {
                  case ApiResultState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ApiResultState.hasData:
                    RestaurantModel restaurant = value.response.restaurant;
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RestaurantDetailImage(restaurant: restaurant),
                          const SizedBox(height: 20),
                          RestaurantDetailInfo(restaurant: restaurant),
                          if (restaurant.menus != null &&
                              restaurant.menus!.foods.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            RestaurantDetailFoods(
                              foods: restaurant.menus!.foods,
                            ),
                          ],
                          if (restaurant.menus != null &&
                              restaurant.menus!.drinks.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            RestaurantDetailDrinks(
                              drinks: restaurant.menus!.drinks,
                            ),
                          ],
                          if (restaurant.customerReviews.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            RestaurantListReview(
                              idRestaurant: restaurant.id,
                              reviews: restaurant.customerReviews,
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
