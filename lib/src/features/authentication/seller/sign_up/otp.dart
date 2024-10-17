// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/authentication/seller/widget/indicator.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class SellOtpPage extends StatefulHookConsumerWidget {
  const SellOtpPage({required this.email, super.key});
  final String email;

  @override
  ConsumerState<SellOtpPage> createState() => _SellOtpPageState();
}

class _SellOtpPageState extends ConsumerState<SellOtpPage> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model1 = ref.read(registerViewmodelProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FF),
      appBar: AppBar(
        title: const Text(''),
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
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: const Color(0xffF8F9FF),
        shadowColor: const Color(0xffF8F9FF),
        surfaceTintColor: const Color(0xffF8F9FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email has been sent to you ',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  //.
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'We sent a code to ',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xff474747),
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold, // Make email bold
                            color: Color(0xff474747),
                            fontSize: 14,
                          ),
                        ),
                        const TextSpan(
                          text: ', Kindly type in the code sent to you email.',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xff474747),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //
                  const NewPageIndicator(
                    currentPage: 4,
                    indicatorColor: TagColors.appThemeColor,
                    totalPages: 5,
                    inactiveIndicatorColor: Colors.white24,
                  ),

                  //
                  const SizedBox(
                    height: 15,
                  ),

                  //
                  PinCodeTextField(
                    // obscureText: true,
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    pinTheme: PinTheme(
                      inactiveColor: const Color(0xffABABAB),
                      activeColor: TagColors.appThemeColor,
                      selectedColor: TagColors.appThemeColor,
                      fieldHeight: 72.h,
                      fieldWidth: 69.w,
                      borderWidth: 0.4,
                      inactiveBorderWidth: 0.4,
                      activeBorderWidth: 0.4,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    appContext: context,
                    controller: otpController,
                    length: 4,
                    onChanged: (value) {
                      // Handle PIN code changes
                    },
                    // onCompleted: (value) {

                    // },
                    onCompleted: (value) async {
                      String pinCode = otpController.text;
                      final response = await model1.verifyEmail(
                        formData: {
                          'key': pinCode,
                        },
                      );

                      if (response.successMessage.isNotEmpty) {
                        String seller = HiveStorage.get(HiveKeys.seller);
                        if (seller != '') {
                          context.pushReplacementNamed(
                            TagRoutes.createStore.name,
                          );
                        } else {
                          context.goNamed(TagRoutes.sellerLogin.name);
                        }
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
                    },
                  ),

                  //

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await model1.resendOTP(
                            formData: {
                              'email': widget.email,
                            },
                          ).then(
                            (value) async {
                              if (value.successMessage.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'OTP Resent, Please check your email',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else if (value.errorMessage.isNotEmpty) {
                                await showDialog(
                                  context: context,
                                  builder: (context) => TagDialog(
                                    icon: const Icon(
                                      Icons.error,
                                      color: TagColors.red,
                                      size: 50,
                                    ),
                                    title: 'Failed',
                                    subtitle: value.errorMessage,
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
                          );

                          // Hide loader dialog
                        },
                        child: const TagText(
                          text: 'Resend OTP',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontColor: TagColors.appThemeColor,
                        ),
                      ),
                    ],
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

            // if (otpController.text.length == 6)
            Consumer(
              builder: (context, ref, child) {
                final model = ref.read(registerViewmodelProvider.notifier);

                final state = ref.watch(registerViewmodelProvider);
                return state.loadStatus == Loader.loading
                    ? const TagLoader(
                        size: 30,
                        color: TagColors.appThemeColor,
                      )
                    : TagButton(
                        width: MediaQuery.of(context).size.width - 70,
                        height: 55,
                        onTap: () async {
                          String pinCode = otpController.text;
                          final response = await model.verifyEmail(
                            formData: {
                              'key': pinCode,
                            },
                          );

                          if (response.successMessage.isNotEmpty) {
                            String buyer = HiveStorage.get(HiveKeys.buyer);
                            if (buyer != 'Buyer' && buyer == '') {
                              context.pushReplacementNamed(
                                TagRoutes.sellerLogin.name,
                              );
                            } else {
                              context.pushReplacementNamed(
                                TagRoutes.createStore.name,
                              );
                            }
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
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'poppins',
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
    );
  }
}




//



//
