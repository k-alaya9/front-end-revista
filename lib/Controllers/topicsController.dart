import 'package:get/get.dart';
class topicItem{
  int id;
  String name;
  String imageUrl;
  RxBool pressed;
  topicItem({required this.id,required this.name,required this.imageUrl,required this.pressed});
}
class TopicController extends GetxController{
   List<topicItem>items=[
    topicItem(id: 1, name: 'news', imageUrl: 'asset/image/news.jpg',pressed: false.obs),
    topicItem(id: 2, name: 'education', imageUrl: 'asset/image/education.jpg',pressed: false.obs),
    topicItem(id: 3, name: 'entertainment', imageUrl: 'asset/image/entertainment.jpg',pressed: false.obs),
    topicItem(id: 4, name: 'sports', imageUrl: 'asset/image/sports.jpg',pressed: false.obs),
    topicItem(id: 5, name: 'food', imageUrl: 'asset/image/food.jpg',pressed: false.obs),
    topicItem(id: 6, name: 'art & crafts', imageUrl: 'asset/image/art & crafts.jpg',pressed: false.obs),
    topicItem(id: 7, name: 'animals & pets', imageUrl: 'asset/image/animals & pets.jpg',pressed: false.obs),
    topicItem(id: 8, name: 'social life', imageUrl: 'asset/image/social life.jpg',pressed: false.obs),
    topicItem(id: 9, name: 'gaming', imageUrl: 'asset/image/gaming.jpg',pressed: false.obs),
    topicItem(id: 10, name: 'business', imageUrl: 'asset/image/business.jpg',pressed: false.obs),
    topicItem(id: 11, name: 'fashion', imageUrl: 'asset/image/fashion.jpg',pressed: false.obs),
    topicItem(id: 12, name: 'travel', imageUrl: 'asset/image/travel.jpg',pressed: false.obs),

  ];

  onPressed(int id){
    for(var item in items){
      if(item.id==id) {
        item.pressed.value=!item.pressed.value;
      }
    }
    update();
  }
}