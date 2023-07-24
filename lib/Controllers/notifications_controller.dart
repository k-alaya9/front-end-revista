import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/notfications_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../Services/apis/linking.dart';
import '../Services/apis/notification.dart';
import '../main.dart';

class notificationsController extends GetxController {
  var Text = '';
  var imageUrl = '';
  var username = '';
  var dateTime;
  // TODO: make the notifications reused
  List<notification> notifications = [];
  RefreshController refreshController = RefreshController(initialRefresh: true);
  var channel;
  var sub;
  String? text;
  @override
  void onInit() {
    fetchData();
    notificationChannel();
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
    channel.sink.close(status.goingAway);
    sub.cancel();
  }
  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    onInit();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
  notificationChannel(){
    var token = sharedPreferences!.getInt('access_id');
    print(token);
    FlutterLocalNotificationsPlugin notifications =
    new FlutterLocalNotificationsPlugin();
    notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    channel =IOWebSocketChannel.connect(Uri.parse('ws://$ip/ws/notifications/'), headers: {'Authorization':token });
    var init = InitializationSettings(android: androidInit);
    notifications
        .initialize(
      init,
    ).then((done) {
      sub = channel.stream.listen((newData)async{
        var data=json.decode(newData);
        print(newData);
        var username=data['text']['username'];
        var Text=data['text']['detail'];
        var imageUrl=data['text']['profile_image'];
        var dateTime=data['text']['created_at'];
        // final bigPicture = await DownloadUtil.downloadAndSaveFile(
        //    imageUrl ,
        //     'image');
        notifications.show(
            0,
            'revista',
            Text,
            payload: 'Default_Sound',
            NotificationDetails(
                android: AndroidNotificationDetails(
                    "revista app",
                    "Revista App",
                    groupKey: "com.example.revista",
                    importance: Importance.max,
                    enableVibration: true,
                    enableLights: true,
                    playSound: true,
                    ticker: 'ticker',
                    //  largeIcon:  DrawableResourceAndroidBitmap('image'),
                    priority: Priority.high,
                    subText: dateTime
                )));
      });
    });
  }
  fetchData() async {
    var token = sharedPreferences!.getString('access_token');
    try {
      final List<notification> notifiy ;
      // = [
        // notification(id: 1,user: 1,type: 'follow',detail: 'khaled alaya followed u',image: 'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8',createdAt: DateTime(2023,10,3)),
        // notification(id: 1,user: 1,type: 'follow',detail: 'khaled alaya followed u',image: 'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8',createdAt: DateTime(2023,11,3)),
        // notification(id: 1,user: 1,type: 'follow',detail: 'khaled alaya followed u',image: 'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8',createdAt: DateTime(2023,12,3)),
        // notification(id: 1,user: 1,type: 'follow',detail: 'khaled alaya followed u',image: 'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8',createdAt: DateTime(2023,1,3)),
        // notification(id: 1,user: 1,type: 'follow',detail: 'khaled alaya followed u',image: 'https://scontent.flca1-2.fna.fbcdn.net/v/t39.30808-6/263316426_1138060467020345_1597101672072243926_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=lGU8xlHy4n4AX_WoXM5&_nc_ht=scontent.flca1-2.fna&oh=00_AfCfXiwcCR9-E37u7xgfjMfHJcTBZBpEljbENFxm_QCq0A&oe=648505F8',createdAt: DateTime(2023,2,3)),
      // ];
      notifiy = await notificationList(token!);
      if (notifications.isEmpty) notifications.assignAll(notifiy);
    } catch (e) {
      print(e);
    }
  }
}
