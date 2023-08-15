import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:revista/Services/apis/forgetpassword_api.dart';

class cameraController extends GetxController{
  late CameraController controller;
  late List<CameraDescription> cameras;

  @override
  void onInit() async{


    super.onInit();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}