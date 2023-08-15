import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/report_api.dart';
import 'package:revista/main.dart';
enum options{
  harassment,
  spam,
  inappropriate_content
}
class ReportController extends GetxController {
  var detailsController = TextEditingController();
var selectedOption=options.harassment.obs;

  void setSelectedOption(options option) {
    selectedOption.value = option;
  }
  void report(type, id) async {
    final token = sharedPreferences!.getString('access_token');
    await createReport(token: token,
        type: type,
        description: detailsController.text,
        category: selectedOption==options.harassment ? "harassment" : selectedOption==options.spam
            ? 'spam'
            : selectedOption==options.inappropriate_content ? 'inappropriate-content':'',
      reported_chat: type=='chat'?id:null,
      reported_post: type=='post'?id:null,
      userId: type=='user'?id:null
    );
    Get.back();

  }
}