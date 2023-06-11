import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Controllers/drawerController.dart';
import '../Widgets/drawer.dart';
import '../Widgets/drawerWidget.dart';
import '../Widgets/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  List Posts=List.generate(5, (index) => null);
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final Key linkKey = GlobalKey();
drawerController controller=Get.find();
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    Posts.add((Posts.length+1).toString());
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero ,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: DrawerWidget(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        middle: Text('Home',style: Theme.of(context).textTheme.headline1),
        trailing: Material(
          color: Theme.of(context).backgroundColor,
          child: IconButton(onPressed: (){
            // Get.toNamed('/notification');
            FlutterLocalNotificationsPlugin notifications =
            new FlutterLocalNotificationsPlugin();
            notifications
                .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
                .requestPermission();
            var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher',);
            var init = InitializationSettings(android: androidInit);
            notifications
                .initialize(
              init,
            ).then((done) {
                notifications.show(
                    0,
                    'revista',
                   'hi',
                    payload: 'Default_Sound',
                    NotificationDetails(
                        android: AndroidNotificationDetails(
                          "revista app",
                          "Revista App",
                          groupKey: "com.example.revista",
                          playSound: true,
                          importance: Importance.max,
                          ticker: 'ticker',
                          priority: Priority.high,
                        )));
              });


          }, icon: Icon(Icons.notifications,size: 28,)),
        ),
      ),
      body:  SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header:ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Posts.length,
            itemBuilder:(ctx,index){
              return Post();
            } ,
          ),
        ),
      ),
    );
  }
}
