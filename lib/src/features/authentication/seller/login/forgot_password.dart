// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class ForgotPassPage extends StatefulHookConsumerWidget {
  const ForgotPassPage({
    super.key,
  });

  @override
  ConsumerState<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends ConsumerState<ForgotPassPage> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      //
                      TagCustomField(
                        textCapitalization: TextCapitalization.none,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: emailController,
                        title: 'Email Address or Phone number',
                        hintText: 'Type your email address or phone number',
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: _isLoading ? null : _loginUser,
              //   child: _isLoading
              //       ? const CircularProgressIndicator()
              //       : const Text('Login'),
              // ),
              const SizedBox(height: 50),
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
                            if (_formKey.currentState!.validate()) {
                              final email = emailController.text;
                              // final last_name = confamController.text;
                              // final String phonie =
                              //     completePhoneNumber!.substring(1).toString();

                              final response = await model.signUp(
                                formData: {
                                  'email': email,
                                },
                              );

                              if (response.successMessage.isNotEmpty) {
                                // final newToken =
                                //     ref.read(registerViewmodelProvider).token;
                                await showDialog(
                                  context: context,
                                  builder: (context) => TagDialog(
                                    icon: const Icon(
                                      Icons.check_circle,
                                      color: TagColors.appThemeColor,
                                      size: 50,
                                    ),
                                    // title: 'Failed',
                                    subtitle: response.successMessage,
                                    buttonColor: TagColors.appThemeColor,
                                    textColor: Colors.white,
                                    buttonText: 'Continue',
                                    onTap: () async {
                                      context
                                          .goNamed(TagRoutes.sellerLogin.name);
                                    },
                                  ),
                                );
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
                                      context.canPop();
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
                                  subtitle: 'All Fields are required',
                                  buttonColor: TagColors.red,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }

                            // String pinCode = otpController.text;
                          },
                          child: const Text(
                            'Reset Password',
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
      );
}
