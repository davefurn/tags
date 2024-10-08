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
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/search/riverpod/service.dart';
import 'package:tags/src/features/search/view.dart';

class CategoryScreen extends StatefulHookConsumerWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  late TextEditingController controller;
  bool isGrid = false;
  String? token;
  @override
  void initState() {
    controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getAllProducts();
      ref.read(profileProvider.notifier).getAllCart();
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
        title: 'Categories',
        token: token,
        state: state,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            CustomTextInput(
              controller: controller,
              onSubmitted: (p0) async {
                await ref.read(profileProvider.notifier).getSearches(query: p0);

                if (context.mounted) {
                  context.goNamed(TagRoutes.search.name);
                }
              },
              onEditingComplete: () {
                ref
                    .read(profileProvider.notifier)
                    .getSearches(query: controller.text);
                ref
                    .read(searchProvider.notifier)
                    .updateSearchText(controller.text);
                context.goNamed(TagRoutes.search.name);
              },
            ),
            const SizedBox(height: 15),
            if (state.loading != Loader.loading && state.allNewCatz.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allNewCatz.length,
                itemBuilder: (context, index) {
                  final allCatz = state.allNewCatz[index];

                  // Ensure category is only shown if there are products
                  if (allCatz.products.isEmpty) {
                    return const SizedBox
                        .shrink(); // Don't show category if no products
                  }

                  return LimitedBox(
                    key: ValueKey(allCatz.name),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            if (allCatz.products.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    TagRoutes.subCategoryScreen.name,
                                    pathParameters: {
                                      'brandName': allCatz.slug,
                                    },
                                  );
                                },
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff3088EF),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allCatz.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 160,
                          ),
                          itemBuilder: (context, productIndex) {
                            final product = allCatz.products[productIndex];
                            final format = NumberFormat('#,##0', 'en_US');
                            String price = format.format(product.price);

                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  TagRoutes.viewProducts.name,
                                  pathParameters: {
                                    'productImage': product.image,
                                    'productTitle': product.name,
                                    'productPrice':
                                        '${getCurrencySymbol(product.currency)}$price',
                                    'productBrand': product.slug,
                                    'slug': product.slug,
                                    'discount':
                                        '${getCurrencySymbol(product.currency)}${product.discountedPrice}',
                                  },
                                );
                              },
                              child: SizedBox(
                                key: ValueKey(product.slug),
                                height: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: SizedBox(
                                        height: 135,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.35,
                                        child: Image.network(
                                          product.image.isNotEmpty
                                              ? product.image
                                              : 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?cs=srgb&dl=pexels-phaseexit-3028500.jpg&fm=jpg',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      product.name,
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
                        ),
                        10.verticalSpace,
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
