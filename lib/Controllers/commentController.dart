import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/comment_model.dart';
import '../Models/searchModel.dart';
import '../Services/apis/comment_api.dart';
import '../Services/apis/login_api.dart';
import '../Services/apis/reply_api.dart';
import '../Services/apis/search_api.dart';
import '../main.dart';
class CommentController extends GetxController{
  RxList<Map<String, dynamic>>  allData=<Map<String, dynamic>> [].obs;
  List comments=[];
  GlobalKey<FlutterMentionsState> mentionsKeyComment = GlobalKey<FlutterMentionsState>();
  GlobalKey<FlutterMentionsState> mentionsKeyReply = GlobalKey<FlutterMentionsState>();
  RxString? text=''.obs;
  format(ddate) {
    DateFormat newDate = DateFormat.yMd();
    String time = newDate.format(ddate);
    return time;
  }
  getSearch(query)async{
    final token =sharedPreferences!.getString('access_token');
    try{
      final List data;
      data = await getSearchList(token,query);
      print(data);
      if (allData != data){
        allData.value=data.map((e) {
          return {
            'photo': e.profileImage!,
            'display':e.username!,
            'full_name':e.firstName!+' '+e.lastName!,
          };
        }).toList();
      }
      print(allData);
    }catch(e){
      print(e);
    }
  }
  var commentController=TextEditingController();
  send(text,isComment,id) async {
  final content = text;
  final token = sharedPreferences!.getString(
      'access_token'); // Replace with the user's authentication token
  if(isComment.value){
  await newComment(id, content, token!);
  text='';
  mentionsKeyComment.currentState!.controller!.text = '';

  }else{
  await newReply(id, content, token!);
  text!='';
  mentionsKeyReply.currentState!.controller!.text = '';
  }

}
  // fetchData() async {
  //   try {
  //     final List<comment> data;
  //     final token = getAccessToken();
  //     data = await getCommentsList(token);
  //     if (comments != data) {
  //       comments.assignAll(data);
  //       print(comments);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}