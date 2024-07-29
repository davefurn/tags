import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/home/widgets/view_products.dart';

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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TagBar(
        isHome: true,
        title: ' ',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_rounded,
                color: Color(0xff5E5E5E)),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const CheckoutScreen(),
              //   ),
              // );
            },
            icon: const Icon(Icons.shopping_bag_outlined,
                color: Color(0xff474747)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                ref.read(currentScreenIndexProvider.notifier).state = 1;
              },
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width - 100,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                    side: const BorderSide(color: TagColors.greyColor),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.search, color: TagColors.greyColor),
                    Text(
                      'Search for categories, product or brand',
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(Icons.mic, color: TagColors.greyColor, size: 15),
                    Icon(Icons.image_outlined,
                        color: TagColors.greyColor, size: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Image.asset(AssetsImages.blackFridaySales),
            const SizedBox(height: 15),
            const Text(
              'Explore Popular Categories',
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                color: TagColors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            if (state.loading != Loader.loading && state.popularCat.isNotEmpty)
              SizedBox(
                height: 150,
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
                      width: 130,
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: SizedBox(
                              height: 125,
                              child: Image.network(
                                topCatz.image.isNotEmpty
                                    ? topCatz.image
                                    : 'https://images.pexels.com/photos/2294342/pexels-photo-2294342.jpeg?cs=srgb&dl=pexels-paggiarofrancesco-2294342.jpg&fm=jpg',
                                fit: BoxFit.fitHeight,
                              ),
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
            const Text(
              'Best Selling',
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                color: TagColors.black,
                fontSize: 16,
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewProducts(
                            productImage: bestSeller.image,
                            productTitle: bestSeller.product,
                            productPrice: bestSeller.priceString,
                            productBrand: bestSeller.slug,
                            slug: bestSeller.slug,
                          ),
                        ),
                      );
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: TagColors.greyColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            bestSeller.priceString.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: TagColors.greyColor,
                              fontSize: 14,
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
            const Text(
              'Deals of the Day',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: TagColors.black),
            ),
            const SizedBox(height: 15),
            if (state.loading != Loader.loading && state.todayDealz.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.todayDealz.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  final dealOfDay = state.todayDealz[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewProducts(
                            productImage: dealOfDay.image,
                            productTitle: dealOfDay.product,
                            productPrice: dealOfDay.priceString,
                            productBrand: dealOfDay.slug,
                            slug: dealOfDay.slug,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      key: ValueKey(dealOfDay.price),
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
                                dealOfDay.image.isNotEmpty
                                    ? dealOfDay.image
                                    : 'https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg?cs=srgb&dl=pexels-solliefoto-298863.jpg&fm=jpg',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dealOfDay.product,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: TagColors.greyColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            dealOfDay.priceString.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: TagColors.greyColor,
                              fontSize: 14,
                            ),
                          )
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
            const SizedBox(height: 20),
            // Text(
            //   "Categories",
            //   style: const TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //       color: TagColors.black),
            // ),
            // const SizedBox(height: 15),
            // if (state.loading != Loader.loading && state.allNewCatz.isNotEmpty)
            //   GridView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: state.allNewCatz.length,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       crossAxisSpacing: 12.0,
            //       mainAxisSpacing: 10.0,
            //       mainAxisExtent: 70,
            //       childAspectRatio: 16 / 9,
            //     ),
            //     itemBuilder: (context, index) {
            //       final allCatz = state.allNewCatz[index];
            //       return SizedBox(
            //         key: ValueKey(allCatz.name),
            //         height: 120,
            //         child: Container(
            //           alignment: Alignment.center,
            //           padding: const EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(15),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.5),
            //                 spreadRadius: 1,
            //                 blurRadius: 1,
            //                 offset: const Offset(0, 3),
            //               ),
            //             ],
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 allCatz.name,
            //                 style: const TextStyle(
            //                   fontWeight: FontWeight.w600,
            //                   color: TagColors.textColor,
            //                   fontSize: 12,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   )
            // else if (state.loading == Loader.loading)
            //   const Center(
            //     child: SpinKitWaveSpinner(
            //       color: TagColors.appThemeColor,
            //       size: 50,
            //     ),
            //   )
            // else
            //   const Center(
            //     child: Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: Text(
            //         'No Categories available',
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
