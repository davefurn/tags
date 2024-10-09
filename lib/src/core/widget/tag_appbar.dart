import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/features/authentication/seller/sign_up/model/profile_viewmodel.dart';

class TagBar extends StatefulWidget implements PreferredSizeWidget {
  const TagBar({
    required this.title,
    required this.isHome,
    super.key,
    // required this.onTap,
    this.myColor,
    this.actions,
    this.token,
    this.state,
  });
  final String title;
  final bool isHome;
  final Color? myColor;
  final String? token;
  final ProfileState? state;
  // final void Function() onTap;
  final List<Widget>? actions;

  @override
  State<TagBar> createState() => _TagBarState();

  @override
  Size get preferredSize => const Size.fromHeight(53);
}

class _TagBarState extends State<TagBar> {
  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.sp,
            letterSpacing: 1,
            color: TagColors.textColor,
            // const Color(0xff344054),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: widget.actions ??
            [
              InkWell(
                onTap: widget.token == null || widget.token!.isEmpty
                    ? () {
                        context.goNamed(TagRoutes.sellerLogin.name);
                      }
                    : () {
                        context.pushNamed(TagRoutes.wishlist.name);
                      },
                child: Badge(
                  backgroundColor: TagColors.appThemeColor,
                  isLabelVisible: widget.state!.resultItem!.isNotEmpty,
                  child: const Icon(
                    Icons.favorite_outline_rounded,
                    color: Color(0xff5E5E5E),
                  ),
                ),
              ),
              4.horizontalSpace,
              InkWell(
                onTap: widget.token == null || widget.token!.isEmpty
                    ? () {
                        context.goNamed(TagRoutes.sellerLogin.name);
                      }
                    : () {
                        context.pushNamed(TagRoutes.cart.name);
                      },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Badge(
                    backgroundColor: TagColors.appThemeColor,
                    isLabelVisible: widget.state!.cartProducts!.isNotEmpty,
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xff474747),
                    ),
                  ),
                ),
              ),
            ],
        leadingWidth: 55.w,
        leading: widget.isHome ==
                false // condition to allow us to resuse this TagBar in the Home Screen
            ? InkWell(
                onTap: () => context.pop(),
                child: Container(
                  width: 28.19.w,
                  height: 27.25.h,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 10.w,
                    top: 12.h,
                    bottom: 8.h,
                  ),
                  decoration: const BoxDecoration(
                    color: TagColors.appThemeColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: TagColors.white,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                child: Image.asset(
                  AssetsImages.tagLogo,
                  fit: BoxFit.contain,
                ),
              ), // tags logo for home screen,
        // foregroundColor: Colors.white,
        backgroundColor: widget.myColor ?? Colors.white,
        shadowColor: widget.myColor ?? Colors.white,
        surfaceTintColor: widget.myColor ?? Colors.white,
      );
}

class TagBars extends StatefulWidget implements PreferredSizeWidget {
  const TagBars({
    required this.title,
    required this.isHome,
    super.key,
    // required this.onTap,
    this.myColor,
    this.actions,
  });
  final String title;
  final bool isHome;
  final Color? myColor;
  // final void Function() onTap;
  final List<Widget>? actions;

  @override
  State<TagBars> createState() => _TagBarsState();

  @override
  Size get preferredSize => const Size.fromHeight(53);
}

class _TagBarsState extends State<TagBars> {
  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.sp,
            letterSpacing: 1,
            color: TagColors.textColor,
            // const Color(0xff344054),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: widget.actions ??
            [
              const InkWell(
                child: Icon(
                  Icons.favorite_outline_rounded,
                  color: Color(0xff5E5E5E),
                ),
              ),
              4.horizontalSpace,
            ],
        leadingWidth: 55.w,
        leading: widget.isHome ==
                false // condition to allow us to resuse this TagBar in the Home Screen
            ? InkWell(
                onTap: () => context.pop(),
                child: Container(
                  width: 28.19.w,
                  height: 27.25.h,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 10.w,
                    top: 12.h,
                    bottom: 8.h,
                  ),
                  decoration: const BoxDecoration(
                    color: TagColors.appThemeColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: TagColors.white,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                child: Image.asset(
                  AssetsImages.tagLogo,
                  fit: BoxFit.contain,
                ),
              ), // tags logo for home screen,
        // foregroundColor: Colors.white,
        backgroundColor: widget.myColor ?? Colors.white,
        shadowColor: widget.myColor ?? Colors.white,
        surfaceTintColor: widget.myColor ?? Colors.white,
      );
}
