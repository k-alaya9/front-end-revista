import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';

import '../../Controllers/settingsController.dart';

class Change_Email extends StatefulWidget {
  const Change_Email({Key? key}) : super(key: key);

  @override
  State<Change_Email> createState() => _Change_EmailState();
}

class _Change_EmailState extends State<Change_Email> {
  settingsController controller=Get.find();
  @override
  Widget build(BuildContext context) {
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
          title: Text( translator.translate("Change Email"), style:Theme.of(context).textTheme.headline1
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
          child: Form(
            key: controller.emailKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text( translator.translate("Change your Email "),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 25.0,),

                  TextFormField(
                    controller: controller.userNameEmailController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      labelText:  translator.translate("UserName"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(15)),
                      border:  OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return  translator.translate("This filed is required");
                      }
                    },
                    onSaved: (val) {
                      controller.userNameEmail = val!;
                    },
                  ),
                  SizedBox(height: 45.0,),
                  TextFormField(
                    controller: controller.newEmailController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      labelText:  translator.translate("New Email"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(15)),
                      border:  OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return translator.translate("This filed is required");
                      }
                      if(!val!.isEmail){
                        return translator.translate("please enter a valid email");
                      }
                    },
                    onSaved: (val) {
                      controller.newEmail = val!;
                    },
                  ),
                  SizedBox(height: 50.0,),

                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                      ),
                      width: double.infinity,
                      child : MaterialButton(
                        onPressed: () {
                          controller.submitEmail();
                        },
                        child: Text(
                          translator.translate("Change Email"),
                          style: TextStyle(color: Colors.white),
                        ) ,

                      )
                  )
                ]

            ),
          ),)
        )

    );
  }
}
