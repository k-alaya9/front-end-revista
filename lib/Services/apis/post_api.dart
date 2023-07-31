import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../../Models/post.dart';
import 'linking.dart';
import 'package:http/http.dart' as http;

createPost({id, topics, text, link,File? image, token}) async {
  try {
    print(topics);
    Map<String, String> body = {
      'author': "$id",
      'content': "$text",
      'topics': '$topics',
      'link': "$link",
    };
    print('hi');
    var request;
    if(image!.path!=''){
      request=
      http.MultipartRequest('POST', Uri.parse('http://$ip/posts/'))
        ..headers.addAll({
          'Authorization': 'Token $token',
        })
        ..fields.addAll(body)..
      files.add(await http.MultipartFile.fromPath('image', image!.path));
    }
    else{
       request =
      http.MultipartRequest('POST', Uri.parse('http://$ip/posts/'))
        ..headers.addAll({
          'Authorization': 'Token $token',
        })
        ..fields.addAll(body);
    }
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print(data);
      Get.back();

    } else {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }
}

getPostsList(token) async {
  try {
    final response = await http.get(Uri.parse('http://$ip/posts/'),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final posts = data.map<post>((e) {
        return post.fromJson(e);
      }).toList();
      return posts;
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }
}
likePost(token,id) async {
  final url = 'http://$ip/posts/like/$id/';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      // Follow successful
      print('User liked post successfully');
      var data=jsonDecode(response.body);
      print(data);
      return data['id'];
    } else {
      // Follow failed
      print('Failed to like post');
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
  }
} unlikePost(token, Id) async {
  final url = 'http://$ip/posts/unlike/$Id/';

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 204) {
      // Unfollow successful
      print(' unlike successfully');
      return false;
    } else {
      // Unfollow failed
      print('Failed to unlike post');
      return true;
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
  }
}

savePost(token,id)async{
  final url = 'http://$ip/save/$id';
  try{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200){
      print('User saved post successfully');
      var data=jsonDecode(response.body);
      print(data);
      return data['id'];
    } else {
      // Follow failed
      print('Failed to like post');
    }

  }catch(e){
    print(e);
  }

}

Future<void> unSavedPost(token,id) async{
  final url='http://$ip/unsave/$id';
  try{
    final response=await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    if(response.statusCode == 200)
      {
        print('Unsaved Successfully');
      }else{
      print('Failed to unsaved post');
    }

  }catch(e){
    print(e);
  }

}