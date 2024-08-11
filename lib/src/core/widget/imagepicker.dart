import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  Future<void> pickImages({
    required ImageSource source,
    required ValueNotifier<List<XFile>> imageList,
  }) async {
    if (Platform.isAndroid || Platform.isIOS) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    List<XFile>? images;
    if (source == ImageSource.gallery) {
      images = await _picker.pickMultiImage(
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
      );
    } else if (source == ImageSource.camera) {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
      );
      if (image != null) {
        images = [image];
      }
    }

    if (images != null && images.isNotEmpty) {
      imageList.value = images;
    }
  }
}

class TagFilePicker {
  TagFilePicker(); // No need for ImagePicker dependency

  Future<List<PlatformFile>?> pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Allow picking multiple documents
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
      ], // Define allowed document types
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files;
    } else {
      return null;
    }
  }
}
