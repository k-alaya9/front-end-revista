import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/comment_model.dart';
import '../Services/apis/comment_api.dart';
import '../Services/apis/login_api.dart';
class CommentController extends GetxController{
  // var commentControlller=TextEditingController();
  // String? comment='';
  // String username='';
  // DateTime date = DateTime.now();
  // RxString numberOfLikesOfComments = ''.obs;
  List comments=[];
  format(ddate) {
    DateFormat newDate = DateFormat.yMd();
    String time = newDate.format(ddate);
    return time;
  }

  var commentController=TextEditingController();

  fetchData() async {
    try {
      final List<comment> data;
      final token = getAccessToken();
      data = await getCommentsList(token);
      if (comments != data) {
        comments.assignAll(data);
        print(comments);
      }
    } catch (e) {
      print(e);
    }
  }
}