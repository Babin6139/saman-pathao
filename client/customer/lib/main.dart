import 'package:customer/pages/chat_page.dart';
import 'package:customer/pages/confirmation_order_page.dart';
import 'package:customer/pages/finalized_page.dart';
import 'package:customer/pages/home_page.dart';
import 'package:customer/pages/individual_chat.dart';
import 'package:customer/pages/login_page.dart';
import 'package:customer/pages/map_placeorder.dart';
import 'package:customer/pages/order_page.dart';
import 'package:customer/pages/setting_page.dart';
import 'package:customer/pages/signup_page.dart';
import 'package:customer/providers/orderDataProvide.dart';
import 'package:customer/providers/userData.dart';
import 'package:customer/utils/routes.dart';
import 'package:customer/widgets/finalized_order.dart';
import 'package:customer/widgets/mythemes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserDataProvide()),
    ChangeNotifierProvider(create: (_) => OrderDataProvide())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_30e12814fed64afa9a7d4a92a2194aeb',
        builder: (context, navigatorKey) {
          return MaterialApp(
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            initialRoute: MyRoutes.landingPage,
            theme: MyThemes.lightTheme(context),
            debugShowCheckedModeBanner: false,
            routes: {
              MyRoutes.landingPage: (context) => LoginPage(),
              MyRoutes.login: (context) => LoginPage(),
              MyRoutes.signup: (context) => SignUp(),
              MyRoutes.homepage: (context) => HomePage(),
              MyRoutes.orderPage: (context) => DisplayOrder(),
              MyRoutes.settingPage: (context) => SettingPage(),
              MyRoutes.mapPlaceOrderPage: (context) => MapPlaceOrder(),
              MyRoutes.confirmOrder: (context) => OrderConfirmationPage(),
              MyRoutes.chat: (context) => IndvChat(),
              MyRoutes.finalized_orderpage: (context) => FinalizedPage(),
            },
          );
        });
  }
}
