import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tags/src/core/constant/colors.dart';

class TagLoader extends StatelessWidget {
  const TagLoader({
    super.key,
    this.color,
    this.size = 50.0,
  });
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitSquareCircle(
            duration: const Duration(seconds: 2),
            color: color ?? TagColors.appThemeColor,
            size: size,
          ),
        ],
      );
}

class OverlayLoader extends StatelessWidget {
  const OverlayLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.2),
        child: Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => const TagLoader(
                size: 60,
              ),
              opaque: true,
            ),
          ],
        ),
      );
}
