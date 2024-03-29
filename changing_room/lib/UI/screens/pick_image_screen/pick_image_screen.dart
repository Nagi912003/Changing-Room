import 'dart:io';

import 'package:camera/camera.dart';
import 'package:changing_room/Data/models/piece.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// import '../../../Business_Logic/remove_background.dart';
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
  late final List cameras;
  CameraController _cameraController = CameraController(
    const CameraDescription(
      name: '0',
      lensDirection: CameraLensDirection.back,
      sensorOrientation: 90,
    ),
    ResolutionPreset.max,
  );
  final String bgRemoverAPIKey = 'DTbCFd8MiPDdsn3ge17Pd2FM';

  // late AppState state;

  String? _imageFile;
  List<String> imagePaths = [];
  // bool imageinProcess = false;

  @override
  void initState() {
    super.initState();
    _initCameras();
    _initCamera();
    // state = AppState.free;
  }

  Future<void> _initCameras() async {
    cameras = await availableCameras();
  }

  Future<void> _initCamera() async {
    // if (cameras.length > 2) {
    //   _cameraController = CameraController(
    //     const CameraDescription(
    //       name: '2',
    //       lensDirection: CameraLensDirection.back,
    //       sensorOrientation: 90,
    //     ),
    //     ResolutionPreset.max,
    //   );
    // }
    _cameraController.setFocusMode(FocusMode.auto);
    await _cameraController.initialize();
    setState(() {});
  }

  // Future<void> _initCamera() async {
  //   cameras = await availableCameras();
  //   if (cameras.length > 2) {
  //     _cameraController = CameraController(
  //       const CameraDescription(
  //         name: '2',
  //         lensDirection: CameraLensDirection.back,
  //         sensorOrientation: 90,
  //       ),
  //       ResolutionPreset.max,
  //     );
  //   }
  //   _cameraController.setFlashMode(FlashMode.off);
  //   _cameraController.setFocusMode(FocusMode.auto);
  //   await _cameraController.initialize();
  //   // await _cameraController.setZoomLevel(1);
  //   // print available cameras
  //   if (kDebugMode) {
  //     print(
  //         'cameras: ---------------------------------\n\n\n\n$cameras\n\n\n\n---------------------------------');
  //   }
  //   // open the flash
  //   setState(() {});
  // }

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
                  top: (MediaQuery.sizeOf(context).height -
                              MediaQuery.sizeOf(context).width) /
                          2 -
                      110,
                  child: buildImageList(),
                ),
                if (clothes.state == AppState.free)
                  Positioned(
                    bottom: (MediaQuery.sizeOf(context).height -
                                MediaQuery.sizeOf(context).width) /
                            2 -
                        100,
                    child: imagePaths.length < outlines.length
                        ? Row(
                            children: [
                              IconButton(
                                icon: _cameraController.value.flashMode ==
                                        FlashMode.off
                                    ? const Icon(Icons.flash_on)
                                    : const Icon(Icons.flash_off),
                                onPressed: () {
                                  setState(() {
                                    _cameraController.setFlashMode(
                                      _cameraController.value.flashMode ==
                                              FlashMode.off
                                          ? FlashMode.torch
                                          : FlashMode.off,
                                    );
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              buildTakePictureButton(),
                              const SizedBox(
                                width: 16,
                              ),
                              if (cameras.length > 1)
                                IconButton(
                                  icon:
                                      const Icon(Icons.switch_camera_outlined),
                                  onPressed: () {
                                    // Navigate through the list of cameras
                                    _cameraController = CameraController(
                                      cameras.firstWhere(
                                        (element) =>
                                            element.lensDirection ==
                                            _cameraController
                                                .description.lensDirection &&
                                            element.name != _cameraController
                                                .description.name,
                                      ),
                                      ResolutionPreset.max,
                                    );
                                    _initCamera();
                                  },
                                ),
                            ],
                          )
                        : buildDoneButton(clothes.setImages),
                  ),
                if (clothes.state == AppState.picked)
                  Positioned(
                    bottom: 16,
                    child: buildButtons(),
                  ),
                if (clothes.state == AppState.processing)
                  const Positioned(
                      bottom: 16, child: Text('removing the background...')),
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
      child: clothes.isStateProcessing()
          ? const Center(child: CircularProgressIndicator())
          : null,
    );
    if (clothes.state == AppState.picked) {
      cameraPreview = Image.file(
        File(_imageFile!),
        fit: BoxFit.cover,
      );
    }
    if (clothes.state == AppState.free &&
        (imagePaths.length < outlines.length) &&
        !clothes.isStateProcessing()) {
      cameraPreview = CameraPreview(
        _cameraController,
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            outlines[imagePaths.length],
            fit: BoxFit.fitWidth,
            width: MediaQuery.sizeOf(context).width,
            color: const Color(0xffffffff),
          ),
        ),
      );
    }
    if (clothes.state == AppState.processing) {
      cameraPreview = const Center(child: CircularProgressIndicator());
    }

    return cameraPreview;
  }

  buildButtons() {
    return Row(
      children: [
        CupertinoButton.filled(
          onPressed: () async {
            await addImagePathToList(_imageFile!, 3);
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

      // setState(() {
      _imageFile = newImagePath;
      clothes.statePicked();
      // });

      // _saveImagePathToHive(newImagePath, widget.pieceId!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Handle any errors
    }
  }

  Future<void> addImagePathToList(String path, outlinesLength) async {
    final clothes = Provider.of<Clothes>(context, listen: false);
    // remove the background with the api
    // final Future<Uint8List> rbgImage = ApiClient().removeBgApi(path);

    // String newImagePath = path;
    // imageinProcess = true;
    // setState(() {
    // clothes.stateProcessing();
    // });

    final String newImagePath =
        await clothes.saveNewImage(path, widget.pieceId!, imagePaths.length);
    imagePaths.add(newImagePath);
    setState(() {});
    // setState(() {
    //   if (imagePaths.length >= outlinesLength) {
    //     // state = AppState.done;
    //   }
    //   clothes.stateFree();
    // });
  }

  _clearImage() {
    final clothes = Provider.of<Clothes>(context, listen: false);
    // setState(() {
    _imageFile = null;
    clothes.stateFree();
    // });
  }
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
