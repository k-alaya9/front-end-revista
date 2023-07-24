import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../Controllers/chatController.dart';

class AssetThumbnail extends StatelessWidget {
  AssetThumbnail({
    Key? key,
    required this.asset, this.id, this.selected,
  }) : super(key: key);
  final id;
  final AssetEntity asset;
  final selected;

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.find();
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return CupertinoActivityIndicator();
        // If there's data, display it as an image
        return InkWell(
          onTap: () {
            if (asset.type == AssetType.image) {
              controller.getPhotos(asset.id, selected);
            }
          }
          ,
          onLongPress: () {
            if (asset.type == AssetType.image) {
              showImage(asset.file);
            }
          },
          child: Stack(
            children: [
              Positioned.fill(child:
              Image.memory(bytes, fit: BoxFit.cover)),
              if(asset.type == AssetType.image)
                GetX(builder: (ChatController controller) =>
                    Container(
                      alignment: Alignment.topLeft,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected.value ? Colors.blue : Colors.grey,
                        border: Border.all(color: Colors.white),
                      ),
                    ),),
              if(asset.type == AssetType.video)
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  showImage(photo) {
    Get.dialog(
      Container(
        color: Colors.transparent,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child:IconButton(onPressed: (){
                    Get.back();
                  },icon: Icon(Icons.close,size: 25,)),
                ),
                InkWell(
                  onTapCancel: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: FutureBuilder<File?>(
                      future: photo,
                      builder: (_, snapshot) {
                        final file = snapshot.data;
                        if (file == null) return Container();
                        return Image.file(file);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      useSafeArea: true,
    );
  }
}
