import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TakeImageButton extends StatefulWidget {
  TakeImageButton({Key? key, required this.imagePaths, this.pieceId}) : super(key: key);
  final String? pieceId;
  List<String> imagePaths;

  @override
  _TakeImageButtonState createState() => _TakeImageButtonState();
}

class _TakeImageButtonState extends State<TakeImageButton> {
  // String? imagePath;
  // CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    // _initCamera();
    _loadImageFromHive();
  }

  Future<void> _loadImageFromHive() async {
    var box = await Hive.openBox('imageBox');
    setState(() {
      widget.imagePaths.add(box.get('imagePath${widget.pieceId}')) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.imagePaths.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(widget.imagePaths.first),
                    fit: BoxFit.cover,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //      builder: (context) => PickImageScreen(pieceId: widget.pieceId,),
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.camera_alt,size: 70,),
                ),
        ),
      ),
    );
  }
}
