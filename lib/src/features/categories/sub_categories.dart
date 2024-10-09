import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/show_banner.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/categories/widget/category_widgets.dart';
import 'package:tags/src/features/categories/widget/toggle_button.dart';
import 'package:tags/src/features/search/view.dart';

class SubCategoryScreen extends StatefulHookConsumerWidget {
  const SubCategoryScreen({
    required this.brandName,
    super.key,
  });
  final String brandName;

  @override
  ConsumerState<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends ConsumerState<SubCategoryScreen> {
  bool isGrid = false;
  String? token;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getAllBrands(widget.brandName);
      ref.read(profileProvider.notifier).getAllBrandsProduct(widget.brandName);
    });
    token = HiveStorage.get(HiveKeys.token);
    super.initState();
  }

  Map<String, String> currencySymbols = {
    'USD': r'$', // Dollar
    'NGN': '₦', // Naira
    'EUR': '€', // Euro
    'GBP': '£', // Pound
    // Add other currencies as needed
  };
  void toggleView({bool grid = false}) {
    setState(() {
      isGrid = grid;
    });
  }

  final format = NumberFormat('#,##0', 'en_US');
// Function to get the currency symbol
  String getCurrencySymbol(String currencyCode) =>
      currencySymbols[currencyCode] ??
      currencyCode; // Fallback to currency code if not found

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    return Scaffold(
      appBar: TagBar(
        token: token,
        state: state,
        isHome: false,
        title: '',
        // actions: [
        //   const InkWell(
        //     child: Icon(
        //       Icons.favorite_outline_rounded,
        //       color: Color(0xff5E5E5E),
        //     ),
        //   ),
        //   4.horizontalSpace,
        //   Padding(
        //     padding: EdgeInsets.only(right: 16.w),
        //     child: const Icon(
        //       Icons.shopping_bag_outlined,
        //       color: Color(0xff474747),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomTextInput(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                widget.brandName.toUpperCase(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(TagColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                  color: TagColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(TagColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Color',
                                style: TextStyle(
                                  color: TagColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(TagColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Conditions',
                                style: TextStyle(
                                  color: TagColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(TagColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Filter ',
                                style: TextStyle(
                                  color: TagColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Image.asset(
                                'assets/images/filter_icon.png',
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 105,
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(TagColors.paleBlue),
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(
                                color: TagColors.black,
                                fontSize: 12,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                'Brands',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            if (state.loading == Loader.loading)
              const SliverToBoxAdapter(
                child: Center(
                  child: SpinKitWaveSpinner(
                    color: TagColors.appThemeColor,
                  ),
                ),
              )
            else if (state.brandsNames.isNotEmpty)
              SliverGrid.builder(
                itemCount: state.brandsNames.length,
                itemBuilder: (context, index) {
                  final brand = state.brandsNames[index];
                  return SizedBox(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width / 4.25,
                    child: brand.image.isEmpty
                        ? Image.asset('assets/images/Oraimo.png')
                        : Image.network(brand.image),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 15,
                ),
              ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  ToggleButton(
                    isSelected: !isGrid,
                    iconPath: 'assets/images/listview_icon.png',
                    onPressed: toggleView,
                  ),
                  ToggleButton(
                    isSelected: isGrid,
                    icon: Icons.grid_view_outlined,
                    onPressed: () => toggleView(grid: true),
                  ),
                ],
              ),
            ),
            if (state.loading == Loader.loading)
              const SliverToBoxAdapter(
                child: Center(
                  child: SpinKitWaveSpinner(
                    color: TagColors.appThemeColor,
                  ),
                ),
              )
            else if (!isGrid && state.productResponse.isNotEmpty)
              SliverList.builder(
                itemCount: state.productResponse.length,
                itemBuilder: (context, index) {
                  final dealOfDay = state.productResponse[index];
                  return CategoryWidget.listCard(
                    context: context,
                    image: dealOfDay.image,
                    name: dealOfDay.name,
                    rating: dealOfDay.rating,
                    inCart: dealOfDay.inCart,
                    discountedPrice:
                        '${getCurrencySymbol(dealOfDay.currency)}${format.format(dealOfDay.discountedPrice)}',
                    price:
                        '${getCurrencySymbol(dealOfDay.currency)}${format.format(dealOfDay.price)}',
                    function: () async {
                      final response = await model.postCart(
                        formData: {
                          'product_slug': dealOfDay.slug,
                          'quantity': 1,
                        },
                      );

                      if (response.successMessage.isNotEmpty &&
                          context.mounted) {
                        showSuccessBanner(
                          context,
                          response.successMessage,
                        );
                      } else if (response.errorMessage.isNotEmpty &&
                          context.mounted &&
                          response.errorMessage ==
                              'Authentication credentials were not provided.') {
                        await context.pushNamed(TagRoutes.sellerLogin.name);
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
                        log(
                          response.error!.response!.statusCode.toString(),
                        );
                      }

                      Future.delayed(const Duration(seconds: 2), () {
                        ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner();
                      });
                    },
                  );
                },
              )
            else if (state.productResponse.isNotEmpty)
              SliverGrid.builder(
                itemCount: state.productResponse.length,
                itemBuilder: (context, index) {
                  final dealOfDay = state.productResponse[index];
                  return CategoryWidget.gridCard(
                    context: context,
                    image: dealOfDay.image,
                    name: dealOfDay.name,
                    discountedPrice:
                        '${getCurrencySymbol(dealOfDay.currency)}${format.format(dealOfDay.discountedPrice)}',
                    price:
                        '${getCurrencySymbol(dealOfDay.currency)}${format.format(dealOfDay.price)}',
                    function: () async {
                      final response = await model.postCart(
                        formData: {
                          'product_slug': dealOfDay.slug,
                          'quantity': 1,
                        },
                      );

                      if (response.successMessage.isNotEmpty &&
                          context.mounted) {
                        showSuccessBanner(
                          context,
                          response.successMessage,
                        );
                      } else if (response.errorMessage.isNotEmpty &&
                          context.mounted &&
                          response.errorMessage ==
                              'Authentication credentials were not provided.') {
                        await context.pushNamed(TagRoutes.sellerLogin.name);
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
                        log(
                          response.error!.response!.statusCode.toString(),
                        );
                      }

                      Future.delayed(const Duration(seconds: 2), () {
                        ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner();
                      });
                    },
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
