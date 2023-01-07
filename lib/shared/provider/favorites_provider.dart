// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:my_restaurant/shared/helpers/database/database_helper.dart';
// import 'package:my_restaurant/shared/model/restaurant_model.dart';

// class FavoritesProvider extends ChangeNotifier {
//   final DatabaseHelper databaseHelper;
//   late List<RestaurantModel> listRestaurant;
//   late List<String> _favorites;
//   late List<RestaurantModel> _favoriteRestaurants;
//   late DatabaseResultState _state;
//   String _message = '';

//   String get message => _message;
//   List<String> get favorites => _favorites;
//   List<RestaurantModel> get favoriteRestaurants => _favoriteRestaurants;
//   DatabaseResultState get state => _state;

//   FavoritesProvider(
//       {required this.databaseHelper, required this.listRestaurant}) {
//     getFavorites();
//   }

//   Future<dynamic> getFavorites() async {
//     try {
//       _state = DatabaseResultState.loading;
//       notifyListeners();
//       final result = await databaseHelper.getFavorites();
//       _favorites = result;
//       if (_favorites.isNotEmpty) {
//         listRestaurant
//             .where((restaurant) =>
//                 _favorites.any((favorite) => favorite == restaurant.id))
//             .toList();
//       } else {
//         _favoriteRestaurants = [];
//       }
//       _state = DatabaseResultState.hasData;
//       notifyListeners();
//       return;
//     } on SocketException catch (_) {
//       _state = DatabaseResultState.error;
//       notifyListeners();
//       return _message = "Please Check Your Internet Connection";
//     } catch (e) {
//       _state = DatabaseResultState.error;
//       notifyListeners();
//       return _message = "";
//     }
//   }

//   // Future<List<RestaurantModel>> filteredFavoriteRestaurant(
//   //     List<RestaurantModel> restaurants) async {
//   //   if (_favorites.isNotEmpty) {
//   //     return restaurants
//   //         .where((restaurant) =>
//   //             _favorites.any((favorite) => favorite == restaurant.id))
//   //         .toList();
//   //   }
//   //   return [];
//   // }
// }
