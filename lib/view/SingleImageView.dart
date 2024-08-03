import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

class SingleImageView extends StatelessWidget {
  String image;
  SingleImageView(this.image, {Key? key}) : super(key: key);

  // saveImage() async {
  //   final encodedStr = image;

  //   Uint8List bytes = base64.decode(encodedStr);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   String fullPath = '$dir/abc.png';
  //   print("local file full path $fullPath");
  //   File file = File(fullPath);
  //   await file.writeAsBytes(bytes);
  //   print(file.path);

  //   final result = await ImageGallerySaver.saveImage(bytes);
  //   DialogHelper.showFlutterToast(strMsg: "Saved Successfully");
  //   print(result);

  //   return file.path;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: AppHelper.themelight ? Colors.white : Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(image),
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
