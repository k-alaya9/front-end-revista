import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Models/reply_model.dart';
import 'linking.dart';

getComment(token,commentId)async{
try{
  final response = await http.get(
    Uri.parse('http://$ip/posts/comment/$commentId/'),
    headers: {'Authorization': 'Token $token'},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    final Reply = reply.fromJson(data);
    return Reply;
  } else {
    final data = jsonDecode(response.body);
    print(data);
    throw Exception(response.reasonPhrase);
  }
}catch(e){
  print(e);
}
}

getReplysList(token,commentId)async{
  try {
    final response = await http.get(Uri.parse('http://$ip/posts/replies/$commentId/'),
        headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
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


newReply(int commentId, String content, String token,  ) async{
  final data = {'content': content};
  print(content);
  try {
    final response = await http.post(Uri.parse('http://$ip/posts/replies/$commentId/'),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',},
        body:jsonEncode(data) );

    if (response.statusCode == 201) {
      // Comment was successfully posted
      print('Reply posted successfully');
    } else {
      // Handle errors
      print('Failed to post reply: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Failed to post reply: $e');

  }


}