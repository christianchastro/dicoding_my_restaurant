import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/restaurant_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
              FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/source/local_restaurant.json"),
                builder: (context, snapshot) {
                  final List<RestaurantModel> restaurants =
                      parserRestaurants(snapshot.data);
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: restaurants.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) =>
                        RestaurantCard(restaurant: restaurants[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
