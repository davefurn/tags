import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/show_banner.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/categories/widget/category_widgets.dart';
import 'package:tags/src/features/search/riverpod/service.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController controller;
  String? token;
  @override
  void initState() {
    // Initialize the controller
    controller = TextEditingController();
    // Fetch token
    token = HiveStorage.get(HiveKeys.token);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Perform your async data loading

      await ref.read(profileProvider.notifier).getSearches();
      await ref.read(profileProvider.notifier).getAllWishlist();
      await ref.read(profileProvider.notifier).getAllCart();
    });
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   // Retrieve the search text from HiveStorage
  //   final searchText = ref.watch(searchProvider);

  //   setState(() {
  //     controller.text = searchText;
  //   });

  //   // Update the controller text to reflect the search text
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);

    return Scaffold(
      appBar: TagBar(
        isHome: true,
        title: 'Search',
        token: token,
        state: state,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            CustomTextInput(
              controller: controller,
              onSubmitted: (p0) async {
                await ref.read(profileProvider.notifier).getSearches(query: p0);
                ref.read(searchProvider.notifier).updateSearchText(p0);
              },
              onEditingComplete: () {
                ref
                    .read(searchProvider.notifier)
                    .updateSearchText(controller.text);
                ref
                    .read(profileProvider.notifier)
                    .getSearches(query: controller.text);
              },
              // onChanged: (p0) async {
              //   await ref.read(profileProvider.notifier).getSearches(query: p0);
              // },
            ),
            // Place input outside the scroll view
            10.verticalSpace,
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.loading == Loader.loading) {
                    // Show shimmer loading effect instead of spinner
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6, // Number of shimmer items
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(9.r),
                              child: Container(
                                height: 200.h,
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 15.h,
                              width: 80.w,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 12.h,
                              width: 60.w,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state.searchResults == null ||
                      state.searchResults!.isEmpty) {
                    // Show empty state when there are no search results
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 155.h),
                      child: SizedBox(
                        child: Center(
                          child: Image.asset(
                            AssetsImages.emptySearchHistory,
                            height: MediaQuery.sizeOf(context).height * 0.25,
                          ),
                        ),
                      ),
                    );
                  } else if (state.searchResults!.isNotEmpty) {
                    // Show the list of search results when data is available
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                      ),
                      children: state.searchResults!.map((product) {
                        Map<String, String> currencySymbols = {
                          'USD': r'$', // Dollar
                          'NGN': '₦', // Naira
                          'EUR': '€', // Euro
                          'GBP': '£', // Pound
                          // Add other currencies as needed
                        };
                        final format = NumberFormat('#,##0', 'en_US');

                        // Function to get the currency symbol
                        String getCurrencySymbol(String currencyCode) =>
                            currencySymbols[currencyCode] ??
                            currencyCode; // Fallback to currency code if not found

                        String price = format.format(product.price);

                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                              TagRoutes.viewProducts.name,
                              pathParameters: {
                                'productImage': product.image.toString(),
                                'productTitle': product.name.toString(),
                                'productPrice':
                                    '${getCurrencySymbol(product.currency.toString())}$price',
                                'productBrand': product.slug.toString(),
                                'slug': product.slug.toString(),
                                'discount': ' ',
                                'subScription': 'false',
                              },
                            );
                          },
                          child: CategoryWidget.gridCard(
                            context: context,
                            image: product.image ?? '',
                            name: product.name ?? '',
                            discountedPrice:
                                '${getCurrencySymbol(product.currency ?? 'USD')}${format.format(product.discountedPrice)}',
                            price:
                                '${getCurrencySymbol(product.currency ?? 'USD')}${format.format(product.price)}',
                            function: () async {
                              final response = await model.postCart(
                                formData: {
                                  'product_slug': product.slug,
                                  'quantity': 1,
                                },
                              );

                              if (response.successMessage.isNotEmpty &&
                                  context.mounted) {
                                showSuccessBanner(
                                    context, response.successMessage);
                              } else if (response.errorMessage.isNotEmpty &&
                                  context.mounted &&
                                  response.errorMessage ==
                                      'Authentication credentials were not provided.') {
                                await context
                                    .pushNamed(TagRoutes.sellerLogin.name);
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
                                log(response.error!.response!.statusCode
                                    .toString());
                              }

                              Future.delayed(const Duration(seconds: 2), () {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentMaterialBanner();
                              });
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }

                  return const SizedBox
                      .shrink(); // Default fallback in case no state matches
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.controller,
    this.onpressed,
  });
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onpressed;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40.h,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          cursorHeight: 15.h,
          cursorColor: TagColors.black,
          textAlignVertical:
              TextAlignVertical.center, // Align hintText to center
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ), // Adjust padding to center vertically
            hintMaxLines: 1,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: TagColors.appThemeColor),
              borderRadius: BorderRadius.circular(25.r),
            ),
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200,
              color: const Color(0xffC6C6C6),
              letterSpacing: 1.2,
              fontSize: 13.sp,
            ),
            prefixIcon: IconButton(
              onPressed: onpressed,
              icon: Icon(
                Icons.search,
                size: 20.sp,
                color: TagColors.greyColor,
              ),
            ),

            hintText: 'Search for categories, product or brand',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
          ),
        ),
      );
}
