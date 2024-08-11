import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:go_router/go_router.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/widget/dotted_border.dart';
// import 'package:sizer/sizer.dart';
import 'package:tags/src/core/widget/imagepicker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    required TagImagePicker picker,
    required this.imageList,
    required this.onImageSelected,
    super.key,
  }) : _picker = picker;

  final TagImagePicker _picker;
  final ValueNotifier<List<XFile>> imageList;
  final void Function() onImageSelected;

  @override
  Widget build(BuildContext context) => IconButton(
        alignment: Alignment.center,
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            barrierColor: TagColors.textGrey,
            builder: (context) => ImagePickerWidget(
              picker: _picker,
              imageList: imageList,
              onImageSelected: onImageSelected,
            ),
          );
        },
        icon: const Icon(
          Icons.camera_alt,
          size: 23,
          color: Colors.white,
        ),
        color: Colors.white,
      );
}

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    required this.picker,
    required this.imageList,
    required this.onImageSelected,
    super.key,
  });

  final TagImagePicker picker;
  final ValueNotifier<List<XFile>> imageList;
  final void Function() onImageSelected;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Image',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: TagColors.textColor,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Select one or more images to upload',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: TagColors.textColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await picker
                            .pickImages(
                          source: ImageSource.camera,
                          imageList: imageList,
                        )
                            .then((value) {
                          if (imageList.value.isNotEmpty) {
                            log(imageList.value.toString());
                            Navigator.pop(context);
                            onImageSelected();
                          }
                        });
                      },
                      child: DotBorder(
                        borderType: BorderType.oval,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(4),
                        dashPattern: const [10, 10],
                        color: TagColors.textColor,
                        child: const Icon(
                          Icons.camera,
                          color: TagColors.textColor,
                          size: 70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Camera',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: TagColors.textColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await picker
                            .pickImages(
                          source: ImageSource.gallery,
                          imageList: imageList,
                        )
                            .then((value) {
                          if (imageList.value.isNotEmpty) {
                            log(imageList.value.toString());
                            Navigator.pop(context);
                            onImageSelected();
                          }
                        });
                      },
                      child: DotBorder(
                        borderType: BorderType.rRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(4),
                        dashPattern: const [10, 10],
                        color: TagColors.textColor,
                        child: const Icon(
                          Icons.photo_outlined,
                          color: TagColors.textColor,
                          size: 70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: TagColors.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

class DocumentPickerWidget extends StatelessWidget {
  const DocumentPickerWidget({
    required this.picker,
    required this.documentList,
    required this.onDocumentSelected,
    super.key,
  });

  final TagFilePicker picker;
  final ValueNotifier<List<PlatformFile>> documentList;
  final void Function() onDocumentSelected;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Documents',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: TagColors.textColor,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Select documents to upload',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: TagColors.textColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedDocuments = await picker.pickDocuments();
                        if (pickedDocuments != null) {
                          documentList.value = pickedDocuments;
                          context.pop();
                          onDocumentSelected();
                        }
                      },
                      child: DotBorder(
                        borderType: BorderType.oval,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(4),
                        dashPattern: const [10, 10],
                        color: TagColors.textColor,
                        child: const Icon(
                          Icons.file_copy,
                          color: TagColors.textColor,
                          size: 70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Files',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: TagColors.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

class PickedDocumentDisplay extends StatelessWidget {
  const PickedDocumentDisplay({
    required this.documentList,
    required this.isDark,
    super.key,
  });

  final ValueNotifier<List<PlatformFile>> documentList;
  final bool isDark;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: documentList.value
            .map(
              (file) => Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 10, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200], // Example color
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.insert_drive_file,
                      size: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      file.name,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );
}
