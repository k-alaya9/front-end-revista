import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revista/Controllers/ProfileController.dart';
import 'package:revista/Services/apis/register_api.dart';
import 'package:revista/Services/apis/topic_api.dart';
import 'package:revista/main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Models/topic.dart';
import '../Services/apis/post_api.dart';

class CreatePostController extends GetxController{
  ProfileController controller=Get.find();
  var PostTextField=TextEditingController();
  var UrlTextField=TextEditingController();
  var profileImage=''.obs;
  var userName=''.obs;
  var Name=''.obs;
  var isVisible=false.obs;
  late PickedFile imageFile;
  PanelController panelController=PanelController();
   List<topicItem>items=[];
  List<int?> selecteditems=[];
@override
  void onInit() {
    fetchData();
    super.onInit();
  }
  final ImagePicker picker = ImagePicker();
   Rx<File> fileImage =File('').obs;
  void takePhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      fileImage.value = File(pickedFile.path);
    }
    Get.back();
  }
  void gitPhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fileImage.value = File(pickedFile.path);
    }
    Get.back();
  }
  deletePhoto(){
    fileImage.value = File('');
  }
  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Pick a Photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Column(
                  children: [Icon(Icons.camera_alt), Text('Take Picutre')],
                ),
                onPressed: takePhoto,
              ),
              MaterialButton(
                child: Column(
                  children: [Icon(Icons.photo), Text('Pick Picture')],
                ),
                onPressed:gitPhoto,
              ),

            ],
          ),
        ],
      ),
    );
  }
  onPressed(int id){
    for(var item in items){
      if(item.id==id) {
        item.pressed.value=!item.pressed.value;
      }
      if(item.id==id &&item.pressed.value){
        selecteditems.add(id);
        print(selecteditems);
      }
      if(item.id==id &&!item.pressed.value){
        selecteditems.remove(id);
        print(selecteditems);
      }
    }
    update();
  }
  SubmitPost()async{
    if (!UrlTextField.text.isURL &&UrlTextField.text.isNotEmpty) {
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Error',style: Theme.of(context).textTheme.headline1),
              content: Text("I don't think that's a valid url",style: Theme.of(context).textTheme.bodyText1,),
              actions:[
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('ok',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),))
              ],
            );
          });
    }
    else if (selecteditems.isEmpty){
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Error',style: Theme.of(context).textTheme.headline1),
              content: Text("pick topic post",style: Theme.of(context).textTheme.bodyText1,),
              actions:[
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('ok',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),))
              ],
            );
          });
    }
    else if(PostTextField.text.isEmpty&&fileImage.value.path==''){
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Error',style: Theme.of(context).textTheme.headline1),
              content: Text("You need to post image or text in the post <3",style: Theme.of(context).textTheme.bodyText1,),
              actions:[
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('ok',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),))
              ],
            );
          });
    }
    else  {
      // Validation passed
      try{
        var token=await getAccessToken();
        var id=sharedPreferences!.getInt('access_id');
        await createPost(id: id,topics:selecteditems,text:  PostTextField.text,link: UrlTextField.text,image:fileImage.value,token: token);
      }
      catch(e){
        print(e);
      }
    }
  }
  switchBottomSheet(){
    isVisible.value=!isVisible.value;
    if(isVisible.value){
      panelController.open();
    }
    else{
      panelController.close();
    }

  }
  fetchData()async{
    try{
      profileImage.value=controller.profileImage.value;
      userName.value=controller.Username.value;
      Name.value=controller.firstname.value+" "+controller.lastName.value;
      var token =await getAccessToken();
      print(token);
      print('hi');
      final list=await getTopicsListPost(token);
      print(list);
      if(items.isEmpty)
        for(var i in list) {
          items.add(i);
          print(items);
        }
     update();
    }
    catch(e){
    }
  }
}