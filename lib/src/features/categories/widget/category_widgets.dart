// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';

class CategoryWidget {
  static Widget listCard(context, image) => SizedBox(
        height: 200,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AirPods Max',
                    style: TextStyle(
                      fontSize: 14,
                      color: TagColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: r'$707,600 ',
                          style: TextStyle(
                            color: TagColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: r'$65,960',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: TagColors.greyColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Free Shipping',
                    style: TextStyle(
                      fontSize: 10,
                      color: TagColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        TagColors.lemonGreen,
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
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
                ],
              ),
            ),
          ],
        ),
      );

  SnackBar topRight(child) => const SnackBar(
        content: Text(''),
      );

  static Widget gridCard(context, image) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: MediaQuery.sizeOf(context).width,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AirPods Max',
                    style: TextStyle(
                      fontSize: 14,
                      color: TagColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: r'$707,600 ',
                          style: TextStyle(
                            color: TagColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: r'$65,960',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: TagColors.greyColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Free Shipping',
                    style: TextStyle(
                      fontSize: 10,
                      color: TagColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        backgroundColor: const WidgetStatePropertyAll(
                          TagColors.lemonGreen,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
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
