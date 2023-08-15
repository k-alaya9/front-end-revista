import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/main.dart';

import '../Models/block.dart';
import '../Services/apis/linking.dart';
import '../Services/apis/settings_api.dart';

class settingsController extends GetxController{
  var onLoadingDialog=false.obs;
  var currentPasswordVis=false.obs;
  var newPasswordVis=false.obs;
  var re_typePasswordVis=false.obs;
  final formKey = GlobalKey<FormState>();
  var currentPasswordController=TextEditingController();
  var newPasswordController=TextEditingController();
  var re_typepasswordController=TextEditingController();
  var currentPassword;
  var newPassword;
  var re_typePassword;
  changeCurrentPasswordVis(){
    currentPasswordVis.value=!currentPasswordVis.value;
  }
  changeNewPasswordVis(){
    newPasswordVis.value=!newPasswordVis.value;
  }
  changeRe_typePasswordVis(){
    re_typePasswordVis.value=!re_typePasswordVis.value;
  }
  submitPassword()async {
    print('out');
    if(formKey.currentState!.validate()==true){
      formKey.currentState!.save();
      print('hi');
      String apiUrl = 'http://$ip/auth/change-password/';
      String? authToken = sharedPreferences!.getString('access_token');
      Map<String, dynamic> requestData = {
        'old_password': currentPassword,
        'new_password': newPassword,
      };
      await changePassword(apiUrl,requestData,authToken!);
    }
  }
  var userNameEmail;
  var newEmail;
  var userNameEmailController=TextEditingController();
  var newEmailController=TextEditingController();
  final emailKey = GlobalKey<FormState>();
  submitEmail()async{
    if(emailKey.currentState!.validate()==true){
      emailKey.currentState!.save();
      final token=sharedPreferences!.getString('access_token');
      var data=await changeEmail(token,userNameEmail,newEmail);
      print(data);
      var id=data['id'];
      var email=data['email'];
      final codeKey = GlobalKey<FormState>();
      TextEditingController codeController = TextEditingController();
      int code = 0;
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Enter confirmation code',style: Theme.of(context).textTheme.headline1 ),
              content: Column(
                children: [
                  Text('Enter the 6-digit change code we sent to $email',style: Theme.of(context).textTheme.headline1),
                  Form(
                    key: codeKey,
                    child: TextFormField(
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
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
              actions:[GetX<settingsController>(
                builder: (settingsController controller) {
                  return Container(
                    width: double.infinity,
                    child: controller.onLoadingDialog.value
                        ? const CupertinoActivityIndicator()
                        : ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),elevation: MaterialStateProperty.all(0)),
                        onPressed: () async {
                          try {
                            final isValid =
                            codeKey.currentState!.validate();
                            if (isValid) {
                              codeKey.currentState!.save();
                              await checkCode(code,token);
                              await resetEmail(id, email,token);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Done')),
                  );
                },
              ),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('cancel',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).accentColor),))
              ],
            );});
    }
  }

 RxList<block> blockList=<block>[].obs;
  fetchData() async {
    try {
      final List<block> data;
      final token =sharedPreferences!.getString('access_token');
      data = await getMyBlockList(token);
      if ( blockList!= data){
        blockList.assignAll(data);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}