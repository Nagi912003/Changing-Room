import 'package:hive_flutter/hive_flutter.dart';

class FavoritesBox{
  static const String _boxName = 'favorites';

  static Future<Box> openBox() async {
    return await Hive.openBox(_boxName);
  }

  static Future<void> addFavorite(Map<String, dynamic> favoriteItem) async {
    final Box box = await openBox();
    await box.add(favoriteItem);
  }

  static Future<void> removeFavorite(int index) async {
    final Box box = await openBox();
    await box.deleteAt(index);
  }

  static Future<List<Map<dynamic, dynamic>>> getFavorites() async {
    final Box box = await openBox();
    final List<Map<dynamic, dynamic>> favorites = [];
    for (int i = 0; i < box.length; i++) {
      favorites.add(box.getAt(i));
    }
    return favorites;
  }
}