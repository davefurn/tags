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
  orderHistory(
    name: 'orderHistory',
    path: '/orderHistory',
  ),
  deliveryPage(
    name: 'deliveryPage',
    path: '/deliveryPage',
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
  addProducts(
    name: 'addProducts',
    path: '/addProducts',
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
  viewProducts(
    name: 'viewProducts',
    path:
        '/viewProducts/:productImage/:productTitle/:productPrice/:productBrand/:slug/:discount/:subScription',
  ),
  salesPage(
    name: 'salesPage',
    path: '/salesPage',
  ),
  filtersPage(
    name: 'filtersPage',
    path: '/filtersPage',
  ),
  checkOut(
    name: 'checkOut',
    path: '/checkOut',
  ),
  mySellProductPage(
    name: 'mySellProductPage',
    path: '/mySellProductPage',
  ),
  orderzPage(
    name: 'orderzPage',
    path: '/orderzPage',
  ),
  addProductPage(
    name: 'addProductPage',
    path: '/addProductPage',
  ),
  paymentsPage(
    name: 'paymentsPage',
    path: '/paymentsPage',
  ),
  storeProfile(
    name: 'storeProfile',
    path: '/storeProfile',
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
  wishlist(
    name: 'wishlist',
    path: '/wishlist',
  ),
  changePassword(
    name: 'changePassword',
    path: '/changePassword',
  ),
  changeAddress(
    name: 'changeAddress',
    path: '/changeAddress',
  ),
  subCategoryScreen(
    name: 'subCategoryScreen',
    path: '/subCategoryScreen/:brandName',
  ),
  cart(
    name: 'cart',
    path: '/cart',
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
