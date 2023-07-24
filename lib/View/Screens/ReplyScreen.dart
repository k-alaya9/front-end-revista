import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/replyController.dart';

import '../Widgets/Comment.dart';
import '../Widgets/NewComment.dart';
class ReplyScreen extends StatelessWidget {
  var x=Get.put(ReplyController());
  ReplyController controller =Get.find();

  ReplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // CommentScreen(
                //
                // ),
                Card(
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:6),
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics:ScrollPhysics(),
                        itemCount: controller.Replies.length,
                        itemBuilder:  (ctx, index) {
                          return Column(
                            children: [
                              Container(
                                // child: CommentScreen(
                                //
                                // ),
                              ),
                            ],
                          );
                        },
                      ),

                    ),
                  ),

                ),
                //new Comment
                comment_Screen(),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
