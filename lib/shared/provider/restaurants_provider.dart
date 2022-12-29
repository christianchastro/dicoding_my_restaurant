import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/response/restaurants_response.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantsResponse _response;
  late ApiResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantsResponse get response => _response;
  ApiResultState get state => _state;

  RestaurantsProvider({required this.apiService}) {
    _getAllRestaurant();
  }
  Future<dynamic> _getAllRestaurant() async {
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
}
