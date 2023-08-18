import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
class IntroPage_2 extends StatelessWidget {

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
                  color: Color(0xffecf5fc)

              ),
              child: Lottie.asset('asset/animations/43320-main.json',width: MediaQuery.of(context).size.width*0.8,
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
              Text(translator.translate("Stay Up To Date"),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
              SizedBox(height: 5,),
              Text(translator.translate("On Topics that intersts you"),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
              SizedBox(height: 5,),
              Text(translator.translate("Like posts, share your opinion and save them for later"),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,) ,
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
