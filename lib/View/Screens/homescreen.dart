
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:revista/View/Screens/DiscoverScreen.dart';
import 'package:revista/View/Screens/MessageScreen.dart';
import 'package:revista/View/Screens/createPost.dart';
import 'package:revista/View/Screens/home.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/cupertino.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _message;
  bool _iserror = false;
  var channel;
  var sub;
  String? text;
  pageindx(index) {setState(() {
    pageindex = index;
    });

  }

  @override
  void initState() {

    super.initState();
    FlutterLocalNotificationsPlugin notifications =
        new FlutterLocalNotificationsPlugin();
    notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.137.252:9000/ws/notifications/'),
    );
    _message = new TextEditingController();
    var init = InitializationSettings(android: androidInit);
    notifications
        .initialize(
      init,
    ).then((done) {
      sub = channel.stream.listen((newData){
        print(newData);
        notifications.show(
            0,
            "revista app",
            newData,
            NotificationDetails(
                android: AndroidNotificationDetails(
              "revista app",
              "Revista App",
                  showWhen: true,
                  enableVibration: true,
                  enableLights: true,
                  priority: Priority.high,
                  playSound: true,
                  visibility:NotificationVisibility.public,
                  sound: RawResourceAndroidNotificationSound('pop'),
                  color: Theme.of(context).primaryColor,
            )));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _iserror = false;
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
