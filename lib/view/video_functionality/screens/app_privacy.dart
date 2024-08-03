import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';

class AppPrivacy extends StatefulWidget {
  const AppPrivacy({super.key});

  @override
  State<AppPrivacy> createState() => _AppPrivacyState();
}

class _AppPrivacyState extends State<AppPrivacy> {
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
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 700),
                  child: DashBoardScreenActivity(type: '',notification: '',),
                ),
              );
            },
          ),
          title: Center(
            child: Text(
              "App Pricacy",
              style: TextStyle(
                color: AppHelper.themelight ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        body: Container(
          height: 20.h,
          child: Card(
            color: AppHelper.themelight ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: 
                  [
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
