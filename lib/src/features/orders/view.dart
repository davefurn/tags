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
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/orders/widget/order_history.dart';

import 'package:tags/src/features/search/view.dart';

class OrderHistory extends ConsumerStatefulWidget {
  const OrderHistory({super.key});

  @override
  ConsumerState<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends ConsumerState<OrderHistory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final response =
          await ref.read(profileProvider.notifier).getAllOrderHistory();
      switch (response.errorMessage) {
        case 'Authentication credentials were not provided.':
          final responseRefresh =
              await ref.read(profileProvider.notifier).refresh();
          log('Case one running');
          if (responseRefresh.successMessage == 'Token refreshed') {
            log('Case one running, success message');
            await ref.read(profileProvider.notifier).getAllWishlist();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: TagBar(
        isHome: false,
        title: 'Order History',
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const CustomTextInput(),
            25.verticalSpace,
            if (state.loading != Loader.loading &&
                state.orderdetails!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Orders',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LimitedBox(
                    maxHeight: 700.h,
                    child: ListView.builder(
                      itemCount: state.orderdetails!.length, // Number of orders
                      itemBuilder: (context, index) => OrderItem(
                        imageUrl: 'https://via.placeholder.com/40',
                        productName:
                            state.orderdetails![index].orderId.toString(),
                        price:
                            '${state.orderdetails![index].currency} ${state.orderdetails![index].total}',
                        sellerName: 'Tola Koko',
                        status: index % 3 == 0
                            ? 'Delivered'
                            : index % 3 == 1
                                ? 'Pending'
                                : 'Shipped',
                        statusColor: index % 3 == 0
                            ? Colors.green
                            : index % 3 == 1
                                ? Colors.red
                                : Colors.yellow,
                        timeAgo: '2 days ago',
                      ),
                    ),
                  ),
                ],
              )
            else if (state.loading == Loader.loading)
              const SizedBox.shrink()
            else if (state.loading != Loader.loading &&
                state.orderdetails!.isNotEmpty)
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
                    'No recent orders',
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
                    "We noticed you haven't made any orders yet. Explore our best-selling products for inspiration",
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
