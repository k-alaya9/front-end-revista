import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:revista/Services/apis/login_api.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/drawerController.dart';
import '../../Controllers/notifications_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  drawerController controller = Get.put(drawerController());

  @override
  Widget build(BuildContext context) {
    Get.put(notificationsController(), permanent: true);
    return Obx(() {
      if (controller.imageUrl.isNotEmpty && controller.userName.isNotEmpty) {
        return ZoomDrawer(
          menuScreen: DrawerScreen(),
          mainScreen: GetX(builder: (drawerController controller) {
            return controller.currentScreen();
          }),
          slideWidth: MediaQuery.of(context).size.width * 0.8,
          borderRadius: 30,
          showShadow: true,
          moveMenuScreen: true,
          angle: 0.0,
          menuBackgroundColor: Colors.blueGrey,
          androidCloseOnBackTap: true,
          menuScreenTapClose: true,
          mainScreenTapClose: true,
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              color: Theme.of(context).backgroundColor,
              child: Lottie.asset('asset/animations/logo.mp4.lottie (1).json',
                  alignment: Alignment.center,
                  repeat: true,
                  animate: true,
                  reverse: true,
                  frameRate: FrameRate.max,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height),
            ),
          ),
        );
      }
    });
  }
}

class DrawerScreen extends StatelessWidget {
  DrawerScreen({
    Key? key,
  }) : super(key: key);
  drawerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Container(
                color: Theme.of(context).primaryColor,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () => controller.setIndex(3),
                      child: GetX(
                        builder: (drawerController controller) => Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    placeholder: (context, url) =>
                                        Image.asset('asset/image/loading.png'),
                                    imageUrl: controller.imageUrl.value!),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  controller.userName.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.white, fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 70, right: 5),
                      child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          radius: 200,
                          borderRadius: BorderRadius.circular(250),
                          onTap: () => controller.switchMode(),
                          child: Lottie.asset(controller.darkMode,
                              repeat: false,
                              controller: controller.darkmodeController,
                              fit: BoxFit.contain,
                              height: 40)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            drawerList(Icons.home, translator.translate("Home Screen"), 0, context),
            drawerList(Icons.save_alt, translator.translate("Saved Posts"), 1, context),
            drawerList(Icons.settings, translator.translate("Settings & Privacy"), 2, context),
            GestureDetector(
              onTap: () async {
                try {
                  var token = await getAccessToken();
                  await logout(token);
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(translator.translate("Logout"),
                        style: Theme.of(context).textTheme.headline1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index, context) {
    return GestureDetector(
      onTap: () => controller.setIndex(index),
      child: Container(
        margin: EdgeInsets.only(left: 15, bottom: 20),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 12,
            ),
            Text(text, style: Theme.of(context).textTheme.headline1),
          ],
        ),
      ),
    );
  }
}
