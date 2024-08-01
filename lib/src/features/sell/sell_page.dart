import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/sell/orderz/myorderz.dart';
import 'package:tags/src/features/sell/products/myproducts.dart';
import 'package:tags/src/features/sell/sales/sales.dart';

class SellPage extends StatefulHookConsumerWidget {
  const SellPage({super.key});

  @override
  ConsumerState<SellPage> createState() => _SellPageState();
}

class _SellPageState extends ConsumerState<SellPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getCompany();
      // ref.read(eventViewmodelProvider.notifier).eventCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    // final CompanyModel company = state.companies;
    // final companyName = ref.read(profileProvider).company_name;
    // final companyEmail = ref.read(profileProvider).company_email;
    // final phone = ref.read(profileProvider).company_phone;
    final logo = ref.read(profileProvider).company_logo;
    final cover = ref.read(profileProvider).company_cover;
    final List<String>? companies = state.companies;
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await ref.read(profileProvider.notifier).getCompany();
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xffF8F9FF),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              // logo.toString(),
                              HiveStorage.get(HiveKeys.companyLogo)
                                      .toString()
                                      .isNotEmpty
                                  ? logo.toString()
                                  : 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?cs=srgb&dl=pexels-phaseexit-3028500.jpg&fm=jpg',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HiveStorage.get(HiveKeys.companyName).toString(),
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                              color: Color(0xff1B1B1B),
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const EditSellerInfo(),
                              //   ),
                              // );
                            },
                            child: Container(
                              // height: 50,
                              padding: const EdgeInsets.all(6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xffF8FFF8),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.edit_rounded,
                                    color: Color(0xff6FC016),
                                  ),
                                  Text(
                                    'Edit info',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff6FC016),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/svg/store.svg'),
                  title: const Text('Store Profile'),
                  onTap: () {
                    // Handle menu tap
                    context.goNamed(TagRoutes.updateStore.name);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/svg/verify_ID.svg'),
                  // const Icon(Icons.abc, color: TagColors.black),
                  title: const Text('Verify ID'),
                  onTap: () {
                    // Handle ABC tap
                    context.pushReplacementNamed(TagRoutes.updateStore.name);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/svg/delivery.svg'),
                  //  const Icon(Icons.air_rounded, color: TagColors.black),
                  title: const Text('Delivery'),
                  onTap: () {
                    // Handle air rounded tap
                    context.pushReplacementNamed(TagRoutes.updateStore.name);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/svg/payments.svg'),
                  title: const Text('Payments'),
                  onTap: () {
                    // Handle air rounded tap
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/svg/subscribe.svg'),
                  title: const Text('Subcribe'),
                  onTap: () {
                    // Handle air rounded tap
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/svg/delivery.svg'),
                  title: const Text('Share Profile'),
                  onTap: () {
                    // Handle air rounded tap
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: TagColors.black,
                  size: 25,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            title: const Center(
              child: TagText(
                text: 'Sell',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: TagColors.black,
                textAlign: TextAlign.center,
              ),
            ),
            actions: const [Text('             ')],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                if (state.loading != Loader.loading &&
                    state.companies!.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.32,
                    child: Stack(
                      children: [
                        Image.network(
                          HiveStorage.get(HiveKeys.companyCover)
                                  .toString()
                                  .isNotEmpty
                              ? cover.toString()
                              : 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?cs=srgb&dl=pexels-phaseexit-3028500.jpg&fm=jpg',
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.23,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          bottom: 20,
                          left: MediaQuery.sizeOf(context).width * 0.36,
                          child: CircleAvatar(
                            radius: 62,
                            backgroundColor: TagColors.white,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundImage: NetworkImage(
                                // logo.toString(),
                                HiveStorage.get(HiveKeys.companyLogo)
                                        .toString()
                                        .isNotEmpty
                                    ? logo.toString()
                                    : 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?cs=srgb&dl=pexels-phaseexit-3028500.jpg&fm=jpg',
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 12,
                        // ),
                        // Positioned(
                        //   bottom: -10,
                        //   right: MediaQuery.sizeOf(context).width * 0.16,
                        //   left: MediaQuery.sizeOf(context).width * 0.16,
                        //   child: TagText(
                        //     text:
                        //         HiveStorage.get(HiveKeys.companyName).toString(),
                        //     // "Company Name",
                        //     // companyName.toString(),
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w600,
                        //     fontColor: TagColors.black,
                        //   ),
                        // ),
                      ],
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
                        'No Image found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                // Center(
                //   child: TagText(
                //     text:
                //         // state.categories.join(", "),
                //         "Electronics, Phones & Gadgets",
                //     fontSize: 14,
                //     fontWeight: FontWeight.w300,
                //     fontColor: TagColors.black,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TagText(
                      text: HiveStorage.get(HiveKeys.companyName).toString(),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontColor: TagColors.black,
                    ),
                    Text(
                      // companies.toString().replaceAll('[]', ""),
                      companies?.join(', ') ?? '',
                      textAlign: TextAlign.center,
                    ),
                    // SizedBox(
                    //   width:
                    //       double.infinity, // Ensure ListView takes full width
                    //   height: 100,
                    //   child: Center(
                    //     child: GridView.builder(
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: state.companies!.length,
                    //       itemBuilder: (context, index) {
                    //         final listCat = state.companies![index];
                    //         final isLastItem =
                    //             index == state.companies!.length - 1;
                    //         final separator = isLastItem ? "" : ", ";
                    //         return Padding(
                    //           padding: const EdgeInsets.only(right: 8.0),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 listCat.toString(),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //               // Text(separator),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //       gridDelegate:
                    //           const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 3,
                    //         crossAxisSpacing: 10.0,
                    //         mainAxisSpacing: 10.0,
                    //         mainAxisExtent: 200,
                    //         childAspectRatio: 16 / 9,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 53,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      // color: const Color(0xffF7F7F7),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xfff9F9F9),
                      ),
                      color: const Color(0xfff9F9F9),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      // const Color(0xff334155),
                      labelStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      unselectedLabelColor: const Color(0xff333333),
                      tabs: const [
                        Tab(
                          text: 'Products',
                        ),
                        Tab(
                          text: 'Sales',
                        ),
                        Tab(
                          text: 'Orders',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      MySellProductPage(),
                      SalesPage(),
                      OrderzPage(),
                    ],
                  ),
                ),

                //

                // SizedBox(
                //   height: MediaQuery.sizeOf(context).height * 0.45,
                //   child: Scaffold(
                //     backgroundColor: Colors.transparent,
                //     appBar: PreferredSize(
                //       preferredSize: Size(MediaQuery.sizeOf(context).width, 31),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           TextButton(
                //             style: const ButtonStyle(
                //               backgroundColor:
                //                   MaterialStatePropertyAll(TagColors.black),
                //             ),
                //             onPressed: () {},
                //             child: const TagText(
                //               text: "Products",
                //               fontSize: 10,
                //               fontWeight: FontWeight.w400,
                //               fontColor: TagColors.oldGrey,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           TextButton(
                //             style: const ButtonStyle(
                //               backgroundColor: MaterialStatePropertyAll(
                //                 Color.fromRGBO(249, 249, 249, 1),
                //               ),
                //             ),
                //             onPressed: () {},
                //             child: const TagText(
                //               text: "Sales",
                //               fontSize: 10,
                //               fontWeight: FontWeight.w400,
                //               fontColor: TagColors.black,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           TextButton(
                //             style: const ButtonStyle(
                //               backgroundColor: MaterialStatePropertyAll(
                //                 Color.fromRGBO(249, 249, 249, 1),
                //               ),
                //             ),
                //             onPressed: () {},
                //             child: const TagText(
                //               text: "Products",
                //               fontSize: 10,
                //               fontWeight: FontWeight.w400,
                //               fontColor: TagColors.black,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     body: SizedBox(
                //       height: MediaQuery.sizeOf(context).height,
                //       width: MediaQuery.sizeOf(context).width,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             "assets/svg/no_products.svg",
                //             height: 120,
                //             width: 130,
                //             fit: BoxFit.fill,
                //           ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           const TagText(
                //             text: "No products yet!",
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
                //             fontColor: TagColors.newGrey,
                //           ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           const TagText(
                //             text: "Use the \"Add Product\" button to add product",
                //             fontSize: 12,
                //             fontWeight: FontWeight.w300,
                //             fontColor: TagColors.newGrey,
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // //add products
              context.pushNamed(TagRoutes.addProducts.name);
            },
            backgroundColor: TagColors.lemonGreen,
            foregroundColor: TagColors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
