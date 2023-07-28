import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../Models/chatModel.dart';
import 'linking.dart';

newChat(token,id)async{
  try{
    final response= await http.get(Uri.parse('http://$ip/chat/user/$id'),
      headers: {
      'Authorization':'token $token'
      }
    );
    if(response.statusCode==201){
      var data=jsonDecode(response.body);
      id=data['chat_id'];
      Get.toNamed('/chatScreen',arguments: {
      'chat_id': id,
      });
    }
  }catch(e){

  }
}

getChats(token)async{
  try {
    final response = await http.get(Uri.parse('http://$ip/chat/contact/'),
        headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final chats = data.map<chat>((e) {
        return chat.fromJson(e);
      }).toList();
      return chats;
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }
}