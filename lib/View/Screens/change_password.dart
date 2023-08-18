import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../Controllers/settingsController.dart';

class Change_Password extends StatefulWidget{
  const Change_Password({Key? key}) : super(key: key);

  @override
  State<Change_Password> createState() => Change_Passwordstate();
}

class Change_Passwordstate extends State<Change_Password> {
  settingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(translator.translate("Change Password"),
              style:Theme.of(context).textTheme.headline1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        translator.translate("Your password should include a combination of number,letters and special characters \# \@\$\%"),
                      style: Theme.of(context).textTheme.bodyText1
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    GetX(
                      builder: (settingsController controller) => TextFormField(
                        controller: controller.currentPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.currentPasswordVis.value,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          labelText: translator.translate("Current Password"),
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.changeCurrentPasswordVis(),
                              icon: Icon(controller.currentPasswordVis.value
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                                color: Theme.of(context).primaryColor,)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return translator.translate("This field is required");
                          }
                          if (val.length <= 6) {
                            return translator.translate("PassWord is too short");
                          }
                        },
                        onSaved: (val) {
                          controller.currentPassword = val!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    GetX(
                      builder: (settingsController controller) => TextFormField(
                        controller: controller.newPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.newPasswordVis.value,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          labelText: translator.translate("New Password"),
                          suffixIcon: IconButton(
                              icon: Icon(controller.newPasswordVis.value
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () =>
                                  (controller).changeNewPasswordVis()),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return translator.translate("This field is required");
                          }
                          if (val.length <= 6) {
                            return translator.translate("PassWord is too short");
                          }
                          if (val ==
                              controller.currentPasswordController.text) {
                            return translator.translate("New password Should not be same as old Password");
                          }
                        },
                        onSaved: (val) {
                          controller.newPassword = val!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    GetX(
                      builder: (settingsController controller) => TextFormField(
                        controller: controller.re_typepasswordController,
                        obscureText: !controller.re_typePasswordVis.value,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          labelText: translator.translate("Re-type new Password"),
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.changeRe_typePasswordVis(),
                              icon: Icon(controller.re_typePasswordVis.value
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                                color: Theme.of(context).primaryColor,
                              )),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return translator.translate("This field is required");
                          }
                          if (val != controller.newPasswordController.text) {
                            return translator.translate("PassWord does not match");
                          }
                        },
                        onSaved: (val) {
                          controller.re_typePassword = val!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).primaryColor,
                        ),
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            controller.submitPassword();
                          },
                          child: Text(
                            translator.translate("Change Password"),
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ]),
            ),
          ),
        ));
  }
}
