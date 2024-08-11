// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/features/authentication/seller/sign_up/model/catmodel.dart';
import 'package:tags/src/features/authentication/seller/widget/indicator.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class SelectCategory extends StatefulHookConsumerWidget {
  const SelectCategory({
    required this.busName,
    required this.busAddress,
    required this.phoneNum,
    required this.shopCountry,
    super.key,
  });

  final String busName;
  final String busAddress;
  final String phoneNum;
  final String shopCountry;

  @override
  ConsumerState<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends ConsumerState<SelectCategory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).categories();
      // ref.read(eventViewmodelProvider.notifier).eventCategory();
    });
    super.initState();
  }

  final List<ResultModel> selectedCategories = [];

  void toggleSelection(ResultModel category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await ref.read(profileProvider.notifier).categories();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FF),
        appBar: AppBar(
          title: const Text(
            ' ',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
              // fontSize: 22,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TagColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: TagColors.white),
              ),
              child: const Icon(
                Icons.keyboard_backspace_rounded,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: const Color(0xffF9F9F9),
          shadowColor: const Color(0xffF9F9F9),
          surfaceTintColor: const Color(0xffF9F9F9),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TagTitleSub(
                        title: 'What do you sell?',
                        subz:
                            'Choose your categories to help customers find you faster.',
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      //
                      if (state.loading != Loader.loading &&
                          state.categories.isNotEmpty)
                        LimitedBox(
                          maxHeight: 400.h,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 2.1,
                            ),
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final item = state.categories[index];
                              final isSelected =
                                  selectedCategories.contains(item);
                              return GestureDetector(
                                onTap: () => toggleSelection(item),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                      horizontal: 10.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.blue
                                            : const Color(0xffF1F1F1),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.name.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          color: isSelected
                                              ? Colors.blue
                                              : const Color(0xff919191),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      else if (state.loading == Loader.loading)
                        const Center(
                          child: SpinKitWaveSpinner(
                            color: TagColors.appThemeColor,
                          ),
                        )
                      else
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'No Categories available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),

                      //
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: _isLoading ? null : _loginUser,
                //   child: _isLoading
                //       ? const CircularProgressIndicator()
                //       : const Text('Login'),
                // ),
                const SizedBox(height: 50),

                // if (otpController.text.isNotEmpty)
                Consumer(
                  builder: (context, ref, child) {
                    final model = ref.read(registerViewmodelProvider.notifier);

                    final state = ref.watch(registerViewmodelProvider);
                    return state.loadStatus == Loader.loading
                        ? const TagLoader(
                            color: TagColors.appThemeColor,
                          )
                        : TagButton(
                            width: MediaQuery.of(context).size.width - 70,
                            height: 55,
                            onTap: () async {
                              if (selectedCategories.toString().isNotEmpty) {
                                //

                                // String pinCode = otpController.text;
                                final response = await model.createCompany(
                                  formData: {
                                    'company_name': widget.busName,
                                    'company_phone': widget.phoneNum,
                                    'company_country': widget.shopCountry,

                                    'categories': selectedCategories
                                        .map((cat) => cat.slug)
                                        .toList(),
                                    'company_email': widget.busAddress,

                                    // "company_password": "tesla123",
                                    // "categories": [
                                    //     "automobile"
                                    // ],
                                  },
                                );

                                if (response.successMessage.isNotEmpty) {
                                  //if successful :
                                  //modal for success

                                  await context.pushNamed(
                                    TagRoutes.successfulSignUp.name,
                                  );
                                  //
                                } else if (response.errorMessage.isNotEmpty) {
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
                                }
                              } else {
                                return showDialog(
                                  context: context,
                                  builder: (context) => TagDialog(
                                    icon: const Icon(
                                      Icons.warning,
                                      color: TagColors.red,
                                      size: 50,
                                    ),
                                    title: ' ',
                                    subtitle: 'One or two must be selected',
                                    buttonColor: TagColors.red,
                                    textColor: Colors.white,
                                    buttonText: 'Dismiss',
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
