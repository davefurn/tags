import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/features/authentication/seller/login/forgot_password.dart';
import 'package:tags/src/features/authentication/seller/login/reset_password.dart';
import 'package:tags/src/features/authentication/seller/login/view.dart';
import 'package:tags/src/features/authentication/seller/sign_up/create_company/create_company.dart';
import 'package:tags/src/features/authentication/seller/sign_up/create_company/successful_sign_up.dart';
import 'package:tags/src/features/authentication/seller/sign_up/create_company/what2sell.dart';
import 'package:tags/src/features/authentication/seller/sign_up/otp.dart';
import 'package:tags/src/features/authentication/seller/sign_up/passW.dart';
import 'package:tags/src/features/authentication/seller/sign_up/signup_page.dart';
import 'package:tags/src/features/authentication/seller/sign_up/signup_page2.dart';
import 'package:tags/src/features/onboarding/intros/buyer.dart';
import 'package:tags/src/features/onboarding/intros/intro_page_two.dart';
import 'package:tags/src/features/onboarding/intros/intro_pagge_one.dart';
import 'package:tags/src/features/onboarding/intros/seller.dart';
import 'package:tags/src/features/onboarding/splash_screen/view.dart';
import 'package:tags/src/features/seller/seller_profile/update_store.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: TagRoutes.splashScreen.path,
  // redirect: (context, state) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final hasOnBoarded = prefs.getBool(LandConstants.hasOnBoarded) ?? false;

  //   if (hasOnBoarded != true) {
  //     return TagRoutes.onBoarding.path;
  //   }
  //   return null;
  // },
  routes: [
    GoRoute(
      name: TagRoutes.splashScreen.name,
      path: TagRoutes.splashScreen.path,
      pageBuilder: (context, state) => const MaterialPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      name: TagRoutes.introPageOne.name,
      path: TagRoutes.introPageOne.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: IntroPageOne(),
      ),
    ),
    GoRoute(
      name: TagRoutes.introPageTwo.name,
      path: TagRoutes.introPageTwo.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: IntroPageTwo(),
      ),
    ),
    GoRoute(
      name: TagRoutes.decideScreen.name,
      path: TagRoutes.decideScreen.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: BuyerPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.sellerPage.name,
      path: TagRoutes.sellerPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SellerPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.sellerLogin.name,
      path: TagRoutes.sellerLogin.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SellLoginPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.forgotPassWord.name,
      path: TagRoutes.forgotPassWord.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: ForgotPassPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.sellerSignUpOne.name,
      path: TagRoutes.sellerSignUpOne.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SellSignUPPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.resetPasswordPage.name,
      path: TagRoutes.resetPasswordPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: ResetPasswordPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.sellerSignUpTwo.name,
      path: TagRoutes.sellerSignUpTwo.path,
      pageBuilder: (context, state) => CupertinoPage(
        child: SellSign2Page(
          email: state.pathParameters['email'].toString(),
        ),
      ),
    ),
    GoRoute(
      name: TagRoutes.confirmPassWord.name,
      path: TagRoutes.confirmPassWord.path,
      pageBuilder: (context, state) => CupertinoPage(
        child: ConfirmPassWord(
          email: state.pathParameters['email'].toString(),
          firstName: state.pathParameters['firstName'].toString(),
          lastName: state.pathParameters['lastName'].toString(),
          phone: state.pathParameters['phone'].toString(),
        ),
      ),
    ),
    GoRoute(
      name: TagRoutes.createStore.name,
      path: TagRoutes.createStore.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: CreateStorePage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.whatToSell.name,
      path: TagRoutes.whatToSell.path,
      pageBuilder: (context, state) => CupertinoPage(
        child: SelectCategory(
          busName: state.pathParameters['busName'].toString(),
          busAddress: state.pathParameters['busAddress'].toString(),
          phoneNum: state.pathParameters['phoneNum'].toString(),
          shopCountry: state.pathParameters['shopCountry'].toString(),
        ),
      ),
    ),
    GoRoute(
      name: TagRoutes.successfulSignUp.name,
      path: TagRoutes.successfulSignUp.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SuccessfulSignUp(),
      ),
    ),
    GoRoute(
      name: TagRoutes.updateStore.name,
      path: TagRoutes.updateStore.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: UpdateStorePage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.sellOtpPage.name,
      path: TagRoutes.sellOtpPage.path,
      pageBuilder: (context, state) => CupertinoPage(
        child: SellOtpPage(
          email: state.pathParameters['email'].toString(),
        ),
      ),
    ),
  ],
);
