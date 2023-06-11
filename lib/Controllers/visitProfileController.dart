import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Models/visitprofile.dart';
import '../Services/apis/profile_api.dart';
import '../main.dart';

class visitProfileController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  List Posts = List.generate(5, (index) => null);
  var id = 0.obs;
  var followId=0.obs;
  var View=true.obs;
  RxString? profileImage = ''.obs;
  RxString? CoverImage = ''.obs;
  RxString? firstname = ''.obs;
  RxString? lastName = ''.obs;
  RxString? Username = ''.obs;
  RxString? followers = ''.obs;
  RxString? following = ''.obs;
  RxString? numberOfPosts = ''.obs;
  RxString? bio = ''.obs;
  ScrollController scrollController = ScrollController();
  final ListKey = GlobalKey();

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  void onRefresh() async {
    // monitor network fetch

    await Future.delayed(Duration(milliseconds: 1000));
    onInit();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  follow() async{
    if (followId.value!=0) {
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: CircleAvatar(
                  radius: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage( profileImage!.value,))
                    ),
                  ),
              ),
              content: Text(
                "are you sure you want to unfollow ${Username!.value}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: [
                TextButton(
                    onPressed: ()async {
                      var token = sharedPreferences!.getString('access_token');
                      print(followId.value);
                     await  unfollowUser(token, followId.value);
                     followId.value=0;
                      Get.back();
                    },
                    child: Text(
                      'unfollow',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'cancel',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
              ],
            );
          });
    } else {
      var token = sharedPreferences!.getString('access_token');

      print(id.value);
      followId= await  followUser(token, id.value);
    }
  }

  showImage(photo) {
    Get.dialog(
      Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
          image: DecorationImage(image: NetworkImage(photo), fit: BoxFit.fitWidth),
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

  fetchData() async {
    var token = sharedPreferences!.getString('access_token');
    try {
      followId.value=Get.arguments['followid'];
      print(followId.value);
      id!.value = Get.arguments['id'];
      print(id!.value);
      visitprofile profile= await fetchVisitorProfile(token,id!.value)!;
      User user=profile.user!;
      Username!.value=user.username!;
      profileImage!.value=user.profileImage!;
      firstname!.value=user.firstName!;
      lastName!.value=user.lastName!;
      CoverImage!.value=profile.coverImage!;
      bio!.value=profile.bio!;
      following!.value=profile.followingCount.toString();
      followers!.value=profile.followersCount.toString();
      numberOfPosts!.value=profile.postsCount.toString();
      followId.value=profile.isFollowing!;
      // Username!.value = 'k.alaya9';
      // profileImage!.value =
      //     'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8';
      // firstname!.value = 'khaled';
      // lastName!.value = 'alaya';
      // CoverImage!.value = 'https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/352379080_585186983746695_5892930268755518858_n.jpg?stp=dst-jpg_p960x960&_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_ohc=p0LMLrYOx1wAX-WfmC4&_nc_ht=scontent-cph2-1.xx&oh=00_AfCRdRNMZm19CK9SewSjvbbqXPg46dVMcWkrae2gQ3fF8g&oe=64840E3C';
      // bio!.value = 'lana del rey';
      // following!.value = '2000';
      // followers!.value = '2000';
      // followId.value = 0;
      // numberOfPosts!.value = '10';
    } catch (e) {}
  }
  switchViewVertical(){
    View.value=true;
  }
  switchViewHorizontal(){
    View.value=false;
  }
}
