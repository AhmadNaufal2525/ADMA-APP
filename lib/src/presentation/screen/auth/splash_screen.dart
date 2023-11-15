import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sima_app/src/presentation/router/routes.dart';
import 'package:sima_app/src/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    var durasiSplash = const Duration(seconds: 2);
    return Timer(
      durasiSplash,
      () {
        Navigator.of(context).pushReplacementNamed(Routes.initScreen);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 240,
                  height: 240,
                ),
              ),
              if (isLoading)
                  CircularProgressIndicator(
                  color: AppColor.whiteColor,
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 36,
            child: Text(
              'Versi 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );

  }
}