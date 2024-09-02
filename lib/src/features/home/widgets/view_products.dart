import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/show_banner.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/features/home/widgets/buildbusinessrow.dart';
import 'package:tags/src/features/home/widgets/product_tiles_specs.dart';
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
  int _quantity = 1;

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
    final model = ref.read(profileProvider.notifier);
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    void incrementQuantity() {
      if (_quantity < (state.viewMoreProducts?.quantity ?? 0)) {
        setState(() {
          _quantity++;
        });
      }
    }

    void decrementQuantity() {
      if (_quantity > 1) {
        setState(() {
          _quantity--;
        });
      }
    }

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
                if (state.loading != Loader.loading &&
                    state.viewMoreProducts != null)
                  SizedBox(
                    height: 40.h,
                    width: 300.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.viewMoreProducts!.images!.length,
                      itemBuilder: (context, index) => Container(
                        height: 40.h,
                        width: 40.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.viewMoreProducts!.images![index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                else if (state.loading == Loader.loading)
                  const Center(
                    child: SizedBox.shrink(),
                  )
                else
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'No Images available',
                        style: TextStyle(color: Colors.grey),
                      ),
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
            Align(
              alignment: Alignment.topLeft,
              child: TagText(
                text: state.viewMoreProducts != null &&
                        state.viewMoreProducts!.brand != null
                    ? 'Brand: ${state.viewMoreProducts!.brand!.name}'
                    : 'Brand: N/A',
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
                fontColor: TagColors.black,
              ),
            ),
            16.verticalSpace,
            buildBusinessInfoRow(),
            12.verticalSpace,

            Row(
              children: [
                Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                10.horizontalSpace,
                Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: const BoxDecoration(
                    color: TagColors.appThemeColor,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: incrementQuantity,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                10.horizontalSpace,
                Text(
                  _quantity.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                10.horizontalSpace,
                Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: const BoxDecoration(
                    color: TagColors.appThemeColor,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: decrementQuantity,
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 164.w,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: TagColors.lemonGreen),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        TagColors.white,
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        TagColors.white,
                      ),
                    ),
                    onPressed: () async {
                      final response = await model.postCart(
                        formData: {
                          'product_slug': state.viewMoreProducts!.slug,
                          'quantity': _quantity,
                        },
                      );

                      if (response.successMessage.isNotEmpty &&
                          context.mounted) {
                        showSuccessBanner(context, response.successMessage);
                      } else if (response.errorMessage.isNotEmpty &&
                          context.mounted &&
                          response.errorMessage ==
                              'Authentication credentials were not provided.') {
                        await context.pushNamed(TagRoutes.sellerLogin.name);
                      } else if (response.errorMessage.isNotEmpty &&
                          context.mounted &&
                          response.errorMessage !=
                              'Authentication credentials were not provided.') {
                        await showDialog(
                          context: context,
                          builder: (context) => TagDialog(
                            icon: const Icon(
                              Icons.error,
                              color: TagColors.red,
                              size: 50,
                            ),
                            title: 'Failed',
                            subtitle: response.errorMessage,
                            buttonColor: TagColors.red,
                            textColor: Colors.white,
                            buttonText: 'Dismiss',
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      } else {
                        log(response.error!.response!.statusCode.toString());
                      }

                      Future.delayed(const Duration(seconds: 2), () {
                        ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner();
                      });
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: TagColors.lemonGreen,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 164.w,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        TagColors.lemonGreen,
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        TagColors.white,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Buy Now'),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: TagColors.paleBlue,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About this item',
                        style: TextStyle(
                          color: TagColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      11.verticalSpace,
                      Text(
                        'Condition: ${state.viewMoreProducts?.condition ?? ''}',
                        style: TextStyle(
                          color: TagColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Color: ${state.viewMoreProducts?.color ?? ''}',
                        style: TextStyle(
                          color: TagColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Brand: ${state.viewMoreProducts?.brand?.name ?? ''}',
                        style: TextStyle(
                          color: TagColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      8.verticalSpace,
                    ],
                  ),
                  30.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      11.verticalSpace,
                      Text(
                        'Quantity In Stock: ${state.viewMoreProducts?.quantity ?? ''}',
                        style: TextStyle(
                          color: TagColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Year of Manufacture: ${state.viewMoreProducts?.manufactureYear ?? ''}',
                        style: TextStyle(
                          color: TagColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      8.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),

            24.verticalSpace,
            Text(
              'Product specifications and features:',
              style: TextStyle(
                color: TagColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            24.verticalSpace,
            ProductSpecTiles(
              theme: theme,
              state: state,
              title: 'Description',
              subDetails: state.viewMoreProducts?.description,
            ),
            8.verticalSpace,
            ProductSpecTiles(
              theme: theme,
              state: state,
              title: 'Shipping',
              subDetails: state.viewMoreProducts?.deliveryType,
            ),

            8.verticalSpace,
            ProductSpecTiles(
              theme: theme,
              state: state,
              title: 'Return Policy',
              subDetails: state.viewMoreProducts?.returnPolicy,
            ),

            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}
