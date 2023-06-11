import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:revista/Controllers/logincontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      Get.offAllNamed('/home');
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
Future<String> authenticateWithGoogle(String googleAccessToken) async {
  final response = await http.post(
    Uri.parse('http://$ip/account/google/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id_token': googleAccessToken,
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    Get.offAllNamed('/home');
    return jsonResponse['token'];
  } else {
    print(response.body);
    controller.showSnackBar(Exception('Failed to authenticate with Google'));
    throw Exception('Failed to authenticate with Google');
  }
}
loginWithGoogle()async{
  final user= await GoogleSignInApi.login();
  if(user==null){
    controller.showSnackBar('Login Failed');
  }else{

    final token =await user.authentication.then((value) => value.idToken);
    print(token);
    saveTokens(token!);
    authenticateWithGoogle(token.toString());

  }
}
Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  return accessToken;
}


Future<void> saveTokens(String accessToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
}
Future<void> saveid(int accessid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('access_id', accessid);
}

Future<void> deleteTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
}

