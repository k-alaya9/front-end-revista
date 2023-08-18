import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:revista/Controllers/logincontroller.dart';
import 'package:revista/Services/apis/topic_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'GoogleSignInApi.dart';
import 'linking.dart';

LoginController controller=Get.find();
Future<void> login(String username, String password) async {
  try{
    controller.onLoading.value=true;
    final response = await http.post(
      Uri.parse('http://$ip/auth/login/'),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final accessToken = data['token'];
      final accessid = data['id'];
      print(accessid);
      await saveTokens(accessToken);// Save the tokens to shared preferences
      await saveid(accessid);
      final List  list=await getYourTopic(accessToken);
      print(list);
      if(list.isEmpty){
        print('hi');
        sharedPreferences!.setBool('topicsSelected',false);
        Get.offAllNamed('/topic');
      }
      else{
        print('bye');
        sharedPreferences!.setBool('topicsSelected',true);
        Get.offAllNamed('/home');
      }
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
loginWithGoogle()async{
  final user= await GoogleSignInApi.login();
  if(user==null){
    controller.showSnackBar('Login Failed');
  }else{
    await loginGoogle(user.displayName!, user.email, user.photoUrl!);
  }
}
Future<void> loginGoogle(String username, String email,String imageurl) async {
  var body=jsonEncode({
    'info':{'displayName': username, 'email': email,'photoUrl':imageurl
    }
  },);
  try{
    final response = await http.post(
      Uri.parse('http://$ip/auth/google-login/'),
      headers: {
        "Content-Type": "application/json"
      },
      body: body,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final accessToken = data['token'];
      final accessid = data['id'];
      print(accessid);
      await saveTokens(accessToken);// Save the tokens to shared preferences
      await saveid(accessid);
      final list=await getYourTopic(accessToken);
      if(list.isEmpty){
        sharedPreferences!.setBool('topicsSelected',false);
        Get.offAllNamed('/topic');
      }
      else{
        sharedPreferences!.setBool('topicsSelected',true);
        Get.offAllNamed('/home');
      }
    } else {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    rethrow;
  }
}
logout(token)async{
  try{
    print(token);
    final response = await http.post(
      Uri.parse('http://$ip/auth/logout/'),
      headers: {'Authorization':"token $token"}
    );
    if (response.statusCode == 204) {

      await deleteTokens();
      Get.offAllNamed('/login');
    } else {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
  catch(e){
    throw Exception(e);
  }
}
Future<void> saveTokens(String accessToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
}
Future<void> saveid(int accessid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('access_id', accessid);
}
Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  return accessToken;
}
Future<void> deleteTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  await prefs.remove('access_id');
}

