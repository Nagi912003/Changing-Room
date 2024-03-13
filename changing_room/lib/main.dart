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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './Business_Logic/remove_background.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RemoveBackground(),
    ),
  );
}

class RemoveBackground extends StatefulWidget {
  @override
  _RemoveBackgroundState createState() => new _RemoveBackgroundState();
}

class _RemoveBackgroundState extends State<RemoveBackground> {
  Uint8List? imageFile;

  String? imagePath;

  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Remove Bg'),
          actions: [
            IconButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.image)),
            IconButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt)),
            IconButton(
                onPressed: () async {
                  imageFile = await ApiClient().removeBgApi(imagePath!);
                  setState(() {});
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () async {
                  saveImage();
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (imageFile != null)
                  ? Screenshot(
                      controller: controller,
                      child: Image.memory(
                        imageFile!,
                      ),
                    )
                  : Container(
                      width: 300,
                      height: 300,
                      color: Colors.grey[300]!,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                      ),
                    ),
            ],
          ),
        ));
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile = await pickedImage.readAsBytes();
        setState(() {});
      }
    } catch (e) {
      imageFile = null;
      setState(() {});
    }
  }

  void saveImage() async {
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }

    if (isGranted) {
      String directory = (await getExternalStorageDirectory())!.path;
      String fileName =
          DateTime.now().microsecondsSinceEpoch.toString() + ".png";
      controller.captureAndSave(directory, fileName: fileName);
    }
  }
}
