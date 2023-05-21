import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:revista/Controllers/forget_password_controller.dart';
import 'package:revista/Controllers/resetpassword_%20controller.dart';

class forgetPassword extends StatelessWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(forgetPasswordController(), permanent: true);
    Get.put(resetPasswordController(),permanent: true);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          'Forgotten password',
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(fontSize: 25, color: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffF2E7FE),),
                child: Lottie.asset('asset/animations/113817-confidentiality.json', width: MediaQuery.of(context).size.width*0.6,
                  height: MediaQuery.of(context).size.width*0.6,
                  repeat: false
                  //fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.topLeft,
                child: Text('Trouble with logging in ?',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 30, color: Colors.black)),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Enter your Username and \n we'll send a code to reset your password",
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 240),
                child: Text(
                  'Username',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: GetBuilder<forgetPasswordController>(
                  init: forgetPasswordController(),
                  builder: (forgetPasswordController controller) => Form(
                    key: controller.formKey,
                    child: TextFormField(
                      controller: controller.usernameController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        suffixIcon:
                            controller.usernameController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () => controller.clearUsername(),
                                    icon: Icon(
                                      Icons.close,
                                      color: Theme.of(context).accentColor,
                                    ))
                                : null,
                        hintText: 'Enter Your Username...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey.shade500),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        focusColor: Theme.of(context).primaryColor,
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Your Username";
                        } else if (val.length < 4) {
                          return "Please Enter a Valid Username";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        controller.username = val!;
                      },
                    ),
                  ),
                ),
              ),
              GetX<forgetPasswordController>(
                builder: (forgetPasswordController controller) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 8),
                  child: controller.onLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            controller.submitFunc(
                              controller.username,
                            );
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff705DF2)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                          child: Text('Next',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

