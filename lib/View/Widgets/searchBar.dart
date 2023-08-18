import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revista/Models/searchModel.dart';
import 'package:revista/Services/apis/search_api.dart';
import 'package:revista/main.dart';

import '../../Controllers/search_controller.dart';

// class SearchScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title:Text('Search Bar Page') ,
//         actions: [
//           IconButton(onPressed: (){
//             showSearch(
//                 context: context,
//                 delegate: CustomSearch(),
//             );
//           },
//               icon: Icon(Icons.search))
//         ],
//       ),
//       );
//
//   }
// }
class CustomSearch extends SearchDelegate{
  SearchController controller=Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: (){
            if(query.isEmpty)
              close(context, null);
            else
              query='';
          },
          icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      body: Column(children: [
      Container(
        child: ListView.builder(
          shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemCount: controller.searchResults.length,
            itemBuilder: (context,index){
              return ListTile(
                leading:Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(controller.searchResults[index].profileImage!)),
                    )) ,
                title: Text(controller.searchResults[index].username!,style: Theme.of(context).textTheme.bodyText1,),
                subtitle: Text(controller.searchResults[index].firstName!+' '+controller.searchResults[index].lastName!,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                onTap:()async{
                  controller.fetchData();
                  final token=sharedPreferences!.getString('access_token');
                  await addHistory(token,controller.searchResults[index].username!);
                  var id=sharedPreferences!.getInt('access_id');
                  print(id);
                  controller.searchResults[index]!.id==id?
                  Get.toNamed('/Profile')
                      :
                  Get.toNamed('/visitProfile', arguments: {
                    'id': controller.searchResults[index].id,
                  });
                },
              );
            }
        ),
      ),
      ]),
    );
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    controller.getSearch(query);
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemCount: controller.allData.length,
        itemBuilder: (context,index){
          return ListTile(
            leading:Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(controller.allData[index].searchedUser!.profileImage!)),
            )) ,
            title: Text(controller.allData[index].searchedUser!.username!,style: Theme.of(context).textTheme.bodyText1,),
            subtitle: Text(controller.allData[index].searchedUser!.firstName!+''+controller.allData[index].searchedUser!.lastName!),
            onTap:(){
              var id=sharedPreferences!.getInt('access_id');
              print(id);
              controller.allData[index].searchedUser!.id==id?
                  Get.toNamed('/Profile')
                  :
              Get.toNamed('/visitProfile', arguments: {
                'id': controller.allData[index].searchedUser!.id,
              });
            },
          );
        }
    );
  }

}