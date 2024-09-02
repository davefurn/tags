import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/authentication/seller/sign_up/model/profile_viewmodel.dart';

class ProductSpecTiles extends StatelessWidget {
  const ProductSpecTiles({
    required this.theme,
    required this.state,
    required this.title,
    this.subDetails,
    super.key,
  });

  final ThemeData theme;
  final ProfileState state;
  final String title;
  final String? subDetails;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: TagColors.greyColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Theme(
          data: theme,
          child: ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            showTrailingIcon: false,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: TagColors.greyColor),
            ),
            title: Text(
              title,
              style: TextStyle(
                color: TagColors.black,
                fontSize: 12.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  subDetails ?? '',
                  style: TextStyle(
                    color: TagColors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
