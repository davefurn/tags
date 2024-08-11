import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/search/view.dart';

class CategoryScreen extends StatefulHookConsumerWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  bool isGrid = false;
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
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TagBar(
        isHome: true,
        title: 'Categories',
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
            const SizedBox(height: 15),
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
                            if (state.allNewCatz[index].products.isNotEmpty)
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
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 15),
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
                              mainAxisExtent: 160,
                            ),
                            itemBuilder: (context, productIndex) {
                              final categories = state
                                  .allNewCatz[index].products[productIndex];

                              return GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  key: ValueKey(
                                    categories.slug,
                                  ),
                                  height: 160,
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
