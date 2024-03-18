import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../Data/providers/clothes.dart';

// import 'package:image_cropper/image_cropper.dart';

enum AppState {
  free,
  picked,
  done,
}

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({Key? key, required this.pieceId}) : super(key: key);
  final String? pieceId;

  @override
  _PickImageScreenState createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final CameraController _cameraController = CameraController(
    const CameraDescription(
      name: '0',
      lensDirection: CameraLensDirection.front,
      sensorOrientation: 0,
    ),
    ResolutionPreset.medium,
  );
  String? _imageFile;
  List<String> imagePaths = [];
  late AppState state;
  String bgRemoverAPIKey = 'DTbCFd8MiPDdsn3ge17Pd2FM';

  @override
  void initState() {
    super.initState();
    // _initializeCamera();
    _initCamera();
    state = AppState.free;
  }

  Future<void> _initCamera() async {
    await _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clothes = Provider.of<Clothes>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Image'),
      ),
      body: !_cameraController.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  // alignment: Alignment.center,
                  children: [
                    imagePaths.isNotEmpty
                        ? SizedBox(
                            height: 100,
                            width: MediaQuery.sizeOf(context).width - 16,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: imagePaths.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(imagePaths[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox(
                            height: 100,
                          ),
                    const SizedBox(height: 16),
                    Stack(
                      children: [
                        if (state == AppState.free)
                          Align(
                            alignment: const Alignment(0, -0.2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                // height: MediaQuery.sizeOf(context).width - 16,
                                width: MediaQuery.sizeOf(context).width - 16,
                                child: CameraPreview(
                                  _cameraController,
                                  child: Image.asset(
                                    'assets/images/outlines/tshirt-top-outline.png',
                                    fit: BoxFit.fitWidth,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (state == AppState.picked)
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                // height: MediaQuery.sizeOf(context).height * 0.6,
                                // width: MediaQuery.sizeOf(context).width * 0.9,
                                child: Image.file(File(_imageFile!)),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (state == AppState.free)
                      CupertinoButton.filled(
                        onPressed: _takePicture,
                        child: const Text('Take Picture'),
                      ),
                    if (state == AppState.picked)
                      Row(
                        children: [
                          CupertinoButton.filled(
                            onPressed: () {
                              addImagePathToList(_imageFile!);
                              _clearImage();
                              clothes.setImages(imagePaths);
                              // clothes.addImage(_imageFile!);
                              print(clothes.imagesInput);
                            },
                            child: const Text('save'),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          CupertinoButton.filled(
                            onPressed: _clearImage,
                            child: const Text('retake picture'),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    // if (state == AppState.picked)
                    CupertinoButton.filled(
                      onPressed: () {
                        saveImagePathsToHive();
                        Navigator.of(context).pop();
                      },
                      child: const Text('save'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _takePicture() async {
    try {
      final image = await _cameraController.takePicture();

      final appDirectory = await getApplicationDocumentsDirectory();
      final newImagePath =
          '${appDirectory.path}/${DateTime.now().millisecond}.jpg';
      await image.saveTo(newImagePath);

      setState(() {
        _imageFile = newImagePath;
        state = AppState.picked;
      });

      // _saveImagePathToHive(newImagePath, widget.pieceId!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Handle any errors
    }
  }

  void addImagePathToList(String path) {
    setState(() {
      imagePaths.add(path);
    });
  }

  void saveImagePathsToHive() async {
    var box = await Hive.openBox('imageBox');
    box.put('imagePaths${widget.pieceId}', imagePaths);
  }
  // Future<void> _captureAndCropImage() async {
  //   if (_controller.value.isInitialized) {
  //     try {
  //       final XFile image = await _controller.takePicture();
  //
  //       // Open the image cropper
  //       // CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       //   sourcePath: image.path,
  //       //   aspectRatioPresets: [
  //       //     // Optional: Add aspect ratio options
  //       //     CropAspectRatioPreset.square,
  //       //     // CropAspectRatioPreset.ratio3x2,
  //       //     CropAspectRatioPreset.original,
  //       //     // CropAspectRatioPreset.ratio4x3,
  //       //     // CropAspectRatioPreset.
  //       //   ],
  //       //   uiSettings: [
  //       //     AndroidUiSettings(
  //       //       // Optional: Show the toolbar and other UI elements
  //       //       toolbarTitle: 'Crop image to fit',
  //       //       toolbarColor: Colors.deepPurple,
  //       //       toolbarWidgetColor: Colors.white,
  //       //       initAspectRatio: CropAspectRatioPreset.original,
  //       //       lockAspectRatio: false,
  //       //       activeControlsWidgetColor: Colors.deepPurple,
  //       //     ),
  //       //   ],
  //       //   // ... (Other ImageCropper settings if desired)
  //       // );
  //
  //       // if (croppedFile != null) {
  //       //   setState(() {
  //       //     _imageFile = croppedFile;
  //       //     state = AppState.cropped;
  //       //   });
  //       // }
  //     } catch (e) {
  //       // Handle errors
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //     }
  //   }
  // }

  _clearImage() {
    setState(() {
      _imageFile = null;
      state = AppState.free;
    });
  }

  Future<void> _saveImagePathToHive(String path, String pieceId) async {
    var box = await Hive.openBox('imageBox');
    box.put('imagePath${pieceId}', path);
  }

// Helper to get a file path in the app's temporary directory
//   Future<String> _getFilePath() async {
//     final directory = await getTemporaryDirectory();
//     return '${directory.path}/my_image_${DateTime.now()}.jpg';
//   }
}
