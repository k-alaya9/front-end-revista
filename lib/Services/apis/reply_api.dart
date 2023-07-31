import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Models/reply_model.dart';
import 'linking.dart';
getReplysList(token)async{

  try {
    final response = await http.get(Uri.parse('http://$ip/replys/'),
        headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final replys = data.map<reply>((e) {
        return reply.fromJson(e);
      }).toList();
      return replys;
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }
}
