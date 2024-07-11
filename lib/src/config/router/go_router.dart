import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/features/authentication/seller/login/forgot_password.dart';
import 'package:tags/src/features/authentication/seller/login/view.dart';
import 'package:tags/src/features/authentication/seller/sign_up/passW.dart';
import 'package:tags/src/features/authentication/seller/sign_up/signup_page.dart';
import 'package:tags/src/features/authentication/seller/sign_up/signup_page2.dart';
import 'package:tags/src/features/onboarding/intros/buyer.dart';
import 'package:tags/src/features/onboarding/intros/intro_page_two.dart';
import 'package:tags/src/features/onboarding/intros/intro_pagge_one.dart';
import 'package:tags/src/features/onboarding/intros/seller.dart';
import 'package:tags/src/features/onboarding/splash_screen/view.dart';

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
    // GoRoute(
    //   name: TagRoutes.forgotPassWord.name,
    //   path: TagRoutes.forgotPassWord.path,
    //   pageBuilder: (context, state) => const CupertinoPage(
    //     child: ForgotPassWord(),
    //   ),
    // ),
    // GoRoute(
    //   name: TagRoutes.forgotPassWord.name,
    //   path: TagRoutes.forgotPassWord.path,
    //   pageBuilder: (context, state) => const CupertinoPage(
    //     child: ForgotPassWord(),
    //   ),
    // ),
  ],
);
