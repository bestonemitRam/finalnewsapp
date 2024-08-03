import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

import 'package:shortnews/view/video_functionality/screens/content_screen.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';

class HomePage extends StatelessWidget {
  final myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    myController.fetchVideo();
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
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeft,
              //     duration: Duration(milliseconds: 700),
              //     child: DashBoardScreenActivity(),
              //   ),
              // );
            },
          ),
          title: Center(
            child: Text(
              "ShotNews",
              style: TextStyle(
                color: AppHelper.themelight ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        body: Obx(() {
          if (myController.videoModel.isEmpty) {
            return Container(
                color: AppHelper.themelight ? Colors.white : Colors.black,
                child: Center(child: CircularProgressIndicator()));
          } else {
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ContentScreen(
                    src: myController.videoModel.value[index].video_url
                        .toString(),
                    title:
                        myController.videoModel.value[index].title.toString());
              },
              itemCount: myController.videoModel.value.length,
              scrollDirection: Axis.vertical,
              onIndexChanged: (int index) {
                if (index == myController.videoModel.length - 1) {
                  myController.loadMoreVideo();
                }
              },
            );
          }
        }));
  }
}
