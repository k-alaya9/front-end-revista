import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:revista/Controllers/forget_password_controller.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:revista/View/Screens/forgetpasswordscreen.dart';

import '../../Controllers/resetpassword_ controller.dart';

forgetPasswordController controller =Get.find();
  forgetPasswordApi(String username,) async {
  try{
    print(username);
    controller.onLoading.value=true;
    final response = await http.post(
      Uri.parse('http://$ip/auth/forget-password/'),
      body: {'username': username,},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    controller.onLoading.value=false;
    rethrow;
  }
  finally{
    controller.onLoading.value=false;
  }
}
checkCode(int code,) async {
  try{
    print(code);
    controller.onLoadingDialog.value=true;
    final response = await http.post(
      Uri.parse('http://$ip/auth/check-code/'),
      body: {'code': '$code',},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    controller.onLoadingDialog.value=false;
    rethrow;
  }
  finally{
    controller.onLoadingDialog.value=false;
  }
}
resetPasswordController resetController=Get.find();
resetPasswordApi(int id, String password)async{
    try{
      print("$id\n$password");
      resetController.onLoading(true);
      final response=await http.post(Uri.parse('http://$ip/auth/reset-password/'),body: {
        'id':id,
        'password':password,
      });
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        print(data);
        Get.offAllNamed('/login');
      }else{
        throw Exception(response.reasonPhrase);
      }
    }
    on SocketException catch (_) {
      // make it explicit that a SocketException will be thrown if the network connection fails
      resetController.onLoading(false);

      rethrow;
    }
    finally{
      resetController.onLoading(false);

    }
}