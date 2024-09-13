import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tags/src/core/constant/colors.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.image,
    required this.productName,
    required this.price,
    required this.discount,
    required this.brand,
    required this.currency,
    super.key,
  });
  final String image;
  final String productName;
  final String price;
  final String discount;
  final String brand;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,##0', 'en_US');
    Map<String, String> currencySymbols = {
      'USD': r'$', // Dollar
      'NGN': '₦', // Naira
      'EUR': '€', // Euro
      'GBP': '£', // Pound
      // Add other currencies as needed
    };

// Function to get the currency symbol
    String getCurrencySymbol(String currencyCode) =>
        currencySymbols[currencyCode] ??
        currencyCode; // Fallback to currency code if not found

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: TagColors.blue,
                width: 0.2,
              ),
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: SizedBox(
              height: 135.h,
              width: MediaQuery.sizeOf(context).width * 0.35,
              child: Image.network(
                image.isNotEmpty
                    ? image
                    : 'https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg?cs=srgb&dl=pexels-solliefoto-298863.jpg&fm=jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        4.verticalSpace,
        LimitedBox(
          maxWidth: 110.w,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${getCurrencySymbol(currency)}${format.format(double.tryParse(discount))}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: const Color(0xff0B1B34),
                  ),
                ),
                WidgetSpan(
                  child: SizedBox(width: 2.w),
                ),
                TextSpan(
                  text:
                      '${getCurrencySymbol(currency)}${format.format(double.tryParse(price))}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 8.sp,
                    color: const Color(0xff777777),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            maxLines: 2, // Adjust this value as needed
          ),
        ),
        Text(
          productName,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: const Color(0xff474747),
            fontSize: 12.sp,
          ),
          maxLines: 2,
        ),
        10.verticalSpace,
      ],
    );
  }
}
