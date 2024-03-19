import 'package:hive_flutter/hive_flutter.dart';

class ClothesBox {
  // static const String _boxName = 'clothes';
  static const String _shirtsBoxName = 'shirts';
  static const String _tshirtsBoxName = 'tshirts';
  static const String _pantsBoxName = 'pants';
  static const String _shoesBoxName = 'shoes';
  static const String _hatsBoxName = 'hats';
  static const String _accessoriesBoxName = 'accessories';
  static const String _jacketsBoxName = 'jackets';

  static Future<Box> openShirtsBox() async {
    return await Hive.openBox(_shirtsBoxName);
  }

  static Future<Box> openTshirtsBox() async {
    return await Hive.openBox(_tshirtsBoxName);
  }

  static Future<Box> openPantsBox() async {
    return await Hive.openBox(_pantsBoxName);
  }

  static Future<Box> openShoesBox() async {
    return await Hive.openBox(_shoesBoxName);
  }

  static Future<Box> openHatsBox() async {
    return await Hive.openBox(_hatsBoxName);
  }

  static Future<Box> openAccessoriesBox() async {
    return await Hive.openBox(_accessoriesBoxName);
  }

  static Future<Box> openJacketsBox() async {
    return await Hive.openBox(_jacketsBoxName);
  }

  static Future<void> addPiece(Map<String, dynamic> piece) async {
    // print('images from the box : ${piece['images']}');
    final category = piece['category'];
    // enum Category { shirt, tshirt, pants, shoes, hat, accessory, jacket }
    switch (category) {
      case 0:
        final Box box = await openShirtsBox();
        await box.add(piece);
        break;
      case 1:
        final Box box = await openTshirtsBox();
        await box.add(piece);
        break;
      case 2:
        final Box box = await openPantsBox();
        await box.add(piece);
        break;
      case 3:
        final Box box = await openShoesBox();
        await box.add(piece);
        break;
      case 4:
        final Box box = await openHatsBox();
        await box.add(piece);
        break;
      case 5:
        final Box box = await openAccessoriesBox();
        await box.add(piece);
        break;
      case 6:
        final Box box = await openJacketsBox();
        await box.add(piece);
        break;
      default:
        throw 'Invalid category';
    }
  }


  static Future<void> removePiece(int category, int index) async {
    switch (category) {
      case 0:
        final Box box = await openShirtsBox();
        await box.deleteAt(index);
        break;
      case 1:
        final Box box = await openTshirtsBox();
        await box.deleteAt(index);
        break;
      case 2:
        final Box box = await openPantsBox();
        await box.deleteAt(index);
        break;
      case 3:
        final Box box = await openShoesBox();
        await box.deleteAt(index);
        break;
      case 4:
        final Box box = await openHatsBox();
        await box.deleteAt(index);
        break;
      case 5:
        final Box box = await openAccessoriesBox();
        await box.deleteAt(index);
        break;
      case 6:
        final Box box = await openJacketsBox();
        await box.deleteAt(index);
        break;
      default:
        throw 'Invalid category';
    }
  }

  static Future<List<Map<dynamic, dynamic>>> getPieces(String category) async {
    switch (category) {
      case 'shirts':
        final Box box = await openShirtsBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      case 'tshirts':
        final Box box = await openTshirtsBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      case 'pants':
        final Box box = await openPantsBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      case 'shoes':
        final Box box = await openShoesBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      case 'hats':
        final Box box = await openHatsBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      case 'accessories':
        final Box box = await openAccessoriesBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      case 'jackets':
        final Box box = await openJacketsBox();
        final List<Map<dynamic, dynamic>> pieces = [];
        for (int i = 0; i < box.length; i++) {
          pieces.add(box.getAt(i));
        }
        return pieces;
      default:
        throw 'Invalid category';
    }
  }

  static clearAll() async {
    await openShirtsBox().then((value) => value.clear());
    await openTshirtsBox().then((value) => value.clear());
    await openPantsBox().then((value) => value.clear());
    await openShoesBox().then((value) => value.clear());
    await openHatsBox().then((value) => value.clear());
    await openAccessoriesBox().then((value) => value.clear());
    await openJacketsBox().then((value) => value.clear());
  }
}
