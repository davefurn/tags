
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tags/src/core/constant/colors.dart';

Widget buildBusinessInfoRow() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Business logo and details
        Row(
          children: [
            // Business logo
            Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://via.placeholder.com/40',
                  ), // Replace with actual image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.horizontalSpace,

            // Business name, rating, and reviews
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dream car Enterprise',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: [
                    // Star rating
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < 4 ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                          size: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    const Text(
                      '(3 reviews)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Action buttons (message and call)
        Row(
          children: [
            Container(
              height: 35.h,
              width: 35.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TagColors.appThemeColor),
              ),
              child: Icon(
                Icons.chat_rounded,
                size: 15.sp,
                color: TagColors.appThemeColor,
              ),
            ),
            10.horizontalSpace,
            Container(
              height: 35.h,
              width: 35.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TagColors.appThemeColor),
              ),
              child:
                  Icon(Icons.call, size: 15.sp, color: TagColors.appThemeColor),
            ),
          ],
        ),
      ],
    );
