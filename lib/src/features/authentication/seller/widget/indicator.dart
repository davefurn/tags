import 'package:flutter/material.dart';

class NewPageIndicator extends StatelessWidget {
  const NewPageIndicator({
    required this.currentPage,
    required this.indicatorColor,
    required this.totalPages,
    required this.inactiveIndicatorColor,
    super.key,
  });
  final int currentPage;
  final int totalPages;
  final Color indicatorColor;
  final Color inactiveIndicatorColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                totalPages,
                (index) => Container(
                  width: (MediaQuery.of(context).size.width / totalPages) - 24,
                  height: 8,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: index + 1 <= currentPage
                        ? indicatorColor
                        : inactiveIndicatorColor,
                  ),
                ),
              ),
            ),
            // const SizedBox(),
          ],
        ),
      );
}

class TagTitleSub extends StatelessWidget {
  const TagTitleSub({
    required this.title,
    required this.subz,
    super.key,
  });
  final String title;
  final String subz;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            subz,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w300,
              color: Color(0xff5E5E5E),
              fontSize: 13,
            ),
          ),
        ],
      );
}
