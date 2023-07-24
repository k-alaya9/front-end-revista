import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../Controllers/commentController.dart';
class comment_Screen extends StatelessWidget {
  CommentController controller =Get.find();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Theme.of(context).primaryColor,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.image_outlined,color: Theme.of(context).primaryColor,)),
          Expanded(
            child: Container(
              child: TextField(
                cursorColor:Theme.of(context).primaryColor,
                minLines: 1,//Normal textInputField will be displayed
                maxLines: 3,// when user presses enter it will adapt to it
                controller:controller.commentController ,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Enter your comment !',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor,),
                      borderRadius: BorderRadius.circular(30),
                    )
                ),
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.send,color: Theme.of(context).primaryColor,))
        ],
      ),
    );
  }
}
