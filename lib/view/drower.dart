import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/datastore/preferences.dart';
import 'package:shortnews/localization/Language/languages.dart';
import 'package:shortnews/view/auth/sign_up.dart';
import 'package:shortnews/view/change_language_screen.dart';
import 'package:shortnews/view/createpost/addnewpost.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/notifications/notifications_screen.dart';
import 'package:shortnews/view/screens/login_screen.dart';
import 'package:shortnews/view/setting/app_setting.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/service/FirebaseServices.dart';
import 'package:shortnews/view/video_functionality/screens/app_privacy.dart';
import 'package:shortnews/view/video_functionality/screens/contact_information.dart';
import 'package:shortnews/view/video_functionality/screens/home_page.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';

class MenuBarScreen extends StatefulWidget {
  const MenuBarScreen({Key? key}) : super(key: key);

  @override
  State<MenuBarScreen> createState() => _MenuBarScreenState();
}

class _MenuBarScreenState extends State<MenuBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, darkThemeProvider, child) {
        return Obx(
          () {
            final myController = Get.find<MyController>();
            return SafeArea(
                child: Container(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                        width: 12.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: AppHelper.themelight
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: EdgeInsets.all(1),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              AppImages.welcomescreenillimage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),

                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        // myController.fetchData();
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: DashBoardScreenActivity(
                              type: '',
                              notification: '',
                            ),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.home,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.home,
                        // 'home',
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        myController.fetchData();
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: HomePage(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.video_camera_back_outlined,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.watchVideo,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        myController.fetchParticularData('notification');

                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: NotificationScreen(
                              notification: 'notification',
                            ),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.notifications_on_outlined,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.notification,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.contrast,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.appTheme,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                      trailing: Switch(
                        value: myController.light.value,
                        activeColor: AppHelper.themelight
                            ? AppColors.primarycolorYellow
                            : AppColors.blackColor,
                        onChanged: (bool value) {
                          myController.light.value = value;

                          AppHelper.themelight = !AppHelper.themelight;
                          darkThemeProvider.darkThemessd(true);
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          elevation: 0,
                          context: context,
                          useRootNavigator: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: ChangeLanguageScreen(),
                            );
                          },
                        );
                      },
                      leading: Icon(
                        Icons.language,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.language,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        if (AppStringFile.USER_ID == "") {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 700),
                              child: LoginScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 700),
                              child: HomeScreen(),
                            ),
                          );
                        }
                      },
                      leading: Icon(
                        Icons.add_to_home_screen_sharp,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.addNews,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: ContactInformation(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.info_rounded,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.contact,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: AppSetting(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.settings,
                        size: 2.5.h,
                        color: AppHelper.themelight
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      title: Text(
                        Languages.of(context)!.setting,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_white
                            : AppStyle.bodytext_black,
                      ),
                    ),
                    AppStringFile.USER_ID == ""
                        ? ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 700),
                                  child: LoginScreen(),
                                ),
                              );
                            },
                            leading: Icon(
                              Icons.login,
                              size: 2.5.h,
                              color: AppHelper.themelight
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                            ),
                            title: Text(
                              Languages.of(context)!.login,
                              style: AppHelper.themelight
                                  ? AppStyle.bodytext_white
                                  : AppStyle.bodytext_black,
                            ),
                          )
                        : ListTile(
                            onTap: () async {
                              await FirebaseServices().googleSignOut();

                              Preferences preferences = Preferences();
                              preferences.clearPrefs();
                              setState(() {
                                AppStringFile.USER_ID = "";
                              });

                              Fluttertoast.showToast(
                                  msg: "Logout successfully!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            },
                            leading: Icon(
                              Icons.logout,
                              size: 2.5.h,
                              color: AppHelper.themelight
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                            ),
                            title: Text(
                              Languages.of(context)!.logout,
                              style: AppHelper.themelight
                                  ? AppStyle.bodytext_white
                                  : AppStyle.bodytext_black,
                            ),
                          ),
                    Spacer(),
                    // Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 13.7.h,
                    //     margin: EdgeInsets.only(
                    //       top: 24.0,
                    //       bottom: 10.0,
                    //     ),
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: myController.list.length,
                    //       itemBuilder: (context, index) {
                    //         return Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: InkWell(
                    //             onTap: () {

                    //               Navigator.pop(context);
                    //               // Navigator.push(
                    //               //   context,
                    //               //   PageTransition(
                    //               //     type: PageTransitionType.rightToLeft,
                    //               //     duration: Duration(milliseconds: 700),
                    //               //     child: DashBoardScreenActivity(),
                    //               //   ),
                    //               // );
                    //               Navigator.push(
                    //                 context,
                    //                 PageTransition(
                    //                   type: PageTransitionType.rightToLeft,
                    //                   duration: Duration(milliseconds: 700),
                    //                   child: DashBoardScreenActivity(
                    //                     type: myController.list[index]['type']
                    //                         .toString(),
                    //                     notification: '',
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //             child: Card(
                    //               //color: Colors.transparent.withOpacity(0.8),
                    //               child: Container(
                    //                 //  width: 25.0.w,
                    //                 //height: 60,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(50),
                    //                   // color: AppHelper.themelight
                    //                   //     ? Colors.white
                    //                   //     : Colors.black
                    //                 ),
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: Column(
                    //                     children: [
                    //                       Icon(
                    //                         myController.list[index]['icon'],
                    //                         size: 10.w,
                    //                         color: AppHelper.themelight
                    //                             ? AppColors.primarycolorYellow
                    //                             : AppColors.blackColor,
                    //                       ),
                    //                       Center(
                    //                           child: Text(
                    //                         textAlign: TextAlign.center,
                    //                         myController.list[index]['type']
                    //                             .toString(),
                    //                         style: AppHelper.themelight
                    //                             ? AppStyle.bodytext_white
                    //                             : AppStyle.bodytext_black,
                    //                       )),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     )),
                  ],
                ),
              ),
            ));
          },
        );
      },
    );
  }
}
