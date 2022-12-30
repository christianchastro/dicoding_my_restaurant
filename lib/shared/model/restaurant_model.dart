import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/model/category_model.dart';
import 'package:my_restaurant/shared/model/customer_review_model.dart';
import 'package:my_restaurant/shared/model/menu_model.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final String pictureId;
  final List<CategoryModel>? categories;
  final MenuModel? menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    this.address,
    required this.pictureId,
    this.categories,
    this.menus,
    required this.rating,
    this.customerReviews = const [],
  });

  String get smallImage => "${ApiService.urlImageSmall}$pictureId";
  String get mediumImage => "${ApiService.urlImageMedium}$pictureId";
  String get largeImage => "${ApiService.urlImageLarge}$pictureId";

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"] as String,
        name: json["name"] as String,
        description: json["description"] as String,
        pictureId: json["pictureId"] as String,
        city: json["city"] as String,
        address: json["address"] as String?,
        rating: (json["rating"] as num).toDouble(),
        categories: json["categories"] == null
            ? null
            : List<CategoryModel>.from(
                json["categories"].map((x) => CategoryModel.fromJson(x))),
        menus: json["menus"] == null ? null : MenuModel.fromJson(json["menus"]),
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "address": address,
        "rating": rating,
        "categories": categories == null || categories!.isEmpty
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus?.toJson(),
        "customerReviews": customerReviews.isEmpty
            ? []
            : List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
