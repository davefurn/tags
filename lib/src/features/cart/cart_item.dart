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
import 'package:tags/src/features/authentication/seller/sign_up/model/profile_viewmodel.dart';

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

    return Card(
      color: TagColors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(
          left: 0.w,
          top: 0.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product details
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$quantity item - \$$price',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  brand,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
                  child: Image.asset(
                    AssetsImages.delete,
                    height: 32.h,
                    width: 32.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✦ $productName - $color',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      '\$ $price',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                _buildQuantityChanger(model, context, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityChanger(
    ProfileViewModel model,
    BuildContext context,
    WidgetRef ref,
  ) {
    String newValue = '1';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              size: 14.sp,
            ),
            onPressed: () async {
              newValue = (int.parse(quantity) - 1).toString();
              final response = await model.editCart(
                formData: {
                  'product_slug': slug,
                  'quantity': newValue,
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
          ),
          Text(
            quantity,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: 14.sp,
            ),
            onPressed: () async {
              newValue = (int.parse(quantity) + 1).toString();

              final response = await model.editCart(
                formData: {
                  'product_slug': slug,
                  'quantity': newValue,
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
          ),
        ],
      ),
    );
  }
}
