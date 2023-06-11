import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Services/apis/register_api.dart';

class register_Controller extends GetxController {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  RxBool isMale = false.obs;
  RxBool isFemale = false.obs;
  String firstname = '';
  String lastname = '';
  String username = '';
  String email = '';
  String password = '';
  String confpassword = '';
  String phonenumber = '';
  RxBool isChecked = false.obs;
  RxBool visibility = false.obs;
  RxBool visibilityConfirm = false.obs;
  Rx<DateTime> SelectedDate = DateTime.now().obs;
  RxBool isLoading=false.obs;
  final formKey = GlobalKey<FormState>();
  late PickedFile imageFile;

  final ImagePicker picker = ImagePicker();
  Rx<File>? fileImage = File('asset/image/blank_profile_picture.png').obs;

  void takePhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      fileImage!.value = File(pickedFile.path);
    }
  }

  selectDate() async {
    final DateTime? datepicked = await showDatePicker(
      context: Get.context!,
      initialDate: SelectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2500),
    );
    if (datepicked != null && SelectedDate.value != datepicked) {
      SelectedDate.value = datepicked;
    }
  }

  void switchVisibility() {
    visibility.value = !visibility.value;
    update();
  }

  void switchVisibilityConfirm() {
    visibilityConfirm.value = !visibilityConfirm.value;
    update();
  }

  void gitPhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fileImage!.value = File(pickedFile.path);
    }
  }

  void submitRegister() {
    if (isChecked.value) {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        try{
          register(
              username,
              password,
              firstname,
              lastname,
              email,
              phonenumber,
              SelectedDate.value==DateTime.now()?'':DateFormat('y-MM-dd').format(SelectedDate.value).toString(),
              isMale.value?'M':isFemale.value?'F':'',
              fileImage!.value
          );
        }
        catch(e){
          showSnackBar(e);
        }
      }
    } else {
      showSnackBar("please approve our terms");
    }
  }

  switchGenderMale() {
    isMale.value = !isMale.value;
    isFemale.value = false;
  }

  switchGenderFemale() {
    isFemale.value = !isFemale.value;
    isMale.value = false;
  }

  Check(val) {
    isChecked.value = val;
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
  deletePhoto(){
    fileImage!.value = File('asset/image/blank_profile_picture.png');
  }
}
