import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/topicsController.dart';
import '../Widgets/topicwidget.dart';

class TopicScreen extends StatelessWidget {
  TopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TopicController controller = Get.put(TopicController());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text("Favorite Topics:"),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black, fontSize: 25),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor),
      body: GetX(
        builder: (TopicController controller) => controller.onLoading.value?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),):SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Pick Your Favorite Topics:(at least 1 topic)",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              child: GridView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: controller.items.map((item) {
                  return TopicWidget(
                    id: item.id,
                    name: item.name,
                    imageUrl: item.imageUrl,
                    pressed: item.pressed,
                  );
                }).toList(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 200, bottom: 20, top: 10),
              child: IconButton(
                  onPressed: controller.sendData,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 40,
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
