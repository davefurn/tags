import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/search/view.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getAllProducts();
    });
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TagBar(
        isHome: true,
        title: ' ',
        actions: [
          const InkWell(
            child: Icon(
              Icons.favorite_outline_rounded,
              color: Color(0xff5E5E5E),
            ),
          ),
          4.horizontalSpace,
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xff474747),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const CustomTextInput(),
            const SizedBox(height: 30),
            Image.asset(AssetsImages.blackFridaySales),
            const SizedBox(height: 15),
            Text(
              'Explore Popular Categories',
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                color: TagColors.black,
                fontSize: 14.sp,
              ),
            ),
            const SizedBox(height: 15),
            if (state.loading != Loader.loading && state.popularCat.isNotEmpty)
              SizedBox(
                height: 180.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: state.popularCat.length,
                  itemBuilder: (context, index) {
                    final topCatz = state.popularCat[index];
                    return SizedBox(
                      key: ValueKey(topCatz.slug),
                      width: 130.w,
                      height: 150.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9.r),
                            child: Image.network(
                              topCatz.image.isNotEmpty
                                  ? topCatz.image
                                  : 'https://images.pexels.com/photos/2294342/pexels-photo-2294342.jpeg?cs=srgb&dl=pexels-paggiarofrancesco-2294342.jpg&fm=jpg',
                              fit: BoxFit.cover,
                              height: 125,
                              width: 130.w,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            topCatz.name,
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else if (state.loading == Loader.loading)
              const Center(
                child: SpinKitWaveSpinner(
                  color: TagColors.appThemeColor,
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'No Categories available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 15),
            Text(
              'Best Selling',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: TagColors.black,
                fontSize: 14.sp,
              ),
            ),
            const SizedBox(height: 15),
            if (state.loading != Loader.loading && state.bestSelling.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.bestSelling.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  final bestSeller = state.bestSelling[index];

                  final format = NumberFormat('#,##0', 'en_US');
                  String price = format.format(bestSeller.price);

                  log(bestSeller.price.toString());
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ViewProducts(
                      //       productImage: bestSeller.image,
                      //       productTitle: bestSeller.product,
                      //       productPrice: bestSeller.price.toString(),
                      //       productBrand: bestSeller.slug,
                      //       slug: bestSeller.slug,
                      //     ),
                      //   ),
                      // );
                    },
                    child: SizedBox(
                      key: ValueKey(bestSeller.product),
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: SizedBox(
                              height: 135,
                              width: MediaQuery.sizeOf(context).width * 0.35,
                              child: Image.network(
                                bestSeller.image.isNotEmpty
                                    ? bestSeller.image
                                    : 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?cs=srgb&dl=pexels-phaseexit-3028500.jpg&fm=jpg',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            bestSeller.product,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff474747),
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            '${getCurrencySymbol(bestSeller.currency)}$price',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff0B1B34),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            else if (state.loading == Loader.loading)
              const Center(
                child: SpinKitWaveSpinner(
                  color: TagColors.appThemeColor,
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'No Products available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              'Deals of the Day',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: TagColors.black,
              ),
            ),
            const SizedBox(height: 15),
            if (state.loading != Loader.loading && state.todayDealz.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.todayDealz.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 205.h,
                ),
                itemBuilder: (context, index) {
                  final dealOfDay = state.todayDealz[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ViewProducts(
                      //       productImage: dealOfDay.image,
                      //       productTitle: dealOfDay.product,
                      //       productPrice: dealOfDay.formattedDiscountedPrice,
                      //       productBrand: dealOfDay.slug,
                      //       slug: dealOfDay.slug,
                      //     ),
                      //   ),
                      // );
                    },
                    child: SizedBox(
                      key: ValueKey(dealOfDay.price),
                      height: 205.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: SizedBox(
                              height: 135,
                              width: MediaQuery.sizeOf(context).width * 0.35,
                              child: Image.network(
                                dealOfDay.image.isNotEmpty
                                    ? dealOfDay.image
                                    : 'https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg?cs=srgb&dl=pexels-solliefoto-298863.jpg&fm=jpg',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          10.verticalSpace,
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: const Color(0xff89C0FF),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              child: Text(
                                '${double.parse(dealOfDay.discount.toString()).toInt()}% Off',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          2.verticalSpace,
                          LimitedBox(
                            maxWidth: 110.w,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${getCurrencySymbol(dealOfDay.currency)}${dealOfDay.formattedDiscountedPrice}',
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
                                        '${getCurrencySymbol(dealOfDay.currency)}${dealOfDay.formattedPrice}',
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
                            dealOfDay.product,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff474747),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            else if (state.loading == Loader.loading)
              const Center(
                child: SpinKitWaveSpinner(
                  color: TagColors.appThemeColor,
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'No Deals available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            20.verticalSpace,
            if (state.loading != Loader.loading && state.allNewCatz.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allNewCatz.length,
                itemBuilder: (context, index) {
                  final allCatz = state.allNewCatz[index];

                  return LimitedBox(
                    key: ValueKey(allCatz.name),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.loading != Loader.loading &&
                            state.allNewCatz[index].products.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allCatz.name,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: TagColors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                        if (state.loading != Loader.loading &&
                            state.allNewCatz[index].products.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.allNewCatz[index].products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 200,
                            ),
                            itemBuilder: (context, index) {
                              final categories =
                                  state.allNewCatz[index].products[index];

                              final format = NumberFormat('#,##0', 'en_US');
                              String price = format.format(categories.price);

                              log(categories.price.toString());
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ViewProducts(
                                  //       productImage: bestSeller.image,
                                  //       productTitle: bestSeller.product,
                                  //       productPrice: bestSeller.price.toString(),
                                  //       productBrand: bestSeller.slug,
                                  //       slug: bestSeller.slug,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: SizedBox(
                                  key: ValueKey(
                                    categories.slug,
                                  ),
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: SizedBox(
                                          height: 135,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.35,
                                          child: Image.network(
                                            categories.image.isNotEmpty
                                                ? categories.image
                                                : 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?cs=srgb&dl=pexels-phaseexit-3028500.jpg&fm=jpg',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        categories.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff474747),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        '${getCurrencySymbol(categories.currency)}$price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff0B1B34),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        else if (state.loading == Loader.loading)
                          const Center(
                            child: SpinKitWaveSpinner(
                              color: TagColors.appThemeColor,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              )
            else if (state.loading == Loader.loading)
              const Center(
                child: SpinKitWaveSpinner(
                  color: TagColors.appThemeColor,
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'No Categories available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
