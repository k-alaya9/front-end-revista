import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:revista/Controllers/settingsController.dart';
import 'package:revista/Models/block.dart';

import '../../View/Screens/settings.dart';
import 'linking.dart';
import 'login_api.dart';
changePassword(String url, Map<String, dynamic> data, String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };

  var jsonData = jsonEncode(data);

  try {
    var response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonData,
    );
    if(response.statusCode==200){
      print('password changed successfully');
    }
    else{
      print(response.statusCode);
      print(jsonDecode(response.body));
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

changeEmail(token,username,email)async{
  var map={
    'username':username,
    'email':email,
  };
  var json=jsonEncode(map);
  try {
    var response = await http.post(
      Uri.parse('http://$ip/auth/change-email/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      } ,
      body: json,
    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
     return data ;
    }
    else{
      print(response.statusCode);
      print(jsonDecode(response.body));
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

checkCode(int code,token) async {
  settingsController controller=Get.find();
  try{
    print(code);
    controller.onLoadingDialog.value=true;
    final response = await http.post(
      Uri.parse('http://$ip/auth/check-email-code/'),
      headers: {
        'Authorization': 'Token $token',
      } ,
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
resetEmail(int id, String email,token)async{
  try{
   var map= {
      'id':id,
  'email':email,
  };
   var json=jsonEncode(map);
    final response=await http.post(Uri.parse('http://$ip/auth/reset-email/'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    } ,body:json );
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      print(data);
      Get.offAll(Settings());
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails

    rethrow;
  }

}
unblock(token, Id) async {
  final url = 'http://$ip/unblock-user/$Id/';

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 204) {
      // Unfollow successful
      print(' unblock successfully');
      Get.back();
      return false;
    } else {
      // Unfollow failed
      print('Failed to unlike post');
      return true;
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
  }
}
getMyBlockList(token)async{
  try {
    final response = await http.get(Uri.parse('http://$ip/block-list/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final posts = data.map<block>((e) {
        return block.fromJson(e);
      }).toList();
      return posts;
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }

}
deactiveAccount(token,)async{
  try {
    var response = await http.patch(
      Uri.parse('http://$ip/auth/deactivate-account/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      } ,
    );
    if(response.statusCode==200){
     await deleteTokens();
      Get.offAllNamed('/login');
    }
    else{
      print(response.statusCode);
      print(jsonDecode(response.body));
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
