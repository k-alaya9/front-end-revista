import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Models/profile.dart';
import '../Services/apis/profile_api.dart';
import '../main.dart';

class ProfileController extends GetxController{
  RefreshController refreshController =
  RefreshController(initialRefresh: true);
  List Posts = List.generate(5, (index) => null);
  int? id;
  var profileImage;
  var  CoverImage;
  var  firstname;
  var  lastName;
  var  Username;
  var  followers;
  var  following;
  var  numberOfPosts='0';
  var  bio;
  var lastnameController=TextEditingController();
  var firstnameController=TextEditingController();
  var usernameController=TextEditingController();
  var bioController=TextEditingController();
  ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final ListKey=GlobalKey();
  void onRefresh() async{
    fetchData();
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }
  showImage(photo){
    Get.dialog(
      Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: NetworkImage(photo),
              fit: BoxFit.cover),
        ),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      useSafeArea: true,
    );
  }
  Widget bottomsheet(int id) {
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
            'Choose  Photo',
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
                onPressed:()=>takePhoto(id),
              ),
              MaterialButton(
                child: Column(
                  children: [Icon(Icons.photo), Text('Pick Picture')],
                ),
                onPressed:()=> gitPhoto(id),
              ),
              MaterialButton(
                child: Column(
                  children: [Icon(Icons.delete), Text('Delete Picutre')],
                ),
                onPressed:()=> deletePhoto(id),
              )
            ],
          ),
        ],
      ),
    );
  }
  late PickedFile imageFile;

  final ImagePicker picker = ImagePicker();
  Rx<File> fileImage = File('').obs;

  void takePhoto(id) async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if(id==1){
        fileImage!.value = File(pickedFile.path);

      }

      else{

      }
    }
  }


  void gitPhoto(id) async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if(id==1){
        fileImage!.value = File(pickedFile.path);

      }

      else{

      }
    }
  }
  deletePhoto(id){
    if(id==1){
      profileImage!.value='';
    }
    else{
      CoverImage!.value='';

    }
  }

  fetchData()async{
    var token =sharedPreferences!.getString('access_token');
    try {
      Profile profile= await getProfileinfo(token);
      User user=profile.user;
      Username=user.username;
      profileImage=user.profile_image;
      firstname=user.first_name;
      lastName=user.last_name;
      CoverImage=profile.cover_image;
      bio=profile.bio;
      following=profile.following_count.toString();
      followers=profile.followers_count.toString();


    }
    catch(e){
      print(e);
    }
  }
}