import 'dart:io';

import 'package:camera/camera.dart';
import 'package:changing_room/Data/models/piece.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../Business_Logic/remove_background.dart';
import '../../../Data/providers/clothes.dart';


class PickImageScreen extends StatefulWidget {
  const PickImageScreen(
      {Key? key, required this.pieceId, required this.selectedCategory})
      : super(key: key);
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
    ResolutionPreset.high,
  );
  final String bgRemoverAPIKey = 'DTbCFd8MiPDdsn3ge17Pd2FM';

  // late AppState state;

  String? _imageFile;
  List<String> imagePaths = [];
  // bool imageinProcess = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
    // state = AppState.free;
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
      // appBar: AppBar(
      //   title: const Text('Pick Image'),
      // ),
      body: !_cameraController.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.center,
              children: [
                buildCameraPreview(outlines),

                SizedBox(
                  // color: Colors.red,
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black,
                        height: (MediaQuery.sizeOf(context).height -
                                MediaQuery.sizeOf(context).width) /
                            2,
                      ),
                      Container(
                        // color: Colors.blue,
                        height: MediaQuery.sizeOf(context).width,
                      ),
                      Container(
                        color: Colors.black,
                        height: (MediaQuery.sizeOf(context).height -
                                MediaQuery.sizeOf(context).width) /
                            2,
                      ),
                    ],
                  ),
                ),
                // list of images
                Positioned(
                  top: (MediaQuery.sizeOf(context).height - MediaQuery.sizeOf(context).width)/2 - 110 ,
                  child: buildImageList(),
                ),
                if (clothes.state == AppState.free)
                  Positioned(
                    bottom: (MediaQuery.sizeOf(context).height - MediaQuery.sizeOf(context).width)/2 - 100,
                    child: imagePaths.length < outlines.length
                        ? buildTakePictureButton()
                        : buildDoneButton(clothes.setImages),
                  ),
                if (clothes.state == AppState.picked)
                  Positioned(
                    bottom: 16,
                    child: buildButtons(),
                  ),
              ],
            ),
    );
  }

  buildImageList() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: imagePaths.isNotEmpty ? 100 : 0,
      width: MediaQuery.sizeOf(context).width - 16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return SizedBox(
            /// height: 100, ------------------------------------->
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
    );
  }

  buildCameraPreview(List outlines) {
    final clothes = Provider.of<Clothes>(context);
    Widget cameraPreview = AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: clothes.state == AppState.processing
          ? const Center(child: CircularProgressIndicator())
          : null,
    );
    if (clothes.state == AppState.picked) {
      cameraPreview = Image.file(
        File(_imageFile!),
        fit: BoxFit.cover,
      );
    }
    if (clothes.state == AppState.free && (imagePaths.length < outlines.length)) {
      cameraPreview = CameraPreview(
        _cameraController,
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            outlines[imagePaths.length],
            fit: BoxFit.fitWidth,
            width: MediaQuery.sizeOf(context).width,
          ),
        ),
      );
      if (clothes.state == AppState.processing) {
        cameraPreview = CameraPreview(
          _cameraController,
          child: const Center(child: CircularProgressIndicator()),
        );
      }
    }

    return cameraPreview;
  }

  buildButtons() {
    return Row(
      children: [
        CupertinoButton.filled(
          onPressed: () {
            addImagePathToList(_imageFile!, 3);
            _clearImage();
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
    );
  }

  buildTakePictureButton() {
    return CupertinoButton.filled(
      onPressed: _takePicture,
      child: const Text('Take Picture'),
    );
  }

  buildDoneButton(setImages) {
    return CupertinoButton.filled(
      onPressed: () {
        setImages(imagePaths);
        // saveImagePathsToHive();
        Navigator.of(context).pop();
      },
      child: const Text('Done'),
    );
  }

  Future<void> _takePicture() async {
    final clothes = Provider.of<Clothes>(context, listen: false);
    try {
      final image = await _cameraController.takePicture();

      final appDirectory = await getApplicationDocumentsDirectory();
      final newImagePath =
          '${appDirectory.path}/${DateTime.now().millisecond}.jpg';
      await image.saveTo(newImagePath);

      setState(() {
        _imageFile = newImagePath;
        clothes.statePicked();
      });

      // _saveImagePathToHive(newImagePath, widget.pieceId!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Handle any errors
    }
  }

  void addImagePathToList(String path, outlinesLength) async {
    final clothes = Provider.of<Clothes>(context, listen: false);
    // remove the background with the api
    // final Future<Uint8List> rbgImage = ApiClient().removeBgApi(path);

    // String newImagePath = path;
    // imageinProcess = true;
    // setState(() {
      clothes.stateProcessing();
    // });

    final String newImagePath = await ImageProcessor()
        .saveNewImage(path, widget.pieceId!, imagePaths.length.toString());
      imagePaths.add(newImagePath);
    setState(() {
      if (imagePaths.length >= outlinesLength) {
        // state = AppState.done;
      }
        clothes.stateFree();
    });
  }


  // void saveImagePathsToHive() async {
  //   var box = await Hive.openBox('imageBox');
  //   box.put('imagePaths${widget.pieceId}', imagePaths);
  // }
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
    final clothes = Provider.of<Clothes>(context, listen: false);
    setState(() {
      _imageFile = null;
      clothes.stateFree();
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
