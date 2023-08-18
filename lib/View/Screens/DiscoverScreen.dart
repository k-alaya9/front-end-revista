import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../Controllers/search_controller.dart';
import '../Widgets/post.dart';
import '../Widgets/searchBar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    SearchController controller = Get.find();
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translator.translate("Explore"),
                            style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30)),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 46,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextField(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: CustomSearch(),
                              );
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: translator.translate("Search"),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GetX(
                            builder: (SearchController controller) {
                              return Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.selected.value = true;
                                        for (int i = 0;
                                            i < controller.topics.length;
                                            i++) {
                                          controller.topics[i].pressed.value =
                                              false;
                                        }
                                        controller.getlist(0);
                                      },
                                      splashFactory: NoSplash.splashFactory,
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: controller.selected.value
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 5,
                                        ),
                                        child: Center(child: Text(translator.translate("General"),style: Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.white),)),
                                      )),
                                  Container(
                                    height: 40,
                                    child: ListView.builder(
                                      itemCount: controller.topics.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            controller.selected.value = false;
                                            for (int i = 0;
                                                i < controller.topics.length;
                                                i++) {
                                              if (index != i) {
                                                controller.topics[i].pressed
                                                    .value = false;
                                              }
                                            }
                                            controller.topics[index].pressed
                                                .value = true;
                                            controller.getlist(
                                                controller.topics[index].id);
                                          },
                                          splashFactory: NoSplash.splashFactory,
                                          child: GetX( builder: (SearchController controller) { return Container(
                                        decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: controller.topics[index]
                                            .pressed.value
                                        ? Theme.of(context)
                                            .primaryColor
                                            : Colors.grey,
                                        ),
                                            width: 100,
                                            height: 40,
                                            padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.symmetric(
                                        // vertical: 20,
                                        horizontal: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                          controller.topics[index].name,style: TextStyle(color: Colors.white)),
                                        ),
                                        ); },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Divider(color: Get.isDarkMode?Colors.white:Colors.black45,)
                      ],
                    ),
                  ),
                )
              ];
            },
            // floatHeaderSlivers: true,
            scrollBehavior: CupertinoScrollBehavior(),
            body: Container(
              child: GetX(
                builder: (SearchController controller) => ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.data.length,
                  itemBuilder: (ctx, index) {
                    var name = controller.data[index].author!.user!.firstName! +
                        controller.data[index].author!.user!.lastName!;
                    var date = DateFormat('yyyy-mm-dd')
                        .parse(controller.data[index].createdAt!);
                    // print(controller.data[index].topics);
                    if (controller.data.isNotEmpty) {
                      return Column(
                        children: [
                          Post(
                            saveId: controller.data[index].saveId,
                            likeId: controller.data[index].likeId,
                            authorId: controller.data[index].author!.id!,
                            topics: controller.data[index].topics!,
                            id: controller.data[index].id,
                            imageUrl: controller.data[index].image,
                            username:
                                controller.data[index].author!.user!.username,
                            date: date,
                            url: controller.data[index].link,
                            numberOfLikes:
                                controller.data[index].likesCount.obs,
                            textPost: controller.data[index].content,
                            nickName: name,
                            numberOfComments: controller
                                .data[index].commentsCount
                                .toString()
                                .obs,
                            userImage: controller
                                .data[index].author!.user!.profileImage,
                            key: ValueKey(controller.data[index].id),
                          ),
                          Container(
                              color: Theme.of(context).backgroundColor,
                              child: Divider(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      );
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                ),
              ),
            )));
  }
}
