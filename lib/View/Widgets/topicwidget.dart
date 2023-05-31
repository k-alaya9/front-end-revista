import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/topicsController.dart';

class TopicWidget extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final RxBool pressed;
  const TopicWidget({Key? key, required this.id, required this.name, required this.imageUrl, required this.pressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TopicController controller=Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          radius:15,
          onTap: ()=>controller.onPressed(id),
          child: GetX<TopicController>(
             builder: (TopicController controller) { return Stack(
               fit: StackFit.passthrough,
               clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: pressed.value?Border.all(color: Theme.of(context).primaryColor,width: 5):null,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(image: NetworkImage(imageUrl,),fit: BoxFit.fill,)
                  ),
                ),
                pressed.value?Positioned(left: -14,
                  top:-12,
                    child: Icon(Icons.favorite,color: Theme.of(context).primaryColor,size:40,),):SizedBox(),
              ],
             ); },
          ),
        ),
        SizedBox(height: 5,),
        Text(name,style: Theme.of(context).textTheme.bodyText1,)
      ],
    );
  }
}
