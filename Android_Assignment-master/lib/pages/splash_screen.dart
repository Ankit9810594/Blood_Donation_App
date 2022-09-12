import 'dart:async';

import 'package:blood_donation/app_data/app_data.dart';
import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/pages/login_screen.dart';
import 'package:blood_donation/response/auth_response.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({Key? key}) : super(key: key);

  @override
  _SplashSCreenState createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  @override
  void initState() {
    super.initState();
    checkIfUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                "assets/icons/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      )),
    );
  }

  Future<void> checkIfUserLoggedIn() async {
    Timer(
        const Duration(seconds: 3),
        () => UserPreferences.getUserId() == null
            ? Constant.moveToNextUntil(context, const LoginScreen())
            : Constant.moveToNextUntil(context, const HomeScreen()));
  }
}
