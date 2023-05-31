import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:revista/Controllers/register_controller.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:shared_preferences/shared_preferences.dart';
register_Controller controller=Get.find();
Future<void> register(username, password,firstname,lastname,email,phonenumber,birthdate,gender,File profileImage) async {
  Map<String,String> body={'first_name': firstname,
    'last_name': lastname,
    "username": username,
    "email":email,
    'password': password,
    'phone_number':phonenumber,
    'birth_date':birthdate,
    'gender': gender,};
  var  request = http.MultipartRequest('POST', Uri.parse('http://$ip/auth/register/'))
    ..fields.addAll(body)
    ..files.add(await http.MultipartFile.fromPath('profile_image',profileImage.path));

  try {
    controller.isLoading.value=true;
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['token'];
      await saveTokens(accessToken); // Save the tokens to shared preferences
      Get.toNamed('/topic');
      print(response.body);
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  } on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    rethrow;
  } finally {
    controller.isLoading.value=false;
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
