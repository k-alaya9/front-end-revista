import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

// import 'package:path/path.dart'as path;
import 'package:revista/View/Widgets/post.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import '../../Controllers/postController.dart';

class ShowImage extends StatelessWidget {
  viewPostController controller=Get.find();
  String imageUrl;
  ShowImage({super.key,required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor:  Theme.of(context).backgroundColor,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        trailing: Material(
          color: Theme.of(context).backgroundColor,
          child: DropdownButton(
              icon: Icon(Icons.more_vert),
              underline: Container(),
              items: [
                DropdownMenuItem(child: Row(children: [
                  Icon(Icons.arrow_downward,),
                  SizedBox(width: 5,),
                  Text(translator.translate("Save")),
                ],),value: 1,)
              ], onChanged: (val){
            if(val==1){
              controller.saveImage(imageUrl);
            }
          }),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(imageUrl, fit: BoxFit.fitWidth),
      ),
    );
  }

}
