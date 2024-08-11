import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickedImageDisplay extends StatelessWidget {
  const PickedImageDisplay({
    required this.imageList,
    required this.isDark,
    super.key,
  });

  final ValueNotifier<List<XFile>> imageList;
  final bool isDark;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 10, // spacing between images
        runSpacing: 10, // spacing between rows
        children: imageList.value
            .map((image) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.cover,
                        width: 84,
                        height: 84,
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: GestureDetector(
                        onTap: () {
                          imageList.value = imageList.value
                              .where((i) => i != image)
                              .toList(); // Remove the image from the list
                        },
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
            .toList(),
      );
}
