import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderItem extends ConsumerWidget {
  const OrderItem({
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.sellerName,
    required this.status,
    required this.statusColor,
    required this.timeAgo,
    super.key,
  });

  final String imageUrl;
  final String productName;
  final String price;
  final String sellerName;
  final String status;
  final Color statusColor;
  final String timeAgo;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     Text(
                  //       sellerName,
                  //       style: const TextStyle(
                  //         fontSize: 12,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 6),
                  //     const Icon(
                  //       Icons.circle,
                  //       color: Colors.blue,
                  //       size: 8,
                  //     ),
                  //     const SizedBox(width: 6),
                  //     Text(
                  //       timeAgo,
                  //       style: const TextStyle(
                  //         fontSize: 12,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 6.w,
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      );
}
