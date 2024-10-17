import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/cart/model/checkout_model.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({
    required this.orderData,
    super.key,
  });
  final OrderData orderData;

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  String? token;
  @override
  void initState() {
    // Fetch token
    token = HiveStorage.get(HiveKeys.token);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: TagBar(
        isHome: true,
        title: 'Search',
        actions: const [],
        token: token,
        state: state,
      ),
      body: ListView(
        children: [
          30.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
