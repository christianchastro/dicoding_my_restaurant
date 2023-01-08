import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/helpers/database/database_helper.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';
import 'package:my_restaurant/shared/response/restaurants_response.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantsResponse _response;
  late ApiResultState _state;

  final DatabaseHelper? databaseHelper;
  late List<RestaurantModel> _favoriteRestaurants;
  late DatabaseResultState _stateFavorite;

  String _message = '';

  String get message => _message;
  RestaurantsResponse get response => _response;
  ApiResultState get state => _state;
  DatabaseResultState get stateFavorite => _stateFavorite;
  List<RestaurantModel> get favoriteRestaurants => _favoriteRestaurants;

  RestaurantsProvider({required this.apiService, this.databaseHelper}) {
    getAllRestaurant();
  }
  Future<dynamic> getAllRestaurant() async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final result = await apiService.getListRestaurant();
      if (result.restaurants == null || result.restaurants!.isEmpty) {
        _state = ApiResultState.noData;
        notifyListeners();
        return _message = "No Data Restaurant";
      } else {
        _state = ApiResultState.hasData;
        notifyListeners();
        _response = result;
        if (databaseHelper != null) {
          getFavoritesRestaurant();
        }
        return;
      }
    } on SocketException catch (_) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = "Please Check Your Internet Connection";
    } catch (e) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = "";
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final result = await apiService.getSearchRestaurant(query);
      if (result.restaurants == null || result.restaurants!.isEmpty) {
        _state = ApiResultState.noData;
        notifyListeners();
        return _message = "No Data Restaurant";
      } else {
        _state = ApiResultState.hasData;
        notifyListeners();
        return _response = result;
      }
    } on SocketException catch (_) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = "Please Check Your Internet Connection";
    } catch (e) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = "";
    }
  }

  Future<dynamic> getFavoritesRestaurant() async {
    try {
      _stateFavorite = DatabaseResultState.loading;
      notifyListeners();
      final result = await databaseHelper!.getFavorites();
      List<String> favorites = result;
      if (favorites.isNotEmpty &&
          response.restaurants != null &&
          response.restaurants!.isNotEmpty) {
        for (int i = 0; i < _response.restaurants!.length; i++) {
          _response.restaurants![i].isFavorite =
              favorites.contains(_response.restaurants![i].id);
        }
        _stateFavorite = DatabaseResultState.hasData;
        notifyListeners();
        return _favoriteRestaurants = _response.restaurants!
            .where((element) => element.isFavorite == true)
            .toList();
      } else {
        _stateFavorite = DatabaseResultState.noData;
        notifyListeners();
        return _message = "No Data Favorite Restaurant";
      }
    } on SocketException catch (_) {
      _stateFavorite = DatabaseResultState.error;
      notifyListeners();
      return _message = "Please Check Your Internet Connection";
    } catch (e) {
      _stateFavorite = DatabaseResultState.error;
      notifyListeners();
      return _message = "";
    }
  }
}
