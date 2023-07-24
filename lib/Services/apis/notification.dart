import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:revista/Models/notfications_model.dart';

import 'linking.dart';

notificationList(String token) async {
  try{

    final response = await http.get(
        Uri.parse('http://$ip/notifications/list'),
        headers: {
          'Authorization':'Token $token'

        }
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final List<notification> users = data.map<notification>((e){
        print(e);
        return notification.fromJson(e);}).toList();
      return users;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    rethrow;
  }
}