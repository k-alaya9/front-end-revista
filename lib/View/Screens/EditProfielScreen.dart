import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Controllers/ProfileController.dart';
import 'package:revista/Services/apis/topic_api.dart';
import 'package:revista/main.dart';

import '../../Controllers/followingController.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();
    var username=controller.Username.value;
    var bio=controller.bio.value;
    var firstname=controller.firstname.value;
    var lastname=controller.lastName.value;

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Material(
          color: Theme.of(context).backgroundColor,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        middle: Text(translator.translate("Profile Settings"),
            style: Theme.of(context).textTheme.headline1),
        trailing: Material(
          color: Theme.of(context).backgroundColor,
          child: TextButton(
              onPressed: controller.editData,
              child: Text(
                translator.translate( "Done"),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            style: ButtonStyle(splashFactory: NoSplash.splashFactory),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetX(
                  builder: (ProfileController controller)=>ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        placeholder: (context, url) =>
                            Image.asset('asset/image/loading.png'),
                        imageUrl: controller.profileImage.value),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                      controller.bottomsheet(1),
                      elevation: 10,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      backgroundColor: Theme.of(context).backgroundColor,
                      enterBottomSheetDuration: const Duration(milliseconds: 500),
                      exitBottomSheetDuration: const Duration(milliseconds: 500),
                    );
                  },
                  child: Text(translator.translate("Change")),
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    elevation: MaterialStatePropertyAll(0),
                    backgroundColor:
                        MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            translator.translate( "first name:"),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          child: TextFormField(
                           // initialValue: firstname??'',
                            controller: controller.firstnameController,
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: translator.translate("First Name"),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1)),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                            validator: (val) {
                              if (val!.isNum) {
                                return translator.translate("Invalid Name");
                              }
                              if (val.isEmpty) {
                                return translator.translate("Enter Your FirstName");
                              }
                            },
                            onSaved: (val) {
                              controller.firstname.value = val!;
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            translator.translate("last name:"),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          child: TextFormField(
                            // initialValue:lastname??'',
                              controller: controller.lastnameController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: translator.translate("Last Name"),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                              validator: (val) {
                                if (val!.isNum) {
                                  return translator.translate("Invalid Name");
                                }
                              },
                              onSaved: (val) {
                                controller.lastName.value = val!;
                              }),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        translator.translate("Username:"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          // initialValue:username ?? '',
                          controller: controller.usernameController,
                          decoration: InputDecoration(
                            hintText: translator.translate("Username"),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return translator.translate("This filed is required");
                            }
                          },
                          onSaved: (val) {
                            controller.Username.value = val!;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        translator.translate("Bio:"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 120,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          // initialValue:bio ?? '',
                          controller: controller.bioController,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: translator.translate("tell people about you"),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                          validator: (val) {},
                          onSaved: (val) {
                            controller.bio.value = val!;
                          },
                        )),
                    ListView.builder
                      (
                      itemCount: controller.items.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              enabled: true,
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage(controller.items[index].imageUrl)),
                                ),
                              ),
                              title: Text(controller.items[index].name ,
                                  style: Theme.of(context).textTheme.bodyText1),
                              subtitle: Text(
                                username,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.grey, fontSize: 13),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () async {
                                    controller.followtopics(index);
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context).primaryColor),
                                    ),
                                    child: GetX(builder: ( ProfileController controller)=>
                                        Text(controller.items[index].pressed.value?'unFollow':'Follow')),
                                    )
                                    ),
                              ),
                            ),
                        ],
                      );
                    },)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
