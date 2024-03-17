import 'package:flutter/material.dart';

import '../models/piece.dart';

class Filter with ChangeNotifier{
  static OutDoors outDoors = OutDoors.all;
  static ForWeather forWeather = ForWeather.all;
  static Brightness brightness = Brightness.all;
  static Fit fit = Fit.all;

  static List<MyColor> hatColor = [];
  static List<MyColor> accessoryColor = [];
  static List<MyColor> shirtColor = [];
  static List<MyColor> tshirtColor = [];
  static List<MyColor> pantsColor = [];
  static List<MyColor> shoesColor = [];

  static New newHats = New.all;
  static New newAccessories = New.all;
  static New newShirts = New.all;
  static New newTshirts = New.all;
  static New newPants = New.all;
  static New newShoes = New.all;


  static List<Piece> filterOutDoors(List<Piece> list) {
    if (outDoors == OutDoors.indoor) {
      return list
          .where((element) => element.outDoors == OutDoors.indoor)
          .toList();
    } else if (outDoors == OutDoors.outdoor) {
      return list
          .where((element) => element.outDoors == OutDoors.outdoor)
          .toList();
    } else if (outDoors == OutDoors.both) {
      return list
          .where((element) => element.outDoors == OutDoors.both)
          .toList();
    }

    return list;
  }
  static List<Piece> filterByWeather(List<Piece> list) {
    if (forWeather == ForWeather.cold) {
      return list
          .where((element) => element.forWeather == ForWeather.cold || element.forWeather == ForWeather.both)
          .toList();
    } else if (forWeather == ForWeather.hot) {
      return list
          .where((element) => element.forWeather == ForWeather.hot || element.forWeather == ForWeather.both)
          .toList();
    } else if (forWeather == ForWeather.both) {
      return list
          .where((element) => element.forWeather == ForWeather.both)
          .toList();
    }

    return list;
  }
  static List<Piece> filterByBrightness(List<Piece> list) {
    if (brightness == Brightness.light) {
      return list
          .where((element) => (element.brightness == Brightness.light ||
          element.brightness == Brightness.both))
          .toList();
    } else if (brightness == Brightness.dark) {
      return list
          .where((element) => (element.brightness == Brightness.dark||
          element.brightness == Brightness.both))
          .toList();
    } else if (brightness == Brightness.both) {
      return list
          .where((element) => element.brightness == Brightness.both)
          .toList();
    }

    return list;
  }
  static List<Piece> filterByFit(List<Piece> list) {
    if (fit == Fit.tight) {
      return list.where((element) => element.fit == Fit.tight).toList();
    } else if (fit == Fit.loose) {
      return list.where((element) => element.fit == Fit.loose).toList();
    } else if (fit == Fit.regular) {
      return list.where((element) => element.fit == Fit.regular).toList();
    }
    return list;
  }
  static List<Piece> filterByColors(List<Piece> list, List<MyColor> colors) {
    if (colors.isEmpty) return list;

    return list.where((element) {
      // Check if the element's colors list contains any of the selected colors
      return element.colors.any((color) => colors.contains(color));
    }).toList();
  }
  static List<Piece> filterByNew(List<Piece> list, New isNew) {
    if (isNew == New.all) return list;
    return list.where((element) => element.isNew == isNew).toList();
  }

  void resetFilters() {
    outDoors = OutDoors.all;
    forWeather = ForWeather.all;
    brightness = Brightness.all;
    fit = Fit.all;
    hatColor = [];
    accessoryColor = [];
    shirtColor = [];
    tshirtColor = [];
    pantsColor = [];
    shoesColor = [];
    newHats = New.all;
    newAccessories = New.all;
    newShirts = New.all;
    newTshirts = New.all;
    newPants = New.all;
    newShoes = New.all;
    notifyListeners();
  }
}