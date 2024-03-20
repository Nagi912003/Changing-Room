import 'package:changing_room/helpers/clothes_box.dart';
import 'package:flutter/material.dart';

import '../models/piece.dart';

import 'clothes_filter.dart';

enum AppState {
  free,
  picked,
  processing,
  done,
}

class Clothes with ChangeNotifier {

  AppState state = AppState.free;
  stateProcessing() {
    state = AppState.processing;
    notifyListeners();
  }
  stateDone() {
    state = AppState.done;
    notifyListeners();
  }
  stateFree() {
    state = AppState.free;
    notifyListeners();
  }
  statePicked() {
    state = AppState.picked;
    notifyListeners();
  }

  static int _idCounter = 0;

  get id {
    return (_idCounter++).toString();
  }

  final List<String> imagesInput = [];

  final List<Piece> general = [];
  static final List<Piece> _hats = [];
  static final List<Piece> _accessories = [];
  static final List<Piece> _tshirts = [
    // Piece(
    //   id: 't1',
    //   images: ['assets/images/black-tshirt-removebg-preview.png',],
    //   category: Category.tshirt,
    //   outDoors: OutDoors.all,
    //   forWeather: ForWeather.all,
    //   // brightness: Brightness.all,
    //   fit: Fit.all,
    //   colors: [MyColor.black, MyColor.white],
    //   // isNew: New.all,
    // ),
  ];
  static final List<Piece> _pants = [];
  static final List<Piece> _shoes = [];
  static final List<Piece> _shirts = [];
  static final List<Piece> _jackets = [];


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
      case MyCategory.shirt:
        _shirts.add(piece);
        break;
      case MyCategory.jacket:
        _jackets.add(piece);
        break;
      case MyCategory.tshirt:
        _tshirts.add(piece);
        print('images from the list itself : ${_tshirts.last.images}');
        break;
      case MyCategory.pants:
        _pants.add(piece);
        break;
      case MyCategory.shoes:
        _shoes.add(piece);
        break;
      case MyCategory.hat:
        _hats.add(piece);
        break;
      case MyCategory.accessory:
        _accessories.add(piece);
        break;
      case MyCategory.general:
        general.add(piece);
        break;
    }
    print('images from clothes.dart : ${piece.images}');
    ClothesBox.addPiece(piece.toMap());
    notifyListeners();
  }

  removePiece(Piece piece, int index) {
    switch (piece.category) {
      case MyCategory.shirt:
        _shirts.remove(piece);
        break;
      case MyCategory.jacket:
        _jackets.remove(piece);
        break;
      case MyCategory.tshirt:
        _tshirts.remove(piece);
        break;
      case MyCategory.pants:
        _pants.remove(piece);
        break;
      case MyCategory.shoes:
        _shoes.remove(piece);
        break;
      case MyCategory.hat:
        _hats.remove(piece);
        break;
      case MyCategory.accessory:
        _accessories.remove(piece);
        break;
      case MyCategory.general:
        general.remove(piece);
        break;
    }
    ClothesBox.removePiece(piece.toMap()['category'], index);
    notifyListeners();
  }

  static loadPieces() async {
    _shirts.addAll(await ClothesBox.getPieces('shirts').then((value) => value.map((e) => Piece.fromMap(e)).toList()));
    _jackets.addAll(await ClothesBox.getPieces('jackets').then((value) => value.map((e) => Piece.fromMap(e)).toList()));
    _tshirts.addAll(await ClothesBox.getPieces('tshirts').then((value) => value.map((e) => Piece.fromMap(e)).toList()));
    _pants.addAll(await ClothesBox.getPieces('pants').then((value) => value.map((e) => Piece.fromMap(e)).toList()));
    _shoes.addAll(await ClothesBox.getPieces('shoes').then((value) => value.map((e) => Piece.fromMap(e)).toList()));
    _hats.addAll(await ClothesBox.getPieces('hats').then((value) => value.map((e) => Piece.fromMap(e)).toList()));
    _accessories.addAll(await ClothesBox.getPieces('accessories').then((value) => value.map((e) => Piece.fromMap(e)).toList()));

    // notifyListeners();
  }
}




