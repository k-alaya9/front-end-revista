import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/report_api.dart';
import 'package:revista/main.dart';

class ReportController extends GetxController {
  var detailsController = TextEditingController();

  var harassment = false.obs;
  var spam = false.obs;
  var inappropriate_Content = false.obs;

  void updateHarassment(bool value) {
    harassment.value = value;
    update();
  }

  void updateSpam(bool value) {
    spam.value = value;
    update();
  }

  void update_Inappropriate_Content(bool value) {
    inappropriate_Content.value = value;
    update();
  }

  void report(type, id) async {
    final token = sharedPreferences!.getString('access_token');
    await createReport(token: token,
        type: type,
        description: detailsController.text,
        category: harassment.value ? "harassment" : spam.value
            ? 'spam'
            : inappropriate_Content.value ? 'inappropriate-content':'',
      reported_chat: type=='chat'?id:null,
      reported_post: type=='post'?id:null,
      userId: type=='user'?id:null
    );
    Get.back();

  }
}