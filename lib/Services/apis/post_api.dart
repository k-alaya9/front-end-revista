import 'dart:convert';

import '../../Models/post.dart';
import 'linking.dart';
import 'package:http/http.dart' as http;

createPost({id, topics, text, link, image, token}) async {
  try {
    Map<String, String> body = {
      'author': id,
      'content': text,
      'topics': topics,
      'link': link,
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('http://$ip/posts/list-posts/'))
          ..headers.addAll({
            'Authorization': token,
          })
          ..fields.addAll(body)
          ..files.add(await http.MultipartFile.fromPath('image', image));
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print(data);
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
    final response = await http.get(Uri.parse('http://$ip/posts/list-posts/'),
        headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
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

