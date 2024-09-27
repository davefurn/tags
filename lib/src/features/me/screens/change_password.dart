// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class ChangePassword extends StatefulHookConsumerWidget {
  const ChangePassword({
    super.key,
  });

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final passController = TextEditingController();
  final oldPasswoord = TextEditingController();
  final confamController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isObscure2 = true;
  bool _isObscure = true;
  bool _isObscure3 = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffF8F9FF),
        appBar: AppBar(
          title: const Text('Change Password'),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 65.w,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              height: 35,
              width: 35,
              margin: EdgeInsets.only(left: 5.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TagColors.appThemeColor,
                shape: BoxShape.circle,
                border: Border.all(color: TagColors.white),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TagCustomField(
                          textCapitalization: TextCapitalization.words,
                          obscureText: _isObscure3,
                          keyboardType: TextInputType.text,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FieldValidaor.validateEmptyfield(value!),
                          controller: oldPasswoord,
                          title: 'Old Password',
                          hintText: 'Enter your old password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure2;
                              });
                            },
                            icon: Icon(
                              _isObscure3
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: _isObscure2
                                  ? TagColors.oldGrey
                                  : Colors.black.withOpacity(0.55),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //
                        TagCustomField(
                          textCapitalization: TextCapitalization.words,
                          obscureText: _isObscure2,
                          keyboardType: TextInputType.text,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              FieldValidaor.validateEmptyfield(value!),
                          controller: passController,
                          title: 'Password',
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            },
                            icon: Icon(
                              _isObscure2
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: _isObscure2
                                  ? TagColors.oldGrey
                                  : Colors.black.withOpacity(0.55),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        TagCustomField(
                          textCapitalization: TextCapitalization.words,
                          obscureText: _isObscure,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              ConfirmPasswordValidator.validateConfirmPassword(
                            value,
                            passController.text,
                          ),
                          controller: confamController,
                          title: 'Confirm Password',
                          hintText: 'Confirm your password',
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

                        const SizedBox(height: 20),
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
                                final password = passController.text;
                                final oldPassword = oldPasswoord.text;
                                // final last_name = confamController.text;
                                // final String phonie =
                                //     widget.phone.replaceAll("+", "");
                                // completePhoneNumber!.substring(1).toString();

                                final response = await model.changePasswords(
                                  formData: {
                                    'old_password': oldPassword,
                                    'new_password': password,
                                  },
                                );

                                if (response.successMessage.isNotEmpty) {
                                  await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => TagDialog(
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: TagColors.appThemeColor,
                                        size: 50,
                                      ),
                                      subtitle: response.successMessage,
                                      buttonColor: TagColors.appThemeColor,
                                      textColor: Colors.white,
                                      buttonText: 'Continue',
                                      onTap: () async {
                                        context.canPop();
                                      },
                                    ),
                                  );
                                  context.canPop();
                                } else {
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
      );
}
