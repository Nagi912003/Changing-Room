// import 'package:flutter/material.dart';
//
// import 'package:changing_room/UI/screens/pick_image_screen/pick_image_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // color: Colors.deepPurple,
//       title: 'Changing Room',
//       theme: ThemeData(
//         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       themeMode: ThemeMode.system,
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         useMaterial3: true,
//       ),
//       home: const PickImageScreen(),
//     );
//   }
// }
//

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
import 'package:changing_room/UI/screens/pick_image_screen/pick_image_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('imageBox'); // Open a Hive box named 'imageBox'
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Image Saving with Hive',
      home: ImageSaver(),
    );
  }
}

class ImageSaver extends StatefulWidget {
  const ImageSaver({Key? key}) : super(key: key);

  @override
  _ImageSaverState createState() => _ImageSaverState();
}

class _ImageSaverState extends State<ImageSaver> {
  String? _imagePath;
  // CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    // _initCamera();
    _loadImageFromHive();
  }

  // Future<void> _initCamera() async {
  //   final cameras = await availableCameras();
  //   final firstCamera = cameras.first;
  //   _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
  //   await _cameraController?.initialize();
  //   setState(() {});
  // }

  Future<void> _loadImageFromHive() async {
    var box = await Hive.openBox('imageBox');
    setState(() {
      _imagePath = box.get('imagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // backgroundColor: Colors.transparent,
        middle: Text('Image Saving with Hive'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagePath != null
                ? Image.file(File(_imagePath!))
                : const Text('No image selected.'),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PickImageScreen(),
                ),
              ),
              child: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}