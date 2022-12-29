import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
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
  final List<RestaurantModel> restaurants = [];
  final List<RestaurantModel> filtered = [];
  TextEditingController searchController = TextEditingController();

  List<RestaurantModel> parserRestaurants(String? json) {
    if (json == null || json.isEmpty) {
      return [];
    }

    final Map<String, dynamic> parsed = jsonDecode(json);
    if (!parsed.containsKey("restaurants")) {
      return [];
    } else {
      return (parsed["restaurants"] as Iterable)
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    }
  }

  void filterRestaurants() {
    filtered.clear();
    if (searchController.text.isNotEmpty) {
      filtered.addAll(
        restaurants.where(
          (element) => element.name.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ),
        ),
      );
    } else {
      filtered.addAll(restaurants);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void unFocus() {
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/source/local_restaurant.json");
    restaurants.addAll(parserRestaurants(data));
    filtered.addAll(restaurants);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildListRestaurant() {
    return Consumer<RestaurantsProvider>(builder: (context, value, _) {
      switch (value.state) {
        case ApiResultState.loading:
          return const Center(child: CircularProgressIndicator());
        case ApiResultState.hasData:
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: value.response.restaurants!.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) =>
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
      // TODO: Delete this code
      // if (value.state == ApiResultState.loading) {
      //   return const Center(child: CircularProgressIndicator());
      // } else if (value.state == ApiResultState.hasData) {
      //   return ListView.separated(
      //     physics: const NeverScrollableScrollPhysics(),
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     itemCount: value.response.restaurants!.length,
      //     shrinkWrap: true,
      //     separatorBuilder: (_, __) => const SizedBox(height: 10),
      //     itemBuilder: (context, index) =>
      //         RestaurantCard(restaurant: value.response.restaurants![index]),
      //   );
      // } else if (value.state == ApiResultState.noData) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     child: Text(
      //       value.message,
      //       style: MyTextStyle.subTitle(),
      //     ),
      //   );
      // } else if (value.state == ApiResultState.error) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     child: Text(
      //       value.message,
      //       style: MyTextStyle.subTitle(),
      //     ),
      //   );
      // } else {
      //   return const SizedBox();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      hintText: "Cari Restaurant kamu",
                    ),
                    onFieldSubmitted: (_) {
                      filterRestaurants();
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
    );
  }
}
