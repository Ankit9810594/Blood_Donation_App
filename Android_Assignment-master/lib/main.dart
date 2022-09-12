import 'package:blood_donation/pages/splash_screen.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Donation',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const SplashSCreen());
  }
}
