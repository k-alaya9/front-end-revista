import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class IntroPage_3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        body: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF2E7FE),),
              //alignment: Alignment.topCenter,
              child: Lottie.asset('asset/animations/116791-chat.json', width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.width*0.8,
                  //fit: BoxFit.fill
              ),
            ),
              SizedBox(height: 10,),
              Center(
              child:Container(

              child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text('Strike conversations with people',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
              SizedBox(height: 5,),
              Text('On common topics',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
              SizedBox(height: 5,),
              Text('And share relevant posts in chats',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
      ],
      ),

      ),
              ),
      ],
        ),
      ),
    );

  }
}
