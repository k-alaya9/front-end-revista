import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/View/Screens/loginscreen.dart';

import '../../main.dart';
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
        if(sharedPreferences!.getBool('firstTimer')==false){
          if(sharedPreferences!.getString('access_token')==null)
          Get.offAll(()=>login());
          else{
            Get.offAllNamed('/home');
          }
        }
        else{
          Get.offAll(()=>OnBordingScreen());

        }
          },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(

      child: Padding(
        padding: const EdgeInsets.all(150.0),
        child: Image(image: AssetImage('asset/image/logo.png'),),
      ),


      ),
    );
  }
}
