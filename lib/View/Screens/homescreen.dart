
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/linking.dart';
import 'package:revista/View/Screens/DiscoverScreen.dart';
import 'package:revista/View/Screens/MessageScreen.dart';
import 'package:revista/View/Screens/createPost.dart';
import 'package:revista/View/Screens/home.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/cupertino.dart';

import '../../main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _message;
  var channel;
  var sub;
  String? text;
  pageindx(index) {setState(() {
    pageindex = index;
    });

  }

  @override
  void initState() {
    var token = sharedPreferences!.getInt('access_id');
    print(token);
    super.initState();
    FlutterLocalNotificationsPlugin notifications =
        new FlutterLocalNotificationsPlugin();
    notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    channel =IOWebSocketChannel.connect(Uri.parse('ws://$ip/ws/notifications/'), headers: {'Authorization':token });
    _message = new TextEditingController();
    var init = InitializationSettings(android: androidInit);
    notifications
        .initialize(
      init,
    ).then((done) {
      sub = channel.stream.listen((newData){
        //var data=json.decode(newData);
        //print(data);
        //  var username=data['text']['username'];
        // var Text=data['text']['detail'];
        // var imageUrl=data['text']['profile_image'];
        // var dateTime=data['text']['created_at'];
        notifications.show(
            0,
            'revista',
            newData,
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
                  largeIcon: const DrawableResourceAndroidBitmap(''),
                  priority: Priority.high,

            )));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _message!.dispose();
    channel.sink.close(status.goingAway);
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Homepages[pageindex],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        color:Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        index: pageindex,
        onTap: (val)=>pageindx(val),
        animationDuration: Duration(milliseconds: 1),
        items: [
          Icon(Icons.home,color: Colors.white,),
          Icon(Icons.search,color: Colors.white,),
          IconButton(icon:  Icon(Icons.add,color: Colors.white,),onPressed: (){
            Get.to(()=>CreatePost());
          }),
          Icon(Icons.chat,color: Colors.white,),
        ],
      ),
    );
  }
  var pageindex = 0;
  List Homepages = [
    PostScreen(),
    DiscoverScreen(),
    Container(),
    MessageScreen(),
  ];


  getpage() {
    return Homepages[pageindex];
  }

}
