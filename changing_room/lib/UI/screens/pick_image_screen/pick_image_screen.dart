import 'dart:io';

import 'package:camera/camera.dart';
import 'package:changing_room/Data/models/piece.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../Business_Logic/remove_background.dart';
import '../../../Data/providers/clothes.dart';

// import 'package:image_cropper/image_cropper.dart';

enum AppState {
  free,
  picked,
  done,
}

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({Key? key, required this.pieceId, required this.selectedCategory}) : super(key: key);
  final String? pieceId;
  final MyCategory selectedCategory;

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
    ResolutionPreset.max,
  );
  String? _imageFile;
  List<String> imagePaths = [];
  late AppState state;
  String bgRemoverAPIKey = 'DTbCFd8MiPDdsn3ge17Pd2FM';

  @override
  void initState() {
    super.initState();
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
    final outlines = CategoryOutlines.getOutline(widget.selectedCategory);
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
                     AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                            height: imagePaths.isNotEmpty ?100:0,
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
                          ),
                    const SizedBox(height: 16),
                    Stack(
                      children: [
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
                        if (state == AppState.free && (imagePaths.length < outlines.length))
                          Align(
                            alignment: const Alignment(0, -0.2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                // height: MediaQuery.sizeOf(context).width - 16,
                                width: MediaQuery.sizeOf(context).width,
                                child: CameraPreview(
                                  _cameraController,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(
                                      outlines[imagePaths.length],
                                      // fit: BoxFit.fitWidth,
                                      width:
                                          MediaQuery.sizeOf(context).width,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (state == AppState.free)
                      CupertinoButton.filled(
                        onPressed: imagePaths.length < outlines.length?_takePicture: (){
                          clothes.setImages(imagePaths);
                          Navigator.of(context).pop();
                        },
                        child: imagePaths.length < outlines.length?const Text('Take Picture'): const Text('Done'),
                      ),
                    if (state == AppState.picked)
                      Row(
                        children: [
                          CupertinoButton.filled(
                            onPressed: () {
                              addImagePathToList(_imageFile!, outlines.length - 1);
                              clothes.setImages(imagePaths);
                              _clearImage();
                              if(state == AppState.done){
                                saveImagePathsToHive();
                                Navigator.of(context).pop();
                              }
                              // clothes.addImage(_imageFile!);
                              // print(clothes.imagesInput);
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

  void addImagePathToList(String path, outlinesLength) async {
    // remove the background with the api
    // final Future<Uint8List> rbgImage = ApiClient().removeBgApi(path);

    // String newImagePath = path;
    final String
    newImagePath = await ImageProcessor().saveNewImage(path, widget.pieceId!, imagePaths.length.toString());

    setState(() {
      imagePaths.add(newImagePath);
      if(imagePaths.length >= outlinesLength){
        // state = AppState.done;
      }
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

  // Future<void> _saveImagePathToHive(String path, String pieceId) async {
  //   var box = await Hive.openBox('imageBox');
  //   box.put('imagePath${pieceId}', path);
  // }

// Helper to get a file path in the app's temporary directory
//   Future<String> _getFilePath() async {
//     final directory = await getTemporaryDirectory();
//     return '${directory.path}/my_image_${DateTime.now()}.jpg';
//   }
}
