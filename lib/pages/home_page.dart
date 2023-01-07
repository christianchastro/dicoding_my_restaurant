import 'package:flutter/material.dart';
import 'package:my_restaurant/pages/favorites_page.dart';
import 'package:my_restaurant/pages/settings_page.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/provider/restaurants_provider.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool isSearched = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterRestaurants(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      isSearched = true;
      Provider.of<RestaurantsProvider>(context, listen: false)
          .searchRestaurant(searchController.text);
    } else if (isSearched) {
      isSearched = false;
      Provider.of<RestaurantsProvider>(context, listen: false)
          .getAllRestaurant();
    }
  }

  void unFocus() {
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
  }

  Widget _buildListRestaurant() {
    return Consumer<RestaurantsProvider>(builder: (_, value, __) {
      switch (value.state) {
        case ApiResultState.loading:
          return const Center(child: CircularProgressIndicator());
        case ApiResultState.hasData:
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: value.response.restaurants!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, index) =>
                RestaurantCard(restaurant: value.response.restaurants![index]),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantsProvider(apiService: ApiService()),
      builder: (context, _) => SafeArea(
        top: false,
        child: GestureDetector(
          onTap: unFocus,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("My Restaurant"),
              backgroundColor: const Color(0xFFFAD643),
              titleTextStyle: MyTextStyle.title(color: Colors.black),
              elevation: 2,
              shadowColor: const Color(0xFFf4A734),
              actions: [
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                  onPressed: () {
                    Navigator.pushNamed(context, FavoritesPage.routeName);
                  },
                  icon: const Icon(Icons.favorite_border_rounded),
                ),
                const SizedBox(width: 4),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                  onPressed: () {
                    Navigator.pushNamed(context, SettingsPage.routeName);
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
                const SizedBox(width: 12),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Recommended Restaurant",
                      style: MyTextStyle.title(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: const Color(0xFFF4A734),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF1D63C8),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF1D63C8),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF1D63C8),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: const Color(0xFFF4A734),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFF4A734),
                          ),
                        ),
                        hintText: "Cari Restoran / Menu Favorit kamu",
                      ),
                      onFieldSubmitted: (_) {
                        filterRestaurants(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildListRestaurant(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
