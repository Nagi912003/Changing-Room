enum MyCategory { shirt, tshirt, pants, shoes, hat, accessory, jacket ,general }

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
  List <String>  images;
  List<MyColor> colors;
  MyCategory category;
  // Brightness brightness;
  // String description = '';
  // double price;
  Fit fit;
  // New isNew;
  OutDoors outDoors;
  ForWeather forWeather;
  bool isAvailable = true;

  Piece({
    required this.id,
    required this.images,
    required this.colors,
    required this.category,
    // this.brightness = Brightness.light,
    // this.description = '',
    // this.price = 0.0,
    this.fit = Fit.regular,
    // this.isNew = New.old,
    this.outDoors = OutDoors.outdoor,
    this.forWeather = ForWeather.both,
    this.isAvailable = true,
  });
  toMap() {
    print(category.index);
    return {
      'id': id,
      'images': images,
      'colors': colors.map((e) => e.index).toList(),
      'category': category.index,
      // 'brightness': brightness.index,
      // 'description': description,
      // 'price': price,
      'fit': fit.index,
      // 'isNew': isNew.index,
      'outDoors': outDoors.index,
      'forWeather': forWeather.index,
      'isAvailable': isAvailable,
    };
  }

  Piece.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        images = map['images'],
        colors = map['colors'].map<MyColor>((e) => MyColor.values[e]).toList(),
        category = MyCategory.values[map['category']],
        // brightness = Brightness.values[map['brightness']],
        fit = Fit.values[map['fit']],
        // isNew = New.values[map['isNew']],
        outDoors = OutDoors.values[map['outDoors']],
        forWeather = ForWeather.values[map['forWeather']],
        isAvailable = map['isAvailable'];
}

class CategoryOutlines {
  static final Map<MyCategory, List<String>> _outlines = {
    MyCategory.shirt: [ 'assets/images/outlines/outline.png'],
    MyCategory.tshirt: ['assets/images/outlines/tshirt-top-outline.png', 'assets/images/outlines/outline.png'],
    MyCategory.pants: ['assets/images/outlines/tshirt-top-outline.png', 'assets/images/outlines/outline.png'],
    MyCategory.shoes: ['assets/images/outlines/outline.png'],
    MyCategory.hat: ['assets/images/outlines/outline.png'],
    MyCategory.accessory: ['assets/images/outlines/outline.png'],
    MyCategory.jacket: ['assets/images/outlines/outline.png'],
    MyCategory.general: ['assets/images/outlines/tshirt-top-outline.png', 'assets/images/outlines/outline.png'],
  };

  static List<String> getOutline(MyCategory category) {
    return _outlines[category]!;
  }
}
