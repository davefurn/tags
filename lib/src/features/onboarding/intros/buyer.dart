import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/onboarding/widgets/page_indicator.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key});

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  late AssetImage assetsI;
  @override
  void initState() {
    super.initState();
    assetsI = const AssetImage(AssetsImages.buyerImage);
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
                      'Find anything you desire, delivered to your doorstep',
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
                      'Shop worry-free with our secure payment options and return policies',
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
                      if (context.mounted) {
                        context.goNamed(TagRoutes.home.name);
                      }
                    },
                    child: TagText(
                      fontColor: const Color(0xff303030),
                      text: 'Start Shopping',
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
