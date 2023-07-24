import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/following_model.dart';
import 'package:revista/Models/followmodel.dart';
import 'package:revista/Services/apis/profile_api.dart';

import '../main.dart';



class followingController extends GetxController {
  List<following> followings = [];
  List<follow> followers = [
    // follow(
    //   id: 0,
    //   followed: Followed(
    //       id: 1,
    //       user: User(
    //           username: 'k.alaya9',
    //           firstName: 'khaled',
    //           lastName: 'alaya',
    //           profileImage:
    //           'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8')),
    // )  ,    follow(
    //   id: 0,
    //   followed: Followed(
    //       id: 1,
    //       user: User(
    //           username: 'k.alaya9',
    //           firstName: 'khaled',
    //           lastName: 'alaya',
    //           profileImage:
    //           'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8')),
    // )  ,    follow(
    //   id: 0,
    //   followed: Followed(
    //       id: 1,
    //       user: User(
    //           username: 'k.alaya9',
    //           firstName: 'khaled',
    //           lastName: 'alaya',
    //           profileImage:
    //           'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8')),
    // )  ,
  ];
  var isSearching = false.obs;

  switchSearch() {
    isSearching.value = !isSearching.value;
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  RefreshController refreshController = RefreshController();

  onRefresh() async {
    // monitor network fetch
    onInit();
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  fetchData() async {
    var token = sharedPreferences!.getString('access_token');
    try {
      final List<follow> followers;
      followers = await getFollowersList(token)!;
      this.followers.assignAll(followers);
      print(this.followers);
    } catch (e) {}

    try {
      final List<following> follows;
      follows = await getFollowList(token)!;
      followings.assignAll(follows);
      print(followings);
    } catch (e) {}
   }
}
