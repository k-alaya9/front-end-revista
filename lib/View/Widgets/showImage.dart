import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

// import 'package:path/path.dart'as path;
import 'package:revista/View/Widgets/post.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  var selected;

  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

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
              Text('Save'),
            ],),value: 1,)
          ], onChanged: (val){
            if(val==1){
              saveImage();
            }
          }),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(imageUrl!, fit: BoxFit.fitWidth),
      ),
    );
  }

  void requestStoragePermission() async {
    print('hello world');
    await Permission.storage.request();
  }

  void saveImage() async {
    print('hi');
    EasyLoading.show(dismissOnTap: false,indicator: CupertinoActivityIndicator(color: Colors.white,radius: 20,));
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
    }
    catch(e){
      EasyLoading.showError('Failed');
    }

  }
}
