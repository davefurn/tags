import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';

late BuildContext globalContext;

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar> {
  String buyer = '';
  String seller = '';

  @override
  void initState() {
    super.initState();
    globalContext = context;
    buyer = HiveStorage.get(HiveKeys.buyer);
    log(buyer);
    seller = HiveStorage.get(HiveKeys.seller);
    log(seller);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: SizedBox(
          height: 73.h,
          child: Builder(
            builder: (context) {
              double height = 66.h;
              double circleHeight = 37.h;
              double heightFactor =
                  (((height - (circleHeight / 2)) * 100) / height) / 100;

              return SizedBox(
                height: height,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: heightFactor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 28.w, right: 21.5.w),
                              child: _buildNavItem(
                                context,
                                0,
                                Assets.home,
                                'Home',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 21.5.w),
                              child: _buildNavItem(
                                context,
                                1,
                                Assets.search,
                                'Search',
                              ),
                            ),
                            if (seller == 'Seller' && buyer == '')
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 21.5.w),
                                child: _buildNavItem(
                                  context,
                                  4,
                                  Assets.sell,
                                  'Sell',
                                ),
                              )
                            else if (buyer == 'Buyer' && seller == '')
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 21.5.w),
                                child: _buildNavItem(
                                  context,
                                  2,
                                  Assets.categories,
                                  'Categories',
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 21.5.w),
                              child: _buildNavItem(context, 3, Assets.me, 'Me'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  Widget _buildNavItem(
    BuildContext context,
    int index,
    String asset,
    String label,
  ) {
    bool isSelected = widget.navigationShell.currentIndex == index;
    Color color =
        isSelected ? TagColors.appThemeColor : const Color(0xff1C1B1F);

    return InkWell(
      onTap: () => _onTap(context, index),
      child: Column(
        children: [
          SvgPicture.asset(
            asset,
            color: color,
            width: 22.5.w,
            height: 19.5.h,
          ),
          4.verticalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: color,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
