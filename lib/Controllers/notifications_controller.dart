import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/notfications_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:workmanager/workmanager.dart';
import '../Services/Notifications/notifications.dart';
import '../Services/apis/linking.dart';
import '../Services/apis/notification.dart';
import '../main.dart';

class notificationsController extends GetxController with WidgetsBindingObserver{
  var isOnline=true.obs;
  var type='';
  var id;
  var Text = '';
  var imageUrl = '';
  var username = '';
  var dateTime;

  List notifications = [];
  RefreshController refreshController = RefreshController(initialRefresh: true);
  var channel;
  var sub;
  String? text;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
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

  notificationChannel() {

    var token = sharedPreferences!.getInt('access_id');
    print(token);
    FlutterLocalNotificationsPlugin notifications =
        new FlutterLocalNotificationsPlugin();
    notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://$ip/ws/notifications/'),
        headers: {'Authorization': token});
    var init = InitializationSettings(android: androidInit);
    notifications
        .initialize(
      init,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse
    )
        .then((done) {
      sub = channel.stream.listen((newData) async {
        var data = json.decode(newData);
        print(newData);
        var type = data['text']['type'];
        var id=data['text']["forward_id"];
        var Text = data['text']['detail'];
        var imageUrl = data['text']['profile_image'];
        var dateTime = data['text']['created_at'];
        sharedPreferences!.setInt('notfiicationsId', id);
        // final bigPicture = await DownloadUtil.downloadAndSaveFile(
        //    imageUrl ,
        //     'image');
        notifications.show(
            0,
            'revista',
            Text,
            payload: '$type',
            NotificationDetails(
                android:
                    AndroidNotificationDetails("revista app", "Revista App",
                        groupKey: "com.example.revista",
                        importance: Importance.max,
                        enableVibration: true,
                        enableLights: true,
                        playSound: true,
                        ticker: 'ticker',
                        //  largeIcon:  DrawableResourceAndroidBitmap('image'),
                        priority: Priority.high,
                        subText: dateTime)));

      });
    });
  }

  fetchData() async {
    var token = sharedPreferences!.getString('access_token');
    try {
      final List<notification> notifiy;
      notifiy = await notificationList(token!);
      if (notifications != notifiy) notifications.assignAll(notifiy);
    } catch (e) {
      print(e);
    }
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed){
      //TODO: set status to online here
      print('online');
      isOnline.value=true;
    }
    else{
      //TODO: set status to offline here
      print('offline');
      isOnline.value=false;
    }

  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  if (service is AndroidServiceInstance) {
    notifiy();
  }
  Timer.periodic(Duration(seconds: 10), (timer) async {

  });
}
