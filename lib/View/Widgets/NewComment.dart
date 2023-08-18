import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:revista/Services/apis/reply_api.dart';
import 'package:revista/main.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import '../../Controllers/commentController.dart';
import '../../Services/apis/comment_api.dart';

class comment_Screen extends StatelessWidget {
  var x=Get.put(CommentController());

  CommentController controller = Get.find();
  final id;
  RxBool isComment;
  comment_Screen({super.key, this.id,required this.isComment,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Obx(()=>FlutterMentions(
                  key:controller.mentionsKeyComment,
                  suggestionPosition: SuggestionPosition.Top,
                  onChanged: (value){
                    controller.text!.value=value;
                      var v=value.replaceAll('@','');
                      controller.getSearch(v);
                  },
                  mentions: [
                    Mention(
                        trigger:'@',
                      disableMarkup: true,
                      matchAll: true,
                      data:controller.allData,
                      suggestionBuilder: (data) {
                          print(data);
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data['photo'],
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: <Widget>[
                                  Text(data['full_name']),
                                  Text('@${data['display']}'),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    ),
                  ],
                  cursorColor: Theme.of(context).primaryColor,
                  minLines: 1,
                  //Normal textInputField will be displayed
                  maxLines: 3,
                  // when user presses enter it will adapt to it
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: isComment.value? translator.translate("Enter your comment !"):translator.translate("Enter your Reply"),
                    contentPadding: const EdgeInsets.all(10),
                    focusColor: Theme.of(context).primaryColor,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(30)),),
                ),
              ),
            ),
          ),
          Obx(()=>IconButton(
            disabledColor: Colors.grey,
            onPressed:controller.text!.value.isNotEmpty?()=>controller.send(controller.text!.value, isComment, id) :null,
            icon: Icon(
              Icons.send,
              color:controller.text!.value!=null && controller.text!.value.isNotEmpty? Theme.of(context).primaryColor:Colors.grey,
            ),
          ),

          )
        ],
      ),
    );
  }
}
