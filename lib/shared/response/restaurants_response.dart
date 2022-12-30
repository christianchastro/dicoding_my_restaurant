import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/response/my_response.dart';

class RestaurantsResponse extends MyResponse {
  /// Digunakan ketika "Get List of Restaurant"
  final int count;

  /// Digunakan ketika "Search Restaurant"
  final int founded;

  final List<RestaurantModel>? restaurants;
  const RestaurantsResponse({
    required bool error,
    required String message,
    required this.count,
    required this.founded,
    this.restaurants,
  }) : super(error, message);

  factory RestaurantsResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantsResponse(
        error: json["error"] as bool? ?? false,
        message: json["message"] as String? ?? "",
        count: (json["count"] as num?)?.toInt() ?? 0,
        founded: (json["founded"] as num?)?.toInt() ?? 0,
        restaurants: json["restaurants"] == null
            ? null
            : List<RestaurantModel>.from(
                json["restaurants"].map((x) => RestaurantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "founded": founded,
        "restaurants": restaurants == null || restaurants!.isEmpty
            ? null
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}
