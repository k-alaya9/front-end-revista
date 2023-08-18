import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';
import 'package:revista/Services/apis/settings_api.dart';
import 'package:revista/main.dart';

import '../../Controllers/settingsController.dart';

class Block_List extends StatelessWidget {
  Block_List({Key? key}) : super(key: key);

  settingsController controller=Get.find();

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back, color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text( translator.translate('Block List'), style: Theme.of(context).textTheme.headline1
        ),
      ),
      body:
      Container(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text( translator.translate("Once you block someone, that person can no longer see things you post on your Timeline,"),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 2)
                ),),
                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(itemCount:controller.blockList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics() ,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.grey,width: 0.7),
                        //   shape: BoxShape.rectangle,
                        //   borderRadius: BorderRadius.circular(12),
                        // ),

                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          enabled: true,
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage(controller.blockList[index].blocked!.user!.profileImage!)),
                            ),
                          ),
                          title: Text('${controller.blockList[index].blocked!.user!.firstName}' + ' ' + '${controller.blockList[index].blocked!.user!.lastName}',
                              style: Theme.of(context).textTheme.bodyText1),
                          subtitle: Text(
                            '${controller.blockList[index].blocked!.user!.username}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey, fontSize: 13),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  final token=sharedPreferences!.getString('access_token');
                                  await unblock(token, controller.blockList[index].id);
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStatePropertyAll(0),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).primaryColor),
                                ),
                                child: Text( translator.translate("unblock"))),
                          ),
                        ),
                      );
                    },),
                )

              ]
          ),
        ),
      ),



    );
  }
}
