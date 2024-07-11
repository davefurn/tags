import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/onboarding/widgets/page_indicator.dart';

class IntroPageTwo extends StatefulWidget {
  const IntroPageTwo({super.key});

  @override
  State<IntroPageTwo> createState() => _IntroPageTwoState();
}

class _IntroPageTwoState extends State<IntroPageTwo> {
  late AssetImage assetsI;

  @override
  void initState() {
    super.initState();
    assetsI = const AssetImage(AssetsImages.second);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(assetsI, context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
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
            SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PageIndicator(
                      indicatorColor: TagColors.appThemeColor,
                      currentPage: 2,
                      totalPages: 3,
                      inactiveIndicatorColor: Color(0xffF9FAF3),
                    ),
                    35.verticalSpace,
                    Text(
                      'Choose your journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0B1B34),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                        top: 2.h,
                      ),
                      child: Text(
                        'Are you here as a buyer or Seller? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff5E5E5E),
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    TagLoginButton(
                      borderColor: TagColors.appThemeColor,
                      myColor: Colors.white,
                      onTap: () {
                        context.pushNamed(TagRoutes.sellerPage.name);
                      },
                      child: TagText(
                        fontColor: TagColors.appThemeColor,
                        text: 'I`m a Seller',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    12.verticalSpace,
                    TagLoginButton(
                      myColor: TagColors.appThemeColor,
                      borderColor: Colors.transparent,
                      onTap: () {
                        context.pushNamed(TagRoutes.decideScreen.name);
                      },
                      child: TagText(
                        fontColor: TagColors.white,
                        text: 'I`m a Buyer',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
