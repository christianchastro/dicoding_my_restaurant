import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/response/my_response.dart';

class RestaurantResponse extends MyResponse {
  final RestaurantModel restaurant;

  const RestaurantResponse({
    required bool error,
    required String message,
    required this.restaurant,
  }) : super(error, message);

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"] as bool,
        message: json["message"] as String,
        restaurant: RestaurantModel.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
