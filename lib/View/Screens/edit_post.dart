import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Controllers/createPostController.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Controllers/edtiPostController.dart';
import '../../Services/apis/forgetpassword_api.dart';
import '../Widgets/topicPost.dart';

class EditPost extends StatelessWidget {
    const EditPost({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var x=Get.put(EditPostController());
    EditPostController controller=Get.find();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,

        appBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          leading: Material(
            color: Theme.of(context).backgroundColor,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.clear, size: 28),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          middle: Text(translator.translate("Edit Your Post"),
              style: Theme.of(context).textTheme.headline1),
          trailing: Material(
            color: Theme.of(context).backgroundColor,
            child: TextButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: () {
                controller.SubmitPost();
              },
              child: Text(translator.translate("Save"),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),

        body: SlidingUpPanel(
          controller: controller.panelController,
          defaultPanelState: PanelState.OPEN,
          minHeight: 20,
          backdropTapClosesPanel: true,
          maxHeight: MediaQuery.of(context).size.height * 0.2,
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          panel: Column(
            children: [
              InkWell(
                onTap: () => controller.switchBottomSheet(),
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Get.bottomSheet(
                                  controller.bottomsheet(),
                                  backgroundColor:
                                  Theme.of(context).backgroundColor,
                                  elevation: 10,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40),
                                      )),
                                  enterBottomSheetDuration:
                                  const Duration(milliseconds: 500),
                                  exitBottomSheetDuration:
                                  const Duration(milliseconds: 500),
                                );
                              },
                              child: Text(translator.translate("Edit photo")))),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CupertinoTextField(
                          cursorColor: Theme.of(context).primaryColor,
                          maxLines: 1,
                          prefix: Icon(Icons.link),
                          placeholder: translator.translate("Paste Your URL HERE"),
                          controller: controller.UrlTextField,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          body: GetX(
            builder: (EditPostController controller) => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                placeholder: (context, url) =>
                                    Image.asset('asset/image/loading.png'),
                                imageUrl: controller.profileImage.value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                controller.userName.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                controller.Name.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      indent: 15,
                      endIndent: 15,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 20,
                      child:  FutureBuilder(
                        // future: controller.fetchData(),
                        builder: (context, snapshot) =>
                            ListView.builder(
                                itemCount: controller.items.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 4),
                                        child:GetX(
                                          init: EditPostController(),
                                          builder: (EditPostController controller)=>InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: ()=>controller.onPressed(controller.items[index].id),
                                            child: Container(
                                                width: 100,
                                                padding: EdgeInsets.all(5),
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(10),
                                                  color:controller.items[index].pressed.value?Theme.of(context).primaryColor:Theme.of(context).accentColor,
                                                ),
                                                child: Center(child: Text(controller.items[index].name,style: Theme.of(context).textTheme.bodyText1,maxLines: 1,overflow: TextOverflow.ellipsis),)
                                            ),
                                          ),
                                        )
                                    )),
                      ),
                    ),
                    Divider(
                      indent: 15,
                      endIndent: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: IntrinsicHeight(
                        child: TextField(
                          controller: controller.PostTextField,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText:
                            translator.translate("Have something to share with the community?"),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey, fontSize: 16),
                            border: InputBorder.none,
                            enabled: true,
                          ),
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16),
                          enableSuggestions: true,
                          enabled: true,
                        ),
                      ),
                    ),
                    controller.fileImage.value.path != ''||controller.PostImage.value!=''
                        ? Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 200,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              clipBehavior: Clip.none,
                              height: 200,
                              width:
                              MediaQuery.of(context).size.width - 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                 ),
                              child: Center(child:
                              controller.PostImage.value!=''?
                              Image.network(controller.PostImage.value):Image.file(
                                  controller.fileImage.value),),
                            ),
                            controller.fileImage.value.path != ''||controller.PostImage.value!=''
                                ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade100,
                                ),
                                child: IconButton(
                                    onPressed:
                                    controller.deletePhoto,
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                    )),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
