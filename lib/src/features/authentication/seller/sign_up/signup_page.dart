// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/authentication/seller/widget/indicator.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class SellSignUPPage extends StatefulWidget {
  const SellSignUPPage({
    super.key,
  });
  @override
  State<SellSignUPPage> createState() => _SellSignUPPageState();
}

class _SellSignUPPageState extends State<SellSignUPPage> {
  final emailController = TextEditingController();

  // final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  // bool _isLoading = false;

  // Future<void> _loginUser() async {
  //   setState(() => _isLoading = true);
  //   // Simulate login logic (replace with actual authentication)
  //   if (emailController.text == "user") {
  //     final user = User(emailController.text, _passwordController.text);
  //     await Hive.box('users').add(user);
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const SellerBottomNavBar()));
  //   } else {
  //     // Show error message
  //   }
  //   setState(() => _isLoading = false);
  // }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create an Account',
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
                      height: 20,
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
                      child: TagCustomField(
                        textCapitalization: TextCapitalization.none,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            EmailValidator.validateEmail(value!),
                        controller: emailController,
                        title: 'Email Address',
                        hintText: 'Type your email address',
                      ),
                    ),

                    //

                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // if (emailController.text.isNotEmpty)
              TagButton(
                width: MediaQuery.of(context).size.width - 70,
                height: 55,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.pushNamed(
                      TagRoutes.sellerSignUpTwo.name,
                      pathParameters: {
                        'email': emailController.text,
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
