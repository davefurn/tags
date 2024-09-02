import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/router/scaffold_with_nav_bar.dart';
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
import 'package:tags/src/features/cart/view.dart';
import 'package:tags/src/features/categories/sub_categories.dart';
import 'package:tags/src/features/categories/view.dart';
import 'package:tags/src/features/home/view.dart';
import 'package:tags/src/features/home/widgets/view_products.dart';
import 'package:tags/src/features/me/screens/settings.dart';
import 'package:tags/src/features/me/view.dart';
import 'package:tags/src/features/onboarding/intros/buyer.dart';
import 'package:tags/src/features/onboarding/intros/intro_page_two.dart';
import 'package:tags/src/features/onboarding/intros/intro_pagge_one.dart';
import 'package:tags/src/features/onboarding/intros/seller.dart';
import 'package:tags/src/features/onboarding/splash_screen/view.dart';
import 'package:tags/src/features/search/view.dart';
import 'package:tags/src/features/sell/add_products.dart';
import 'package:tags/src/features/sell/orderz/myorderz.dart';
import 'package:tags/src/features/sell/payments_screen.dart';
import 'package:tags/src/features/sell/products/myproducts.dart';
import 'package:tags/src/features/sell/sales/sales.dart';
import 'package:tags/src/features/sell/sell_page.dart';
import 'package:tags/src/features/sell/store_profile.dart';

import 'package:tags/src/features/seller/seller_profile/update_store.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorSearchKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCategoriesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorSellKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');
final _shellNavigatorMeKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: TagRoutes.splashScreen.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => ScaffoldWithNavBar(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: <RouteBase>[
            GoRoute(
              name: TagRoutes.home.name,
              path: TagRoutes.home.path,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const HomePage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearchKey,
          routes: <RouteBase>[
            GoRoute(
              name: TagRoutes.search.name,
              path: TagRoutes.search.path,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const SearchPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCategoriesKey,
          routes: <RouteBase>[
            GoRoute(
              name: TagRoutes.categories.name,
              path: TagRoutes.categories.path,
              pageBuilder: (context, state) => const CupertinoPage(
                child: CategoryScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMeKey,
          routes: <RouteBase>[
            GoRoute(
              name: TagRoutes.me.name,
              path: TagRoutes.me.path,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MePage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSellKey,
          routes: <RouteBase>[
            GoRoute(
              name: TagRoutes.sell.name,
              path: TagRoutes.sell.path,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SellPage(),
              ),
            ),
          ],
        ),
      ],
    ),
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
      name: TagRoutes.deliveryPage.name,
      path: TagRoutes.deliveryPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: DeliveryPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.cart.name,
      path: TagRoutes.cart.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: Cart(),
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
      name: TagRoutes.viewProducts.name,
      path: TagRoutes.viewProducts.path,
      pageBuilder: (context, state) => CupertinoPage(
        child: ViewProducts(
          productImage: state.pathParameters['productImage'].toString(),
          productTitle: state.pathParameters['productTitle'].toString(),
          productPrice: state.pathParameters['productPrice'].toString(),
          productBrand: state.pathParameters['productBrand'].toString(),
          slug: state.pathParameters['slug'].toString(),
          discount: state.pathParameters['discount'].toString(),
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
      name: TagRoutes.settings.name,
      path: TagRoutes.settings.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: Settings(),
      ),
    ),
    GoRoute(
      name: TagRoutes.addProducts.name,
      path: TagRoutes.addProducts.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: AddProductPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.mySellProductPage.name,
      path: TagRoutes.mySellProductPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: MySellProductPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.orderzPage.name,
      path: TagRoutes.orderzPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: OrderzPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.paymentsPage.name,
      path: TagRoutes.paymentsPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: PaymentsPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.salesPage.name,
      path: TagRoutes.salesPage.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SalesPage(),
      ),
    ),
    GoRoute(
      name: TagRoutes.storeProfile.name,
      path: TagRoutes.storeProfile.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: StoreProfile(),
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
    GoRoute(
      name: TagRoutes.subCategoryScreen.name,
      path: TagRoutes.subCategoryScreen.path,
      pageBuilder: (context, state) => CupertinoPage(
        child: SubCategoryScreen(
          brandName: state.pathParameters['brandName'].toString(),
        ),
      ),
    ),
  ],
);
