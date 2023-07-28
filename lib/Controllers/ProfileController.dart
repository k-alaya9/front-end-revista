import 'dart:io';
import 'dart:ui';

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
  var postView=true.obs;
  var View=true.obs;
  int? id;
  RxString profileImage=''.obs;
  RxString  CoverImage=''.obs;
  RxString  firstname=''.obs;
  var  lastName=''.obs;
  var  Username=''.obs;
  var  followers=''.obs;
  var  following=''.obs;
  var  numberOfPosts='0'.obs;
  RxString  bio=''.obs;
  var lastnameController;
  var firstnameController;
  var usernameController;
  var bioController;
  ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final ListKey=GlobalKey();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  void onRefresh() async{
    fetchData();
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }
  showImage(photo){
    Get.dialog(
      Container(
          color: Colors.transparent,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                          ))),
                  InkWell(
                      onTapCancel: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.transparent),
                        child: Image.network(photo),
                      )),
                ],
              ),
            ),
          )),
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
    var token = sharedPreferences!.getString('access_token');
    if (pickedFile != null) {
      if(id==1){
        fileImage!.value = File(pickedFile.path);
        try{
          editImage(token,profileImage: fileImage.value);
          Get.back();
        }catch(e){
          showSnackBar(e);
        }
        finally{
          fetchData();
        }
      }
      else{
        fileImage.value = File(pickedFile.path);
        try{
          editImageCover(token,coverImage:  fileImage.value);
          Get.back();
        }catch(e){
          showSnackBar(e);
        }
        finally{
          fetchData();
        }
      }
      onRefresh();
    }
  }


  void gitPhoto(id) async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    var token = sharedPreferences!.getString('access_token');
    if (pickedFile != null) {
      if(id==1){
        fileImage!.value = File(pickedFile.path);
        try{
          editImage(token,profileImage: fileImage.value);
          Get.back();
        }catch(e){
          showSnackBar(e);
        }
        finally{
          fetchData();
        }
      }
      else{
        fileImage.value = File(pickedFile.path);
        try{
          editImageCover(token,coverImage:  fileImage.value);
          Get.back();
        }catch(e){
          showSnackBar(e);
        }

      }
    }
    onRefresh();
  }
  deletePhoto(id){
    if(id==1){
      profileImage!.value='';
      Get.back();
    }
    else{
      CoverImage!.value='';
      Get.back();
    }
  }

  fetchData()async{
    var token =sharedPreferences!.getString('access_token');
    try {
      Profile profile= await getProfileinfo(token);
      User user=profile.user;
      Username.value=user.username;
      profileImage.value=user.profile_image;
      firstname.value=user.first_name;
      lastName.value=user.last_name;
      CoverImage.value=profile.cover_image;
      if(profile.bio!=null)
      bio.value=profile.bio;
      following.value=profile.following_count.toString();
      followers.value=profile.followers_count.toString();
      lastnameController=TextEditingController(text: lastName.value);
      firstnameController=TextEditingController(text: firstname.value);
      usernameController=TextEditingController(text: Username.value);
      bioController=TextEditingController(text: bio.value);
      // Username!.value = 'k.alaya9';
      // profileImage!.value =
      //     'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8';
      // firstname!.value = 'khaled';
      // lastName!.value = 'alaya';
      // CoverImage!.value = 'https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/352379080_585186983746695_5892930268755518858_n.jpg?stp=dst-jpg_p960x960&_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_ohc=p0LMLrYOx1wAX-WfmC4&_nc_ht=scontent-cph2-1.xx&oh=00_AfCRdRNMZm19CK9SewSjvbbqXPg46dVMcWkrae2gQ3fF8g&oe=64840E3C';
      // bio!.value = 'lana del rey';
      // following!.value = '2000';
      // followers!.value = '2000';
      // numberOfPosts!.value = '10';
    }
    catch(e){
      showSnackBar(e);
    }
  }

  editData()async {
    var token = sharedPreferences!.getString('access_token');
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        print(Username.value);
        editbio(token,bio: bio.value);
        editprofile(token,username: Username.value,firstname: firstname.value,lastname: lastName.value,);
        Get.back();
      }
      catch (e) {
        showSnackBar(e);
      }
    }
  }
  switchViewVertical(){
    View.value=true;
  }
  switchViewHorizontal(){
    View.value=false;
  }
  switchViewSavedPosts(){
    postView.value=false;
  }
  switchViewPost(){
    postView.value=true;
  }
  void showSnackBar(var e) {
    Get.showSnackbar(GetSnackBar(
      borderRadius: 20,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.white,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.all(10),
      messageText: Text(e.toString()),
    ));
  }
}