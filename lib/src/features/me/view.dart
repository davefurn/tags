import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/home/models/home_models.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String? email;
  String? name;
  String? buyer;
  String? seller;
  @override
  void initState() {
    setState(() {
      email = HiveStorage.get(HiveKeys.userEmail);
      name = HiveStorage.get(HiveKeys.name);
      buyer = HiveStorage.get(HiveKeys.buyer);
      seller = HiveStorage.get(HiveKeys.seller);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProfileModel> myProfile = [
      ProfileModel(
        action: buyer == 'Buyer'
            ? () {
                HiveStorage.put(HiveKeys.seller, 'Seller');
                HiveStorage.put(HiveKeys.buyer, '');
                context.goNamed(TagRoutes.sellerLogin.name);
              }
            : () {},
        image: Assets.ads,
        title: buyer == 'Buyer' ? 'Sell' : 'My Ads',
      ),
      //order
      ProfileModel(
        action: () {},
        image: Assets.order,
        title: 'Order History',
      ),

      //id
      if (seller == 'Seller')
        ProfileModel(
          action: () {},
          image: Assets.uploadId,
          title: 'Upload ID',
        ),
      if (seller == 'Seller')
        ProfileModel(
          action: () {},
          image: Assets.drafts,
          title: 'Drafts',
        ),

      //wishlist
      ProfileModel(
        action: () {},
        image: Assets.wishlist,
        title: 'Wishlist',
      ),

      //rate us
      ProfileModel(
        action: () {},
        image: Assets.rateUs,
        title: 'Rate Us',
      ),

      //settings
      ProfileModel(
        action: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return const BuyerSettingsPage();
          // }));
        },
        image: Assets.setting,
        title: 'Settings',
      ),

      //log out
      ProfileModel(
        action: () {},
        image: Assets.logout,
        title: 'Log Out',
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FF),
      appBar: const TagBar(
        isHome: false,
        myColor: Color(0xffF8F9FF),
        title: 'Me',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AssetsImages.noMessage,
                      height: 100,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? 'Tags Market',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff000000),
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          email ?? 'tagsmarket001@gmail.com',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff5E5E5E),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //
              const SizedBox(
                height: 10,
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const Divider(
                      color: Color(0xffF1F1F1),
                      thickness: 0.5,
                    ),
                    itemCount: myProfile.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          //
                          SvgPicture.asset(
                            myProfile[index].image,
                            // height: 30,
                          ),

                          const SizedBox(width: 20),

                          Text(
                            myProfile[index].title,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.2,
                              color: Color(0xff1B1B1B),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
