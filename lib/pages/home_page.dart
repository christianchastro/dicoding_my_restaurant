import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<RestaurantModel> parserRestaurants(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => RestaurantModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Restaurant"),
        backgroundColor: Colors.white,
        titleTextStyle: MyTextStyle.title(color: Colors.black),
        elevation: 2,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
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
              Expanded(
                child: FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString("lib/shared/source/local_restaurant.json"),
                  builder: (context, snapshot) {
                    final List<RestaurantModel> restaurants =
                        parserRestaurants(snapshot.data);
                    return ListView.separated(
                      itemCount: restaurants.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) =>
                          RestaurantCard(restaurant: restaurants[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
