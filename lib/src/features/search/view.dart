import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: TagBar(
          isHome: true,
          title: 'Search',
          actions: [
            const InkWell(
              child: Icon(
                Icons.favorite_outline_rounded,
                color: Color(0xff5E5E5E),
              ),
            ),
            4.horizontalSpace,
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xff474747),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomTextInput(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 155.h),
                  child: SizedBox(
                    child: Center(
                      child: Image.asset(
                        AssetsImages.emptySearchHistory,
                        height: MediaQuery.sizeOf(context).height * 0.25,
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

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60.h,
        child: TextField(
          cursorColor: TagColors.black,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w)
                    .copyWith(bottom: 20.h),
            hintMaxLines: 1,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: TagColors.appThemeColor),
              borderRadius: BorderRadius.circular(25.r),
            ),
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200,
              color: const Color(0xffC6C6C6),
              letterSpacing: 1.2,
              fontSize: 13.sp,
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 20.sp,
                color: TagColors.greyColor,
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: SizedBox(
                width: 50.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.mic_none_outlined,
                      color: TagColors.greyColor,
                      size: 24.sp,
                    ),
                    2.horizontalSpace,
                    Icon(
                      Icons.image_outlined,
                      color: TagColors.greyColor,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
            hintText: 'Search for categories, product or brand',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
          ),
        ),
      );
}
