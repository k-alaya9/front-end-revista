import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:revista/Models/savedPost.dart';
import '../../Models/post.dart';
import 'linking.dart';
import 'package:http/http.dart' as http;

createPost({id, topics, text, link,File? image, token}) async {
  try {
    print(topics);
    Map<String,String> body = {
      'author': id,
      'content': text,
      'topics':topics,
      'link': link
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
      // request = jsonToFormData(request, body);

    }
    else{
       request =
      http.MultipartRequest('POST', Uri.parse('http://$ip/posts/'))
         ..headers.addAll({
          'Authorization': 'Token $token',
        })..fields.addAll(body);
       // request = jsonToFormData(request, body);
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
editPost({id, topics, text, link,File? image, token,postId}) async {
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
      http.MultipartRequest('PATCH', Uri.parse('http://$ip/posts/post/$postId/'))
        ..headers.addAll({
          'Authorization': 'Token $token',
        })
        ..fields.addAll(body)..
      files.add(await http.MultipartFile.fromPath('image', image!.path));
    }
    else{
      request =
      http.MultipartRequest('PATCH', Uri.parse('http://$ip/posts/post/$postId/'))
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

getUserPosts(token,id)async{
  try {
    final response = await http.get(Uri.parse('http://$ip/posts/timeline/$id/'),
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
getMyPosts(token)async{
  try {
  final response = await http.get(Uri.parse('http://$ip/posts/timeline/'),
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
getMySavedPosts(token)async{
  try {
    final response = await http.get(Uri.parse('http://$ip/posts/saved-posts/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final posts = data.map<savedPost>((e) {
        return savedPost.fromJson(e);
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
}
unlikePost(token, Id) async {
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
  final url = 'http://$ip/posts/save-post/$id/';
  try{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 201){
      print('User saved post successfully');
      var data=jsonDecode(response.body);
      print(data);
      return data['id'];
    } else {
      // Follow failed
      print(jsonDecode(response.body));
      print('Failed to save post');
    }

  }catch(e){
    print(e);
  }

}

 unSavedPost(token,id) async{
  final url='http://$ip/posts/saved-post/$id/';
  try{
    final response=await http.delete(Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    if(response.statusCode == 204)
      {
        print('Unsaved Successfully');
        return false;
      }else{
      print('Failed to unsaved post');
      return true;
    }

  }catch(e){
    print(e);
  }

}
getDiscoverList(token,id)async{
  try {
    final response = await http.get(Uri.parse("http://$ip/posts/discover/$id/"),
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
DeleteMyPosts(token,id)async{
  try{
    final response=await http.delete(Uri.parse('http://$ip/posts/post/$id/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },);
    if (response.statusCode == 204) {
      final data = jsonDecode(response.body);
      print('done');
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  }catch(e){
    print(e);
  }
}
jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}