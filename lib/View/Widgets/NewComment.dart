import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:revista/main.dart';

import '../../Controllers/commentController.dart';
import '../../Services/apis/comment_api.dart';

class comment_Screen extends StatelessWidget {
  var x=Get.put(CommentController());

  CommentController controller = Get.find();
  final id;

  comment_Screen({super.key, this.id});

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
                    hintText: 'Enter your comment !',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
          ),
          GetBuilder(builder: (CommentController controller)=>IconButton(
            disabledColor: Colors.grey,
            onPressed: controller.commentController.text.isNotEmpty? () async {
              final content = controller.commentController.text.trim();
              final token = sharedPreferences!.getString(
                  'access_token'); // Replace with the user's authentication token
              final postId = id; // Replace with the ID of the post
              print(postId);
              await newComment(postId, content, token!);
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
