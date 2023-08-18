import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Controllers/settingsController.dart';
import 'package:revista/Services/apis/settings_api.dart';
import 'package:revista/View/Screens/block_list.dart';
import 'package:revista/View/Screens/change_email.dart';
import 'package:revista/View/Widgets/drawerWidget.dart';
import 'package:revista/main.dart';

import 'change_password.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(settingsController());
    settingsController controller=Get.find();



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 1,
        leading: DrawerWidget(),centerTitle: true,
        title: Text(
            translator.translate("Settings"), style: Theme.of(context).textTheme.headline1
        ),

      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 10, right: 16),
          child: ListView(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black26,
                  ),
                  SizedBox(width: 10,),
                  Text(translator.translate("Account"), style:Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30))
                ],
              ),
              Divider(height: 15, thickness: 2,
              ),
              buildAccountOption(context, translator.translate("Change Password"), () {
                Get.to(()=>Change_Password());
              }),
              buildAccountOption(context, translator.translate("Change email"), () {
                Get.to(()=>Change_Email());
              }),
            GetX(builder: (settingsController controller) =>   buildLanguageOption(translator.translate("Language"), controller.valLan1.value, controller.onChangeFunctions1),),
              buildAccountOption(context, translator.translate("Block list"), () async{
                await controller.fetchData();
                Get.to(()=>Block_List());
              }),
              buildAccountOption(context, translator.translate("deactivate account"), () {
                Get.defaultDialog(content: Text(translator.translate("Are you sure you want to deactive your account")),onCancel: (){
                  Get.back();
                }, onConfirm: ()async{
                  final token=sharedPreferences!.getString('access_token');
                  await deactiveAccount(token);
                },title:translator.translate( "Deactivate account" ));
              }),

            ],

          )

      ),
    );
  }
}



  @override


  Padding buildLanguageOption(String title, bool value,
      Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(Get.context!).textTheme.headline1
          ),
          Transform.scale(
            scale: 0.7,
            child:  CupertinoSwitch(
              activeColor: Theme.of(Get.context!).primaryColor,
              trackColor: Theme.of(Get.context!).accentColor,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
                translator.setNewLanguage(
                  Get.context!,
                  newLanguage: translator.currentLanguage=='ar'?'en':'ar',
                  restart: true,
                );
              }
              ,
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title, func) {
    return GestureDetector(
      onTap: func,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.headline1
            ),
            Icon(Icons.arrow_forward_ios,
              color: Colors.black26,)
          ],
        ),
      ),

    );
  }

