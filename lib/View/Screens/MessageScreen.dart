

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Controllers/messageScreenController.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/notifications_controller.dart';
import '../Widgets/drawerWidget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(messageScreenController());
    messageScreenController controller=Get.find();
    return Scaffold(
     appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero ,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: DrawerWidget(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        middle: Text(translator.translate("Chat"),style: Theme.of(context).textTheme.headline1),
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
        body:FutureBuilder(
            future: controller.fetchData(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey.shade500,
                    highlightColor: Colors.grey.shade700,
                    enabled: true,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 0.2)),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              style: ListTileStyle.drawer,
                              leading: Container(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey.shade900,
                                ),
                              ),
                              title: Container(
                                  width: 100,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      shape: BoxShape.rectangle)),
                              subtitle: Container(
                                  width: 150,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      shape: BoxShape.rectangle)),
                              trailing: Container(
                                  width: 20,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      shape: BoxShape.rectangle)),
                            ),
                          ),
                        ),
                      ),
                    ));
              }
              // final reversedNotifications =List.generate(10, (index) => print(index));
              // var date=DateTime.now();
              return SmartRefresher(
                header: ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
                onRefresh: controller.onRefresh,
                enablePullDown: true,
                controller: controller.refreshController,
                child: ListView.builder(
                  physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.chats.length,
                    itemBuilder: (context, index) {
                      var date;
                      if(controller.chats[index].lastMessage!=null){
                        if(controller.chats[index].lastMessage!.createdAt!=null) {
                          date =DateFormat('yyyy-mm-dd').add_Hm().parse(controller.chats[index].lastMessage!.createdAt!.replaceAll('T',' '));
                        } else {
                          date=DateTime.now();
                        }
                        if(controller.chats.isNotEmpty) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds:500),
                            child: SlideAnimation(
                              verticalOffset: 100,
                              child: FadeInAnimation(
                                duration: const Duration(milliseconds: 500),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.13,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                    onTap: (){
                                      print(controller.chats[index].id!);
                                      Get.toNamed('/chatScreen',arguments: {
                                        'chat_id': controller.chats[index].id!,
                                        'username':controller.chats[index].user!.username,
                                        'imageUrl':controller.chats[index].user!.profileImage,
                                      });
                                    },
                                    style: ListTileStyle.list,
                                    leading: Stack(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: NetworkImage(controller.chats[index].user!.profileImage!)),
                                          ),
                                          margin: EdgeInsets.all(5),
                                        ),
                                        Positioned(
                                            left: 35,
                                            bottom: 5,
                                            child: GetX(
                                              builder: (messageScreenController controller) =>
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: controller.chats.value[index].user!.isOnline==true?Colors.green:Colors.grey,
                                                    ),
                                                  ),
                                            )),
                                      ],
                                    ),
                                    title: Text(controller.chats[index].user!.username!,style: Theme.of(context).textTheme.bodyText1,),
                                    subtitle: controller.chats[index].lastMessage!=null?Text(controller.chats[index].lastMessage!.type=='text'?controller.chats[index].lastMessage!.text!:
                                    controller.chats[index].lastMessage!.type=='image'?
                                    'photo':'voice record'
                                      ,style: Theme.of(context).textTheme.bodyText1!.copyWith(overflow:TextOverflow.fade,color: Colors.grey.withOpacity(0.5) ),)
                                        :Container(),
                                    trailing: Column(
                                      children: [
                                        // Container(
                                        //   margin: EdgeInsets.only(top: 10,bottom: 0),
                                        //   width: 10,
                                        //   height: 10,
                                        //   decoration: BoxDecoration(
                                        //     color: Theme.of(context).accentColor,
                                        //     shape: BoxShape.circle
                                        //   ),
                                        // ),
                                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 10, 0),child:Text("${DateFormat('yyyy-M-dd').add_Hm().format(date)}",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Get.isDarkMode?Colors.white30:Colors.black26
                                        ),) ),
                                      ],
                                    ),

                                  ),

                                ),
                              ),
                            ),
                          );
                        }
                        else{
                          return Center(child: Text(translator.translate("You Dont have any chat yet")),);
                        }
                      }
                      return Container();
                    }

                )
                ,
              );

            })
    );
  }
}
