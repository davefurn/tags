// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tags/src/core/constant/colors.dart';

class CategoryWidget {
  static Widget listCard(context, image, name, price, discountedPrice) =>
      SizedBox(
        height: 135.h,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: 135.h,
                    width: 141.w,
                  ),
                ),
              ),
            ),
            39.horizontalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: TagColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: discountedPrice,
                          style: TextStyle(
                            color: const Color(0xff0B1B34),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '  $price',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: TagColors.greyColor,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  4.verticalSpace,
                  const Text(
                    'Free Shipping',
                    style: TextStyle(
                      fontSize: 10,
                      color: TagColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: TagColors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: TagColors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: TagColors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: TagColors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star_border,
                        color: TagColors.yellow,
                        size: 20,
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        TagColors.lemonGreen,
                      ),
                      foregroundColor: const MaterialStatePropertyAll(
                        TagColors.white,
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          surfaceTintColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          elevation: 1,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          content: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 56,
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.8,
                              ),
                              color: TagColors.blue,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.done,
                                    color: TagColors.white,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Cart Successfully updated',
                                    style: TextStyle(
                                      color: TagColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .removeCurrentMaterialBanner();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: TagColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: const [
                            SizedBox(),
                            SizedBox(),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: TagColors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  SnackBar topRight(child) => const SnackBar(
        content: Text(''),
      );

  static Widget gridCard(context, image, name, price, discountedPrice) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 135.h,
              width: MediaQuery.sizeOf(context).width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  height: 135.h,
                ),
              ),
            ),
            8.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: TagColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: discountedPrice,
                        style: TextStyle(
                          color: const Color(0xff0B1B34),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '  $price',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: TagColors.greyColor,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                4.verticalSpace,
                const Text(
                  'Free Shipping',
                  style: TextStyle(
                    fontSize: 10,
                    color: TagColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                4.verticalSpace,
                const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: TagColors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: TagColors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: TagColors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: TagColors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star_border,
                      color: TagColors.yellow,
                      size: 20,
                    ),
                  ],
                ),
                4.verticalSpace,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        TagColors.lemonGreen,
                      ),
                      foregroundColor: const MaterialStatePropertyAll(
                        TagColors.white,
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          surfaceTintColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          elevation: 1,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          content: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 56,
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.8,
                              ),
                              color: TagColors.blue,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.done,
                                    color: TagColors.white,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Cart Successfully updated',
                                    style: TextStyle(
                                      color: TagColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .removeCurrentMaterialBanner();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: TagColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: const [
                            SizedBox(),
                            SizedBox(),
                          ],
                        ),
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ),
           
           
              ],
            ),
          ],
        ),
      );
}

class TopRight extends StatelessWidget {
  const TopRight({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.only(top: 16, right: 16),
        child: Align(
          alignment: Alignment.topRight,
          child: SnackBar(content: Text('Cart successfully updated')),
        ),
      );
}
