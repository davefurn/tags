// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/widget/tag_loader.dart';

Widget tagDefaultButton({
  onTap,
  color,
  text,
  height,
  icon,
  textColor = TagColors.black,
  bool loading = false,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: InkWell(
        onTap: loading ? null : onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: icon != null ? Colors.transparent : color ?? TagColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: icon != null ? Border.all(color: textColor) : null,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 91, 91, 100).withOpacity(0.20),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
              // BoxShadow(color: Colors.black54, blurRadius: 2, spreadRadius: 1)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const TagLoader(
                          size: 20,
                          color: TagColors.appThemeColor,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null)
                          SvgPicture.asset(
                            'assets/svg/$icon.svg',
                            color: textColor,
                          ),
                        const SizedBox(width: 5),
                        Text(
                          text ?? '',
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );

Widget strengthText(text, {color}) => Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 8),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'NeulisAlt',
                fontSize: 12,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );

Widget smallButton({onTap, color, text, textColor}) => InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? TagColors.white,
          // border: Border.all(color: PRIMARY, width: 1)
        ),
        child: Center(
          child: Text(
            text ?? 'Close',
            style: TextStyle(
              fontFamily: 'NeulisAlt',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? TagColors.black,
            ),
          ),
        ),
      ),
    );
