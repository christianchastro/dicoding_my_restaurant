import 'package:sqflite/sqflite.dart';

enum DatabaseResultState { loading, noData, hasData, error }

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;
  static const String _tableFavorites = "favorites";
  static const String _databaseName = "my_restaurant.db";

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    String path = await getDatabasesPath();
    Database db = await openDatabase(
      "$path/$_databaseName",
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableFavorites (
            id TEXT PRIMARY KEY
          )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<int> insertFavorite(String idRestaurant) async {
    final Database db = await database;
    return await db.insert(_tableFavorites, {'id': idRestaurant});
  }

  Future<bool> isFavorite(String idRestaurant) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db
        .query(_tableFavorites, where: "id = ?", whereArgs: [idRestaurant]);
    if (result.isEmpty) {
      return false;
    }
    return true;
  }

  Future<List<String>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableFavorites);
    return results.map((e) => e["id"]).whereType<String>().toList();
  }

  Future<int> deleteFavorite(String idRestaurant) async {
    final Database db = await database;
    return await db
        .delete(_tableFavorites, where: "id = ?", whereArgs: [idRestaurant]);
  }
}
