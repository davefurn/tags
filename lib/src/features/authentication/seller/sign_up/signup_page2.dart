// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/authentication/seller/widget/indicator.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class SellSign2Page extends StatefulHookConsumerWidget {
  const SellSign2Page({
    required this.email,
    super.key,
  });
  final String email;

  @override
  ConsumerState<SellSign2Page> createState() => _SellSign2PageState();
}

class _SellSign2PageState extends ConsumerState<SellSign2Page> {
  final firstNameControll = TextEditingController();
  final lastNameControll = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  // bool _isLoading = false;
  String? completePhoneNumber;

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
          child: ListView(
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
                        'Enter your details',
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
                      // Text(
                      //   "Kindly put in your Email Address and a PIN would be sent to your mail.",
                      //   style:TextStyle(
                      // fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w300,
                      //     color: const Color(0xff474747),
                      //     fontSize: 14,
                      //   ),
                      // ),

                      const SizedBox(
                        height: 8,
                      ),

                      //
                      const NewPageIndicator(
                        currentPage: 2,
                        indicatorColor: TagColors.appThemeColor,
                        totalPages: 5,
                        inactiveIndicatorColor: Colors.white24,
                      ),

                      //
                      const SizedBox(
                        height: 8,
                      ),

                      //
                      TagCustomField(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        keyboardType: TextInputType.text,
                        controller: firstNameControll,
                        title: 'First Name',
                        hintText: 'Type your first name',
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TagCustomField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: lastNameControll,
                        title: 'Last Name',
                        hintText: 'Type your last name',
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      //phone
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
                        controller: phoneController,
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TagButton(
                width: MediaQuery.of(context).size.width - 70,
                height: 55,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final firstname = firstNameControll.text;
                    final lastname = lastNameControll.text;
                    final String phonie = completePhoneNumber!;

                    context.pushNamed(
                      TagRoutes.confirmPassWord.name,
                      pathParameters: {
                        'email': widget.email,
                        'firstName': firstname,
                        'lastName': lastname,
                        'phone': phonie,
                      },
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
              ),
            ],
          ),
        ),
      );
}
