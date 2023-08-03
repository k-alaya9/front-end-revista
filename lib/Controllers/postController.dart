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
import 'package:revista/Services/apis/login_api.dart';
import 'package:revista/main.dart';

import '../Models/chatModel.dart';
import '../Models/post.dart';
import '../Models/topic.dart';
import '../Services/apis/post_api.dart';
import 'drawerController.dart';

class viewPostController extends GetxController {
  RxList<chat> chats=<chat>[].obs;
  RxList<post> Posts = <post>[
  ].obs;
  List selectedChats=[].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final Key linkKey = GlobalKey();
  drawerController controller = Get.find();
  var picked=false.obs;
  void onRefresh() async {
    // monitor network fetch
    await fetchData();
    refreshController.refreshCompleted();
  }

  late List<List<topicItem>> items;

  fetchData() async {
    try {
      final List<post> data;
      final token =sharedPreferences!.getString('access_token');
      data = await getPostsList(token);
      if (Posts != data){
        Posts.assignAll(data);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    requestStoragePermission();
    fetchData();
    super.onInit();
  }

  format(ddate) {
    DateFormat newDate = DateFormat.yMd().add_jms();
    String time = newDate.format(ddate);
    return time;
  }

  void requestStoragePermission() async {
    await Permission.storage.request();
  }

  void saveImage(imageUrl) async {
    print('hi');
    EasyLoading.show(
        dismissOnTap: false,
        indicator: CupertinoActivityIndicator(
          color: Colors.white,
          radius: 20,
        ));
    try {
      var response = await http.get(Uri.parse(imageUrl!));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/image.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      EasyLoading.showSuccess('Saved');
    } catch (e) {
      EasyLoading.showError('Failed');
    }
  }

  send(){
    selectedChats.clear();
    picked.value=selectedChats.isNotEmpty;
  }


}
