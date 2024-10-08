import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/cart/cart_item.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/search/view.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  String? token;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final response = await ref.read(profileProvider.notifier).getAllCart();
      await ref.read(profileProvider.notifier).getAllWishlist();
      switch (response.errorMessage) {
        case 'Authentication credentials were not provided.':
          final responseRefresh =
              await ref.read(profileProvider.notifier).refresh();
          log('Case one running');
          if (responseRefresh.successMessage == 'Token refreshed') {
            log('Case one running, success message');
            await ref.read(profileProvider.notifier).getAllCart();
          } else {
            log('Case one running, successful message');
            await context.pushNamed(TagRoutes.sellerLogin.name);
          }
          break;
        default:
          log('Case one failed, failed message');
          // Handle other cases or proceed if no error
          break;
      }
    });
    token = HiveStorage.get(HiveKeys.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);

    return Scaffold(
      appBar: TagBar(
        isHome: false,
        title: 'Cart',
        actions: [
          InkWell(
            onTap: token == null || token!.isEmpty
                ? () {
                    context.goNamed(TagRoutes.sellerLogin.name);
                  }
                : () {
                    context.pushNamed(TagRoutes.wishlist.name);
                  },
            child: const Icon(
              Icons.favorite_outline_rounded,
              color: Color(0xff5E5E5E),
            ),
          ),
          20.horizontalSpace,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const CustomTextInput(),
            25.verticalSpace,
            if (state.loading != Loader.loading &&
                state.cartProducts!.isNotEmpty)
              Column(
                children: [
                  LimitedBox(
                    maxHeight: 550.h,
                    child: ListView.builder(
                      itemCount: state.cartProducts!
                          .length, // Assuming there are 2 items in the cart
                      itemBuilder: (context, index) => CartItem(
                        slug: state.cartProducts![index].slug.toString(),
                        image: state.cartProducts![index].image.toString(),
                        productName: state.cartProducts![index].name.toString(),
                        price: state.cartProducts![index].price.toString(),
                        discount: state.cartProducts![index].discountedPrice
                            .toString(),
                        brand: state.cartProducts![index].brand.toString(),
                        color: state.cartProducts![index].color.toString(),
                        quantity:
                            state.cartProducts![index].quantity.toString(),
                        delete: () {},
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  TagLoginButton(
                    height: 50.h,
                    child: Text(
                      'Check out',
                      style: TextStyle(
                        fontFamily: 'Poppings',
                        fontSize: 12.sp,
                        letterSpacing: 1,
                        color: TagColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              )
            else if (state.loading != Loader.loading &&
                state.cartProducts!.isNotEmpty)
              const SizedBox.shrink()
            else if (state.loading == Loader.loading)
              const SizedBox.shrink()
            else
              Column(
                children: [
                  Image.asset(
                    AssetsImages.cart,
                    width: 76.w,
                    height: 76.h,
                  ),
                  28.verticalSpace,
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.sp,
                      letterSpacing: 1,
                      color: TagColors.textColor,
                      // const Color(0xff344054),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  12.verticalSpace,
                  Text(
                    "We noticed you haven't filled your cart yet. Explore our best-selling products for inspiration",
                    style: TextStyle(
                      fontFamily: 'Poppings',
                      fontSize: 14.sp,
                      letterSpacing: 1,
                      color: TagColors.textColor,
                      // const Color(0xff344054),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  24.verticalSpace,
                  TagLoginButton(
                    height: 38.h,
                    child: Text(
                      'Start Shopping',
                      style: TextStyle(
                        fontFamily: 'Poppings',
                        fontSize: 12.sp,
                        letterSpacing: 1,
                        color: TagColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.goNamed(TagRoutes.categories.name);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
