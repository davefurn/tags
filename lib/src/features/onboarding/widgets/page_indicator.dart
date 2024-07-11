import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.currentPage,
    required this.indicatorColor,
    required this.inactiveIndicatorColor,
    required this.totalPages,
    super.key,
  });
  final int currentPage;
  final int totalPages;
  final Color indicatorColor;
  final Color inactiveIndicatorColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (index) => Container(
                  width: 40,
                  height: 10,
                  // padding: EdgeInsets.all(2),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1.2, color: inactiveIndicatorColor),
                    // shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    color: index == currentPage - 1
                        ? indicatorColor
                        : inactiveIndicatorColor,
                  ),
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      );
}
