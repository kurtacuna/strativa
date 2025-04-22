import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class ImageCropperService {
  static Future<File?> cropImage(String imagePath, String label) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop $label Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: false,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop $label Image',
        ),
      ],
    );

    if (croppedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/${label}_${basename(croppedFile.path)}';
      return File(croppedFile.path).copy(newPath);
    }

    return null;
  }
}
