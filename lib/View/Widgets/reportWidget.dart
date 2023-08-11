import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() =>   CheckboxListTile(
            value: controller.harassment.value,
            onChanged: (val){
              controller.updateHarassment(val!);
            },
            title: Text('Harassment'),),
          ),
          Obx(() =>   CheckboxListTile(
            value: controller.spam.value,
            onChanged: (val){
              controller.updateSpam(val!);
            },
            title: Text('Spam'),),
          ),
          Obx(() =>   CheckboxListTile(
            value: controller.inappropriate_Content.value,
            onChanged: (val){
              controller.update_Inappropriate_Content(val!);
            },
            title: Text('Inappropriate_Content'),),
          ),
          Container(
              height: 50,
              child:Expanded(child:  TextField(
                controller: controller.detailsController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12,),
                      borderRadius: BorderRadius.circular(25)),
                  errorBorder: InputBorder.none,
                  focusedErrorBorder:InputBorder.none,
                  hintText:
                  'More Info !',

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
          Row(children: [
            OutlinedButton(onPressed:(){Get.back();}, child:Text('Cancel',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).accentColor),)),
            OutlinedButton(onPressed:(){
              controller.report(type, id);
            }, child:Text('Confirm',),style:
                ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                ),
            ),
          ],)
        ],
      ),
    );
  }
}