import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// class TagImagePicker {
//   TagImagePicker(this._picker);
//   final ImagePicker _picker;

//   Future<void> pickImage(
//       {required ImageSource source,
//       required ValueNotifier<XFile> imageList}) async {
//     final XFile? images = await _picker.pickImage(
//       source: source,
//       imageQuality: 50,
//       maxHeight: 1000,
//       maxWidth: 1000,
//     );
//     //imageList.value = images!;

//     if (images != null) {
//       final croppedImage = await ImageCropper().cropImage(
//         sourcePath: images.path,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         aspectRatioPresets: [CropAspectRatioPreset.square],
//         cropStyle: CropStyle.circle,
//       );

//       imageList.value = XFile(croppedImage!.path);
//     }
//   }
// }

class TagImagePicker {
  TagImagePicker(this._picker);
  final ImagePicker _picker;

  Future<void> pickImage(
      {required ImageSource source,
      required ValueNotifier<XFile> imageList}) async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    if (Platform.isIOS) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    final XFile? images = await _picker.pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (images != null) {
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
      }

      imageList.value = images;
    }
  }
}
