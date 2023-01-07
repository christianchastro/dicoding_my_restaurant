import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/helpers/database/database_helper.dart';
import 'package:my_restaurant/shared/response/restaurant_response.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantResponse _response;
  late ApiResultState _state;
  late ApiResultState _stateReview;
  String _message = '';

  final DatabaseHelper databaseHelper;
  late DatabaseResultState _stateFavorite;

  String get message => _message;
  RestaurantResponse get response => _response;
  ApiResultState get state => _state;
  ApiResultState get stateReview => _stateReview;
  DatabaseResultState get stateFavorite => _stateFavorite;

  RestaurantProvider({
    required this.apiService,
    required String id,
    required this.databaseHelper,
  }) {
    getRestaurant(id);
  }
  Future<dynamic> getRestaurant(String id) async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final result = await apiService.getDetailRestaurant(id);
      _state = ApiResultState.hasData;
      notifyListeners();
      _response = result;
      _setFavorite();
      return;
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

  Future<dynamic> postCustomerReview(
    String restaurantId,
    String userName,
    String review,
  ) async {
    try {
      _stateReview = ApiResultState.loading;
      notifyListeners();
      final result = await apiService.postCustomerReview(
        restaurantId,
        userName,
        review,
      );
      _stateReview = ApiResultState.hasData;
      _response.restaurant.customerReviews.clear();
      _response.restaurant.customerReviews.addAll(result.customerReviews);
      notifyListeners();
      return _response.restaurant.customerReviews;
    } on SocketException catch (_) {
      _stateReview = ApiResultState.error;
      notifyListeners();
      return _message = "Please Check Your Internet Connection";
    } catch (e) {
      _stateReview = ApiResultState.error;
      notifyListeners();
      return _message = "";
    }
  }

  Future<dynamic> _setFavorite() async {
    try {
      _stateFavorite = DatabaseResultState.loading;
      notifyListeners();
      final result = await databaseHelper.isFavorite(_response.restaurant.id);
      _response.restaurant.isFavorite = result;
      if (result) {
        _stateFavorite = DatabaseResultState.hasData;
      } else {
        _stateFavorite = DatabaseResultState.noData;
      }
      notifyListeners();
      return _response.restaurant.isFavorite;
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

  Future<dynamic> favoritedRestaurant() async {
    try {
      _stateFavorite = DatabaseResultState.loading;
      notifyListeners();
      _response.restaurant.isFavorite = !_response.restaurant.isFavorite;
      if (_response.restaurant.isFavorite) {
        await databaseHelper.insertFavorite(_response.restaurant.id);
        _stateFavorite = DatabaseResultState.hasData;
      } else {
        await databaseHelper.deleteFavorite(_response.restaurant.id);
        _stateFavorite = DatabaseResultState.noData;
      }
      notifyListeners();
      return _response.restaurant.isFavorite;
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
