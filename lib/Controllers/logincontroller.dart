import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/login_api.dart';

class LoginController extends GetxController {
  RxBool visibility = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool onLoading = false.obs;
  String username='';
  String password='';
  final formKey=GlobalKey<FormState>();

  void clearUsername(){
    usernameController.clear();
    update();
  }

  void switchVisibility() {
    visibility.value = !visibility.value;
    update();
  }

  void submitFunc(String username, String password) async{
    final isValid=formKey.currentState!.validate();
    if(isValid){
      formKey.currentState!.save();
      try {
        print(username);
        print(password);
        await login(username, password);
      } catch (e) {
        showSnackBar(e);
      }
    }
  }
  void showSnackBar(var e){
    Get.showSnackbar(GetSnackBar(
      borderRadius: 20,
      icon: const Icon(Icons.warning_amber_rounded,color: Colors.white,),
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
