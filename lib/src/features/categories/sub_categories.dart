import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/categories/widget/category_widgets.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getAllBrands(widget.brandName);
      ref.read(profileProvider.notifier).getAllBrandsProduct(widget.brandName);
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
      appBar: TagBar(
        isHome: false,
        title: '',
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
            const SliverToBoxAdapter(
              child: Text(
                'All Categories',
                style: TextStyle(
                  fontSize: 14,
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
                                MaterialStatePropertyAll(TagColors.paleBlue),
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
                                MaterialStatePropertyAll(TagColors.paleBlue),
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
                                MaterialStatePropertyAll(TagColors.paleBlue),
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
                                MaterialStatePropertyAll(TagColors.paleBlue),
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
                              MaterialStatePropertyAll(TagColors.paleBlue),
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
            SliverGrid.builder(
              itemCount: state.brandsNames.length,
              itemBuilder: (context, index) {
                if (state.loading == Loader.loading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: SpinKitWaveSpinner(
                        color: TagColors.appThemeColor,
                      ),
                    ),
                  );
                } else if (state.loading != Loader.loading &&
                    state.brandsNames.isNotEmpty) {
                  return SizedBox(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width / 4.25,
                    child: state.brandsNames[index].image == ''
                        ? Image.asset('assets/images/Oraimo.png')
                        : Image.network(state.brandsNames[index].image),
                  );
                }
                return null;
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = false;
                      });
                    },
                    icon: CircleAvatar(
                      backgroundColor: isGrid == false
                          ? TagColors.paleBlue
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/listview_icon.png',
                        height: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = true;
                      });
                    },
                    icon: CircleAvatar(
                      backgroundColor: isGrid == false
                          ? Colors.transparent
                          : TagColors.paleBlue,
                      child: const Icon(
                        Icons.grid_view_outlined,
                        size: 24,
                      ),
                    ),
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
              ))
            else if (isGrid == false &&
                state.loading != Loader.loading &&
                state.productResponse.isNotEmpty)
              SliverList.builder(
                itemCount: state.productResponse.length,
                itemBuilder: (context, index) {
                  final dealOfDay = state.productResponse[index];

                  return CategoryWidget.listCard(
                    context,
                    dealOfDay.image,
                    dealOfDay.name,
                    '${getCurrencySymbol(dealOfDay.currency)}${dealOfDay.discountedPrice}',
                    '${getCurrencySymbol(dealOfDay.currency)}${dealOfDay.price}',
                  );
                },
              )
            else if (state.productResponse.isNotEmpty)
              SliverGrid.builder(
                itemCount: state.productResponse.length,
                itemBuilder: (context, index) {
                  final dealOfDay = state.productResponse[index];
                  return CategoryWidget.gridCard(
                    context,
                    dealOfDay.image,
                    dealOfDay.name,
                    '${getCurrencySymbol(dealOfDay.currency)}${dealOfDay.discountedPrice}',
                    '${getCurrencySymbol(dealOfDay.currency)}${dealOfDay.price}',
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
