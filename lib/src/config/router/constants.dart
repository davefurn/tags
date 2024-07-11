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
    path: '/confirmPassWord/:email/:firstName/:lastName/phone;',
  ),

  decideScreen(
    name: 'decideScreen',
    path: '/decideScreen',
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
