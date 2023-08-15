import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:revista/Models/following_model.dart';
import 'package:revista/Models/profile.dart';
import 'package:revista/Models/visitprofile.dart';
import 'package:revista/Services/apis/linking.dart';
import '../../Models/followmodel.dart';
import 'package:http/http.dart' as http;
Future<Profile>getProfileinfo(token) async {
  try{
    final response = await http.get(
        Uri.parse('http://$ip/my-profile/'),
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
Future<List<follow>>?getFollowersList(token)async{
  try{
    final response=await http.get(Uri.parse('http://$ip/followers-list/'), headers: {
      'Authorization':'Token $token'
    } );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
     final List<follow> users = data.map<follow>((e){
       return follow.fromJson(e);}).toList();
     return users;
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
}
Future<List<following>>?getFollowList(token)async{
  try{
    final response=await http.get(Uri.parse('http://$ip/following-list/'), headers: {
      'Authorization':'Token $token'
    } );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      final users = data.map<following>((e){
        return following.fromJson(e);}).toList();
      return users;
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
editbio(token,{bio})async{
  var map={
    'bio':bio
  };
  var jsonbody=json.encode(map);
  try{
   var response = await http.put(Uri.parse('http://$ip/my-profile/'),
     headers: {
       'Authorization':'Token $token',
       'Content-Type': 'application/json',
     },
     body: jsonbody
   );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      print('data');
      getProfileinfo(token);
    }
    else{
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
    
  }
  on SocketException catch(_){
    rethrow ;
  }

}
editprofile(token,{firstname,lastname,username,})async{
  var map1=
     {
      'first_name':firstname,
      'last_name':lastname,
      'username': username,
    }
  ;
  var jsonbody1=json.encode(map1);
  try{
    var response = await http.put(Uri.parse('http://$ip/auth/user-edit/'),
        headers: {
          'Authorization':'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonbody1
    );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      print('data');
      getProfileinfo(token);
    }
    else{
      print(response.body);
      throw Exception(response.reasonPhrase);
    }

  }
  on SocketException catch(_){
    rethrow ;
  }
}
editImage(token,{profileImage})async{
  var map={
  };
  var jsonbody=jsonEncode(map);
  try{
    var  request = http.MultipartRequest('PUT', Uri.parse('http://$ip/auth/user-edit/'))
    ..headers.addAll({'Authorization':'Token $token'})
      ..fields['json']=jsonbody
       ..files.add(await http.MultipartFile.fromPath('profile_image',profileImage.path,));
   var response = await http.Response.fromStream(await request.send());
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      print('data');
      getProfileinfo(token);
    }
    else{
      print(response.body);
      throw Exception(response.reasonPhrase);
    }

  }
  on SocketException catch(_){
    rethrow ;
  }
  finally{

  }
}
editImageCover(token,{coverImage})async{
  var map={
    'user': {
    },
  };
  var jsonbody=json.encode(map);
  try{
    var  request = http.MultipartRequest('PUT', Uri.parse('http://$ip/my-profile/'))
    ..headers.addAll({'Authorization':'Token $token'})
      ..fields['json']=jsonbody
      ..files.add(await http.MultipartFile.fromPath('cover_image',coverImage.path,));
   var response = await http.Response.fromStream(await request.send());
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      print('data');
      getProfileinfo(token);
    }
    else{
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
  on SocketException catch(_){
    rethrow ;
  }
  finally{

  }
}

fetchVisitorProfile (token,int profileId) async {
  final url = Uri.parse('http://$ip/profile/$profileId');
  final response = await http.get(url,
    headers: {
      'Authorization':'Token $token'
    }
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
    var map=visitprofile.fromJson(data);
    return map;
  } else {
    throw Exception('Failed to fetch visitor profile');
  }
}

 followUser(token,id) async {
  final url = 'http://$ip/follow/';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'followed': '$id',
      }),
    );

    if (response.statusCode == 201) {
      // Follow successful
      print('User followed successfully');
      var data=jsonDecode(response.body);
      return data['id'];
    } else {
      // Follow failed
      print('Failed to follow user');
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
  }
}
Future<void> unfollowUser(token,int followId) async {
  final url = 'http://$ip/unfollow/$followId';

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 204) {
      // Unfollow successful
      print('User unfollowed successfully');
    } else {
      // Unfollow failed
      print('Failed to unfollow user');
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
  }
}
blockUser(token,id)async{
  try{
    final response=await http.post(Uri.parse('http://$ip/block-user/'),
    headers: {
      'Authorization': 'Token $token'
        },
        body: {
          "blocked": '$id'
        }
    );
    if(response.statusCode==201){
      print('User Blocked Successfully');
      Get.back();
    }
    else{
      var data=json.decode(response.body);
      print(data);
    }
  }catch(e){
    throw e;
  }
}
userStatus(token,{isOnline})async{
  var map1=
  {
    "is_online": isOnline
  }
  ;
  var jsonbody1=json.encode(map1);
  try{
    var response = await http.put(Uri.parse('http://$ip/auth/user-edit/'),
        headers: {
          'Authorization':'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonbody1
    );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      print('data');
      getProfileinfo(token);
    }
    else{
      print(response.body);
      throw Exception(response.reasonPhrase);
    }

  }
  on SocketException catch(_){
    rethrow ;
  }
}