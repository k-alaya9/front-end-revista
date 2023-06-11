import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revista/Controllers/ProfileController.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Models/topic.dart';

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
  List<topicItem>items=[
    topicItem(id: 0, name: 'General', imageUrl:'',pressed: false.obs),
    topicItem(id: 1, name: 'news', imageUrl: 'asset/image/news.jpg',pressed: false.obs),
    topicItem(id: 2, name: 'education', imageUrl: 'asset/image/education.jpg',pressed: false.obs),
    topicItem(id: 3, name: 'entertainment', imageUrl: 'asset/image/entertainment.jpg',pressed: false.obs),
    topicItem(id: 4, name: 'sports', imageUrl: 'asset/image/sports.jpg',pressed: false.obs),
    topicItem(id: 5, name: 'food', imageUrl: 'asset/image/food.jpg',pressed: false.obs),
    topicItem(id: 6, name: 'art & crafts', imageUrl: 'asset/image/art & crafts.jpg',pressed: false.obs),
    topicItem(id: 7, name: 'animals & pets', imageUrl: 'asset/image/animals & pets.jpg',pressed: false.obs),
    topicItem(id: 8, name: 'social life', imageUrl: 'asset/image/social life.jpg',pressed: false.obs),
    topicItem(id: 9, name: 'gaming', imageUrl: 'asset/image/gaming.jpg',pressed: false.obs),
    topicItem(id: 10, name: 'business', imageUrl: 'asset/image/business.jpg',pressed: false.obs),
    topicItem(id: 11, name: 'fashion', imageUrl: 'asset/image/fashion.jpg',pressed: false.obs),
    topicItem(id: 12, name: 'travel', imageUrl: 'asset/image/travel.jpg',pressed: false.obs),
  ];
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
  SubmitPost(){
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
    }else if (selecteditems.isEmpty){
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
    }else  {
      // Validation passed
      print('Hello world');
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
  fetchData(){
    profileImage.value=controller.profileImage.value;
    userName.value=controller.Username.value;
    Name.value=controller.firstname.value+" "+controller.lastName.value;
  }

}