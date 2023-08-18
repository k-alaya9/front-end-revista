import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/View/Screens/streamsScreen.dart';

import '../../Controllers/cameraController.dart';
import '../../Controllers/notifications_controller.dart';
import '../Widgets/drawerWidget.dart';


class Lives extends StatelessWidget {
  const Lives({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(cameraController());
    return Scaffold(
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: DrawerWidget(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        middle: Container(
          margin: EdgeInsets.only(top: 3,bottom: 3,right: 45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('asset/image/logo.png'),isAntiAlias: true,filterQuality: FilterQuality.high,fit: BoxFit.contain)
          ),
        ),
        trailing: GetX(builder: (notificationsController ncontroller)=>
            InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: (){
                Get.toNamed('/notification');
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications_active_outlined),
                  if(ncontroller.notifiction_number.value!=0)
                    Positioned(
                      right: -8,
                      top: -7,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(child: Text((ncontroller.notifiction_number.value).toInt().toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)),),
                      ),
                    ),
                ],
              ),
            ),
        ),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: GetX(
            builder: (cameraController controller) => MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.Streams.length,
              itemBuilder: (ctx, index) {
                if (controller.Streams.isNotEmpty) {
                  return InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap:(){
                      Get.to(()=>MyAppdd(role: false),arguments: {
                        'channel': controller.Streams[index].id
                      });
                    },
                    child: Container(
                      width: 300,
                      height: 180,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                border: Border.all(color: Theme.of(context).primaryColor),
                                image: DecorationImage(image: NetworkImage(controller.Streams[index].streamer!.profileImage!))
                              ),
                            ),
                            Container(
                              child: Text(controller.Streams[index].streamer!.username!,style: Theme.of(context).textTheme.headline1,),
                            ),
                            Container(
                              child: Text(controller.Streams[index].title!,style: Theme.of(context).textTheme.bodyText1,),
                            ),
                            Container(
                              child: Text(controller.Streams[index].description!,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                            ),
                          ],
                        )
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(translator.translate("There is no live yet")),
                  );
                }
              },
            ),
          )),
    );
  }
}
