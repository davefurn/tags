import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showTagBottomSheet({
  required Widget child,
  required BuildContext context,
}) {
  showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => child,
  );
}
