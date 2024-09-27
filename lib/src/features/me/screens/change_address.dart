// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class ChangeAddress extends StatefulHookConsumerWidget {
  const ChangeAddress({
    super.key,
  });

  @override
  ConsumerState<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends ConsumerState<ChangeAddress> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final flatNo = TextEditingController();
  final streetAddress = TextEditingController();
  final country = TextEditingController();
  String? completePhoneNumber;
  final List myCountry = [
    'Nigeria',
    'Ghana',
    'UK',
    'US',
  ];
  String? selectedCountry;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffF8F9FF),
        appBar: AppBar(
          title: const Text('Change Address'),
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
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) =>
                              FieldValidaor.validateEmptyfield(value!),
                          keyboardType: TextInputType.text,
                          controller: firstName,
                          title: 'First Name',
                          hintText: 'Type your first name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //
                        TagCustomField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FieldValidaor.validateEmptyfield(value!),
                          controller: lastName,
                          title: 'Last Name',
                          hintText: 'Type your last name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 3),
                          child: TagText(
                            text: 'Phone number',
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontColor: TagColors.newText,
                          ),
                        ),
                        IntlPhoneField(
                          // key: const Key('phoneField'),
                          controller: phoneNumber,
                          dropdownIconPosition: IconPosition.trailing,
                          dropdownTextStyle: const TextStyle(
                            fontFamily: 'GeneralSans',
                            color: TagColors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          style: const TextStyle(
                            color: TagColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          keyboardType: TextInputType.number,
                          // validator: (value) =>
                          //     PhoneNumberValidator.validatePhoneNumber(value as String),
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: 'Enter your phone number',

                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xffD0D5DD),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: TagColors.appThemeColor,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            // hintText: 'Enter your password',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: TagColors.newText,
                              fontSize: 12,
                            ),
                          ),
                          initialCountryCode: 'NG',
                          onChanged: (phone) {
                            log(phone.completeNumber);
                            completePhoneNumber = phone.completeNumber;
                          },
                        ),

                        const SizedBox(height: 20),
                        TagCustomField(
                          textCapitalization: TextCapitalization.none,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              EmailValidator.validateEmail(value!),
                          controller: email,
                          title: 'Email Address',
                          hintText: 'Type your email address',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TagCustomField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FieldValidaor.validateEmptyfield(value!),
                          controller: flatNo,
                          title: 'Flat No',
                          hintText: 'Type your flat number',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TagCustomField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FieldValidaor.validateEmptyfield(value!),
                          controller: streetAddress,
                          title: 'Street Address',
                          hintText: 'Type your street address',
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 3),
                          child: TagText(
                            text: 'Phone number',
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontColor: TagColors.newText,
                          ),
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Nigeria',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: TagColors.textGrey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            // Theme.of(context).colorScheme.background,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xffC6C6C6)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                style: BorderStyle.none,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          items: myCountry
                              .map<DropdownMenuItem<String>>(
                                (value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'montserrat',
                                      color: Color(0xff5E5E5E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: selectedCountry,
                          onChanged: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          },
                        ),

                        //
                        const SizedBox(
                          height: 20,
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
                const SizedBox(height: 20),
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
                                // final last_name = confamController.text;
                                // final String phonie =
                                //     widget.phone.replaceAll("+", "");
                                // completePhoneNumber!.substring(1).toString();

                                final response = await model.changeAddress(
                                  formData: {
                                    'first_name': firstName.text,
                                    'last_name': lastName.text,
                                    'phone_number': phoneNumber.text,
                                    'email': email.text,
                                    'flat_no': flatNo.text,
                                    'street_address': streetAddress.text,
                                    'country': country.text,
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
