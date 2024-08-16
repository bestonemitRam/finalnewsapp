import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/notifications/notification_list.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/video_functionality/screens/app_privacy.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  State<AppSetting> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppSetting> {
  final MyController myController = Get.put(MyController());

  @override
  void initState() {
    super.initState();
  }

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
        title: Center(
          child: Text(
            "App Setting",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: Card(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _launchUrl(
                      Uri.parse("https://lavender-halimeda-17.tiiny.site/"));
                },
                leading: Icon(
                  Icons.privacy_tip,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                title: Text(
                  'Privacy',
                  style: AppHelper.themelight
                      ? AppStyle.bodytext_white
                      : AppStyle.bodytext_black,
                ),
              ),
              ListTile(
                onTap: () {
                  _launchURL();
                },
                leading: Icon(
                  Icons.rate_review_outlined,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                title: Text(
                  'Rate this app',
                  style: AppHelper.themelight
                      ? AppStyle.bodytext_white
                      : AppStyle.bodytext_black,
                ),
              ),
              ListTile(
                onTap: () {
                  _sendFeedbackEmail();
                },
                leading: Icon(
                  Icons.feedback,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                title: Text(
                  'Feedback',
                  style: AppHelper.themelight
                      ? AppStyle.bodytext_white
                      : AppStyle.bodytext_black,
                ),
              ),
              ListTile(
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.app.shotNews',
                      subject: 'Application download !');
                },
                leading: Icon(
                  Icons.share,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 2.5.h,
                  color: AppHelper.themelight
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                title: Text(
                  'Share this app',
                  style: AppHelper.themelight
                      ? AppStyle.bodytext_white
                      : AppStyle.bodytext_black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.app.shotNews'; // replace with your app's package name
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendFeedbackEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'shotnews9@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': '${DateTime.now()} Feedback For ShotNews as android app',
        'body':
            'Dear Team,\n\nI would like to share the following feedback...\n\nBest regards,'
      }),
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
