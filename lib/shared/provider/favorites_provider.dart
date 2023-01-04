import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/helpers/database/database_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  late List<String> _favorites;
  late DatabaseResultState _state;
  String _message = '';

  String get message => _message;
  List<String> get favorites => _favorites;
  DatabaseResultState get state => _state;

  FavoritesProvider({required this.databaseHelper}) {
    getFavorites();
  }

  Future<dynamic> getFavorites() async {
    try {
      _state = DatabaseResultState.loading;
      notifyListeners();
      final result = await databaseHelper.getFavorites();
      _state = DatabaseResultState.hasData;
      notifyListeners();
      return _favorites = result;
    } on SocketException catch (_) {
      _state = DatabaseResultState.error;
      notifyListeners();
      return _message = "Please Check Your Internet Connection";
    } catch (e) {
      _state = DatabaseResultState.error;
      notifyListeners();
      return _message = "";
    }
  }
}
