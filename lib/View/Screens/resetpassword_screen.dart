import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/resetpassword_ controller.dart';

class resetPassword extends StatelessWidget {
  resetPassword({Key? key}) : super(key: key);
  var _controller=Get.put(resetPasswordController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    resetPasswordController controller=Get.find();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text('Reset Password'),
          centerTitle: true,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 25, color: Colors.black),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor),
      body: Form(
        key: controller.formKey,
        child: Column(children: [
          Text(""),
          SizedBox(
            height: 5,
          ),
          GetX(
            builder: (resetPasswordController controller) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
              child: TextFormField(
                cursorColor: Theme.of(context).accentColor,
                controller: controller.newPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  suffixIcon: IconButton(
                      onPressed: controller.switchVisibility,
                      icon: controller.visibility.value
                          ? Icon(
                        Icons.visibility_off,
                        color: Theme.of(context).accentColor,
                      )
                          : Icon(
                        Icons.visibility,
                        color: Theme.of(context).accentColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(35)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  enabled: true,
                  hintText: 'Enter Your new password...',
                ),
                obscureText: !controller.visibility.value,
                validator: (val) {
                  if (val!.length < 8) {
                    return "Password is too short";
                  }
                  if (val.isEmpty) {
                    return ' this fields is required';
                  }
                },
                onSaved: (val) {
                  controller.newPassword = val!;
                },
              ),
            ),
          ),
          GetX(
            builder: (resetPasswordController controller) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
              child: TextFormField(
                cursorColor: Theme.of(context).accentColor,
                controller: controller.confirmPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  suffixIcon: IconButton(
                      onPressed:controller.switchVisibilityConfirm,
                      icon: controller.visibilityconfirm.value
                          ? Icon(
                        Icons.visibility_off,
                        color: Theme.of(context).accentColor,
                      )
                          : Icon(
                        Icons.visibility,
                        color: Theme.of(context).accentColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(35)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  enabled: true,
                  hintText: 'Confirm password..',
                ),
                obscureText: !controller.visibilityconfirm.value,
                validator: (val) {
                  if (val!.length < 8) {
                    return "Password is too short";
                  }
                  if (val.isEmpty) {
                    return ' this fields is required';
                  }
                  if(val!=controller.newPassword){
                    return "this password does not match";
                  }
                },
                onSaved: (val) {
                  controller.confirmPassword= val!;
                },
              ),
            ),
          ),

          GetX(builder: (resetPasswordController controller)=> Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 8),
            child: controller
                .onLoading.value
                ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
                : ElevatedButton(
              onPressed: () {
                controller.resetPasswordFunc(controller.newPassword,);
              },
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      const Color(0xff705DF2)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
              child: Text('Done',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          )),
        ]),
      ),
    );
  }
}
