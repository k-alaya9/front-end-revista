import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
class IntroPage_4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.3),
        body: Column(
          children: [
            // SizedBox(height: 35,),
             ClipOval(
               clipBehavior: Clip.antiAlias,
               child: Container(
                 width: MediaQuery.of(context).size.width*0.8,
                 height: MediaQuery.of(context).size.width*0.8,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: Color(0xffedf1f4),),
                 alignment: Alignment.topCenter,
                 child: Center(
                   child: Lottie.asset('asset/animations/72817-get-started.json', width: MediaQuery.of(context).size.width*0.8,
                     height: MediaQuery.of(context).size.width*0.8,
                   ),
                 ),
                 ),
             ),
                  SizedBox(height: 10,),
                  Center(
                  child:Container(

                  child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text(translator.translate("This is just the start"),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
                  SizedBox(height: 5,),
                  Text(translator.translate("explore the app, find many more features"),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
                  SizedBox(height: 5,),
                  Text(translator.translate("that will make your experience much better"),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
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
