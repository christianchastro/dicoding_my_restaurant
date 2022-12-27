import 'package:my_restaurant/shared/model/menu_model.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final MenuModel menus;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"] as String,
        name: json["name"] as String,
        description: json["description"] as String,
        pictureId: json["pictureId"] as String,
        city: json["city"] as String,
        rating: (json["rating"] as num).toDouble(),
        menus: MenuModel.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
      };
}
