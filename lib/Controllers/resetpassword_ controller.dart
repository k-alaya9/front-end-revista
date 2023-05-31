import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/apis/forgetpassword_api.dart';
import 'forget_password_controller.dart';

class resetPasswordController extends GetxController{

  RxBool visibility = false.obs;
  RxBool visibilityconfirm = false.obs;
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  RxBool onLoading = false.obs;
  String confirmPassword='';
  String newPassword='';
  final formKey=GlobalKey<FormState>();


  void switchVisibility() {
    visibility.value=!visibility.value;
    update();
  }
  void switchVisibilityConfirm() {
    visibilityconfirm.value=!visibilityconfirm.value;
    update();
  }
  void resetPasswordFunc(String password) async{
    final isValid=formKey.currentState!.validate();
    if(isValid){
      formKey.currentState!.save();
      try{
        forgetPasswordController controller=Get.find();
        resetPasswordApi(controller.id,password);
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