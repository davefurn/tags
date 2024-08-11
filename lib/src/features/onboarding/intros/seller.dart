import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/onboarding/widgets/page_indicator.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  late AssetImage assetsI;
  @override
  void initState() {
    super.initState();
    assetsI = const AssetImage(AssetsImages.sellerPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(assetsI, context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: TagColors.appThemeColor,
        body: Column(
          children: [
            Container(
              height: 480.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(108.r),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: assetsI,
                ),
              ),
            ),
            22.verticalSpace,
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PageIndicator(
                    indicatorColor: TagColors.white,
                    currentPage: 3,
                    totalPages: 3,
                    inactiveIndicatorColor: Colors.white24,
                  ),
                  35.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      'Sell your products to the world',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                    ),
                    child: Text(
                      'Create a beautiful online store and reach millions of potential buyers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xfff9f9f9),
                      ),
                    ),
                  ),
                  40.verticalSpace,
                  TagLoginButton(
                    myColor: TagColors.white,
                    borderColor: Colors.transparent,
                    onTap: () async {
                      await HiveStorage.put(HiveKeys.onBoarded, 'true');
                      if (context.mounted) {
                        context.goNamed(TagRoutes.sellerLogin.name);
                      }
                    },
                    child: TagText(
                      fontColor: const Color(0xff303030),
                      text: 'Start selling',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
