// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _nextPage();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInQuad),
    );
    _controller.forward();
  }

  Future _nextPage() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      // Fetch values from HiveStorage
      String onborded = (await HiveStorage.get(HiveKeys.onBoarded)) ?? 'false';
      String seller = (await HiveStorage.get(HiveKeys.seller)) ?? '';
      String buyer = (await HiveStorage.get(HiveKeys.buyer)) ?? '';

      // Redirect logic
      if (context.mounted && onborded != 'true') {
        context.goNamed(TagRoutes.introPageOne.name);
      } else if (context.mounted &&
          onborded == 'true' &&
          seller == '' &&
          buyer == '') {
        context.goNamed(TagRoutes.introPageTwo.name);
      } else if (onborded == 'true' && context.mounted && seller == 'Seller') {
        context.goNamed(TagRoutes.sellerLogin.name);
      } else if (onborded == 'true' && context.mounted && buyer == 'Buyer') {
        context.goNamed(TagRoutes.home.name);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: TagColors.appThemeColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          color: TagColors.appThemeColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) => Transform.scale(
                  scale: _animation.value,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.sp,
                        child: Image.asset('assets/images/tag_logo.png'),
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
