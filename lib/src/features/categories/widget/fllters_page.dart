import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class FilterScreen extends StatefulHookConsumerWidget {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends ConsumerState<FilterScreen> {
  String? selectedLocation;
  String? selectedPriceRange;
  String? selectedRating;
  String? token;
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  @override
  void initState() {
    token = HiveStorage.get(HiveKeys.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: TagBar(
        token: token,
        state: state,
        title: 'Filter',
        isHome: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Category and Brand selection
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0.w,
              ),
              minTileHeight: 40.h,
              title: Text(
                'Category',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              trailing: SizedBox(
                width: 105.w,
                child: Row(
                  children: [
                    Text(
                      'Electronics',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    2.5.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
              onTap: () {
                // Handle category selection
              },
            ),
            const Divider(),
            ListTile(
              minTileHeight: 40.h,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0.w,
              ),
              title: Text(
                'Brands',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              trailing: SizedBox(
                width: 65.w,
                child: Row(
                  children: [
                    Text(
                      'Apple',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    2.5.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
              onTap: () {
                // Handle brand selection
              },
            ),
            const Divider(),
            20.verticalSpace,
            // Item Location
            Text(
              'Item Location',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            RadioListTile(
              activeColor: TagColors.appThemeColor,
              value: 'United States',
              groupValue: selectedLocation,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value.toString();
                });
              },
              title: const Text(
                'United States',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              value: 'Russia',
              groupValue: selectedLocation,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value.toString();
                });
              },
              title: const Text(
                'Russia',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              value: 'United Kingdom',
              groupValue: selectedLocation,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value.toString();
                });
              },
              title: const Text(
                'United Kingdom',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              value: 'Nigeria',
              groupValue: selectedLocation,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value.toString();
                });
              },
              title: const Text(
                'Nigeria',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Divider(),
            20.verticalSpace,
            // Price Range
            Text(
              'Price',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            RadioListTile(
              activeColor: TagColors.appThemeColor,
              value: r'Under $10',
              groupValue: selectedPriceRange,
              onChanged: (value) {
                setState(() {
                  selectedPriceRange = value.toString();
                });
              },
              title: const Text(
                r'Under $10',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              activeColor: TagColors.appThemeColor,
              value: r'$10 - $50',
              groupValue: selectedPriceRange,
              onChanged: (value) {
                setState(() {
                  selectedPriceRange = value.toString();
                });
              },
              title: const Text(
                r'$10 - $50',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              activeColor: TagColors.appThemeColor,
              value: r'$100 - $500',
              groupValue: selectedPriceRange,
              onChanged: (value) {
                setState(() {
                  selectedPriceRange = value.toString();
                });
              },
              title: const Text(
                r'$100 - $500',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              activeColor: TagColors.appThemeColor,
              value: r'$1000 - $5000',
              groupValue: selectedPriceRange,
              onChanged: (value) {
                setState(() {
                  selectedPriceRange = value.toString();
                });
              },
              title: const Text(
                r'$1000 - $5000',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            RadioListTile(
              activeColor: TagColors.appThemeColor,
              value: r'Above $50000',
              groupValue: selectedPriceRange,
              onChanged: (value) {
                setState(() {
                  selectedPriceRange = value.toString();
                });
              },
              title: const Text(
                r'Above $50000',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Divider(),
            20.verticalSpace,
            // Custom Price Range
            Text(
              'Custom Price Range',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _minPriceController,
                    decoration: InputDecoration(
                      hintText: 'Min Price',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ), // Adjust padding to center vertically
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: TagColors.appThemeColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: TagColors.appThemeColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200,
                        color: const Color(0xffC6C6C6),
                        letterSpacing: 1.2,
                        fontSize: 13.sp,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _maxPriceController,
                    decoration: InputDecoration(
                      hintText: 'Max Price',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ), // Adjust padding to center vertically
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: TagColors.appThemeColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: TagColors.appThemeColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200,
                        color: const Color(0xffC6C6C6),
                        letterSpacing: 1.2,
                        fontSize: 13.sp,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 45.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: TagColors.appThemeColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Go',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: TagColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,

            // Ratings of Items
            Text(
              'Ratings of Items',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            RadioListTile(
              value: '4 & up',
              groupValue: selectedRating,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedRating = value.toString();
                });
              },
              title: Row(
                children: List.generate(
                  4,
                  (index) => const Icon(Icons.star, color: Color(0xffF4C41C)),
                ),
              ),
            ),
            RadioListTile(
              value: '3 & up',
              groupValue: selectedRating,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedRating = value.toString();
                });
              },
              title: Row(
                children: List.generate(
                  3,
                  (index) => const Icon(Icons.star, color: Color(0xffF4C41C)),
                ),
              ),
            ),
            RadioListTile(
              value: '2 & up',
              groupValue: selectedRating,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedRating = value.toString();
                });
              },
              title: Row(
                children: List.generate(
                  2,
                  (index) => const Icon(Icons.star, color: Color(0xffF4C41C)),
                ),
              ),
            ),
            RadioListTile(
              value: '1 & up',
              groupValue: selectedRating,
              activeColor: TagColors.appThemeColor,
              onChanged: (value) {
                setState(() {
                  selectedRating = value.toString();
                });
              },
              title: Row(
                children: List.generate(
                  1,
                  (index) => const Icon(Icons.star, color: Color(0xffF4C41C)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            TagLoginButton(
              height: 48.h,
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Poppings',
                  fontSize: 12.sp,
                  letterSpacing: 1,
                  color: TagColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
