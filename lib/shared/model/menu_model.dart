import 'package:my_restaurant/shared/model/drink_model.dart';
import 'package:my_restaurant/shared/model/food_model.dart';

class MenuModel {
  final List<FoodModel> foods;
  final List<DrinkModel> drinks;

  const MenuModel({
    required this.foods,
    required this.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        foods: List<FoodModel>.from(
          json["foods"].map((x) => FoodModel.fromJson(x)),
        ),
        drinks: List<DrinkModel>.from(
          json["drinks"].map((x) => DrinkModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(
          foods.map((x) => x.toJson()),
        ),
        "drinks": List<dynamic>.from(
          drinks.map((x) => x.toJson()),
        ),
      };
}
