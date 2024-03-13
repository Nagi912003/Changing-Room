import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // color: Colors.deepPurple,
      title: 'Changing Room',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const CameraOverlay(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Changing Room'),
      ),
      body: Center(
        child: Container(
          height: 750,
          width: MediaQuery.sizeOf(context).width * 0.9,
          // color: Colors.deepPurple,
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 0.53),
                child: SizedBox(
                  height: 411.6,
                  // width: 225,
                  // color: Colors.white,
                  child: Image.asset(
                    'assets/images/jeans2-removebg-preview.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 338.34,
                  // width: 275.409,
                  // color: Colors.greenAccent,
                  child: Image.asset(
                    'assets/images/white-tshirt-removebg-preview.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: myBottomNavigationBar(),
    );
  }

  Widget myBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
    );
  }
}

class CameraOverlay extends StatefulWidget {
  const CameraOverlay({Key? key}) : super(key: key);

  @override
  _CameraOverlayState createState() => _CameraOverlayState();
}

class _CameraOverlayState extends State<CameraOverlay> {
  late CameraController _controller;
  CroppedFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (kDebugMode) {
      print('cameras------------------------------------');
    }
    if (kDebugMode) {
      print(cameras);
    }
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {}); // Update the UI to show the preview
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          if (_imageFile == null)
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: CameraPreview(_controller),
                ),
              ),
            ),
          if (_imageFile != null)
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Image.file(File(_imageFile!.path)),
                ),
              ),
            ),

          // Your custom overlay widgets
          Align(
            alignment: const Alignment(0, -0.2),
            // top: 50,
            // left: 20,
            child: Image.asset(
              'assets/images/outlines/tshirt-top-outline.png',
              fit: BoxFit.fill,
              width: MediaQuery.sizeOf(context).width * 0.9,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureImage,
        child: const Icon(Icons.camera),
      ),
    );
  }

  // Future<void> _takePicture() async {
  //   final picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (pickedFile != null) {
  //     // Process the captured image (e.g., display it)
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  // Future<void> _captureImage() async {
  //   if (_controller.value.isInitialized) {
  //     final imagePath = await _getFilePath(); // Get a file path
  //
  //     try {
  //       await _controller.takePicture(imagePath);
  //       // Optionally, display a success message or navigate to image view
  //
  //     } catch (e) {
  //       // Handle errors (e.g., display a message)
  //       print(e);
  //     }
  //   }
  // }
  Future<void> _captureImage() async {
    if (_controller.value.isInitialized) {
      try {
        final XFile image = await _controller.takePicture();

        // Open the image cropper
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            // Optional: Add aspect ratio options
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              // Optional: Show the toolbar and other UI elements
              toolbarTitle: 'Crop image to fit',
              toolbarColor: Colors.deepPurple,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
          // ... (Other ImageCropper settings if desired)
        );

        if (croppedFile != null) {
          setState(() {
            _imageFile = croppedFile;
          });
        }
      } catch (e) {
        // Handle errors
        print(e);
      }
    }
  }

// Helper to get a file path in the app's temporary directory
//   Future<String> _getFilePath() async {
//     final directory = await getTemporaryDirectory();
//     return '${directory.path}/my_image_${DateTime.now()}.jpg';
//   }
}
