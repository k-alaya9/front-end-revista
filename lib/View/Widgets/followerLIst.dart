import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Controllers/followingController.dart';
import 'package:revista/Controllers/visitProfileController.dart';
import '../../Services/apis/profile_api.dart';
import '../../main.dart';

class followerList extends StatelessWidget {
  var followId;
  final id;
  final username;
  final name;
  final lastname;
  final imageUrl;

  followerList({
    Key? key,
    this.username,
    this.name,
    this.imageUrl,
    this.lastname,
    this.id,
    this.followId,
  }) : super(key: key);
  followingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print(followId);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey,width: 0.7),
          //   shape: BoxShape.rectangle,
          //   borderRadius: BorderRadius.circular(12),
          // ),

          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            enabled: true,
            onTap: () {
              Get.toNamed('/visitProfile', arguments: {
                'id': id,
                'followid': followId,
              });
            },
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(imageUrl)),
              ),
            ),
            title: Text(name + ' ' + lastname,
                style: Theme.of(context).textTheme.bodyText1),
            subtitle: Text(
              username,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey, fontSize: 13),
            ),
            // trailing: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //       onPressed: () async {
            //         var token = sharedPreferences!.getString('access_token');
            //         Get.put(visitProfileController());
            //         visitProfileController controller = Get.find();
            //         if (followId== 0) {
            //           followId = await followUser(token, id);
            //         } else if (followId.value != 0) {
            //           await unfollowUser(token, followId);
            //           followId = 0;
            //         }
            //       },
            //       style: ButtonStyle(
            //         elevation: MaterialStatePropertyAll(0),
            //         backgroundColor: MaterialStatePropertyAll(
            //             Theme.of(context).primaryColor),
            //       ),
            //       child: GetBuilder(
            //         builder: (followingController controller) => Text(
            //           followId == 0 ? translator.translate("Follow") : translator.translate("Following"),
            //         ),
            //       )),
            // ),
          ),
        ),
      ],
    );
  }
}
