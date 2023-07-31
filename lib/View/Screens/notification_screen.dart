import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:revista/View/Widgets/notifications.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../Controllers/notifications_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../Models/notfications_model.dart';
import '../../main.dart';

class notification_screen extends StatelessWidget {
  const notification_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var token = sharedPreferences!.getInt('access_id');
    print(token);
    notificationsController controller = Get.put(notificationsController());
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          border: null,
          leading: Material(
              color: Theme
                  .of(context)
                  .backgroundColor,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  splashRadius: 1)),
          middle: Text('Notifications  ',
              style:
              Theme
                  .of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 20)),
          backgroundColor: Theme
              .of(context)
              .backgroundColor,
          trailing: Icon(Icons.notifications,
              color: Theme
                  .of(context)
                  .primaryColor, size: 28),
        ),
        body:FutureBuilder(
          future: controller.fetchData(),
            builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
         return Shimmer.fromColors(
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.grey.shade700,
              enabled: true,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black12, width: 0.2)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        style: ListTileStyle.drawer,
                        leading: Container(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade900,
                          ),
                        ),
                        title: Container(
                            width: 100,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                shape: BoxShape.rectangle)),
                        subtitle: Container(
                            width: 150,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                shape: BoxShape.rectangle)),
                        trailing: Container(
                            width: 20,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                shape: BoxShape.rectangle)),
                      ),
                    ),
                  ),
                ),
              ));
          final  reversedNotifications = List.from(controller.notifications.reversed);
         return SmartRefresher(
            header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
            onRefresh: controller.onRefresh,
            enablePullDown: true,
            controller: controller.refreshController,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: reversedNotifications.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                          duration: const Duration(milliseconds: 500),
                          child: Notifications(id: reversedNotifications[index].id,
                            type:reversedNotifications[index].type ,
                            imageUrl:reversedNotifications[index].image! ,
                            dateTime:reversedNotifications[index].createdAt! ,
                            text:  reversedNotifications[index].detail!,
                          )
                      ),
                    ),
                  );}
            )
            ,
          );

        })
  );
}}
