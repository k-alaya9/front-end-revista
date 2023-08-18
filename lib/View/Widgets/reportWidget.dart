import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../Controllers/reportController.dart';
class Report extends StatelessWidget {
  final type;
  final id;
  var x=Get.put(ReportController());
  ReportController controller=Get.find();

   Report({super.key, required this.type,required this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).backgroundColor,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(translator.translate("Report"),style: Theme.of(context).textTheme.headline1,),
          ),
          Obx(
                () => RadioListTile<options>(
              title: Text(translator.translate("Harassment")),
              value: options.harassment,
              groupValue: controller.selectedOption.value,
              onChanged: (value) {
                controller.setSelectedOption(value!);
              },
                  activeColor: Theme.of(context).primaryColor,
            ),
          ),
          Obx(
                () => RadioListTile<options>(
              title: Text(translator.translate("Spam")),
              value: options.spam,
              groupValue: controller.selectedOption.value,
              onChanged: (value) {
                controller.setSelectedOption(value!);
              },
                  activeColor: Theme.of(context).primaryColor,
            ),
          ),
          Obx(
                () => RadioListTile<options>(
              title: Text(translator.translate("InappropriateContent")),
              value: options.inappropriate_content,
              groupValue: controller.selectedOption.value,
              onChanged: (value) {
                controller.setSelectedOption(value!);
              },
                  activeColor: Theme.of(context).primaryColor,
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.all(5),
              child:Expanded(child:  TextField(
                controller: controller.detailsController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 0,left: 10,top: 1),
                  disabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor,),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12,),
                      borderRadius: BorderRadius.circular(25)),
                  errorBorder: InputBorder.none,
                  focusedErrorBorder:InputBorder.none,
                  hintText:
                  translator.translate("More Info !"),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey, fontSize: 16),
                  border: InputBorder.none,
                  enabled: true,
                ),
                expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: null,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
                enableSuggestions: true,
                enabled: true,

              ),)
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            OutlinedButton(onPressed:(){Get.back();}, child:Text(translator.translate("Cancel"),style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).primaryColor),),style:
            ButtonStyle(
              splashFactory: NoSplash.splashFactory,
            ),),
            OutlinedButton(onPressed:(){
              controller.report(type, id);
            }, child:Text(translator.translate("Confirm"),),style:
                ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                ),
            ),
          ],)
        ],
      ),
    );
  }
}