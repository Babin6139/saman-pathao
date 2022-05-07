import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/providers/biddedOrdersProvider.dart';
import 'package:transporter/providers/changePageProvider.dart';
import 'package:transporter/providers/deliveryOrdersProvider.dart';
import 'package:transporter/providers/formValueProvider.dart';
import 'package:transporter/providers/onBidOrdersProvider.dart';
import 'package:transporter/providers/transporterDataProvider.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:transporter/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TransporterDataProvider()),
    ChangeNotifierProvider(create: (_) => FormValueProvider()),
    ChangeNotifierProvider(create: (_) => BiddedOrdersProvider()),
    ChangeNotifierProvider(create: (_) => DeliveryOrdersProvider()),
    ChangeNotifierProvider(create: (_) => OnBidOrdersProvider()),
    ChangeNotifierProvider(create: (_) => ChangePageProvider()),
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
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
