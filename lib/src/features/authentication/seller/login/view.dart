// ignore_for_file: use_build_context_synchronously, deprecated_member_use

// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/authentication/seller/widget/indicator.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

// import 'package:tags/seller_bottom_bar.dart';

// import 'package:tags/splashscreen/seller_page.dart';

// import '../../widgets/tag_dialog.dart';

class SellLoginPage extends StatefulWidget {
  const SellLoginPage({super.key});

  @override
  State<SellLoginPage> createState() => _SellLoginPageState();
}

class _SellLoginPageState extends State<SellLoginPage> {
  bool hasLogged = HiveStorage.get(HiveKeys.hasLoggedIn) ?? false;
  final emailController = TextEditingController(
    text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
        ? HiveStorage.get(HiveKeys.userEmail)
        : '',
  );
  final passwordController = TextEditingController(
    text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
        ? HiveStorage.get(HiveKeys.userPassword)
        : '',
  );
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isObscure = true;

  bool _hasLoggedIn = false;

  // void _handleLogin(BuildContext context) {
  //   setState(() {
  //     _hasLoggedIn = true;
  //   });
  //   // Navigate to MarketPage
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const SellPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: const Color(0xffF8F9FF),
          appBar: AppBar(
            title: const Text(''),
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                context.goNamed(TagRoutes.introPageTwo.name);
              },
              icon: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: TagColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: TagColors.white,
                  ),
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
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Log In',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        //.
                        const Text(
                          'Kindly put in your Email Address and a PIN would be sent to your mail.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xff474747),
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        //
                        const NewPageIndicator(
                          currentPage: 1,
                          indicatorColor: TagColors.appThemeColor,
                          totalPages: 5,
                          inactiveIndicatorColor: Colors.white24,
                        ),

                        //
                        const SizedBox(
                          height: 8,
                        ),

                        //
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TagCustomField(
                                textCapitalization: TextCapitalization.none,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FieldValidaor.validateEmptyfield(value!),
                                controller: emailController,
                                title: 'Email Address or Phone number',
                                hintText:
                                    'Type your email address or phone number',
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TagCustomField(
                                textCapitalization: TextCapitalization.words,
                                obscureText: _isObscure,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    FieldValidaor.validateField(value!),
                                // PasswordValidator.validatePassword(value!),
                                controller: passwordController,
                                title: 'Password',
                                hintText: 'Type your password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: _isObscure
                                        ? TagColors.oldGrey
                                        : Colors.black.withOpacity(0.55),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox.adaptive(
                                    activeColor: TagColors.appThemeColor,
                                    value: _hasLoggedIn,
                                    onChanged: (value) {
                                      setState(() {
                                        _hasLoggedIn = !_hasLoggedIn;
                                      });
                                    },
                                  ),
                                  const TagText(
                                    fontColor: TagColors.textColor,
                                    text: 'Remember me',
                                    fontSize: 11,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ],
                              ),
                            ),

                            //       //
                            Expanded(
                              child: TextButton(
                                child: const TagText(
                                  fontColor: TagColors.blue,
                                  text: 'Forgot your password?',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                                onPressed: () {
                                  context
                                      .pushNamed(TagRoutes.forgotPassWord.name);
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Consumer(
                    builder: (context, ref, child) {
                      final model = ref.read(loginViewModelProvider.notifier);
                      final state = ref.watch(loginViewModelProvider);
                      return state.loadStatus == Loader.loading
                          ? const TagLoader(
                              size: 30,
                              color: TagColors.appThemeColor,
                            )
                          : TagButton(
                              width: MediaQuery.of(context).size.width - 70,
                              height: 55,
                              onTap: () async {
                                // _handleLogin(context);
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text;
                                  final passW = passwordController.text;

                                  final response = await model.login(
                                    formData: {
                                      'email': email,
                                      'password': passW,
                                    },
                                  );
                                  if (response.successMessage.isNotEmpty) {
                                    await Future.delayed(
                                        const Duration(milliseconds: 100),
                                        () async {
                                      await HiveStorage.put(
                                        HiveKeys.userEmail,
                                        emailController.text,
                                      );
                                      await HiveStorage.put(
                                        HiveKeys.userPassword,
                                        passwordController.text,
                                      );
                                      await HiveStorage.put(
                                        HiveKeys.hasLoggedIn,
                                        true,
                                      );
                                    });

                                    setState(() {
                                      _hasLoggedIn = true;
                                    });

                                    context.goNamed(TagRoutes.home.name);
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
                                  await showDialog(
                                    context: context,
                                    builder: (context) => TagDialog(
                                      icon: const Icon(
                                        Icons.info_outline_rounded,
                                        color: TagColors.red,
                                        size: 50,
                                      ),
                                      buttonColor: TagColors.red,
                                      textColor: Colors.white,
                                      buttonText: 'Continue',
                                      subtitle: 'All Fields are required',
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                }

                                // String pinCode = otpController.text;
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            );
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(TagRoutes.sellerSignUpOne.name);
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,

                        // borderRadius: BorderRadius.circular(4)
                      ),
                      child: const TagText(
                        fontColor: TagColors.blue,
                        text: 'Create an account',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

//
