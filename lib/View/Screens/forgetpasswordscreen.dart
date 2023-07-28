import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:revista/Controllers/forget_password_controller.dart';
import 'package:revista/Controllers/resetpassword_%20controller.dart';

class forgetPassword extends StatelessWidget {
   forgetPassword({Key? key}) : super(key: key);
  var _controller=Get.put(forgetPasswordController(),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Get.isDarkMode?Colors.white:Colors.black,)),
        title: const Text(
          'Forgotten password',
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF2E7FE),),
                  child: Lottie.asset('asset/animations/113817-confidentiality.json', width: MediaQuery.of(context).size.width*0.6,
                    filterQuality: FilterQuality.high,
                    animate: true,
                    height: MediaQuery.of(context).size.width*0.6,
                    repeat: false
                    //fit: BoxFit.fill,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('Trouble with logging in ?',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 30, )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Enter your Username and \n we'll send a code to reset your password",
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Username',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15),
                  child: GetBuilder<forgetPasswordController>(
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: controller.onLoading.value
                        ? Center(
                            child: CupertinoActivityIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              controller.submitFunc(
                              );
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
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
      ),
    );
  }
}

