import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_application_5/const.dart';
import 'package:flutter_application_5/helpers/hive_helper.dart';
import 'package:flutter_application_5/main/main_screen.dart';
import 'package:flutter_application_5/onboarding/onboarding_screen.dart';

import '../auth/screen/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color _color = Color(0xFF40AA54);
  int imageNum = 1;

  void _changeTheme() {
    if (imageNum == 1) {
      _color = Colors.white;
      imageNum = 2;
    } else {
      _color = Color(0xFF40AA54);
      imageNum = 1;
    }

    setState(() {});
  }

  @override
  void initState() {
    const oneSec = Duration(seconds: 1);
    var time = Timer.periodic(oneSec, (Timer t) => _changeTheme());
    Future.delayed(Duration(seconds: 4)).then((val) {
      time.cancel();
      if (HiveHelper.checkOnBoardingValue()) {
        if (HiveHelper.getToken() != null) {
          Get.offAll(MainScreen());
        } else {
          Get.offAll(AuthScreen());
        }
      } else {
        Get.offAll(OnboardingScreen());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Center(
        child: Container(
          height: 70,
          width: 280,
          child: Image.asset(
            imagePath + "logo$imageNum.png",
          ),
        ),
      ),
    );
  }
}
