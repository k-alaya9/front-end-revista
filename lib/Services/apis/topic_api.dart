
import 'dart:convert';
import 'dart:io';
import "package:collection/collection.dart";
import 'package:get/get.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:revista/main.dart';
import '../../Models/topic.dart';
import '../../Controllers/topicsController.dart';
import 'package:http/http.dart' as http;
TopicController controller=Get.find();
Future<List>getTopicsList(token) async {
  print('hi');
  try{
    controller.onLoading.value=true;
    print('hi');
    final response = await http.get(
      Uri.parse('http://$ip/topics/'),
      headers: {
        'Authorization':'Token $token'
      }
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data.map((e)=>topicItem.fromJson(e)).toList();
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
Future<List>getTopicsListPost(token) async {
  print('hi');
  try{
    print('hi');
    final response = await http.get(
        Uri.parse('http://$ip/topics/'),
        headers: {
          'Authorization':'Token $token'
        }
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data.map((e)=>topicItem.fromJson(e)).toList();
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    rethrow;
  }
  finally{
  }
}
getYourTopic(token)async{
  try{
    final response = await http.get(
        Uri.parse('http://$ip/topics-follow/'),
        headers: {
          'Authorization':'Token $token'
        }
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      var map=data.map((e)=>e).toList();
      return map;
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
sendTopicList(String token, List topicList)async{
  try{
    controller.onLoading.value=true;
    final response = await http.post(
        Uri.parse('http://$ip/topics-follow/'),
        headers: {
          'Authorization':'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
        },
      body: jsonEncode(topicList),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      controller.topicsSelected.value=true;
      sharedPreferences!.setBool('topicsSelected',controller.topicsSelected.value);
      controller.selecteditems.clear();
      Get.offAllNamed('/home');
      print(data);
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
unFollowTopics(token,id)async{
try{
  print(id);
  final response=await http.delete(Uri.parse('http://$ip/topics-unfollow/$id',),
  headers: {
    'Authorization':'Token $token',
    'Content-Type': 'application/json'
  });
  if(response.statusCode==204){
    print('unfollowed!');
    return false;
  }
  else{
    print('failed');
    return true;
  }
}catch(e){
  print(e);
}
}
followTopics(token,id)async{
  var map={
    'topic':id
  };
  try{
    final response=await http.post(Uri.parse('http://$ip/topics-follow/'),
        headers: {
          'Authorization':'Token $token',
          'Content-Type': 'application/json'
        },
      body: jsonEncode(map));
    if(response.statusCode==201){
      var data=jsonDecode(response.body);
      print(data);
      print('followed!');
      print(data['id']);
      return data['id'];
    }
    else{
      print('failed');
    }
  }catch(e){
    print(e);
  }
}