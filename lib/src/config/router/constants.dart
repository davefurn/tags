enum TagRoutes {
  splashScreen(
    name: 'splashScreen',
    path: '/splashScreen',
  ),
  introPageOne(
    name: 'introPageOne',
    path: '/introPageOne',
  ),
  introPageTwo(
    name: 'introPageTwo',
    path: '/introPageTwo',
  ),
  sellerPage(
    name: 'sellerPage',
    path: '/sellerPage',
  ),
  sellerLogin(
    name: 'sellerLogin',
    path: '/sellerLogin',
  ),
  updateStore(
    name: 'updateStore',
    path: '/updateStore',
  ),
  forgotPassWord(
    name: 'forgotPassWord',
    path: '/forgotPassWord',
  ),
  sellerSignUpOne(
    name: 'sellerSignUpOne',
    path: '/sellerSignUpOne',
  ),
  sellerSignUpTwo(
    name: 'sellerSignUpTwo',
    path: '/sellerSignUpTwo/:email',
  ),
  confirmPassWord(
    name: 'confirmPassWord',
    path: '/confirmPassWord/:email/:firstName/:lastName/:phone',
  ),
  createStore(
    name: 'createStore',
    path: '/createStore',
  ),
  whatToSell(
    name: 'whatToSell',
    path: '/whatToSell/:busName/:busAddress/:phoneNum/:shopCountry',
  ),
  sellOtpPage(
    name: 'sellOtpPage',
    path: '/sellOtpPage/:email',
  ),
  successfulSignUp(
    name: 'successfulSignUp',
    path: '/successfulSignUp',
  ),
  resetPasswordPage(
    name: 'resetPasswordPage',
    path: '/resetPasswordPage',
  ),
  decideScreen(
    name: 'decideScreen',
    path: '/decideScreen',
  ),
  categories(
    name: 'categories',
    path: '/categories',
  ),
  home(
    name: 'home',
    path: '/home',
  ),
  sell(
    name: 'sell',
    path: '/sell',
  ),
  search(
    name: 'search',
    path: '/search',
  ),
  settings(
    name: 'settings',
    path: '/settings',
  ),
  me(
    name: 'me',
    path: '/me',
  );

  const TagRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  @override
  String toString() => name;
}
