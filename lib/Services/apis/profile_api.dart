
import 'dart:convert';
import 'dart:io';
import 'package:revista/Models/profile.dart';
import 'package:revista/Services/apis/linking.dart';
import '../../Models/topic.dart';
import 'package:http/http.dart' as http;
Future<Profile>getProfileinfo(token) async {
  try{
    final response = await http.get(
        Uri.parse('http://$ip/profile-edit/'),
        headers: {
          'Authorization': 'Token $token'
        }
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Profile map=Profile.fromJson(data);
      print(data);
      return map;
    } else {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    rethrow;
  }
  finally{
  }
}

getFollowList(token)async{
  try{
    final response=await http.get(Uri.parse('http://$ip/profile-edit/'), headers: {
      'Authorization':'Token $token'
    } );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
    }
    else{
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    rethrow;
  }
  finally{
  }
}
