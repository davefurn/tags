import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/home/models/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildBusinessInfoRow(ViewMoreProduct? view) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Business logo and details
        Row(
          children: [
            // Business logo
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    view?.seller?.logo?.isNotEmpty == true
                        ? view!.seller!.logo! // Use seller's logo if available
                        : 'https://via.placeholder.com/40', // Fallback to placeholder image
                  ),
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
                  view?.seller?.name ??
                      'Unknown Business', // Default to 'Unknown Business' if null
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
                          index < (view?.seller?.stars?.toInt() ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.yellow,
                          size: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '(${view?.seller?.reviews ?? 0} reviews)', // Fallback to 0 reviews
                      style: const TextStyle(
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

        // Action buttons (email, message, and call)
        Row(
          children: [
            // Email button
            InkWell(
              onTap: () => _launchEmail(view?.seller?.email),
              child: Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: TagColors.appThemeColor),
                ),
                child: Icon(
                  Icons.email,
                  size: 15.sp,
                  color: TagColors.appThemeColor,
                ),
              ),
            ),
            10.horizontalSpace,

            // Message button
            InkWell(
              onTap: () {
                // Implement chat functionality here
              },
              child: Container(
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
            ),
            10.horizontalSpace,

            // Call button
            InkWell(
              onTap: () => _launchPhone(view?.seller?.phone),
              child: Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: TagColors.appThemeColor),
                ),
                child: Icon(
                  Icons.call,
                  size: 15.sp,
                  color: TagColors.appThemeColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );

/// Function to launch email client
Future<void> _launchEmail(String? email) async {
  if (email != null && email.isNotEmpty) {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      log('Could not launch email');
    }
  } else {
    log('Email not available');
  }
}

/// Function to launch phone dialer
Future<void> _launchPhone(String? phone) async {
  if (phone != null && phone.isNotEmpty) {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      log('Could not launch phone');
    }
  } else {
    log('Phone number not available');
  }
}
