import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/logincontroller.dart';
import 'package:revista/Services/apis/login_api.dart';
import 'package:revista/View/Screens/register_screen.dart';
import 'package:revista/View/Widgets/bottomsheetwidget.dart';

import '../../Controllers/register_controller.dart';

class login extends StatelessWidget {
   login({Key? key}) : super(key: key);
  var controller=Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Get.put(register_Controller());
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('asset/image/post.png',fit: BoxFit.cover,height: MediaQuery.of(context).size.height*0.50),
              const SizedBox(height: 10,),
              Text('Welcome Back!',
                  style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Get.bottomSheet(
                      bottomSheet(),
                      elevation: 10,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      backgroundColor: Theme.of(context).backgroundColor,
                    enterBottomSheetDuration: const  Duration(seconds: 1),
                    exitBottomSheetDuration: const Duration(seconds: 1),
                  );

                },
                elevation: 0,
                animationDuration: const Duration(seconds: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Theme.of(context).accentColor,
                height: 40,
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Login with username and password',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                          color: Colors.white,
                          indent: 80,
                        )),
                    Text(
                      'OR',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Expanded(
                        child: Divider(
                          color: Colors.white,
                          endIndent: 80,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 220,
                child: MaterialButton(
                  onPressed: (){
                    loginWithGoogle();
                  },
                  elevation: 0,
                  animationDuration: const Duration(seconds: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: Colors.white,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Image.asset('asset/image/Google.png', scale: 3),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('Login with Google',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),)
                  ]),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //Divider(color: Colors.white,indent: 70,endIndent: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: Theme.of(context).textTheme.bodyText1,),
                  TextButton(
                      onPressed: () {
                        Get.bottomSheet(
                          Register(),

                          backgroundColor: Theme.of(context).backgroundColor,
                          elevation: 10,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              )),
                          enterBottomSheetDuration: const  Duration(seconds: 1),
                          exitBottomSheetDuration: const Duration(seconds: 1),
                        );
                      },
                      style: ButtonStyle(
                          animationDuration: Duration(seconds: 1),
                          elevation: MaterialStateProperty.all(0),
                          splashFactory: NoSplash.splashFactory),
                      child: Text(
                        'Create one!',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).accentColor,decoration: TextDecoration.underline),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}