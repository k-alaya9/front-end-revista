import 'package:get/get.dart';

class topicItem{
  int id;
  var name;
  var imageUrl;
  RxBool pressed;
  RxInt followId=0.obs;
  topicItem({required this.id,required this.name,required this.imageUrl,required this.pressed});


  factory topicItem.fromJson(Map<String,dynamic>json){
   return topicItem(id: json['id'], name:json['name'], imageUrl: json['image'], pressed: false.obs,);
  }
}