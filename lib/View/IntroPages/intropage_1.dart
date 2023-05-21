import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class IntroPage_1 extends StatelessWidget {
  const IntroPage_1({Key? key}) : super(key: key);

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
               child: Lottie.asset('asset/animations/85795-man-and-woman-say-hi.json', width: MediaQuery.of(context).size.width*0.8,
                 height: MediaQuery.of(context).size.width*0.8,

                 //fit: BoxFit.fill,
               ),
               ),
            SizedBox(height: 10,),
            Center(
                child:Container(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Welcome to revista app',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
                    SizedBox(height: 5,),
                    Text('Where you can find all the topics',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
                      SizedBox(height: 5,),
                    Text('that peak your interest and many more!',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
                ],
                  ),

            ),



        ),
      ],
        )
      ),
    );

  }
}
