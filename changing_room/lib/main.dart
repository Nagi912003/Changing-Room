///----------------------------------------------------------------------------------------------------------------
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import './Business_Logic/remove_background.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: RemoveBackground(),
//     ),
//   );
// }
//
// class RemoveBackground extends StatefulWidget {
//   @override
//   _RemoveBackgroundState createState() => new _RemoveBackgroundState();
// }
//
// class _RemoveBackgroundState extends State<RemoveBackground> {
//   Uint8List? imageFile;
//
//   String? imagePath;
//
//   ScreenshotController controller = ScreenshotController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[300],
//         appBar: AppBar(
//           title: const Text('Remove Bg'),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   getImage(ImageSource.gallery);
//                 },
//                 icon: const Icon(Icons.image)),
//             IconButton(
//                 onPressed: () {
//                   getImage(ImageSource.camera);
//                 },
//                 icon: const Icon(Icons.camera_alt)),
//             IconButton(
//                 onPressed: () async {
//                   imageFile = await ApiClient().removeBgApi(imagePath!);
//                   setState(() {});
//                 },
//                 icon: const Icon(Icons.delete)),
//             IconButton(
//                 onPressed: () async {
//                   saveImage();
//                 },
//                 icon: const Icon(Icons.save))
//           ],
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               (imageFile != null)
//                   ? Screenshot(
//                       controller: controller,
//                       child: Image.memory(
//                         imageFile!,
//                       ),
//                     )
//                   : Container(
//                       width: 300,
//                       height: 300,
//                       color: Colors.grey[300]!,
//                       child: const Icon(
//                         Icons.image,
//                         size: 100,
//                       ),
//                     ),
//             ],
//           ),
//         ));
//   }
//
//   void getImage(ImageSource source) async {
//     try {
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage != null) {
//         imagePath = pickedImage.path;
//         imageFile = await pickedImage.readAsBytes();
//         setState(() {});
//       }
//     } catch (e) {
//       imageFile = null;
//       setState(() {});
//     }
//   }
//
//   void saveImage() async {
//     // Permission.storage.request();
//     // bool isGranted = await Permission.storage.status.isGranted;
//     // if (!isGranted) {
//     //   isGranted = await Permission.storage.request().isGranted;
//     // }
//     //
//     // if (isGranted) {
//     //   String directory = (await getExternalStorageDirectory())!.path;
//     //   String fileName =
//     //       DateTime.now().microsecondsSinceEpoch.toString() + ".png";
//     //   controller.captureAndSave(directory, fileName: fileName);
//     // }
//   }
// }

///----------------------------------------------------------------------------------------------------------------
import 'package:changing_room/UI/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'Data/providers/clothes.dart';
import 'Data/providers/clothes_filter.dart';
import 'Data/providers/clothes_selector_provider.dart';
import 'Data/providers/favorites.dart';
import 'helpers/clothes_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('imageBox'); // Open a Hive box named 'imageBox'
  await Hive.openBox('shirts');
  await Hive.openBox('pants');
  await Hive.openBox('tshirts');
  await Hive.openBox('shoes');
  await Hive.openBox('hats');
  await Hive.openBox('accessories');
  await Hive.openBox('jackets');

  // ClothesBox.clearAll(); // Clear the box
  Clothes.loadPieces(); // Load all the clothes
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857142857144, 914.2857142857143),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (BuildContext context) => Clothes()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => ClothesSelectorProvider()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => Filter()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => Favorites()),
            ],
            child: MaterialApp(
              theme: ThemeData(
                // brightness: Brightness.dark,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              title: 'Image Saving with Hive',
              home: HomeScreen(),
            ),
          );
        });
  }
}
