import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CommentController extends GetxController{


  var commentControlller=TextEditingController();
  // String? comment='';
  // String username='';
  // DateTime date = DateTime.now();
  // RxString numberOfLikesOfComments = ''.obs;
  format(ddate) {
    DateFormat newDate = DateFormat.yMd();
    String time = newDate.format(ddate);
    return time;
  }

  var commentController=TextEditingController();
}