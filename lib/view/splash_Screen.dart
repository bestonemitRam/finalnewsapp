import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/loader_widget.dart';
import 'package:shortnews/view/uitl/service/FirebaseNotification.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    startTimer();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  }

  startTimer() async {
    var duration = const Duration(microseconds: 10);
    return Timer(duration, homePageRoute);
  }

  homePageRoute() async {
   
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.dashBoardScreenActivity, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppHelper.themelight ? Colors.white : Colors.black,
      ),
    );
  }
}
