import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:revista/Controllers/logincontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

LoginController controller=Get.find();
Future<void> login(String username, String password) async {
  try{
    controller.onLoading.value=true;
    final response = await http.post(
      Uri.parse('http://192.168.43.231:9000/accounts/login/'),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      final refreshToken = data['refresh_token'];
      await saveTokens(accessToken, refreshToken); // Save the tokens to shared preferences
    } else {
      print(response.body);
      throw Exception(response.body);
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

Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  return accessToken;
}

Future<String?> getRefreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token');
  return refreshToken;
}

Future<void> saveTokens(String accessToken, String refreshToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
  await prefs.setString('refresh_token', refreshToken);
}

Future<void> deleteTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  await prefs.remove('refresh_token');
}

Future<void> refreshTokens() async {
  final accessToken = await getAccessToken();
  final refreshToken = await getRefreshToken();
  final response = await http.post(
    Uri.parse('http://your-api-url.com/refresh-tokens/'),
    headers: {'Authorization': 'Bearer $accessToken'},
    body: {'refresh_token': refreshToken},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newAccessToken = data['access_token'];
    final newRefreshToken = data['refresh_token'];
    await saveTokens(newAccessToken, newRefreshToken); // Save the new tokens to shared preferences
  } else {
    throw Exception('Failed to refresh tokens');
  }
}

void startTimer(Duration duration) {
  Timer.periodic(duration, (_) async {
    final accessToken = await getAccessToken();
    if (accessToken != null) {
      // Get the token expiration time
      final parts = accessToken.split('.');
      final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      // Refresh the tokens if the access token is expired or about to expire
      if (expirationTime.difference(DateTime.now()) < Duration(minutes: 5)) {
        await refreshTokens();
      }
    }
  });
}
