import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';
import 'package:revista/View/Screens/forgetpasswordscreen.dart';

import '../View/Screens/resetpassword_screen.dart';

class forgetPasswordController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String username = '';
  RxBool onLoading = false.obs;
  RxBool onLoadingDialog = false.obs;
  int id = 0;
  String email = '';
  final formKey = GlobalKey<FormState>();
  final codeKey = GlobalKey<FormState>();

  clearUsername() {
    usernameController.clear();
    update();
  }

  void submitFunc(String username) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        var data= await forgetPasswordApi(username);
        id=data['id'];
        email=data['email'];
        int code = 0;
        showCupertinoDialog(
            context: Get.context!,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('Enter confirmation code',style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black)),
                content: Column(
                  children: [
                    Text('Enter the 6-digit login code we sent to $email',style: Theme.of(context).textTheme.headline1),
                    Form(
                      key: codeKey,
                      child: TextFormField(
                        cursorColor: Color(0xff705DF2),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff705DF2))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff705DF2))),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff705DF2))),
                        ),
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        controller: codeController,
                        validator: (val) {
                          if (val!.length < 6) {
                            return "code is too short";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          code = int.parse(val!);
                        },
                      ),
                    ),
                  ],
                ),
                actions:[GetX<forgetPasswordController>(
                  builder: (forgetPasswordController controller) {
                    return Container(
                      width: double.infinity,
                      child: controller.onLoadingDialog.value
                          ? const CupertinoActivityIndicator()
                          : ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff705DF2)),elevation: MaterialStateProperty.all(0)),
                          onPressed: () async {
                            try {
                              final isValid =
                              codeKey.currentState!.validate();
                              if (isValid) {
                                codeKey.currentState!.save();
                                await checkCode(code);
                                Get.offAllNamed('/resetpass');
                              }
                            } catch (e) {
                              showSnackBar(e);
                            }
                          },
                          child: Text('Next')),
                    );
                  },
                ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('cancel',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),))
                ],
              );});
        // await login(username, password);
      } catch (e) {
        showSnackBar(e);
      }
    }
  }

  void showSnackBar(var e) {
    Get.showSnackbar(GetSnackBar(
      borderRadius: 20,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.white,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.all(10),
      messageText: Text(e.toString()),
    ));
  }
}

