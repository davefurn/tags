import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/categories/widget/category_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: TagBar(
        isHome: false,
        title: 'Categories',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_rounded,
              color: Color(0xff5E5E5E),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
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
            SliverGrid(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset('assets/images/Oraimo.png'),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset('assets/images/JBL.png'),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset('assets/images/Nokia.png'),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset('assets/images/Apple.png'),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset('assets/images/Sony.png'),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset('assets/images/Samsung.png'),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.sizeOf(context).width / 4.25) / 6,
                    ),
                    child: Image.asset('assets/images/Tecno.png'),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset('assets/images/Xiaomi.png'),
                ),
              ]),
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
            if (isGrid == false &&
                state.loading != Loader.loading &&
                state.todayDealz.isNotEmpty)
              SliverList.builder(
                itemCount: state.todayDealz.length,
                itemBuilder: (context, index) {
                  final dealOfDay = state.todayDealz[index];
                  return CategoryWidget.listCard(
                    context,
                    dealOfDay.image,
                    dealOfDay.product,
                    '${dealOfDay.currency} ${dealOfDay.formattedDiscountedPrice}',
                    '${dealOfDay.currency} ${dealOfDay.formattedPrice}',
                  );
                },
              )
            else
              SliverGrid.builder(
                itemCount: state.todayDealz.length,
                itemBuilder: (context, index) {
                  final dealOfDay = state.todayDealz[index];
                  return CategoryWidget.gridCard(
                    context,
                    dealOfDay.image,
                    dealOfDay.product,
                    '${dealOfDay.currency} ${dealOfDay.formattedDiscountedPrice}',
                    '${dealOfDay.currency} ${dealOfDay.formattedPrice}',
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
