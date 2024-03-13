import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';

enum AppState {
  free,
  picked,
  cropped,
}

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({Key? key}) : super(key: key);

  @override
  _PickImageScreenState createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  late CameraController _controller;
  CroppedFile? _imageFile;
  late AppState state;
  String bgRemoverAPIKey = 'DTbCFd8MiPDdsn3ge17Pd2FM';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    state = AppState.free;
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
          if (state == AppState.free)
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
          if (state == AppState.cropped)
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
          if (state == AppState.free)
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
        onPressed: state==AppState.free ?_captureAndCropImage:_clearImage,
        child: state==AppState.free?const Icon(Icons.camera):const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> _captureAndCropImage() async {
    if (_controller.value.isInitialized) {
      try {
        final XFile image = await _controller.takePicture();

        // Open the image cropper
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            // Optional: Add aspect ratio options
            CropAspectRatioPreset.square,
            // CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            // CropAspectRatioPreset.ratio4x3,
            // CropAspectRatioPreset.
          ],
          uiSettings: [
            AndroidUiSettings(
              // Optional: Show the toolbar and other UI elements
              toolbarTitle: 'Crop image to fit',
              toolbarColor: Colors.deepPurple,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              activeControlsWidgetColor: Colors.deepPurple,
            ),
          ],
          // ... (Other ImageCropper settings if desired)
        );

        if (croppedFile != null) {
          setState(() {
            _imageFile = croppedFile;
            state = AppState.cropped;
          });
        }
      } catch (e) {
        // Handle errors
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  _clearImage() {
    setState(() {
      _imageFile = null;
      state = AppState.free;
    });
  }

// Helper to get a file path in the app's temporary directory
//   Future<String> _getFilePath() async {
//     final directory = await getTemporaryDirectory();
//     return '${directory.path}/my_image_${DateTime.now()}.jpg';
//   }

}
