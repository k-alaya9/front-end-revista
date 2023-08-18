import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 5),
          () {
        Get.to(OnBordingScreen());
          },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(

      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Image(image: AssetImage('asset/image/logo.png'),),
      ),


      ),
    );
  }
}
