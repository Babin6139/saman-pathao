import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/providers/transporterDataProvider.dart';

import 'package:transporter/route_generator.dart';

void main() async {
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TransporterDataProvider()),
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
