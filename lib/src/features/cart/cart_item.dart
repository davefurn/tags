import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';

class CartItem extends ConsumerWidget {
  const CartItem({
    required this.image,
    required this.productName,
    required this.price,
    required this.discount,
    required this.brand,
    required this.color,
    required this.quantity,
    required this.delete,
    required this.slug,
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
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(profileProvider.notifier);

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

          InkWell(
            onTap: () async {
              final response = await model.delCart(
                formData: {
                  'product_slug': slug,
                },
              );

              if (response.successMessage.isNotEmpty && context.mounted) {
                await ref.read(profileProvider.notifier).getAllCart();
              } else if (response.errorMessage.isNotEmpty &&
                  context.mounted &&
                  response.errorMessage ==
                      'Authentication credentials were not provided.') {
                await context.pushNamed(TagRoutes.sellerLogin.name);
              } else if (response.errorMessage.isNotEmpty &&
                  context.mounted &&
                  response.errorMessage !=
                      'Authentication credentials were not provided.') {
                await showDialog(
                  context: context,
                  builder: (context) => TagDialog(
                    icon: const Icon(
                      Icons.error,
                      color: TagColors.red,
                      size: 50,
                    ),
                    title: 'Failed',
                    subtitle: response.errorMessage,
                    buttonColor: TagColors.red,
                    textColor: Colors.white,
                    buttonText: 'Dismiss',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else {
                log(response.error!.response!.statusCode.toString());
              }
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                AssetsImages.delete,
                height: 32.h,
                width: 32.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
