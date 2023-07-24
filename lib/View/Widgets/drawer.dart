import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
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
    Get.put(notificationsController(),permanent: true);
    return Obx(() {
      if (controller.imageUrl.isNotEmpty && controller.userName.isNotEmpty) {
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
      } else {
        return Scaffold(
            body: Shimmer.fromColors(
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade700,
                enabled: true,
                child:ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context,index)=>Container(
                      child: Column(children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          elevation: 2,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                                shape: BoxShape.rectangle,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Container(
                                              width: 60,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 400,
                                              height: 400,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, 0),
                                      child:Container(
                                        width: 60,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black54,
                                      thickness: 1,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                        ),
                        SizedBox(height: 20,),
                      ],)
                    ))
            )
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
                    child: GetX(
                      builder: (drawerController controller)=>
                          Column(
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
                                alignment: Alignment(-0.8,0),
                                child: Text(
                                  controller.userName.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white, fontSize: 16),
                                ),
                              )
                            ],
                          ),
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
              onTap: ()async{
                try{
                  var token =await getAccessToken();
                  await logout(token);
                }catch(e){
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
