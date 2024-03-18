import 'package:changing_room/helpers/favorites_box.dart';
import 'package:flutter/material.dart';

import '../models/piece.dart';

class Favorites with ChangeNotifier {
  List<FavoriteItem> _favorites = [];

  List<FavoriteItem> get favorites {
    FavoritesBox.getFavorites().then((value) {
      _favorites = value.map((e) => FavoriteItem().fromMap(e)).toList();
      notifyListeners();
    });
    return [..._favorites];
  }

  bool addFavorite(FavoriteItem favoriteItem) {
    if (favoriteItem.selectedTshirt == null || favoriteItem.selectedPants == null) {
      return false;
    }
    _favorites.add(favoriteItem);
    FavoritesBox.addFavorite(favoriteItem.toMap());
    notifyListeners();
    return true;
  }

  void removeFavorite(int index) {
    _favorites.removeAt(index);
    FavoritesBox.removeFavorite(index);
    notifyListeners();
  }

  bool isFavorite(FavoriteItem favoriteItem) {
    return _favorites.contains(favoriteItem);
  }
}

class FavoriteItem {
  Piece? selectedHat;
  Piece? selectedAccessories;
  Piece? selectedShirt;
  Piece? selectedTshirt;
  Piece? selectedPants;
  Piece? selectedShoes;

  FavoriteItem({
    this.selectedHat,
    this.selectedAccessories,
    this.selectedShirt,
    this.selectedTshirt,
    this.selectedPants,
    this.selectedShoes,
  });

  toMap() {
    return {
      'selectedHat': selectedHat?.toMap(),
      'selectedAccessories': selectedAccessories?.toMap(),
      'selectedShirt': selectedShirt?.toMap(),
      'selectedTshirt': selectedTshirt?.toMap(),
      'selectedPants': selectedPants?.toMap(),
      'selectedShoes': selectedShoes?.toMap(),
    };
  }

  FavoriteItem fromMap(Map<dynamic, dynamic> map) {
    selectedHat = map['selectedHat']== null? null:  Piece(
      id: map['selectedHat']['id'],
      images: map['selectedHat']['images'],
      colors: map['selectedHat']['colors'].map<MyColor>((e) =>
      MyColor.values[e]).toList(),
      category: Category.values[map['selectedHat']['category']],
      // brightness: Brightness.values[map['selectedHat']['brightness']],
      fit: Fit.values[map['selectedHat']['fit']],
      // isNew: New.values[map['selectedHat']['isNew']],
      outDoors: OutDoors.values[map['selectedHat']['outDoors']],
      forWeather: ForWeather.values[map['selectedHat']['forWeather']],
    );
    selectedAccessories = map['selectedAccessories']== null? null: Piece(
      id: map['selectedAccessories']['id'],
      images: map['selectedAccessories']['images'],
      colors: map['selectedAccessories']['colors'].map<MyColor>((e) =>
      MyColor.values[e]).toList(),
      category: Category.values[map['selectedAccessories']['category']],
      // brightness: Brightness.values[map['selectedAccessories']['brightness']],
      fit: Fit.values[map['selectedAccessories']['fit']],
      // isNew: New.values[map['selectedAccessories']['isNew']],
      outDoors: OutDoors.values[map['selectedAccessories']['outDoors']],
      forWeather: ForWeather.values[map['selectedAccessories']['forWeather']],
    );
    selectedShirt =map['selectedShirt']== null? null: Piece(
      id: map['selectedShirt']['id'],
      images: map['selectedShirt']['images'],
      colors: map['selectedShirt']['colors'].map<MyColor>((e) =>
      MyColor.values[e]).toList(),
      category: Category.values[map['selectedShirt']['category']],
      // brightness: Brightness.values[map['selectedShirt']['brightness']],
      fit: Fit.values[map['selectedShirt']['fit']],
      // isNew: New.values[map['selectedShirt']['isNew']],
      outDoors: OutDoors.values[map['selectedShirt']['outDoors']],
      forWeather: ForWeather.values[map['selectedShirt']['forWeather']],
    );
    selectedTshirt = map['selectedTshirt']== null? null:  Piece(
      id: map['selectedTshirt']['id'],
      images: map['selectedTshirt']['images'],
      colors: map['selectedTshirt']['colors'].map<MyColor>((e) =>
      MyColor.values[ e]).toList(),
      category: Category.values[map['selectedTshirt']['category']],
      // brightness: Brightness.values[map['selectedTshirt']['brightness']],
      fit: Fit.values[map['selectedTshirt']['fit']],
      // isNew: New.values[map['selectedTshirt']['isNew']],
      outDoors: OutDoors.values[map['selectedTshirt']['outDoors']],
      forWeather: ForWeather.values[map['selectedTshirt']['forWeather']],
    );
    selectedPants = map['selectedPants']== null? null:  Piece(
      id: map['selectedPants']['id'],
      images: map['selectedPants']['images'],
      colors: map['selectedPants']['colors'].map<MyColor>((e) =>
      MyColor.values[e]).toList(),
      category: Category.values[map['selectedPants']['category']],
      // brightness: Brightness.values[map['selectedPants']['brightness']],
      fit: Fit.values[map['selectedPants']['fit']],
      // isNew: New.values[map['selectedPants']['isNew']],
      outDoors: OutDoors.values[map['selectedPants']['outDoors']],
      forWeather: ForWeather.values[map['selectedPants']['forWeather']],
    );
    selectedShoes = map['selectedShoes']== null? null:  Piece(
      id: map['selectedShoes']['id'],
      images: map['selectedShoes']['images'],
      colors: map['selectedShoes']['colors'].map<MyColor>((e) =>
      MyColor.values[e]).toList(),
      category: Category.values[map['selectedShoes']['category']],
      // brightness: Brightness.values[map['selectedShoes']['brightness']],
      fit: Fit.values[map['selectedShoes']['fit']],
      // isNew: New.values[map['selectedShoes']['isNew']],
      outDoors: OutDoors.values[map['selectedShoes']['outDoors']],
      forWeather: ForWeather.values[map['selectedShoes']['forWeather']],
    );
    return this;
  }
}

