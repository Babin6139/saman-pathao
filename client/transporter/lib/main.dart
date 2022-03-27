import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/providers/changePageProvider.dart';
import 'package:transporter/providers/formValueProvider.dart';
import 'package:transporter/providers/transporterDataProvider.dart';

import 'package:transporter/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TransporterDataProvider()),
    ChangeNotifierProvider(create: (_) => FormValueProvider()),
    ChangeNotifierProvider(create: (_) => ChangePageProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
