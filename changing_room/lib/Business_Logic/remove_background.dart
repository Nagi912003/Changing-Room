
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<Uint8List> removeBgApi(String imagePath) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": "4EBpzsf6oeWejxtCKnRVJumy"
      , "crop": "true"
      // , "crop_margin": "10px"
      , "type": "clothes"
      , "size": "full"
    }); //Put Your API key HERE
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }

  // Future<File?> removeBgApiNew(File imageFile) async {
  //   try {
  //     // Prepare the API request
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse('https://sdk.photoroom.com/v1/segment'));
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'image_file', imageFile.path));
  //
  //     request.headers['X-API-KEY'] = '279eb530-e8f8-11ee-8a63-07b85785431f';
  //     request.headers['crop'] = 'true';
  //
  //     // Send the request and get the response
  //     final response = await request.send();
  //     final responseBytes = await response.stream.toBytes();
  //
  //     if (response.statusCode == 200) {
  //       // Save the image with the removed background
  //       final newImagePath = '${imageFile.parent.path}/output_${imageFile.path.split("/").last}';
  //       final newImageFile = await File(newImagePath).writeAsBytes(responseBytes);
  //       return newImageFile;
  //     } else {
  //       print('API request failed: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (error) {
  //     print('Error removing background: $error');
  //     return null;
  //   }
  // }
  // Future<File?> removeImageBackgroundDeepImage(File imageFile) async {
  //   try {
  //     // Prepare API request
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse('https://deep-image.ai/rest_api/process_result'));
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'image', imageFile.path)); // Note: 'image' is the expected file field name
  //
  //     request.headers['X-API-KEY'] = '279eb530-e8f8-11ee-8a63-07b85785431f';
  //
  //     // Send the request
  //     final response = await request.send();
  //     final responseBytes = await response.stream.toBytes();
  //
  //     if (response.statusCode == 200) {
  //       // Save the image with the background removed
  //       final newImagePath = '${imageFile.parent.path}/output_${imageFile.path.split("/").last}';
  //       final newImageFile = await File(newImagePath).writeAsBytes(responseBytes);
  //       return newImageFile;
  //     } else {
  //       print('API request failed: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (error) {
  //     print('Error removing background: $error');
  //     return null;
  //   }
  // }
}

class ImageProcessor {
  Future<String> saveNewImage(String imagePath, String id, int count) async {
    // 1. Get the image data from the API
    Uint8List imageData = await ApiClient().removeBgApi(imagePath);

    // 2. Save to a new file
    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/${DateTime.now().millisecond}.png'; // Adjust the name
    final newImageFile = File(newImagePath).writeAsBytesSync(imageData);

    // 3. Return the new path
    return newImagePath;
  }

  // Future<String> saveNewImageNew(File imageFile, String id, String count) async {
  //   // 1. Get the image data from the API
  //   File? newImageFile = await ApiClient().removeImageBackgroundDeepImage(imageFile);
  //
  //   // 2. Save to a new file
  //   final directory = await getApplicationDocumentsDirectory();
  //   final newImagePath = '${directory.path}/${DateTime.now().millisecond}.png'; // Adjust the name
  //   await newImageFile!.copy(newImagePath);
  //
  //   // 3. Return the new path
  //   return newImagePath;
  // }
}