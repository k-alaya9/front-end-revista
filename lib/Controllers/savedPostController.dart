import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/savedPost.dart';
import 'package:revista/Services/apis/login_api.dart';
import 'package:revista/main.dart';

import '../Models/chatModel.dart';
import '../Models/post.dart';
import '../Models/topic.dart';
import '../Services/apis/post_api.dart';
import 'drawerController.dart';

class savedPostController extends GetxController {
  RxList<savedPost> Posts = <savedPost>[
  ].obs;
  RefreshController refreshController =
  RefreshController(initialRefresh: true);
  void onRefresh() async {
    // monitor network fetch
    await fetchData();
    refreshController.refreshCompleted();
  }

  fetchData() async {
    try {
      final List<savedPost> data;
      final token =sharedPreferences!.getString('access_token');
      data = await getMySavedPosts(token);
      if (Posts != data){
        Posts.assignAll(data);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

}
