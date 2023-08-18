import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:revista/main.dart';

import '../../Models/live.dart';
import 'linking.dart';

createLive({text,description, token}) async {
  try
  {
    var map={
      "title":text,
      "description":description
    };
    var body=jsonEncode(map);
    var response=await http.post(Uri.parse('http://$ip/live/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':'Token $token'
        },
        body: body
    );
    if(response.statusCode==201){
      var data=jsonDecode(response.body);
      print(data);
      return data['id'];
    }
    else{
      var data=jsonDecode(response.body);
      print(data);
    }
  }
  catch(e){
    print(e);
    rethrow ;
  }
}
getLives(token)async{
  try {
    final response = await http.get(Uri.parse('http://$ip/live/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final posts = data.map<live>((e) {
        return live.fromJson(e);
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
deleteLive(token,id)async{
  try{
    final response=await http.delete(Uri.parse('http://$ip/live/close/$id'),
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