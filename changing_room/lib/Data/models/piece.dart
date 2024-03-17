enum Category { shirt, tshirt, pants, shoes, hat, accessory, jacket }

enum MyColor {
  all,
  white,
  black,
  blue,
  darkBlue,
  green,
  red,
  yellow,
  orange,
  purple,
  pink,
  brown,
  grey
}

enum Fit { tight, regular, loose, all }

enum Brightness { light, dark, both, all }

enum OutDoors { indoor, outdoor, both, all }

enum ForWeather { hot, cold, both, all }

enum New { new_, old, all }

class Piece {
  String id;
  String image;
  List<MyColor> colors;
  Category category;
  Brightness brightness;
  // String description = '';
  // double price;
  Fit fit;
  New isNew;
  OutDoors outDoors;
  ForWeather forWeather;
  bool isAvailable = true;

  Piece({
    required this.id,
    required this.image,
    required this.colors,
    required this.category,
    this.brightness = Brightness.light,
    // this.description = '',
    // this.price = 0.0,
    this.fit = Fit.regular,
    this.isNew = New.old,
    this.outDoors = OutDoors.outdoor,
    this.forWeather = ForWeather.both,
    this.isAvailable = true,
  });
  toMap() {
    return {
      'id': id,
      'image': image,
      'colors': colors.map((e) => e.index).toList(),
      'category': category.index,
      'brightness': brightness.index,
      // 'description': description,
      // 'price': price,
      'fit': fit.index,
      'isNew': isNew.index,
      'outDoors': outDoors.index,
      'forWeather': forWeather.index,
      'isAvailable': isAvailable,
    };
  }

  Piece.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        image = map['image'],
        colors = map['colors'].map<MyColor>((e) => MyColor.values[e]).toList(),
        category = Category.values[map['category']],
        brightness = Brightness.values[map['brightness']],
        fit = Fit.values[map['fit']],
        isNew = New.values[map['isNew']],
        outDoors = OutDoors.values[map['outDoors']],
        forWeather = ForWeather.values[map['forWeather']],
        isAvailable = map['isAvailable'];
}
