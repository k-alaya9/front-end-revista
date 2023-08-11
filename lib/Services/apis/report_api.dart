import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:revista/Services/apis/linking.dart';

createReport({type,category,userId,token,description,reported_chat,reported_post})async{
  print(description);
 var body;
 if(description!=null&&description!=''){
   if(type=='post'){
     body={
       'type':'$type',
       'category':'$category',
       'description':'$description',
       'reported_post':'$reported_post'
     };
   }
   else if(type=='chat'){
     body={
       'type':'$type',
       'category':'$category',
       'description':'$description',
       'reported_chat':'$reported_chat'
     };
   }
   else if(type=='user'){
     body= {
       'type':'$type',
       'category':'$category',
       'reported_user':'$userId',
       'description':'$description',
     };
   }
 }else{
   if(type=='post'){
     body={
       'type':'$type',
       'category':'$category',
       'reported_post':'$reported_post'
     };
   }
   else if(type=='chat'){
     body={
       'type':'$type',
       'category':'$category',
       'reported_chat':'$reported_chat'
     };
   }
   else if(type=='user'){
     body= {
       'type':'$type',
       'category':'$category',
       'reported_user':'$userId',
     };
   }
 }
 print(body);
 var json=jsonEncode(body);
  try{
    final response=await http.post(Uri.parse('http://$ip/report-app/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json,
    );
    if(response.statusCode==201){
      print('reported succsefully');
      Get.back();
      Get.showSnackbar(GetSnackBar(
        icon: Icon(Icons.check_circle),
        title: 'Your reported will be review',
      ));
    }
    else{
      print('failed to report');
    }
  }
  catch(e){
    throw(e);
  }
}