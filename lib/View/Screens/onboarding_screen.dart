import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/View/Screens/loginscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Controllers/onbordingcontroller.dart';
import '../IntroPages/intropage_1.dart';
import '../IntroPages/intropage_2.dart';
import '../IntroPages/intropage_3.dart';
import '../IntroPages/intropage_4.dart';
class OnBordingScreen extends StatelessWidget {

  //controller to keep track of page
  PageController controller=PageController();
  //controller to keep track of we are on the last page or not
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
        init: OnBordingController(),
        builder: (OnBordingController  Getcontroller)=> Stack(
          children: [
            PageView(
              controller: controller,
              onPageChanged: (index)=>Getcontroller.changeIndex(index),
              children: [
                IntroPage_1(),
                IntroPage_2(),
                IntroPage_3(),
                IntroPage_4(),
              ],
            ),
               Container(
                 alignment: Alignment(0,0.75),
                 child:
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                 //SKIP
                 GestureDetector(
                 child:
                 Text('Skip'),
                 onTap:(){
                   controller.jumpToPage(3);
                 },
                  ),

                 SizedBox(width: 20,),
                 //dot indicator
                 SmoothPageIndicator(controller: controller, count: 4,effect: WormEffect(activeDotColor: Theme.of(context).primaryColor)),
                     SizedBox(width: 20,),
                  //NEXT OR Get Sated
                     Getcontroller.isLast.value? GestureDetector(
                     child:
                     Text('Get Started'),
                       onTap: ()async{
                       await Getcontroller.switchFirsTimer();
                       },
                 )
                 : GestureDetector(
                   child:
                  Text('Next'),
                   onTap: (){
                    controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,);
                    },),
                   ],
                 ),
               ),

             ],

    ),
      ));
  }
}
