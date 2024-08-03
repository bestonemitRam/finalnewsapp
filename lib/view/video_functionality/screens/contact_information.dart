import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';

class ContactInformation extends StatefulWidget {
  const ContactInformation({super.key});

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
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
              "Contact Information",
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
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text(
                            "Phone No. : ",
                            style: AppHelper.themelight
                                ? AppStyle.bodytext_black
                                : AppStyle.bodytext_white,
                          ),
                          Text(
                            "+91 6393100157",
                            style: AppHelper.themelight
                                ? AppStyle.bodytext_black
                                : AppStyle.bodytext_white,
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.black12,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text(
                            "Email : ",
                            style: AppHelper.themelight
                                ? AppStyle.bodytext_black
                                : AppStyle.bodytext_white,
                          ),
                          Text(
                            "shotNews9@gmail.com",
                            style: AppHelper.themelight
                                ? AppStyle.bodytext_black
                                : AppStyle.bodytext_white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  
  }
}
