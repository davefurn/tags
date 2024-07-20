// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:tags/src/core/constant/colors.dart';

class TagText extends StatelessWidget {
  const TagText({
    required this.fontWeight,
    required this.fontColor,
    required this.text,
    required this.fontSize,
    this.fontStyle,
    this.textAlign,
    super.key,
  });
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
        text,
        overflow: TextOverflow.clip,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 1.2,
          color: fontColor,
        ),
      );
}

class TagText2 extends StatelessWidget {
  const TagText2({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.fontColor,
    this.fontStyle,
    this.textAlign,
    super.key,
  });
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
        text,
        overflow: TextOverflow.clip,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 1.2,
          color: fontColor,
        ),
      );
}

class TagButton extends StatelessWidget {
  const TagButton({
    required this.child,
    required this.width,
    required this.height,
    required this.onTap,
    super.key,
  });
  final Widget child;
  final double width;
  final double height;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: TagColors.appThemeColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      );
}

class TagLoginButton extends StatelessWidget {
  const TagLoginButton({
    required this.child,
    required this.onTap,
    super.key,
    this.borderColor,
    this.myColor,
  });
  final Widget child;
  final void Function() onTap;
  final Color? myColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 57.h,
          width: MediaQuery.of(context).size.width - 40.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: myColor ?? TagColors.appThemeColor,
            border: Border.all(
              color: borderColor ?? TagColors.white,
            ),
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: child,
        ),
      );
}

class errorButton extends StatelessWidget {
  const errorButton({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        height: 60,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: TagColors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );
}

class TagCustomField extends StatelessWidget {
  const TagCustomField({
    required this.controller,
    required this.title,
    required this.hintText,
    required this.textCapitalization,
    super.key,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.prefixText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final String hintText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;

  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              color: TagColors.newText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            cursorColor: TagColors.black,
            controller: controller,
            obscureText: obscureText,
            maxLength: maxLength,
            // maxLines: maxLines,
            onChanged: onChanged,

            onEditingComplete: onEditingComplete,
            textInputAction: TextInputAction.next,
            textCapitalization: textCapitalization,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xff5E5E5E),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            autovalidateMode: autovalidateMode,
            keyboardType: keyboardType,
            validator: validator,
            onSaved: (value) {},
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 11),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD0D5DD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: TagColors.appThemeColor),
              ),
              filled: true,
              fillColor: Colors.white,
              prefixText: prefixText,
              // hintText: 'Enter your password',
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: Color(0xff5E5E5E),
                fontSize: 12,
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      );
}

class TagCustomField2 extends StatelessWidget {
  const TagCustomField2({
    required this.controller,
    required this.title,
    required this.hintText,
    super.key,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.prefixText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final String hintText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;

  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              color: TagColors.newText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            cursorColor: TagColors.black,
            controller: controller,
            maxLength: maxLength,
            maxLines: maxLines,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              color: Color(0xff5E5E5E),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            autovalidateMode: autovalidateMode,
            keyboardType: keyboardType,
            validator: validator,
            onSaved: (value) {},
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 11),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD0D5DD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: TagColors.appThemeColor),
              ),
              filled: true,
              fillColor: Colors.white,
              prefixText: prefixText,
              // hintText: 'Enter your password',
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: Color(0xff5E5E5E),
                fontSize: 12,
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      );
}

String removeThousandSeparator(String value) => value.replaceAll(',', '');

// Function to format the amount with thousand separators
String formatAmountWithThousandSeparator(String value) {
  final numberFormat = NumberFormat('#,###,##0', 'en_US');
  try {
    return numberFormat.format(double.parse(value));
  } on Exception catch (e) {
    log(e.toString());
    return '';
  }
}
