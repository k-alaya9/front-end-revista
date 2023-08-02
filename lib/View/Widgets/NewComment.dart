import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:revista/Services/apis/reply_api.dart';
import 'package:revista/main.dart';

import '../../Controllers/commentController.dart';
import '../../Services/apis/comment_api.dart';

class comment_Screen extends StatelessWidget {
  var x=Get.put(CommentController());

  CommentController controller = Get.find();
  final id;
  final isComment;
  comment_Screen({super.key, this.id,required this.isComment,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Theme.of(context).primaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.image_outlined,
                color: Theme.of(context).primaryColor,
              )),
          Expanded(
            child: Container(
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                minLines: 1,
                //Normal textInputField will be displayed
                maxLines: 3,
                // when user presses enter it will adapt to it
                controller: controller.commentController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: isComment? 'Enter your comment !':'Enter your Reply',
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
          GetBuilder(builder: (CommentController controller)=>IconButton(
            disabledColor: Colors.grey,
            onPressed: controller.commentController.text.isNotEmpty? () async {
              final content = controller.commentController.text.trim();
              final token = sharedPreferences!.getString(
                  'access_token'); // Replace with the user's authentication token
              isComment?await newComment(id, content, token!):await newReply(id, content, token!);
              controller.commentController.clear();

            }:null,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          ),

          )
        ],
      ),
    );
  }
}
