import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';

class TagTheme {
  TagTheme._();
  static ThemeData lightTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TagColors.white,
    ),
    dialogBackgroundColor: TagColors.white,
    dialogTheme: const DialogTheme(
      backgroundColor: TagColors.white,
    ),
    primaryColor: TagColors.appThemeColor,
    brightness: Brightness.light,
    fontFamily: 'Nunito',
    // textTheme: TextsTheme.lightTheme,
    scaffoldBackgroundColor: TagColors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
