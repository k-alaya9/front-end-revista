import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/drawerController.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  drawerController controller = Get.put(drawerController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting) {
          return Scaffold(
            body: Shimmer.fromColors(
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade700,
                enabled: true,
                child:ListView.builder(
                  itemCount: 2,
                    itemBuilder: (context,index)=>Container(
                  child: Image.asset('asset/image/post_.png'),
                ))
                )
          );
        } else {
          return ZoomDrawer(
        menuScreen: DrawerScreen(),
        mainScreen: GetX(
            builder: (drawerController controller) => controller.currentScreen()),
        slideWidth: 290.0,
        borderRadius: 20,
        shadowLayer1Color: Colors.black26,
        shadowLayer2Color: Colors.deepPurple[200],
        showShadow: true,
        angle: 0.0,
        menuBackgroundColor: Colors.deepPurple.shade400,
      );
        }}
    );
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
        backgroundColor: Colors.deepPurple[400],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              height: 150,
              width: 300,
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap:() => controller.setIndex(3),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                              placeholder: (context, url) =>
                                  Image.asset('asset/image/loading.png'),
                              imageUrl: controller.imageUrl!),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment(-0.8,0),
                          child: Text(
                            controller.userName!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 100),
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
            drawerList(Icons.home, "Home Screen", 0),
            drawerList(Icons.save_alt, "Saved_Post", 1),
            drawerList(Icons.settings, "Settings & Privacy", 2),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 15, bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            )
          ],
        ),
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () => controller.setIndex(index),
      child: Container(
        margin: EdgeInsets.only(left: 15, bottom: 20),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black45,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
