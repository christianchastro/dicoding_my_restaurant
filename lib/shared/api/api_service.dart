import 'dart:convert';

import 'package:my_restaurant/shared/response/restaurant_response.dart';
import 'package:my_restaurant/shared/response/restaurants_response.dart';
import 'package:http/http.dart' as http;
import 'package:my_restaurant/shared/response/reviews_response.dart';

enum ApiResultState { loading, noData, hasData, error }

class ApiService {
  static const String baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String urlImageSmall = "${baseUrl}images/small/";
  static const String urlImageMedium = "${baseUrl}images/medium/";
  static const String urlImageLarge = "${baseUrl}images/large/";
  static const Map<String, String> _headersPost = {
    "Content-Type": "application/json",
  };

  static Uri stringToUri(String url) {
    return Uri.parse(url);
  }

  Future<RestaurantsResponse> getListRestaurant() async {
    final response = await http.get(stringToUri("${baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    }
    throw Exception("Failed to load data Restaurants");
  }

  Future<RestaurantResponse> getDetailRestaurant(String id) async {
    if (id.isNotEmpty) {
      final response = await http.get(stringToUri("${baseUrl}detail/$id"));
      if (response.statusCode == 200) {
        return RestaurantResponse.fromJson(json.decode(response.body));
      }
    }
    throw Exception("Failed to load data Restaurant");
  }

  /// query = Nama / Kategori / Menu dari Restaurants
  Future<RestaurantsResponse> getSearchRestaurant(String query) async {
    if (query.isNotEmpty) {
      final response = await http.get(stringToUri("${baseUrl}search?q=$query"));
      if (response.statusCode == 200) {
        return RestaurantsResponse.fromJson(json.decode(response.body));
      }
    }
    throw Exception("Failed to search Restaurants");
  }

  Future<ReviewsResponse> postCustomerReview(
      String restaurantId, String userName, String review) async {
    if (restaurantId.isNotEmpty && userName.isNotEmpty && review.isNotEmpty) {
      Map<String, dynamic> body = {
        "id": restaurantId,
        "name": userName,
        "review": review
      };
      final response = await http.post(
        stringToUri("${baseUrl}review"),
        headers: _headersPost,
        body: json.encode(body),
      );
      if (response.statusCode == 201) {
        return ReviewsResponse.fromJson(json.decode(response.body));
      }
    }
    throw Exception("Failed to add Review Restaurant");
  }
}
