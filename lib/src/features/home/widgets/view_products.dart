import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/search/view.dart';

class ViewProducts extends StatefulHookConsumerWidget {
  const ViewProducts({
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.productBrand,
    required this.slug,
    this.discount,
    super.key,
  });

  final String productImage;
  final String productTitle;
  final String productPrice;
  final String productBrand;
  final String slug;
  final String? discount;

  @override
  ConsumerState<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends ConsumerState<ViewProducts> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getAProduct(widget.slug);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontFamily: 'montserrat',
            // fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.goNamed(TagRoutes.home.name);
          },
          icon: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TagColors.appThemeColor,
              shape: BoxShape.circle,
              border: Border.all(color: TagColors.appThemeColor),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: TagColors.white),
              ),
              child: const Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            15.verticalSpace,
            const CustomTextInput(),
            15.verticalSpace,
            Container(
              height: 212.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.productImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        Assets.iphoneBack,
                        width: 40.w,
                        height: 40.h,
                      ),
                      SvgPicture.asset(
                        Assets.iphoneForward,
                        width: 40.w,
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //

            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300.w,
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50.w,
                  child: Row(
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.share,
                            color: TagColors.black,
                          ),
                        ),
                      ),
                      Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFF6F1),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: TagColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: TagText2(
                text: widget.productTitle,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                fontColor: TagColors.black,
                letterSpacing: 0,
              ),
            ),
            2.verticalSpace,
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TagText(
                    text: widget.productPrice,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontColor: TagColors.black,
                    letterSpacing: 0,
                  ),
                ),
                if (widget.discount == null || widget.discount == '')
                  const SizedBox.shrink()
                else
                  Align(
                    alignment: Alignment.topLeft,
                    child: TagText(
                      text: widget.discount.toString(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff777777),
                      letterSpacing: 0,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            TagText(
              text: 'Brand : ${widget.slug}',
              fontSize: 12,
              fontWeight: FontWeight.w300,
              fontColor: TagColors.black,
            ),

            const SizedBox(
              height: 50,
            ),

            // Container(
            //   padding: EdgeInsets.all(4),
            //   decoration: BoxDecoration(color: TagColors.textGrey),
            // ),
          ],
        ),
      ),
    );
  }
}
