import 'dart:convert';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/notifications_controller.dart';
import 'package:revista/Controllers/onbordingcontroller.dart';
import 'package:revista/Services/Thems/themes.dart';
import 'package:revista/Services/Thems/themeservice.dart';
import 'package:revista/View/Screens/EditProfielScreen.dart';
import 'package:revista/View/Screens/followersScreen.dart';
import 'package:revista/View/Screens/loginscreen.dart';
import 'package:revista/View/Screens/onboarding_screen.dart';
import 'package:revista/View/Screens/resetpassword_screen.dart';
import 'package:revista/View/Widgets/drawer.dart';
import 'package:revista/middleware/loginMIddleware.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:workmanager/workmanager.dart';
import 'Services/Notifications/notifications.dart';
import 'Services/apis/linking.dart';
import 'View/Screens/chatScreen.dart';
import 'View/Screens/createPost.dart';
import 'View/Screens/followingScreen.dart';
import 'View/Screens/forgetpasswordscreen.dart';
import 'View/Screens/notification_screen.dart';
import 'View/Screens/profile_screen.dart';
import 'View/Screens/register_screen.dart';
import 'View/Screens/topicsscreen.dart';
import 'View/Screens/visiterProfile.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

SharedPreferences? sharedPreferences;

void main() async {
  final service = FlutterBackgroundService();
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await service.configure(iosConfiguration: IosConfiguration(), androidConfiguration:AndroidConfiguration(onStart: onStart, isForegroundMode: true,autoStartOnBoot: true,autoStart: true));
  service.invoke('setAsBackground');
  service.startService();
  runApp(MyApp());
}

//ToDo Hero animation

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    OnBordingController _controller = Get.put(OnBordingController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'revista',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      builder: EasyLoading.init(),
      initialRoute: '/',
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 500),
      getPages: [
        GetPage(
          name: '/',
          page: () => OnBordingScreen(),
          middlewares: [onBoradingMiddleWare()],
        ),
        GetPage(
            name: '/login', page: () => login(), middlewares: [loginMiddleWare()]),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/forgetpass', page: () => forgetPassword()),
        GetPage(name: '/resetpass', page: () => resetPassword()),
        GetPage(name: '/topic', page: () => TopicScreen()),
        GetPage(name: '/notification', page: () => notification_screen()),
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/CreatePost', page: () => CreatePost()),
        GetPage(name: '/EditProfile', page: () => EditProfileScreen()),
        GetPage(name: '/followers', page: () => FollowersScreen()),
        GetPage(name: '/following', page: () => FollowingScreen()),
        GetPage(name: '/visitProfile', page: () => visiterProfileScreen()),
        GetPage(name: '/Profile', page: () => ProfileScreen()),
        GetPage(name: '/chatScreen', page: () => ChatScreen())
      ],
    );
  }
}

var channel;

notifiy()async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var token = sharedPreferences.getInt('access_id');
  print(token);
  FlutterLocalNotificationsPlugin notifications =
  new FlutterLocalNotificationsPlugin(
  );
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
    channel.stream.listen((newData) async {
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
            android: AndroidNotificationDetails("revista app", "Revista App",
                groupKey: "com.example.revista",
                importance: Importance.max,
                enableVibration: true,
                enableLights: true,
                playSound: true,
                ticker: 'ticker',
                //  largeIcon:  DrawableResourceAndroidBitmap('image'),
                priority: Priority.high,
                subText: dateTime)),
      );
    });
  });
}