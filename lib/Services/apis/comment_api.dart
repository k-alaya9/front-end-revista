import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../../Models/comment_model.dart';
import '../../Models/post.dart';
import 'linking.dart';
import 'package:http/http.dart' as http;

getPost(token, postId) async {
  try {
    print('hi');
    final response = await http.get(
      Uri.parse('http://$ip/posts/post/$postId/'),
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final Post = post.fromJson(data);
      return Post;
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }
}
getCommentsList(token,postId)async{

  try {
    final response = await http.get(Uri.parse('http://$ip/posts/comments/$postId'),
        headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final comments = data.map<comment>((e) {
        return comment.fromJson(e);
      }).toList();
      return comments;
    } else {
      final data = jsonDecode(response.body);
      print(data);
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
  }
}

newComment(int postId, String content, String token,  ) async{
  final data = {'content': content};
  print(content);
  try {
    final response = await http.post(Uri.parse('http://$ip/posts/comments/$postId/'),
        headers: {
      'Authorization': 'Token $token',
          'Content-Type': 'application/json',},
        body:jsonEncode(data) );

    if (response.statusCode == 201) {
      // Comment was successfully posted
      print('Comment posted successfully');
    } else {
      // Handle errors
      print('Failed to post comment: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Failed to post comment: $e');

  }}
  deleteMyComment(token,postId)async{

    try{
      final response=await http.delete(Uri.parse('http://$ip/posts/comments/$postId/'),
          headers: {'Authorization': 'Token $token'});

      if (response.statusCode == 204) {
        final data = jsonDecode(response.body);
        print(data);
        final comments = data.map<comment>((e) {
          return comment.fromJson(e);
        }).toList();
        return comments;
      } else {
        final data = jsonDecode(response.body);
        print(data);
        throw Exception(response.reasonPhrase);
      }

    }catch(e){
      print(e);
    }
  }
