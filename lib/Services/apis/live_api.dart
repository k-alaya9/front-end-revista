import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:revista/main.dart';

import 'linking.dart';

createLiveid()async{
  final token=sharedPreferences!.getString('access_token');
  try{
    final response =await http.get(Uri.parse('http://$ip/live/'),
    headers: {
      'Authorization': 'Token $token'}
    );
    if(response.statusCode==201){
      var data=jsonDecode(response.body);
      return data['live_id'];
    }
    else{
      print(jsonDecode(response.body));
    }
  }catch(e){
    print(e);
  }
}