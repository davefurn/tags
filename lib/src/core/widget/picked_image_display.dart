import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickedImageDisplay extends StatelessWidget {
  const PickedImageDisplay({
    required this.imageList,
    required this.isDark,
    super.key,
  });

  final ValueNotifier<XFile> imageList;
  final bool isDark;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // height: 84,
            // width: 84,
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(right: 10, bottom: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.file(
              File(imageList.value.path),
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
}
