import 'package:flutter/material.dart';

import '../models/piece.dart';

import 'clothes_filter.dart';

class Clothes with ChangeNotifier {
  final List<String> imagesInput = [];

  final List<Piece> general = [];
  final List<Piece> _hats = [];
  final List<Piece> _accessories = [];
  final List<Piece> _tshirts = [
    Piece(
      id: 't1',
      images: ['assets/images/black-tshirt-removebg-preview.png',],
      category: Category.tshirt,
      outDoors: OutDoors.all,
      forWeather: ForWeather.all,
      // brightness: Brightness.all,
      fit: Fit.all,
      colors: [MyColor.black, MyColor.white],
      // isNew: New.all,
    ),
  ];
  final List<Piece> _pants = [];
  final List<Piece> _shoes = [];
  final List<Piece> _shirts = [];
  final List<Piece> _jackets = [];


  List<Piece> get all => [
        ..._shirts,
        ..._tshirts,
        ..._pants,
        ..._shoes,
        ..._hats,
        ..._accessories,
      ];
  List<Piece> get shirts {
    List<Piece> list = Filter.filterOutDoors(_shirts);
    list = Filter.filterByWeather(list);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.shirtColor);
    // list = Filter.filterByNew(list, Filter.newShirts);

    return list;
  }
  List<Piece> get jackets {
    List<Piece> list = Filter.filterOutDoors(_jackets);
    list = Filter.filterByWeather(list);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.shirtColor);
    // list = Filter.filterByNew(list, Filter.newShirts);

    return list;
  }
  List<Piece> get tshirts {
    List<Piece> list = Filter.filterOutDoors(_tshirts);
    list = Filter.filterByWeather(list);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.tshirtColor);
    // list = Filter.filterByNew(list, Filter.newTshirts);

    return list;
  }
  List<Piece> get pants {
    List<Piece> list = Filter.filterOutDoors(_pants);
    list = Filter.filterByWeather(list);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.pantsColor);
    // list = Filter.filterByNew(list, Filter.newPants);

    return list;
  }
  List<Piece> get shoes {
    List<Piece> list = Filter.filterOutDoors(_shoes);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByColors(list, Filter.shoesColor);
    // list = Filter.filterByNew(list, Filter.newShoes);

    return list;
  }
  List<Piece> get hats {
    List<Piece> list = Filter.filterOutDoors(_hats);
    list = Filter.filterByWeather(list);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByColors(list, Filter.hatColor);
    // list = Filter.filterByNew(list, Filter.newHats);

    return list;
  }
  List<Piece> get accessories {
    List<Piece> list = Filter.filterOutDoors(_accessories);
    list = Filter.filterByWeather(list);
    // list = Filter.filterByBrightness(list);
    list = Filter.filterByColors(list, Filter.accessoryColor);
    // list = Filter.filterByNew(list, Filter.newAccessories);

    return list;
  }

  addImage(String imagePath) {
    imagesInput.add(imagePath);
    notifyListeners();
  }
  setImages(List<String> images) {
    imagesInput.clear();
    imagesInput.addAll(images);
    notifyListeners();
  }
  addPiece(Piece piece) {
    switch (piece.category) {
      case Category.shirt:
        _shirts.add(piece);
        break;
      case Category.jacket:
        _jackets.add(piece);
        break;
      case Category.tshirt:
        _tshirts.add(piece);
        break;
      case Category.pants:
        _pants.add(piece);
        break;
      case Category.shoes:
        _shoes.add(piece);
        break;
      case Category.hat:
        _hats.add(piece);
        break;
      case Category.accessory:
        _accessories.add(piece);
        break;
      case Category.general:
        general.add(piece);
        break;
    }
    notifyListeners();
  }
}




