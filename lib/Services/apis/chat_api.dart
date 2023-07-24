import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

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
      print(data);
      id=data['chat_id'];
      print(id);
      Get.toNamed('/chatScreen',arguments: {
      'chat_id': id,
      });
    }
  }catch(e){

  }
}