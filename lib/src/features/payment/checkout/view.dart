import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/cart/model/checkout_model.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({
    required this.subTotal,
    required this.delivery,
    required this.coupon,
    required this.orderData,
    super.key,
  });
  final OrderData orderData;
  final String subTotal;
  final String delivery;
  final String coupon;

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  String? token;
  late TextEditingController controller;
  @override
  void initState() {
    // Fetch token
    controller = TextEditingController();
    token = HiveStorage.get(HiveKeys.token);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: TagBar(
        state: state,
        token: token,
        isHome: false,
        title: 'Checkout',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
            Text(
              'Order Summary',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
            20.verticalSpace,
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.orderData.products.length *
                    180.h, // Adjust the height per item
              ),
              child: ListView.builder(
                itemCount: widget.orderData.products.length,
                itemBuilder: (context, index) => _buildProductCard(
                  context,
                  widget.orderData.products[index].image,
                  widget.orderData.products[index].name,
                  widget.orderData.products[index].quantity.toString(),
                  widget.orderData.products[index].price.toString(),
                  widget.orderData.products[index].currency,
                  widget.orderData.products[index].brand,
                  widget.orderData.products[index].color,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildAddressSection(),
            40.verticalSpace,
            _buildPaymentMethod(),
            const SizedBox(height: 20),
            _buildPaymentSummary(),
            const SizedBox(height: 30),
            _buildPaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String image,
    String name,
    String numberItem,
    String price,
    String currency,
    String brand,
    String color,
  ) =>
      Card(
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
                        name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$numberItem item - $currency $price',
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
                  Image.asset(
                    AssetsImages.delete,
                    height: 32.h,
                    width: 32.w,
                    fit: BoxFit.cover,
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
                        '✦ $name - $color',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '$currency $price',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  _buildQuantityChanger(),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildQuantityChanger() => DecoratedBox(
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
              onPressed: () {},
            ),
            Text(
              '1',
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
              onPressed: () {},
            ),
          ],
        ),
      );

  Widget _buildAddressSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          4.verticalSpace,
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: TagColors.textColor,
              ),
              const SizedBox(width: 8),
              Text(
                widget.orderData.address == ''
                    ? 'Address not supplied'
                    : widget.orderData.address,
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            'Item Instruction',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          8.verticalSpace,
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                borderSide: const BorderSide(
                  color: TagColors.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                borderSide: const BorderSide(
                  color: TagColors.appThemeColor,
                ),
              ),
              hintText: 'Add Instruction',
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200,
                color: const Color(0xffC6C6C6),
                letterSpacing: 1.2,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      );

  Widget _buildPaymentMethod() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pay Online'),
              Radio(
                value: 1,
                groupValue: 1,
                onChanged: (int? value) {},
                activeColor: Colors.green,
              ),
            ],
          ),
        ],
      );

  Widget _buildPaymentSummary() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            'Subtotal',
            '${widget.orderData.products[0].currency} ${widget.subTotal}',
          ),
          _buildSummaryRow(
            'Delivery',
            '${widget.orderData.products[0].currency} ${widget.delivery}',
          ),
          const Divider(),
          _buildSummaryRow(
            'Total',
            '${widget.orderData.products[0].currency} ${widget.orderData.total}',
            isBold: true,
          ),
        ],
      );

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );

  Widget _buildPaymentButton() => TagLoginButton(
        height: 50.h,
        child: Text(
          'Make Payments',
          style: TextStyle(
            fontFamily: 'Poppings',
            fontSize: 12.sp,
            letterSpacing: 1,
            color: TagColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {},
      );
}
