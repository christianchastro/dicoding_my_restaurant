import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/response/restaurant_response.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantResponse _response;
  late ApiResultState _state;
  late ApiResultState _stateReview;
  String _message = '';

  String get message => _message;
  RestaurantResponse get response => _response;
  ApiResultState get state => _state;
  ApiResultState get stateReview => _stateReview;

  RestaurantProvider({required this.apiService, required String id}) {
    getRestaurant(id);
  }
  Future<dynamic> getRestaurant(String id) async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final result = await apiService.getDetailRestaurant(id);
      _state = ApiResultState.hasData;
      notifyListeners();
      return _response = result;
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
}
