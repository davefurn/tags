// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/onboarding/widgets/page_indicator.dart';

class IntroPageOne extends StatefulWidget {
  const IntroPageOne({super.key});

  @override
  State<IntroPageOne> createState() => _IntroPageOneState();
}

class _IntroPageOneState extends State<IntroPageOne> {
  late AssetImage assetsI;

  @override
  void initState() {
    super.initState();
    assetsI = const AssetImage(AssetsImages.firstPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(assetsI, context);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
                    children: [
                      const PageIndicator(
                        indicatorColor: TagColors.appThemeColor,
                        currentPage: 1,
                        totalPages: 3,
                        inactiveIndicatorColor: Color(0xffF9FAF3),
                      ),
                      35.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Text(
                          'Discover a world of shopping at your fingertips.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff303030),
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
                          'Welcome to Tags Marketplace, your one-stop shop for everything you need',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff474747),
                          ),
                        ),
                      ),
                      40.verticalSpace,
                      TagLoginButton(
                        myColor: TagColors.appThemeColor,
                        borderColor: Colors.transparent,
                        onTap: () {
                          context.pushNamed(TagRoutes.introPageTwo.name);
                        },
                        child: TagText(
                          fontColor: TagColors.white,
                          text: 'Get started',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
