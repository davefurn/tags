import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/widget/general_widgets.dart';

class TagDialog extends StatelessWidget {
  const TagDialog({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.onTap,
    this.buttonText,
    this.buttonColor,
    this.textColor,
    this.icon,
  });
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final String? buttonText;
  final Widget? icon;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                SvgPicture.asset(
                  Assets.success,
                  height: 100,
                  // color: const Color(0xff000000),
                ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'NeulisAlt',
                fontSize: 13,
                color: TagColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'NeulisAlt',
                fontSize: 14,
                color: TagColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          tagDefaultButton(
            color: buttonColor,
            textColor: textColor ?? Colors.white,
            text: buttonText ?? 'Continue',
            onTap: onTap,
          ),
        ],
      );
}
