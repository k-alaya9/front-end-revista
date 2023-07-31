import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:revista/main.dart';

import '../../View/Screens/ReplyScreen.dart';
import '../../View/Screens/ViewPost.dart';

void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    print('notification payload: $payload');}
  var id=sharedPreferences!.getInt('notfiicationsId');
  switch(notificationResponse.payload){
    case 'Follow':
      await Get.toNamed('/visitProfile',
        arguments: {
          'id':id
        }
      );
      break;
    case "Post":
      await Get.to(()=>ViewPost(),arguments: {
        'PostId':id
      });
      break;
    case 'Reply':
      await Get.to(()=>ReplyScreen(),arguments: {
        'ReplyId':id
      });
      break;
    case'Chat':
      await Get.toNamed('/chatScreen',arguments: {
        'chat_id':id
      });
      break;
  }
  // await Get.toNamed('/notification');
}