import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/search/view.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getAllCart();
    });
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
          const InkWell(
            child: Icon(
              Icons.favorite_outline_rounded,
              color: Color(0xff5E5E5E),
            ),
          ),
          20.horizontalSpace,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const CustomTextInput(),
            56.verticalSpace,
            if (state.loading != Loader.loading &&
                state.cartProducts!.isNotEmpty)
              const SizedBox(
                height: 20,
              )
            else if (state.loading == Loader.loading)
              const Center(
                child: SpinKitWaveSpinner(
                  color: TagColors.appThemeColor,
                ),
              )
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
