
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:revista/Services/apis/linking.dart';

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