import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/router/go_router.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/data/hivekeys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  Stripe.publishableKey =
      'pk_test_51PsoKuD0kq1OhQSyTJ8fhMKAn9Z8zcadfjSqtBPe6zYDi3yj7dCBB1KRbLRplpD7Ru85RHELTqCiTW6uY675DpOX000R9S38Fu';
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then(
    (_) async {
      runApp(
        const ProviderScope(child: MyApp()),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(393, 850),
        splitScreenMode: true,
        minTextAdapt: true,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp.router(
            title: 'TAGS MARKETPLACE',
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: TagColors.white,
              brightness: Brightness.light,
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: TagColors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
          ),
        ),
      );
}
