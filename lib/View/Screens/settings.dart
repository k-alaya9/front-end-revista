import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/settingsController.dart';
import 'package:revista/Services/apis/settings_api.dart';
import 'package:revista/View/Screens/block_list.dart';
import 'package:revista/View/Screens/change_email.dart';
import 'package:revista/View/Widgets/drawerWidget.dart';
import 'package:revista/main.dart';

import 'change_password.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool valLan1 = true;

  onChangeFunctions1(bool newValue1) {
    setState(() {
      valLan1 = newValue1;
    });
  }

  @override
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
            'Settings', style: Theme.of(context).textTheme.headline1
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
                  Text("Account", style:Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30))
                ],
              ),
              Divider(height: 15, thickness: 2,
              ),
              buildAccountOption(context, "Change Password", () {
                Get.to(()=>Change_Password());
              }),
              buildAccountOption(context, "Change email", () {
                Get.to(()=>Change_Email());
              }),
              buildLanguageOption("Language", valLan1, onChangeFunctions1),
              buildAccountOption(context, "Block list", () async{
                await controller.fetchData();
                Get.to(()=>Block_List());
              }),
              buildAccountOption(context, "deactivate account", () {
                Get.defaultDialog(content: Text('Are you sure you want to deactive your account'),onCancel: (){
                  Get.back();
                }, onConfirm: ()async{
                  final token=sharedPreferences!.getString('access_token');
                  await deactiveAccount(token);
                },title: 'Deactivate account' );
              }),

            ],

          )

      ),
    );
  }

  Padding buildLanguageOption(String title, bool value,
      Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline1
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Theme.of(context).primaryColor,
              trackColor: Theme.of(context).accentColor,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
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
}
