import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/createPostController.dart';
import 'package:revista/Controllers/topicsController.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';

class TopicWidget extends StatelessWidget {
  final int id;
  final String name;
  final RxBool pressed;

  const TopicWidget(
      {Key? key, required this.id, required this.name, required this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   return GetX(
     init: CreatePostController(),
     builder: (CreatePostController controller)=>InkWell(
       borderRadius: BorderRadius.circular(10),
       onTap: ()=>controller.onPressed(id),
       child: Container(
         width: 100,
         padding: EdgeInsets.all(5),
         height: 100,
         decoration: BoxDecoration(
           shape: BoxShape.rectangle,
           borderRadius: BorderRadius.circular(10),
           color: pressed.value?Theme.of(context).primaryColor:Theme.of(context).accentColor,
         ),
         child: Center(child: Text(name,style: Theme.of(context).textTheme.bodyText1,maxLines: 1,overflow: TextOverflow.ellipsis),)
       ),
     ),
   );
  }
}