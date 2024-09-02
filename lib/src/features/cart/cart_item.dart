import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tags/src/core/resources/resources.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.image,
    required this.productName,
    required this.price,
    required this.discount,
    required this.brand,
    required this.color,
    required this.quantity,
    required this.delete,
    super.key,
  });
  final String image;
  final String productName;
  final String price;
  final String discount;
  final String brand;
  final String color;
  final String quantity;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,##0', 'en_US');
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  image, // Replace with actual image URL
                  width: 130.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                ),
              ),
              16.horizontalSpace,
              // Product Details
              SizedBox(
                height: 160.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          format.format(double.tryParse(price)),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        4.horizontalSpace,
                        Text(
                          format.format(double.tryParse(discount)),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Text(
                      'Brand',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      brand,
                      style: TextStyle(
                        color: const Color(0xff5e5e5e),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Color',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      color == '' ? 'null' : color,
                      style: TextStyle(
                        color: const Color(0xff5e5e5e),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      quantity,
                      style: TextStyle(
                        color: const Color(0xff5e5e5e),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Delete Icon

          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              AssetsImages.delete,
              height: 32.h,
              width: 32.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
