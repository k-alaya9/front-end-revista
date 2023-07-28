import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/ProfileController.dart';

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
        middle: Text('Profile Settings',
            style: Theme.of(context).textTheme.headline1),
        trailing: Material(
          color: Theme.of(context).backgroundColor,
          child: TextButton(
              onPressed: controller.editData,
              child: Text(
                'Done',
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
                  child: Text('Change'),
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
                            "first name:",
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
                              hintText: 'First Name',
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
                                return 'Invalid Name';
                              }
                              if (val.isEmpty) {
                                return 'Enter Your FirstName';
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
                            "last name:",
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
                                hintText: 'Last Name',
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
                                  return "Invalid Name";
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
                        "Username:",
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
                            hintText: 'Username',
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
                              return 'This filed is required';
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
                        "Bio:",
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
                        height: 40,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          // initialValue:bio ?? '',
                          controller: controller.bioController,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'tell people about you',
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
                        ))
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
