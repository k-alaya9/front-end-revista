import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revista/Models/searchModel.dart';

import '../../Models/hestoryModel.dart';
import 'linking.dart';

getHestoryList(token)async{
  try{
    final response=await http.get(Uri.parse('http://$ip/posts/search-history/'),headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },);
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      final history = data.map<hestory>((e) {
        return hestory.fromJson(e);
      }).toList();
      return history;
    }
    
  }catch(e){
    print('error :$e');
  }
}
addHistory(token,username)async{
  final url = 'http://$ip/posts/add-history/';
print(username);
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },body:jsonEncode({
      'searched_username':username
    })
    );

    if (response.statusCode == 201) {
      // Follow successful
      print('User added  successfully');
      var data=jsonDecode(response.body);
      print(data);
    } else {
      // Follow failed
      print('Failed to added');
    }
  } catch (error) {
    // Handle error
    print('Error: $error');
  }
}
getSearchList(token,query)async {
  try {
    final response = await http.get(Uri.parse('http://$ip/posts/search/?username=$query'), headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final result = data.map<search>((e) {
        return search.fromJson(e);
      }).toList();
      print(result);
      return result;
    }
  }
  catch (e) {
    print('error :$e');
  }
}