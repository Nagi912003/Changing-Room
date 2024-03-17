import 'package:flutter/material.dart';

import '../models/piece.dart';

import 'clothes_filter.dart';

class Clothes with ChangeNotifier {
  final _hats = [
    Piece(
        id: 'hat0',
        image: 'assets/images/hats/hat.png',
        colors: [MyColor.grey, MyColor.black, MyColor.white],
        category: Category.hat,
        isNew: New.old,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
    ),
  ];
  final _accessories = [
    Piece(
        id: 'accessories0',
        image: 'assets/images/accessories/accessories (1).png',
        colors: [MyColor.grey, MyColor.white],
        category: Category.accessory,
        brightness: Brightness.light,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
    ),
    Piece(
        id: 'accessories1',
        image: 'assets/images/accessories/accessories (2).png',
        colors: [MyColor.black],
        category: Category.accessory,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
    ),
    Piece(
        id: 'accessories2',
        image: 'assets/images/accessories/accessories (3).png',
        colors: [MyColor.black],
        category: Category.accessory,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
    ),
    Piece(
        id: 'accessories3',
        image: 'assets/images/accessories/accessories (4).png',
        colors: [MyColor.black],
        category: Category.accessory,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
    ),
    Piece(
        id: 'accessories4',
        image: 'assets/images/accessories/accessories (5).png',
        colors: [MyColor.brown],
        category: Category.accessory,
        brightness: Brightness.light,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
    ),
    Piece(
        id: 'accessories5',
        image: 'assets/images/accessories/accessories (6).png',
        colors: [MyColor.grey],
        category: Category.accessory,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
    ),
  ];
  final _tshirts = [
    //outdoors
    Piece(
        id: 'tshirt0',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (1).png',
        colors: [MyColor.blue],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
      fit: Fit.loose,
    ),
    Piece(
        id: 'tshirt1',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (2).png',
        colors: [MyColor.grey],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.both,
        forWeather: ForWeather.both,
      isNew: New.old,
      fit: Fit.regular,
    ),
    Piece(
        id: 'tshirt2',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (3).png',
        colors: [MyColor.grey, MyColor.black],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
      fit: Fit.regular,
    ),
    Piece(
        id: 'tshirt3',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (4).png',
        colors: [MyColor.black],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
      fit: Fit.regular,
    ),
    Piece(
        id: 'tshirt4',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (5).png',
        colors: [MyColor.black, MyColor.green],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
      fit: Fit.regular,
    ),
    Piece(
        id: 'tshirt5',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (6).png',
        colors: [MyColor.black],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      isNew: New.old,
      fit: Fit.regular,
    ),
    Piece(
        id: 'tshirt6',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (7).png',
        colors: [MyColor.grey, MyColor.white],
        category: Category.tshirt,
        brightness: Brightness.both,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,
    ),
    Piece(
        id: 'tshirt7',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (8).png',
        colors: [MyColor.green],
        category: Category.tshirt,
        brightness: Brightness.dark,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt8',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (9).png',
        colors: [MyColor.yellow],
        category: Category.tshirt,
        brightness: Brightness.dark,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'tshirt9',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (10).png',
        colors: [MyColor.orange, MyColor.red],
        category: Category.tshirt,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt10',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (11).png',
        colors: [MyColor.blue],
        category: Category.tshirt,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt11',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (12).png',
        colors: [MyColor.grey, MyColor.white],
        category: Category.tshirt,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.both,
        forWeather: ForWeather.both,
      fit: Fit.regular),
    Piece(
        id: 'tshirt12',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (13).png',
        colors: [MyColor.yellow],
        category: Category.tshirt,
        brightness: Brightness.light,
        isNew: New.new_,
        outDoors: OutDoors.both,
        forWeather: ForWeather.both,
      fit: Fit.regular
    ),
    Piece(
        id: 'tshirt13',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (14).png',
        colors: [MyColor.green],
        category: Category.tshirt,
        brightness: Brightness.light,
        isNew: New.new_,
        outDoors: OutDoors.both,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt14',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (15).png',
        colors: [MyColor.grey,MyColor.black],
        category: Category.tshirt,
        brightness: Brightness.dark,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt15',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (16).png',
        colors: [MyColor.blue],
        category: Category.tshirt,
        brightness: Brightness.dark,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt16',
        image: 'assets/images/tshirts/outdoors/tshirt-outdoors (17).png',
        colors: [MyColor.grey, MyColor.white],
        category: Category.tshirt,
        brightness: Brightness.both,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    //indoor
    Piece(
        id: 'tshirt17',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (1).png',
        colors: [MyColor.black],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,
    isNew: New.old,),
    Piece(
        id: 'tshirt18',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (2).png',
        colors: [MyColor.orange, MyColor.red],
        category: Category.tshirt,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,isNew: New.old),
    Piece(
        id: 'tshirt19',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (3).png',
        colors: [MyColor.green],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
        isNew: New.old,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'tshirt20',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (4).png',
        colors: [MyColor.green],
        category: Category.tshirt,
        brightness: Brightness.both,
        outDoors: OutDoors.both,
        forWeather: ForWeather.both,
      fit: Fit.regular,isNew: New.old,),
    Piece(
        id: 'tshirt21',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (5).png',
        colors: [MyColor.red],
        category: Category.tshirt,
        brightness: Brightness.light,
        outDoors: OutDoors.both,
        forWeather: ForWeather.both,
      fit: Fit.regular,isNew: New.old,),
    Piece(
        id: 'tshirt22',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (6).png',
        colors: [MyColor.grey],
        category: Category.tshirt,
        brightness: Brightness.both,
        outDoors: OutDoors.indoor,
        forWeather: ForWeather.both,
      fit: Fit.tight,isNew: New.old,),
    Piece(
        id: 'tshirt23',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (7).png',
        colors: [MyColor.blue],
        category: Category.tshirt,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
        forWeather: ForWeather.both,
      fit: Fit.tight,isNew: New.old,),
    Piece(
        id: 'tshirt24',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (8).png',
        colors: [MyColor.blue],
        category: Category.tshirt,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,isNew: New.old,),
    Piece(
        id: 'tshirt25',
        image: 'assets/images/tshirts/in-home/tshirt-in-home (9).png',
        colors: [MyColor.red],
        category: Category.tshirt,
        brightness: Brightness.both,
        outDoors: OutDoors.indoor,
        forWeather: ForWeather.both,
      fit: Fit.tight,isNew: New.old,),
  ];
  final _pants = [
    //outdoors
    Piece(
        id: 'pants17',
        image: 'assets/images/pants/outdoors/pants-outdoors (1).png',
        colors: [MyColor.green, MyColor.brown],
        category: Category.pants,
        brightness: Brightness.dark,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.hot,
      fit: Fit.regular,),
    Piece(
        id: 'pants18',
        image: 'assets/images/pants/outdoors/pants-outdoors (2).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.loose,
    ),
    Piece(
        id: 'pants19',
        image: 'assets/images/pants/outdoors/pants-outdoors (3).png',
        colors: [MyColor.brown],
        category: Category.pants,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants20',
        image: 'assets/images/pants/outdoors/pants-outdoors (4).png',
        colors: [MyColor.grey],
        category: Category.pants,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'pants21',
        image: 'assets/images/pants/outdoors/pants-outdoors (5).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.hot,
      fit: Fit.regular,),
    Piece(
        id: 'pants22',
        image: 'assets/images/pants/outdoors/pants-outdoors (6).png',
        colors: [MyColor.blue],
        category: Category.pants,
        brightness: Brightness.both,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.regular,
    ),
    Piece(
        id: 'pants23',
        image: 'assets/images/pants/outdoors/pants-outdoors (7).png',
        colors: [MyColor.blue],
        category: Category.pants,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'pants24',
        image: 'assets/images/pants/outdoors/pants-outdoors (8).png',
        colors: [MyColor.blue],
        category: Category.pants,
        brightness: Brightness.light,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants25',
        image: 'assets/images/pants/outdoors/pants-outdoors (9).png',
        colors: [MyColor.blue],
        category: Category.pants,
        brightness: Brightness.dark,
        isNew: New.new_,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'pants26',
        image: 'assets/images/pants/outdoors/pants-outdoors (10).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,fit: Fit.regular,),
    Piece(
        id: 'pants27',
        image: 'assets/images/pants/outdoors/pants-outdoors (11).png',
        colors: [MyColor.brown],
        category: Category.pants,
        brightness: Brightness.light,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,fit: Fit.regular,),
    Piece(
        id: 'pants28',
        image: 'assets/images/pants/outdoors/pants-outdoors (12).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        isNew: New.old,
        outDoors: OutDoors.outdoor,
        forWeather: ForWeather.both,fit: Fit.tight,),
    Piece(
        id: 'pants29',
        image: 'assets/images/pants/outdoors/pants-outdoors (13).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
      outDoors: OutDoors.outdoor,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
    //indoors
    Piece(
        id: 'pants0',
        image: 'assets/images/pants/in-home/pants-in-home.png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.both,
        isNew: New.new_,
        forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants1',
        image: 'assets/images/pants/in-home/pants-in-home (1).png',
        colors: [MyColor.white, MyColor.blue],
        category: Category.pants,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
        isNew: New.old,
        forWeather: ForWeather.hot,
      fit: Fit.loose,
    ),
    Piece(
        id: 'pants2',
        image: 'assets/images/pants/in-home/pants-in-home (2).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.new_,
      forWeather: ForWeather.hot,
      fit: Fit.loose,),
    Piece(
        id: 'pants3',
        image: 'assets/images/pants/in-home/pants-in-home (3).png',
        colors: [MyColor.blue, MyColor.red],
        category: Category.pants,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.hot,
      fit: Fit.tight,),
    Piece(
        id: 'pants4',
        image: 'assets/images/pants/in-home/pants-in-home (4).png',
        colors: [MyColor.brown],
        category: Category.pants,
        brightness: Brightness.both,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants5',
        image: 'assets/images/pants/in-home/pants-in-home (5).png',
        colors: [MyColor.brown],
        category: Category.pants,
        brightness: Brightness.both,
        outDoors: OutDoors.both,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
    Piece(
        id: 'pants6',
        image: 'assets/images/pants/in-home/pants-in-home (6).png',
        colors: [MyColor.blue],
        category: Category.pants,
        brightness: Brightness.both,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
    Piece(
        id: 'pants7',
        image: 'assets/images/pants/in-home/pants-in-home (7).png',
        colors: [MyColor.grey],
        category: Category.pants,
        brightness: Brightness.both,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants8',
        image: 'assets/images/pants/in-home/pants-in-home (8).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants9',
        image: 'assets/images/pants/in-home/pants-in-home (9).png',
        colors: [MyColor.blue],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'pants10',
        image: 'assets/images/pants/in-home/pants-in-home (10).png',
        colors: [MyColor.grey],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.tight,),
    Piece(
        id: 'pants11',
        image: 'assets/images/pants/in-home/pants-in-home (11).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
    Piece(
        id: 'pants12',
        image: 'assets/images/pants/in-home/pants-in-home (12).png',
        colors: [MyColor.grey],
        category: Category.pants,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
    Piece(
        id: 'pants13',
        image: 'assets/images/pants/in-home/pants-in-home (13).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
    Piece(
        id: 'pants14',
        image: 'assets/images/pants/in-home/pants-in-home (14).png',
        colors: [MyColor.black],
        category: Category.pants,
        brightness: Brightness.dark,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'pants15',
        image: 'assets/images/pants/in-home/pants-in-home (15).png',
        colors: [MyColor.green],
        category: Category.pants,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
    Piece(
        id: 'pants16',
        image: 'assets/images/pants/in-home/pants-in-home (16).png',
        colors: [MyColor.grey],
        category: Category.pants,
        brightness: Brightness.light,
        outDoors: OutDoors.indoor,
      isNew: New.old,
      forWeather: ForWeather.cold,
      fit: Fit.loose,),
  ];
  final _shoes = [
    Piece(
        id: 'shoes0',
        image: 'assets/images/shoes/shoe (1).png',
        colors: [MyColor.white],
        category: Category.shoes,
        brightness: Brightness.both,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'shoes1',
        image: 'assets/images/shoes/shoe (2).png',
        colors: [MyColor.brown],
        category: Category.shoes,
        brightness: Brightness.light,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'shoes2',
        image: 'assets/images/shoes/shoe (3).png',
        colors: [MyColor.blue, MyColor.white],
        category: Category.shoes,
        brightness: Brightness.both,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.loose,),
    Piece(
        id: 'shoes3',
        image: 'assets/images/shoes/shoe (4).png',
        colors: [MyColor.grey],
        category: Category.shoes,
        brightness: Brightness.both,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'shoes4',
        image: 'assets/images/shoes/shoe (5).png',
        colors: [MyColor.white, MyColor.brown],
        category: Category.shoes,
        brightness: Brightness.both,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'shoes5',
        image: 'assets/images/shoes/shoe (6).png',
        colors: [MyColor.white, MyColor.brown],
        category: Category.shoes,
        brightness: Brightness.both,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'shoes6',
        image: 'assets/images/shoes/shoe (7).png',
        colors: [MyColor.blue, MyColor.red],
        category: Category.shoes,
        brightness: Brightness.light,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'shoes7',
        image: 'assets/images/shoes/shoe (8).png',
        colors: [MyColor.black],
        category: Category.shoes,
        brightness: Brightness.dark,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
    Piece(
        id: 'shoes8',
        image: 'assets/images/shoes/shoe (9).png',
        colors: [MyColor.blue],
        category: Category.shoes,
        brightness: Brightness.light,
      isNew: New.new_,
      forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'shoes9',
        image: 'assets/images/shoes/shoe (10).png',
        colors: [MyColor.blue],
        category: Category.shoes,
        brightness: Brightness.light,
      isNew: New.old,
      forWeather: ForWeather.both,
      fit: Fit.tight,),
    Piece(
        id: 'shoes10',
        image: 'assets/images/shoes/shoe (11).png',
        colors: [MyColor.brown],
        category: Category.shoes,
        brightness: Brightness.light,
      isNew: New.old,
      forWeather: ForWeather.hot,
      fit: Fit.regular,),
    Piece(
        id: 'shoes11',
        image: 'assets/images/shoes/shoe (12).png',
        colors: [MyColor.black, MyColor.red],
        category: Category.shoes,
        brightness: Brightness.dark,
      isNew: New.new_,
      forWeather: ForWeather.both,
      fit: Fit.regular,),
  ];
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
    list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.shirtColor);
    list = Filter.filterByNew(list, Filter.newShirts);

    return list;
  }
  List<Piece> get jackets {
    List<Piece> list = Filter.filterOutDoors(_jackets);
    list = Filter.filterByWeather(list);
    list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.shirtColor);
    list = Filter.filterByNew(list, Filter.newShirts);

    return list;
  }
  List<Piece> get tshirts {
    List<Piece> list = Filter.filterOutDoors(_tshirts);
    list = Filter.filterByWeather(list);
    list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.tshirtColor);
    list = Filter.filterByNew(list, Filter.newTshirts);

    return list;
  }
  List<Piece> get pants {
    List<Piece> list = Filter.filterOutDoors(_pants);
    list = Filter.filterByWeather(list);
    list = Filter.filterByBrightness(list);
    list = Filter.filterByFit(list);
    list = Filter.filterByColors(list, Filter.pantsColor);
    list = Filter.filterByNew(list, Filter.newPants);

    return list;
  }
  List<Piece> get shoes {
    List<Piece> list = Filter.filterOutDoors(_shoes);
    list = Filter.filterByBrightness(list);
    list = Filter.filterByColors(list, Filter.shoesColor);
    list = Filter.filterByNew(list, Filter.newShoes);

    return list;
  }
  List<Piece> get hats {
    List<Piece> list = Filter.filterOutDoors(_hats);
    list = Filter.filterByWeather(list);
    list = Filter.filterByBrightness(list);
    list = Filter.filterByColors(list, Filter.hatColor);
    list = Filter.filterByNew(list, Filter.newHats);

    return list;
  }
  List<Piece> get accessories {
    List<Piece> list = Filter.filterOutDoors(_accessories);
    list = Filter.filterByWeather(list);
    list = Filter.filterByBrightness(list);
    list = Filter.filterByColors(list, Filter.accessoryColor);
    list = Filter.filterByNew(list, Filter.newAccessories);

    return list;
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
    }
  }
}




